package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import daos.ApplicationDAO;
import daos.PostsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Application;
import models.JobSeeker;
import models.Recruiter;

@WebServlet(name = "ApplicationController", urlPatterns = {"/applications"})
public class ApplicationController extends HttpServlet {
    private ApplicationDAO applicationDAO;
    private PostsDAO postsDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        postsDAO = new PostsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Pagination parameters
            int page = 1;
            int pageSize = 10;
            
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Filter parameters
            String status = request.getParameter("status");
            String keyword = request.getParameter("keyword");
            String sortBy = request.getParameter("sortBy");
            
            // Set default sort
            if (sortBy == null || sortBy.trim().isEmpty()) {
                sortBy = "created_at_desc";
            }

            if ("job-seeker".equals(role)) {
                handleJobSeekerApplications(request, response, session, page, pageSize, status, keyword, sortBy);
            } else if ("recruiter".equals(role)) {
                handleRecruiterApplications(request, response, session, page, pageSize, status, keyword, sortBy);
            } else {
                response.sendRedirect("home");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách ứng tuyển");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleJobSeekerApplications(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, int page, int pageSize, String status, String keyword, String sortBy) 
            throws SQLException, ServletException, IOException {
        
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        if (jobSeeker == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get applications for jobseeker with pagination and filters
        List<Application> applications = applicationDAO.getApplicationsByJobSeeker(
            jobSeeker.getId(), page, pageSize, status, keyword, sortBy);
        
        int totalApplications = applicationDAO.countApplicationsByJobSeeker(
            jobSeeker.getId(), status, keyword);
        
        int totalPages = (int) Math.ceil((double) totalApplications / pageSize);

        // Set attributes for JSP
        request.setAttribute("applications", applications);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("status", status);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("userType", "jobseeker");

        // Forward to jobseeker applications page
        request.getRequestDispatcher("applications.jsp").forward(request, response);
    }

    private void handleRecruiterApplications(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, int page, int pageSize, String status, String keyword, String sortBy) 
            throws SQLException, ServletException, IOException {
        
        Recruiter recruiter = (Recruiter) session.getAttribute("user");
        if (recruiter == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get applications for recruiter's posts with pagination and filters
        List<Application> applications = applicationDAO.getApplicationsByRecruiter(
            recruiter.getId(), page, pageSize, status, keyword, sortBy);
        
        int totalApplications = applicationDAO.countApplicationsByRecruiter(
            recruiter.getId(), status, keyword);
        
        int totalPages = (int) Math.ceil((double) totalApplications / pageSize);

        // Set attributes for JSP
        request.setAttribute("applications", applications);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("status", status);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("userType", "recruiter");

        // Forward to recruiter applications page
        request.getRequestDispatcher("recruiter-applications.jsp").forward(request, response);
    }
} 