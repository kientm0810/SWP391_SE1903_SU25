package controllers;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import daos.EmailHistoryDAO;
import daos.EmailTemplateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.EmailHistory;
import models.EmailTemplate;
import models.Recruiter;
import utils.EmailService;
import utils.JavaMail;

@WebServlet(name = "SendCustomEmailController", urlPatterns = {"/send-custom-email"})
public class SendCustomEmailController extends HttpServlet {

    private EmailService emailService;
    private EmailTemplateDAO emailTemplateDAO;
    private EmailHistoryDAO emailHistoryDAO;

    @Override
    public void init() throws ServletException {
        // Lazy initialization - will initialize when first used
    }
    
    private void initializeIfNeeded() {
        try {
            if (emailTemplateDAO == null) {
                emailTemplateDAO = new EmailTemplateDAO();
                System.out.println("EmailTemplateDAO initialized");
            }
            if (emailHistoryDAO == null) {
                emailHistoryDAO = new EmailHistoryDAO();
                System.out.println("EmailHistoryDAO initialized");
            }
            if (emailService == null) {
                emailService = new EmailService();
                System.out.println("EmailService initialized");
            }
        } catch (Exception e) {
            System.err.println("Error in initializeIfNeeded: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        initializeIfNeeded();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"recruiter".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Recruiter recruiter = (Recruiter) session.getAttribute("user");
        
        // Get parameters from URL
        String recipientEmail = request.getParameter("recipientEmail");
        String candidateName = request.getParameter("candidateName");
        String jobTitle = request.getParameter("jobTitle");
        String companyName = request.getParameter("companyName");
        String applicationId = request.getParameter("applicationId");
        
        // Validate required parameters
        if (recipientEmail == null || recipientEmail.trim().isEmpty()) {
            session.setAttribute("error", "Email người nhận không được để trống.");
            response.sendRedirect("applications");
            return;
        }
        
        // Set attributes for the form
        request.setAttribute("recipientEmail", recipientEmail);
        request.setAttribute("candidateName", candidateName);
        request.setAttribute("jobTitle", jobTitle);
        request.setAttribute("companyName", companyName);
        request.setAttribute("applicationId", applicationId);
        request.setAttribute("recruiterName", recruiter.getFullName());
        
        // Forward to the email form
        request.getRequestDispatcher("/send-email.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        initializeIfNeeded();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"recruiter".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Recruiter recruiter = (Recruiter) session.getAttribute("user");
        
        // Get form parameters
        String recipientEmail = request.getParameter("recipientEmail");
        String candidateName = request.getParameter("candidateName");
        String jobTitle = request.getParameter("jobTitle");
        String companyName = request.getParameter("companyName");
        String applicationIdStr = request.getParameter("applicationId");
        String emailType = request.getParameter("emailType");
        String subject = request.getParameter("subject");
        String emailContent = request.getParameter("emailContent");
        String emailContentHidden = request.getParameter("emailContentHidden");
        
        // Use hidden field content if main field is empty (for TinyMCE)
        if ((emailContent == null || emailContent.trim().isEmpty()) && 
            emailContentHidden != null && !emailContentHidden.trim().isEmpty()) {
            emailContent = emailContentHidden;
        }
        
        
        
        // Get additional form fields for different email types
        // Interview invitation fields
        String interviewDate = request.getParameter("interviewDate");
        String interviewTime = request.getParameter("interviewTime");
        String interviewLocation = request.getParameter("interviewLocation");
        String interviewerName = request.getParameter("interviewerName");
        String interviewType = request.getParameter("interviewType");
        String interviewDuration = request.getParameter("interviewDuration");
        
        // Interview reminder fields
        String reminderInterviewDate = request.getParameter("reminderInterviewDate");
        String reminderInterviewTime = request.getParameter("reminderInterviewTime");
        String reminderLocation = request.getParameter("reminderLocation");
        String reminderInterviewer = request.getParameter("reminderInterviewer");
        String reminderNotes = request.getParameter("reminderNotes");
        
        // Rejection fields
        String rejectionReason = request.getParameter("rejectionReason");
        String customRejectionReason = request.getParameter("customRejectionReason");
        String futureOpportunities = request.getParameter("futureOpportunities");
        
        // Offer fields
        String salaryOffer = request.getParameter("salaryOffer");
        String startDate = request.getParameter("startDate");
        String workingTime = request.getParameter("workingTime");
        String workLocation = request.getParameter("workLocation");
        String responseDeadline = request.getParameter("responseDeadline");
        String benefits = request.getParameter("benefits");
        String offerNotes = request.getParameter("offerNotes");
        
        // Validation
        if (recipientEmail == null || recipientEmail.trim().isEmpty()) {
            session.setAttribute("error", "Email người nhận không được để trống.");
            response.sendRedirect("applications");
            return;
        }
        
        if (emailType == null || emailType.trim().isEmpty()) {
            session.setAttribute("error", "Vui lòng chọn loại email.");
            response.sendRedirect("send-email?recipientEmail=" + recipientEmail + "&candidateName=" + candidateName + "&jobTitle=" + jobTitle + "&companyName=" + companyName + "&applicationId=" + applicationIdStr);
            return;
        }
        
        try {
            boolean emailSent = false;
            String successMessage = "";
            
            // Send template-based email (including custom)
            List<EmailTemplate> templates = emailTemplateDAO.getTemplatesByType(emailType.trim());
            if (templates.isEmpty()) {
                session.setAttribute("error", "Không tìm thấy template email cho loại này.");
                response.sendRedirect("send-email?recipientEmail=" + recipientEmail + "&candidateName=" + candidateName + "&jobTitle=" + jobTitle + "&companyName=" + companyName + "&applicationId=" + applicationIdStr);
                return;
            }
            
            // Use the first template found
            EmailTemplate template = templates.get(0);
            
            // Process template variables with additional fields
            String processedSubject = processTemplate(template.getSubject(), 
                candidateName, jobTitle, companyName, recruiter.getFullName(),
                interviewDate, interviewTime, interviewLocation, interviewerName, interviewType, interviewDuration,
                reminderInterviewDate, reminderInterviewTime, reminderLocation, reminderInterviewer, reminderNotes,
                rejectionReason, customRejectionReason, futureOpportunities,
                salaryOffer, startDate, workingTime, workLocation, responseDeadline, benefits, offerNotes,
                subject, emailContent);
            String processedContent = processTemplate(template.getBodyHtml(), 
                candidateName, jobTitle, companyName, recruiter.getFullName(),
                interviewDate, interviewTime, interviewLocation, interviewerName, interviewType, interviewDuration,
                reminderInterviewDate, reminderInterviewTime, reminderLocation, reminderInterviewer, reminderNotes,
                rejectionReason, customRejectionReason, futureOpportunities,
                salaryOffer, startDate, workingTime, workLocation, responseDeadline, benefits, offerNotes,
                subject, emailContent);
            
            // Send email
            emailSent = JavaMail.sendEmail(recipientEmail, processedSubject, processedContent);
            
            // Save email history with correct status
            String emailStatus = emailSent ? "sent" : "failed";
            boolean saved = saveEmailHistory(request, recipientEmail, processedSubject, processedContent, 
                           applicationIdStr, template.getTemplateName(), emailType.trim(), emailStatus);
            
            System.out.println("Email sent: " + emailSent + ", Email saved to history: " + saved);
            
            if (emailSent) {
                successMessage = "Email đã được gửi thành công!";
                session.setAttribute("success", successMessage);
                // Redirect to email history page to show the sent email
                response.sendRedirect("recruiter-email-history");
                return;
            } else {
                session.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception in SendCustomEmailController: " + e.getMessage());
            System.out.println("Exception type: " + e.getClass().getName());
            session.setAttribute("error", "Có lỗi xảy ra khi gửi email: " + e.getMessage());
        }
        
        // Redirect back to applications page only if there was an error
        response.sendRedirect("applications");
    }
    
    /**
     * Process template by replacing variables
     */
    private String processTemplate(String template, String candidateName, String jobTitle, String companyName, String recruiterName,
                                 String interviewDate, String interviewTime, String interviewLocation, String interviewerName, String interviewType, String interviewDuration,
                                 String reminderInterviewDate, String reminderInterviewTime, String reminderLocation, String reminderInterviewer, String reminderNotes,
                                 String rejectionReason, String customRejectionReason, String futureOpportunities,
                                 String salaryOffer, String startDate, String workingTime, String workLocation, String responseDeadline, String benefits, String offerNotes,
                                 String subject, String emailContent) {
        String result = template;
        
        // Basic variables
        result = result.replace("{{candidateName}}", candidateName != null ? candidateName : "");
        result = result.replace("{{jobTitle}}", jobTitle != null ? jobTitle : "");
        result = result.replace("{{companyName}}", companyName != null ? companyName : "");
        result = result.replace("{{recruiterName}}", recruiterName != null ? recruiterName : "");
        result = result.replace("{{applicationDate}}", new Timestamp(System.currentTimeMillis()).toString());
        
        // Interview invitation variables
        result = result.replace("{{interviewDate}}", interviewDate != null ? interviewDate : "");
        result = result.replace("{{interviewTime}}", interviewTime != null ? interviewTime : "");
        result = result.replace("{{location}}", interviewLocation != null ? interviewLocation : "Văn phòng công ty");
        result = result.replace("{{interviewerName}}", interviewerName != null ? interviewerName : "Người phỏng vấn");
        result = result.replace("{{interviewType}}", interviewType != null ? interviewType : "Phỏng vấn trực tiếp");
        result = result.replace("{{duration}}", interviewDuration != null ? interviewDuration : "60");
        
        // Interview reminder variables
        result = result.replace("{{reminderInterviewDate}}", reminderInterviewDate != null ? reminderInterviewDate : "");
        result = result.replace("{{reminderInterviewTime}}", reminderInterviewTime != null ? reminderInterviewTime : "");
        result = result.replace("{{reminderLocation}}", reminderLocation != null ? reminderLocation : "Văn phòng công ty");
        result = result.replace("{{reminderInterviewer}}", reminderInterviewer != null ? reminderInterviewer : "Người phỏng vấn");
        result = result.replace("{{reminderNotes}}", reminderNotes != null ? reminderNotes : "");
        
        // Rejection variables
        String finalRejectionReason = (rejectionReason != null && rejectionReason.equals("Khác")) ? 
            (customRejectionReason != null ? customRejectionReason : "Không phù hợp với yêu cầu công việc") :
            (rejectionReason != null ? rejectionReason : "Không phù hợp với yêu cầu công việc");
        result = result.replace("{{rejectionReason}}", finalRejectionReason);
        result = result.replace("{{futureOpportunities}}", futureOpportunities != null ? futureOpportunities : "");
        
        // Offer variables
        result = result.replace("{{salaryOffer}}", salaryOffer != null ? salaryOffer : "Thỏa thuận");
        result = result.replace("{{startDate}}", startDate != null ? startDate : "");
        result = result.replace("{{workingTime}}", workingTime != null ? workingTime : "8 giờ/ngày");
        result = result.replace("{{workLocation}}", workLocation != null ? workLocation : "Văn phòng công ty");
        result = result.replace("{{responseDeadline}}", responseDeadline != null ? responseDeadline : "7");
        result = result.replace("{{benefits}}", benefits != null ? benefits : "");
        result = result.replace("{{offerNotes}}", offerNotes != null ? offerNotes : "");
        
        // Custom email variables
        result = result.replace("{{subject}}", subject != null ? subject : "");
        result = result.replace("{{emailContent}}", emailContent != null ? emailContent : "");
        
        return result;
    }
    
    /**
     * Save email history
     */
    private boolean saveEmailHistory(HttpServletRequest request, String recipientEmail, String subject, String content, 
                                 String applicationIdStr, String templateName, String emailType, String status) {
        try {
            System.out.println("=== Starting saveEmailHistory ===");
            System.out.println("Recipient: " + recipientEmail);
            System.out.println("Subject: " + subject);
            System.out.println("Template: " + templateName);
            System.out.println("Status: " + status);
            
            if (emailHistoryDAO == null) {
                System.out.println("ERROR: emailHistoryDAO is null!");
                return false;
            }
            
            EmailHistory emailHistory = new EmailHistory();
            
            if (applicationIdStr != null && !applicationIdStr.trim().isEmpty()) {
                emailHistory.setApplicationId(Integer.parseInt(applicationIdStr.trim()));
                System.out.println("Application ID: " + emailHistory.getApplicationId());
            }
            
            // Get recruiter from session
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null && "recruiter".equals(session.getAttribute("role"))) {
                Recruiter recruiter = (Recruiter) session.getAttribute("user");
                emailHistory.setRecruiterId(recruiter.getId());
                System.out.println("Recruiter ID: " + recruiter.getId());
            } else {
                System.out.println("ERROR: No recruiter found in session!");
                return false;
            }
            
            emailHistory.setTemplateName(templateName);
            emailHistory.setRecipientEmail(recipientEmail);
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(content);
            emailHistory.setStatus(status);
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            System.out.println("EmailHistory object created: " + emailHistory.toString());
            
            boolean saved = emailHistoryDAO.saveEmailHistory(emailHistory);
            System.out.println("Email history save result: " + saved);
            System.out.println("=== End saveEmailHistory ===");
            return saved;
            
        } catch (Exception e) {
            System.out.println("Error saving email history: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
} 