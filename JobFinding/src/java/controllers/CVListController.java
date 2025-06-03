package controllers;

import daos.CVTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;
import models.JobSeeker;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.logging.Level;
import models.CVTemplate;

@WebServlet(name = "CVListController", urlPatterns = "/list_cv")
public class CVListController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CVListController.class.getName());
    private CVTemplateDAO cvTemplateDAO;

    @Override
    public void init() throws ServletException {
        cvTemplateDAO = new CVTemplateDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        String searchTerm = request.getParameter("search");
        try {
            List<CVTemplate> cvs = cvTemplateDAO.getCVsByJobSeeker(jobSeeker.getId(), searchTerm);
            request.setAttribute("cvs", cvs);
            request.setAttribute("searchTerm", searchTerm);
            request.getRequestDispatcher("list_cv.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching CVs", e);
            request.setAttribute("error", "Unable to load CVs due to a database error");
            request.getRequestDispatcher("list_cv.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String csrfToken = request.getParameter("csrfToken");
            String sessionToken = (String) session.getAttribute("csrfToken");
            if (csrfToken == null || !csrfToken.equals(sessionToken)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
                return;
            }

            try {
                int cvId = Integer.parseInt(request.getParameter("cvId"));
                boolean success = cvTemplateDAO.deleteCV(cvId, jobSeeker.getId());
                if (success) {
                    request.setAttribute("message", "CV deleted successfully");
                } else {
                    request.setAttribute("error", "Failed to delete CV");
                }
                doGet(request, response); 
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid CV ID", e);
                request.setAttribute("error", "Invalid CV ID");
                doGet(request, response);
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error deleting CV", e);
                request.setAttribute("error", "Database error");
                doGet(request, response);
            }
        } else {
            doGet(request, response); 
        }
    }
}