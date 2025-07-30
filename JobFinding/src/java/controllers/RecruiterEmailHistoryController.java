package controllers;

import java.io.IOException;
import java.util.List;

import daos.EmailHistoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.EmailHistory;
import models.Recruiter;

@WebServlet(name = "RecruiterEmailHistoryController", urlPatterns = {"/recruiter-email-history"})
public class RecruiterEmailHistoryController extends HttpServlet {

    private EmailHistoryDAO emailHistoryDAO;

    @Override
    public void init() throws ServletException {
        emailHistoryDAO = new EmailHistoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"recruiter".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Recruiter recruiter = (Recruiter) session.getAttribute("user");
        
        try {
            // Get filter parameters
            String status = request.getParameter("status");
            String emailType = request.getParameter("emailType");
            String sortBy = request.getParameter("sortBy");
            String keyword = request.getParameter("keyword");
            String pageStr = request.getParameter("page");
            
            // Set default values
            if (sortBy == null || sortBy.trim().isEmpty()) {
                sortBy = "sent_at";
            }
            if (pageStr == null || pageStr.trim().isEmpty()) {
                pageStr = "1";
            }
            
            int currentPage = Integer.parseInt(pageStr);
            int pageSize = 10; // Number of emails per page
            int offset = (currentPage - 1) * pageSize;
            

            
            // Get email history for this recruiter
            List<EmailHistory> emailHistory = emailHistoryDAO.getEmailHistoryByRecruiter(
                recruiter.getId(), status, emailType, sortBy, keyword, pageSize, offset);
            

            
            // Get total count for pagination
            int totalEmails = emailHistoryDAO.getTotalEmailCountByRecruiter(
                recruiter.getId(), status, emailType, keyword);
            
            // Get statistics
            int sentEmails = emailHistoryDAO.getEmailCountByRecruiterAndStatus(recruiter.getId(), "sent");
            int failedEmails = emailHistoryDAO.getEmailCountByRecruiterAndStatus(recruiter.getId(), "failed");
            int pendingEmails = emailHistoryDAO.getEmailCountByRecruiterAndStatus(recruiter.getId(), "pending");
            

            
            // Calculate pagination
            int totalPages = (int) Math.ceil((double) totalEmails / pageSize);
            
            // Set attributes
            request.setAttribute("emailHistory", emailHistory);
            request.setAttribute("totalEmails", totalEmails);
            request.setAttribute("sentEmails", sentEmails);
            request.setAttribute("failedEmails", failedEmails);
            request.setAttribute("pendingEmails", pendingEmails);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", pageSize);
            

            
            // Forward to JSP
            request.getRequestDispatcher("/recruiter-email-history.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi tải lịch sử email: " + e.getMessage());
            response.sendRedirect("recruiter-applications.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle POST requests if needed (e.g., for resending emails)
        doGet(request, response);
    }
} 