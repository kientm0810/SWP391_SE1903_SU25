package controllers;

import java.io.IOException;
import java.sql.Timestamp;
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

@WebServlet(name = "EmailHistoryTestController", urlPatterns = {"/email-history-test"})
public class EmailHistoryTestController extends HttpServlet {

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
        
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h2>Email History Test</h2>");
        response.getWriter().println("<p><strong>Recruiter ID:</strong> " + recruiter.getId() + "</p>");
        response.getWriter().println("<p><strong>Recruiter Name:</strong> " + recruiter.getFullName() + "</p>");
        
        try {
            // Test 1: Save a test email
            response.getWriter().println("<h3>Test 1: Saving Test Email</h3>");
            EmailHistory testEmail = new EmailHistory();
            testEmail.setApplicationId(1);
            testEmail.setRecruiterId(recruiter.getId());
            testEmail.setTemplateName("Test Template");
            testEmail.setRecipientEmail("test@example.com");
            testEmail.setSubject("Test Email - " + System.currentTimeMillis());
            testEmail.setBodyHtml("<p>This is a test email content</p>");
            testEmail.setStatus("sent");
            testEmail.setSentAt(new Timestamp(System.currentTimeMillis()));
            testEmail.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            boolean saved = emailHistoryDAO.saveEmailHistory(testEmail);
            response.getWriter().println("<p><strong>Test Email Saved:</strong> " + (saved ? "SUCCESS" : "FAILED") + "</p>");
            
            // Test 2: Get emails for this recruiter
            response.getWriter().println("<h3>Test 2: Getting Emails for Recruiter</h3>");
            List<EmailHistory> recruiterEmails = emailHistoryDAO.getEmailHistoryByRecruiter(
                recruiter.getId(), null, null, "sent_at", null, 10, 0);
            response.getWriter().println("<p><strong>Emails found:</strong> " + recruiterEmails.size() + "</p>");
            
            if (!recruiterEmails.isEmpty()) {
                response.getWriter().println("<h4>Recent Emails:</h4>");
                response.getWriter().println("<ul>");
                for (EmailHistory email : recruiterEmails) {
                    response.getWriter().println("<li>ID: " + email.getId() + 
                        ", Subject: " + email.getSubject() + 
                        ", Recipient: " + email.getRecipientEmail() + 
                        ", Status: " + email.getStatus() + 
                        ", Recruiter ID: " + email.getRecruiterId() + "</li>");
                }
                response.getWriter().println("</ul>");
            }
            
            // Test 3: Get statistics
            response.getWriter().println("<h3>Test 3: Statistics</h3>");
            int totalCount = emailHistoryDAO.getTotalEmailCountByRecruiter(recruiter.getId(), null, null, null);
            int sentCount = emailHistoryDAO.getEmailCountByRecruiterAndStatus(recruiter.getId(), "sent");
            int failedCount = emailHistoryDAO.getEmailCountByRecruiterAndStatus(recruiter.getId(), "failed");
            
            response.getWriter().println("<p><strong>Total emails:</strong> " + totalCount + "</p>");
            response.getWriter().println("<p><strong>Sent emails:</strong> " + sentCount + "</p>");
            response.getWriter().println("<p><strong>Failed emails:</strong> " + failedCount + "</p>");
            
        } catch (Exception e) {
            response.getWriter().println("<h3>Error</h3>");
            response.getWriter().println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            response.getWriter().println("<pre>" + e.toString() + "</pre>");
            e.printStackTrace();
        }
        
        response.getWriter().println("<p><a href='recruiter-email-history'>Go to Email History Page</a></p>");
        response.getWriter().println("</body></html>");
    }
} 