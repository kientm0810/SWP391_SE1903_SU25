package controllers;

import java.io.IOException;
import java.sql.Timestamp;

import daos.ApplicationDAO;
import daos.JobDAO;
import daos.RecruitmentProcessDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import models.Application;
import models.JobListing;
import models.JobSeeker;
import models.RecruitmentProcess;

@WebServlet(name = "ApplyController", urlPatterns = {"/apply"})
public class ApplyController extends HttpServlet {
    private ApplicationDAO applicationDAO;
    private RecruitmentProcessDAO recruitmentProcessDAO;
    private JobDAO jobDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        recruitmentProcessDAO = new RecruitmentProcessDAO();
        jobDAO = new JobDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
            if (jobSeeker == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            int postId = Integer.parseInt(request.getParameter("id"));
            Part cvPart = request.getPart("cvFile");
            String fileName = cvPart.getSubmittedFileName();
            String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
            long fileSize = cvPart.getSize();
            if (!(ext.equals("pdf") || ext.equals("doc") || ext.equals("docx")) || fileSize > 5 * 1024 * 1024) {
                request.setAttribute("errorMsg", "Chỉ hỗ trợ file .doc, .docx, .pdf và kích thước dưới 5MB!");
                request.getRequestDispatcher("apply-job.jsp?id=" + postId).forward(request, response);
                return;
            }
            String coverLetter = request.getParameter("coverLetter");

            // 1. Lưu vào bảng Applications
            Application app = new Application();
            app.setJobSeekerId(jobSeeker.getId());
            app.setJobListingId(postId);
            app.setCvFile(fileName);
            app.setCoverLetter(coverLetter);
            app.setStatus("new");
            int applicationId = applicationDAO.insertApplication(app);

            // 2. Lưu vào quy trình tuyển dụng của recruiter
            JobListing jobFull = jobDAO.getJobListingById(postId);
            // Giả sử recruiterId lấy từ jobFull (nếu có recruiterId trong JobListing)
            int recruiterId = -1;
            if (jobFull != null && jobFull.getRecruiterName() != null) {
                // Nếu có recruiterId thì lấy, nếu không thì cần sửa JobListing để có recruiterId
                // recruiterId = jobFull.getRecruiterId();
            }
            RecruitmentProcess process = new RecruitmentProcess();
            process.setApplicationId(applicationId);
            process.setCurrentStage("initial_screening");
            process.setStatus("in_progress");
            process.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            process.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
            process.setAssignedRecruiterId(recruiterId);
            process.setNotes("Ứng viên vừa ứng tuyển");
            recruitmentProcessDAO.insert(process);

            // 3. Chuyển hướng về trang xác nhận hoặc danh sách việc làm đã ứng tuyển
            response.sendRedirect("applications.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("apply-job.jsp?error=1");
        }
    }
} 