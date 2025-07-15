package controllers;

import daos.ApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateApplicationStatusController", urlPatterns = {"/update-application-status"})
public class UpdateApplicationStatusController extends HttpServlet {
    private ApplicationDAO applicationDAO;

    public UpdateApplicationStatusController() {
        applicationDAO = new ApplicationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"recruiter".equals(session.getAttribute("role"))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\": false, \"message\": \"Unauthorized: Please log in as recruiter.\"}");
            out.flush();
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("user");
        String applicationIdStr = request.getParameter("applicationId");
        String newStatus = request.getParameter("newStatus");
        if (applicationIdStr == null || newStatus == null || applicationIdStr.trim().isEmpty() || newStatus.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"Missing parameters.\"}");
            out.flush();
            return;
        }
        // Only allow specific statuses
        String[] allowedStatuses = {"new", "reviewed", "interviewed", "offered", "rejected"};
        boolean validStatus = false;
        for (String s : allowedStatuses) {
            if (s.equalsIgnoreCase(newStatus)) {
                validStatus = true;
                break;
            }
        }
        if (!validStatus) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"Invalid status value.\"}");
            out.flush();
            return;
        }
        try {
            int applicationId = Integer.parseInt(applicationIdStr.trim());
            boolean success = applicationDAO.updateApplicationStatusByRecruiter(applicationId, newStatus, recruiter.getId());
            if (success) {
                out.print("{\"success\": true, \"message\": \"Status updated successfully.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"success\": false, \"message\": \"Application not found or you do not have permission.\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"Invalid applicationId format.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Database error. Please try again later.\"}");
        } finally {
            out.flush();
        }
    }
}
