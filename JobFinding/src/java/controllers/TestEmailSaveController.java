package controllers;

import java.io.IOException;
import java.sql.Timestamp;

import daos.EmailHistoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.EmailHistory;
import models.Recruiter;

@WebServlet(name = "TestEmailSaveController", urlPatterns = {"/test-email-save"})
public class TestEmailSaveController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        StringBuilder html = new StringBuilder();
        html.append("<html><head><title>Test Email Save</title></head><body>");
        html.append("<h1>Test Email Save</h1>");
        
        try {
            // Get recruiter from session
            HttpSession session = request.getSession(false);
            Recruiter recruiter = null;
            if (session != null && session.getAttribute("user") != null && "recruiter".equals(session.getAttribute("role"))) {
                recruiter = (Recruiter) session.getAttribute("user");
                html.append("<p><strong>Recruiter ID:</strong> ").append(recruiter.getId()).append("</p>");
            } else {
                html.append("<p><strong>Error:</strong> No recruiter found in session</p>");
                html.append("</body></html>");
                response.getWriter().write(html.toString());
                return;
            }
            
            EmailHistoryDAO dao = new EmailHistoryDAO();
            
            // Create test email
            EmailHistory testEmail = new EmailHistory();
            testEmail.setApplicationId(null);
            testEmail.setRecruiterId(recruiter.getId());
            testEmail.setTemplateName("Test Template");
            testEmail.setRecipientEmail("test@example.com");
            testEmail.setSubject("Test Email Subject");
            testEmail.setBodyHtml("<p>This is a test email body</p>");
            testEmail.setStatus("sent");
            testEmail.setSentAt(new Timestamp(System.currentTimeMillis()));
            testEmail.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            html.append("<p><strong>Test Email Data:</strong></p>");
            html.append("<ul>");
            html.append("<li>Recruiter ID: ").append(testEmail.getRecruiterId()).append("</li>");
            html.append("<li>Template Name: ").append(testEmail.getTemplateName()).append("</li>");
            html.append("<li>Recipient: ").append(testEmail.getRecipientEmail()).append("</li>");
            html.append("<li>Subject: ").append(testEmail.getSubject()).append("</li>");
            html.append("<li>Status: ").append(testEmail.getStatus()).append("</li>");
            html.append("</ul>");
            
            // Try to save
            boolean saved = dao.saveEmailHistory(testEmail);
            if (saved) {
                html.append("<p style='color: green;'><strong>SUCCESS:</strong> Email saved with ID: ").append(testEmail.getId()).append("</p>");
            } else {
                html.append("<p style='color: red;'><strong>FAILED:</strong> Could not save email</p>");
            }
            
            // Check if email appears in history
            var emails = dao.getEmailHistoryByRecruiter(recruiter.getId(), null, null, "created_at", null, 5, 0);
            html.append("<p><strong>Total emails in history:</strong> ").append(emails.size()).append("</p>");
            
            if (!emails.isEmpty()) {
                html.append("<h3>Recent emails:</h3>");
                html.append("<ul>");
                for (EmailHistory email : emails) {
                    html.append("<li>ID: ").append(email.getId())
                        .append(", Subject: ").append(email.getSubject())
                        .append(", Status: ").append(email.getStatus())
                        .append("</li>");
                }
                html.append("</ul>");
            }
            
        } catch (Exception e) {
            html.append("<p style='color: red;'><strong>Error:</strong> ").append(e.getMessage()).append("</p>");
            html.append("<pre>").append(e.toString()).append("</pre>");
            e.printStackTrace();
        }
        
        html.append("<br><a href='recruiter-email-history'>Go to Email History Page</a>");
        html.append("</body></html>");
        
        response.getWriter().write(html.toString());
    }
} 