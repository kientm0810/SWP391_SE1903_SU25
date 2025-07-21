package controllers;

import daos.ApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Application;
import models.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import utils.EmailService;

@WebServlet(name = "UpdateApplicationStatusController", urlPatterns = {"/update-application-status"})
public class UpdateApplicationStatusController extends HttpServlet {
    private ApplicationDAO applicationDAO;
    private EmailService emailService;

    public UpdateApplicationStatusController() {
        applicationDAO = new ApplicationDAO();
        emailService = new EmailService();
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
        String status = request.getParameter("status");
        String action = request.getParameter("action");
        String rejectionReason = request.getParameter("rejectionReason");
        String offerDetails = request.getParameter("offerDetails");
        
        // Simple validation
        if (applicationIdStr == null || applicationIdStr.trim().isEmpty()) {
            session.setAttribute("error", "Không tìm thấy ID ứng tuyển.");
            response.sendRedirect("recruiter-applications");
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
        
        if (!isValidStatus) {
            session.setAttribute("error", "Trạng thái không hợp lệ.");
            response.sendRedirect("applications");
            return;
        }
        
        // Validate required fields for specific statuses
        if ("rejected".equals(status.trim()) && (rejectionReason == null || rejectionReason.trim().isEmpty())) {
            session.setAttribute("error", "Vui lòng nhập lý do từ chối.");
            response.sendRedirect("applications");
            return;
        }
        
        if ("offered".equals(status.trim()) && (offerDetails == null || offerDetails.trim().isEmpty())) {
            session.setAttribute("error", "Vui lòng nhập chi tiết đề nghị.");
            response.sendRedirect("applications");
            return;
        }
        try {
            int applicationId = Integer.parseInt(applicationIdStr.trim());
            
            // Get application details before updating
            Application application = applicationDAO.getApplicationById(applicationId, recruiter.getId());
            if (application == null) {
                session.setAttribute("error", "Không tìm thấy đơn ứng tuyển hoặc bạn không có quyền.");
                response.sendRedirect("applications");
                return;
            }
            
            // Update application status
            boolean updated = applicationDAO.updateApplicationStatus(applicationId, status.trim(), recruiter.getId());
            
            if (updated) {
                // Send email notification based on status
                boolean emailSent = false;
                String emailMessage = "";
                
                switch (status.trim()) {
                    case "reviewed":
                        emailSent = emailService.sendApplicationReviewedEmailByEmail(
                            application.getJobseeker().getEmail(),
                            application.getJobseeker().getFullName(),
                            application.getPost().getTitle(),
                            application.getPost().getCompanyName(),
                            applicationId
                        );
                        emailMessage = "Email thông báo đã xem hồ sơ đã được gửi.";
                        break;
                        
                    case "interviewed":
                        emailSent = emailService.sendInterviewCompletedEmailByEmail(
                            application.getJobseeker().getEmail(),
                            application.getJobseeker().getFullName(),
                            application.getPost().getTitle(),
                            application.getPost().getCompanyName(),
                            applicationId
                        );
                        emailMessage = "Email cảm ơn tham gia phỏng vấn đã được gửi.";
                        break;
                        
                    case "rejected":
                        emailSent = emailService.sendRejectionEmailByEmail(
                            application.getJobseeker().getEmail(),
                            application.getJobseeker().getFullName(),
                            application.getPost().getTitle(),
                            application.getPost().getCompanyName(),
                            rejectionReason,
                            applicationId
                        );
                        emailMessage = "Email từ chối đã được gửi.";
                        break;
                        
                    case "offered":
                        emailSent = emailService.sendAcceptanceEmailByEmail(
                            application.getJobseeker().getEmail(),
                            application.getJobseeker().getFullName(),
                            application.getPost().getTitle(),
                            application.getPost().getCompanyName(),
                            offerDetails,
                            applicationId
                        );
                        emailMessage = "Email chấp nhận đã được gửi.";
                        break;
                        
                    default:
                        // For "new" status, no email is sent
                        emailSent = false;
                        emailMessage = "";
                        break;
                }
                
                // Create status display mapping
                String statusDisplay = "";
                switch (status.trim()) {
                    case "new": statusDisplay = "Mới"; break;
                    case "reviewed": statusDisplay = "Đã xem"; break;
                    case "interviewed": statusDisplay = "Phỏng vấn"; break;
                    case "offered": statusDisplay = "Mời nhận việc"; break;
                    case "rejected": statusDisplay = "Từ chối"; break;
                    default: statusDisplay = status;
                }
                
                String successMessage = "Đã cập nhật trạng thái thành \"" + statusDisplay + "\" thành công!";
                if (emailSent && !emailMessage.isEmpty()) {
                    successMessage += " " + emailMessage;
                    session.setAttribute("emailSent", true);
                }
                
                session.setAttribute("success", successMessage);
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
        
        // Redirect back to applications page
        response.sendRedirect("applications");
    }
}
