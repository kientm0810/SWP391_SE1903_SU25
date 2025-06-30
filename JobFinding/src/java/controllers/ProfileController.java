package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import daos.CVTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.CVTemplate;
import models.JobSeeker;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());
    private static final int PAGE_SIZE = 5; // Number of CVs per page
    
    private CVTemplateDAO cvDAO;
    
    @Override
    public void init() throws ServletException {
        cvDAO = new CVTemplateDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is a job seeker
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            // Get pagination parameters
            String pageParam = request.getParameter("page");
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) currentPage = 1;
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            // Get search parameter
            String searchTerm = request.getParameter("search");
            
            // Get all CVs for the job seeker
            List<CVTemplate> allCVs = cvDAO.getCVsByJobSeeker(jobSeeker.getId(), searchTerm);
            
            // Calculate pagination
            int totalCVs = allCVs.size();
            int totalPages = (int) Math.ceil((double) totalCVs / PAGE_SIZE);
            int startIndex = (currentPage - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, totalCVs);
            
            // Get CVs for current page
            List<CVTemplate> pageCVs = allCVs.subList(startIndex, endIndex);
            
            // Set attributes for JSP
            request.setAttribute("cvList", pageCVs);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCVs", totalCVs);
            request.setAttribute("searchTerm", searchTerm);
            
            // Forward to profile page
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading profile for jobSeeker: " + jobSeeker.getId(), e);
            request.setAttribute("error", "Unable to load profile. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Handle CV deletion
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            handleDeleteCV(request, response);
        } else {
            response.sendRedirect("profile");
        }
    }
    
    private void handleDeleteCV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        
        try {
            String cvIdParam = request.getParameter("cvId");
            if (cvIdParam != null && !cvIdParam.isEmpty()) {
                int cvId = Integer.parseInt(cvIdParam);
                
                boolean deleted = cvDAO.deleteCV(cvId, jobSeeker.getId());
                
                if (deleted) {
                    session.setAttribute("successMessage", "CV đã được xóa thành công!");
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa CV. Vui lòng thử lại!");
                }
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid CV ID format: " + request.getParameter("cvId"));
            session.setAttribute("errorMessage", "ID CV không hợp lệ!");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting CV", e);
            session.setAttribute("errorMessage", "Lỗi hệ thống khi xóa CV!");
        }
        
        response.sendRedirect("profile");
    }
} 