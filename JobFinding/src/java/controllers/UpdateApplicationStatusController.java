package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import daos.ApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Recruiter;

@WebServlet(name = "UpdateApplicationStatusController", urlPatterns = {"/update-application-status"})
public class UpdateApplicationStatusController extends HttpServlet {

    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"recruiter".equals(session.getAttribute("role"))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\": false, \"error\": \"Unauthorized: Please sign in as recruiter.\"}");
            out.flush();
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("user");

        String applicationIdStr = request.getParameter("applicationId");
        String status = request.getParameter("status");

        if (applicationIdStr == null || applicationIdStr.trim().isEmpty() || status == null || status.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"error\": \"Missing parameters.\"}");
            out.flush();
            return;
        }

        try {
            int applicationId = Integer.parseInt(applicationIdStr.trim());
            boolean updated = applicationDAO.updateApplicationStatus(applicationId, status.trim(), recruiter.getId());
            if (updated) {
                out.print("{\"success\": true}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"success\": false, \"error\": \"Application not found or you don't have permission.\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"error\": \"Invalid applicationId format.\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Database error. Please try again later.\"}");
        } finally {
            out.flush();
        }
    }
} 