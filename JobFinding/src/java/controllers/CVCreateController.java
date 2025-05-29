package controllers;

import daos.CVTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.CVTemplate;
import models.JobSeeker;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

public class CVCreateController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CVCreateController.class.getName());
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
        request.getRequestDispatcher("create_cv.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.sendRedirect("login");
            return;
        }

        try {
            JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
            CVTemplate cv = new CVTemplate();
            cv.setJobSeekerId(jobSeeker.getId());
            cv.setFullName(request.getParameter("fullName"));
            cv.setJobPosition(request.getParameter("jobPosition"));
            cv.setPhone(request.getParameter("phone"));
            cv.setEmail(request.getParameter("email"));
            cv.setAddress(request.getParameter("address"));
            cv.setCertificates(request.getParameter("certificates"));
            cv.setWorkExperience(request.getParameter("workExperience"));

            // Basic validation
            if (cv.getFullName() == null || cv.getFullName().trim().isEmpty() ||
                cv.getJobPosition() == null || cv.getJobPosition().trim().isEmpty() ||
                cv.getEmail() == null || cv.getEmail().trim().isEmpty()) {
                request.setAttribute("error", "Full Name, Job Position, and Email are required.");
                request.getRequestDispatcher("create_cv.jsp").forward(request, response);
                return;
            }

            boolean success = cvTemplateDAO.createCV(cv);
            if (success) {
                response.sendRedirect("list_cv");
            } else {
                request.setAttribute("error", "Failed to create CV.");
                request.getRequestDispatcher("create_cv.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating CV", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}