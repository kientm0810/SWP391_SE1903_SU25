package controllers;

import daos.CVTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.JobSeeker;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;
import models.CVTemplate;

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

        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        String searchTerm = request.getParameter("search");
        try {
            List<CVTemplate> cvs = cvTemplateDAO.getCVsByJobSeeker(jobSeeker.getId(), searchTerm);
            request.setAttribute("cvs", cvs);
            request.setAttribute("searchTerm", searchTerm);
            request.getRequestDispatcher("list_cv.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching CVs", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}