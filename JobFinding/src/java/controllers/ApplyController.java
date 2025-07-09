package controllers;

import java.io.IOException;
import java.sql.Timestamp;

import daos.ApplicationDAO;
import daos.JobDAO;
import daos.RecruitmentProcessDAO;
import daos.PostsDAO;
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
import models.Posts;
import models.CVTemplate;
import daos.CVTemplateDAO;
import java.util.List;

@WebServlet(name = "ApplyController", urlPatterns = {"/apply"})
public class ApplyController extends HttpServlet {
    private ApplicationDAO applicationDAO;
    private RecruitmentProcessDAO recruitmentProcessDAO;
    private JobDAO jobDAO;
    private PostsDAO postsDAO;
    private CVTemplateDAO cvTemplateDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        recruitmentProcessDAO = new RecruitmentProcessDAO();
        jobDAO = new JobDAO();
        postsDAO = new PostsDAO();
        cvTemplateDAO = new CVTemplateDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
            String postIdStr = request.getParameter("id");
            if (postIdStr == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            int postId = Integer.parseInt(postIdStr);

            Posts post = postsDAO.getPostById(postId);
            List<CVTemplate> cvList = cvTemplateDAO.getCVsByJobSeeker(jobSeeker.getId());

            if (post == null) {
                // Handle post not found
                response.sendRedirect(request.getContextPath() + "/home?error=post_not_found");
                return;
            }

            request.setAttribute("post", post);
            request.setAttribute("cvList", cvList);
            request.getRequestDispatcher("/apply-job.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions, maybe redirect to an error page
            response.sendRedirect(request.getContextPath() + "/home?error=server_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
<<<<<<< HEAD
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
=======

            JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
            int postId = Integer.parseInt(request.getParameter("postId"));
            int cvId = Integer.parseInt(request.getParameter("cvId"));
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622

            // Lấy thông tin bài đăng để có recruiterId
            Posts post = postsDAO.getPostById(postId);
            if (post == null) {
                throw new Exception("Post not found with id: " + postId);
            }
            int recruiterId = post.getUserId();

            // Tạo đối tượng Application
            Application application = new Application();
            application.setJobSeekerId(jobSeeker.getId());
            application.setPostId(postId);
            application.setCvId(cvId);
            application.setStatus("new"); // Trạng thái ban đầu

            // Lưu application và tạo process, gán cho đúng recruiter
            // Giả sử hrId được gán mặc định là 0 hoặc một giá trị nào đó
            boolean success = applicationDAO.saveApplicationAndCreateProcess(application, recruiterId, 0);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/applications?applySuccess=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/post/view?id=" + postId + "&applyError=true");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            // Gửi lỗi về trang apply hoặc trang chi tiết bài đăng
            String postIdParam = request.getParameter("postId");
            if (postIdParam != null && !postIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/post/view?id=" + postIdParam + "&applyError=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/home?error=unknown");
            }
        }
    }
} 