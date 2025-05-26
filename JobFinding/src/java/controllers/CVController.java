package controllers;

import daos.CVDAO;
import models.CV;
import models.JobSeeker;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/cv/*")
public class CVController extends HttpServlet {
    private CVDAO cvDao;

    @Override
    public void init() throws ServletException {
        cvDao = new CVDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        JobSeeker user = (JobSeeker) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        if (user == null || !"job_seeker".equals(role)) {
            response.sendRedirect("login");
            return;
        }

        String path = request.getPathInfo() != null ? request.getPathInfo() : "/";
        switch (path) {
            case "/list":
                listCVs(user.getId(), request, response);
                break;
            case "/create":
                request.getRequestDispatcher("/views/jobseeker/cv_create.jsp").forward(request, response);
                break;
            case "/update":
                updateCVForm(user.getId(), request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        JobSeeker user = (JobSeeker) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        if (user == null || !"job_seeker".equals(role)) {
            response.sendRedirect("login");
            return;
        }

        String path = request.getPathInfo() != null ? request.getPathInfo() : "/";
        switch (path) {
            case "/create":
                createCV(user.getId(), request, response);
                break;
            case "/update":
                updateCV(user.getId(), request, response);
                break;
            case "/delete":
                deleteCV(user.getId(), request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listCVs(int jobSeekerId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
            List<CV> cvs = cvDao.searchCVs(jobSeekerId, keyword);
            request.setAttribute("cvs", cvs);
            request.getRequestDispatcher("/views/jobseeker/cv_list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách CV.");
            request.getRequestDispatcher("/views/jobseeker/cv_list.jsp").forward(request, response);
        }
    }

    private void createCV(int jobSeekerId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String summary = request.getParameter("summary");
            String education = request.getParameter("education");
            String experience = request.getParameter("experience");
            String skills = request.getParameter("skills");

            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Tiêu đề CV là bắt buộc.");
                request.getRequestDispatcher("/views/jobseeker/cv_create.jsp").forward(request, response);
                return;
            }

            CV cv = new CV();
            cv.setJobSeekerId(jobSeekerId);
            cv.setTitle(title);
            cv.setSummary(summary != null ? summary : "");
            cv.setEducation(education != null ? education : "");
            cv.setExperience(experience != null ? experience : "");
            if (skills != null && !skills.trim().isEmpty()) {
                cv.setSkills(Arrays.asList(skills.split(",")));
            }

            if (cvDao.createCV(cv)) {
                request.setAttribute("message", "Tạo CV thành công!");
                response.sendRedirect("list");
            } else {
                request.setAttribute("error", "Tạo CV thất bại.");
                request.getRequestDispatcher("/views/jobseeker/cv_create.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/jobseeker/cv_create.jsp").forward(request, response);
        }
    }

    private void updateCVForm(int jobSeekerId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String cvIdStr = request.getParameter("id");
            if (cvIdStr == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID CV là bắt buộc.");
                return;
            }
            int cvId = Integer.parseInt(cvIdStr);
            List<CV> cvs = cvDao.searchCVs(jobSeekerId, "");
            CV cv = cvs.stream().filter(c -> c.getId() == cvId).findFirst().orElse(null);
            if (cv != null) {
                request.setAttribute("cv", cv);
                request.getRequestDispatcher("/views/jobseeker/cv_update.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "CV không tồn tại.");
                response.sendRedirect("list");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID CV không hợp lệ.");
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải CV.");
            response.sendRedirect("list");
        }
    }

    private void updateCV(int jobSeekerId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String cvIdStr = request.getParameter("id");
            String title = request.getParameter("title");
            String summary = request.getParameter("summary");
            String education = request.getParameter("education");
            String experience = request.getParameter("experience");
            String skills = request.getParameter("skills");

            if (cvIdStr == null || title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "ID CV và tiêu đề là bắt buộc.");
                request.getRequestDispatcher("/views/jobseeker/cv_update.jsp").forward(request, response);
                return;
            }

            int cvId = Integer.parseInt(cvIdStr);
            CV cv = new CV();
            cv.setId(cvId);
            cv.setJobSeekerId(jobSeekerId);
            cv.setTitle(title);
            cv.setSummary(summary != null ? summary : "");
            cv.setEducation(education != null ? education : "");
            cv.setExperience(experience != null ? experience : "");
            if (skills != null && !skills.trim().isEmpty()) {
                cv.setSkills(Arrays.asList(skills.split(",")));
            }

            if (cvDao.updateCV(cv)) {
                request.setAttribute("message", "Cập nhật CV thành công!");
                response.sendRedirect("list");
            } else {
                request.setAttribute("error", "Cập nhật CV thất bại.");
                request.setAttribute("cv", cv);
                request.getRequestDispatcher("/views/jobseeker/cv_update.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID CV không hợp lệ.");
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/jobseeker/cv_update.jsp").forward(request, response);
        }
    }

    private void deleteCV(int jobSeekerId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String cvIdStr = request.getParameter("id");
            if (cvIdStr == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID CV là bắt buộc.");
                return;
            }
            int cvId = Integer.parseInt(cvIdStr);
            if (cvDao.deleteCV(cvId, jobSeekerId)) {
                request.setAttribute("message", "Xóa CV thành công!");
            } else {
                request.setAttribute("error", "Xóa CV thất bại.");
            }
            response.sendRedirect("list");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID CV không hợp lệ.");
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại.");
            response.sendRedirect("list");
        }
    }
}