package controllers;

import java.io.IOException;

import daos.EmailHistoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.EmailHistory;
import models.Recruiter;
import utils.JavaMail;

@WebServlet(name = "ResendEmailController", urlPatterns = {"/resend-email"})
public class ResendEmailController extends HttpServlet {

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
        String emailIdStr = request.getParameter("emailId");
        
        if (emailIdStr == null || emailIdStr.trim().isEmpty()) {
            session.setAttribute("error", "ID email không hợp lệ.");
            response.sendRedirect("recruiter-email-history");
            return;
        }
        
        try {
            int emailId = Integer.parseInt(emailIdStr);
            
            // Get email history by ID
            EmailHistory emailHistory = emailHistoryDAO.getEmailHistoryById(emailId);
            
            if (emailHistory == null) {
                session.setAttribute("error", "Không tìm thấy email.");
                response.sendRedirect("recruiter-email-history");
                return;
            }
            
            // Verify that this email belongs to the current recruiter
            if (!emailHistoryDAO.isEmailBelongsToRecruiter(emailId, recruiter.getId())) {
                session.setAttribute("error", "Bạn không có quyền gửi lại email này.");
                response.sendRedirect("recruiter-email-history");
                return;
            }
            
            // Try to resend the email
            boolean emailSent = JavaMail.sendEmail(
                emailHistory.getRecipientEmail(),
                emailHistory.getSubject(),
                emailHistory.getBodyHtml()
            );
            
            if (emailSent) {
                // Update email status
                emailHistoryDAO.updateEmailStatus(emailId, "sent", null);
                session.setAttribute("success", "Email đã được gửi lại thành công.");
            } else {
                // Update email status to failed
                emailHistoryDAO.updateEmailStatus(emailId, "failed", "Gửi lại thất bại");
                session.setAttribute("error", "Không thể gửi lại email. Vui lòng thử lại sau.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID email không hợp lệ.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi gửi lại email: " + e.getMessage());
        }
        
        response.sendRedirect("recruiter-email-history");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 