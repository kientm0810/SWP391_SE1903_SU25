package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import daos.CVTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.CVTemplate;
import models.JobSeeker;

@WebServlet(name = "CVPreviewController", urlPatterns = {"/cv-preview"})
public class CVPreviewController extends HttpServlet {
    private CVTemplateDAO cvTemplateDAO;

    @Override
    public void init() throws ServletException {
        cvTemplateDAO = new CVTemplateDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            out.println("<div class='alert alert-danger'>You must be logged in as a job seeker to preview CV.</div>");
            return;
        }
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            out.println("<div class='alert alert-danger'>Missing or empty CV ID.</div>");
            return;
        }
        idParam = idParam.trim();
        int cvId;
        try {
            cvId = Integer.parseInt(idParam);
            if (cvId <= 0) {
                out.println("<div class='alert alert-danger'>Invalid CV ID. Please try again.</div>");
                return;
            }
        } catch (NumberFormatException e) {
            out.println("<div class='alert alert-danger'>Invalid CV ID format.</div>");
            return;
        }
        try {
            CVTemplate cv = cvTemplateDAO.getCVById(cvId, jobSeeker.getId());
            if (cv == null) {
                out.println("<div class='alert alert-danger'>CV not found or you do not have permission to view this CV.</div>");
                return;
            }
            out.println("<div class='cv-preview-content p-4'>");
            out.println("<h3>" + escapeHtml(cv.getFullName()) + "</h3>");
            out.println("<p><strong>Position:</strong> " + escapeHtml(cv.getJobPosition()) + "</p>");
            out.println("<p><strong>Email:</strong> " + escapeHtml(cv.getEmail()) + "</p>");
            if (cv.getPhone() != null) out.println("<p><strong>Phone:</strong> " + escapeHtml(cv.getPhone()) + "</p>");
            if (cv.getAddress() != null) out.println("<p><strong>Address:</strong> " + escapeHtml(cv.getAddress()) + "</p>");
            if (cv.getCertificates() != null) out.println("<p><strong>Certificates:</strong> " + escapeHtml(cv.getCertificates()) + "</p>");
            if (cv.getWorkExperience() != null) out.println("<p><strong>Work Experience:</strong> " + escapeHtml(cv.getWorkExperience()) + "</p>");
            out.println("</div>");
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>Database error occurred.</div>");
        }
    }

    private String escapeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
} 