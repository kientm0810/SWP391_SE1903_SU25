package utils;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import daos.ApplicationDAO;
import daos.EmailHistoryDAO;
import daos.EmailTemplateDAO;
import daos.InterviewScheduleDAO;
import daos.JobAlertDAO;
import daos.JobSeekerDAO;
import daos.RecruiterDAO;
import models.Application;
import models.EmailHistory;
import models.EmailTemplate;
import models.InterviewSchedule;
import models.JobAlert;
import models.JobSeeker;
import models.Posts;
import models.Recruiter;

/**
 * Service class for handling all email operations
 */
public class EmailService {
    private static final Logger LOGGER = Logger.getLogger(EmailService.class.getName());
    
    private final EmailTemplateDAO emailTemplateDAO;
    private final EmailHistoryDAO emailHistoryDAO;
    private final ApplicationDAO applicationDAO;
    private final JobSeekerDAO jobSeekerDAO;
    private final RecruiterDAO recruiterDAO;
    private final InterviewScheduleDAO interviewScheduleDAO;
    private final JobAlertDAO jobAlertDAO;
    
    public EmailService() {
        this.emailTemplateDAO = new EmailTemplateDAO();
        this.emailHistoryDAO = new EmailHistoryDAO();
        this.applicationDAO = new ApplicationDAO();
        this.jobSeekerDAO = new JobSeekerDAO();
        this.recruiterDAO = new RecruiterDAO();
        this.interviewScheduleDAO = new InterviewScheduleDAO();
        this.jobAlertDAO = new JobAlertDAO();
    }
    
    /**
     * Send application confirmation email to job seeker
     */
    public boolean sendApplicationConfirmationEmail(int applicationId) {
        try {
            // Get application details
            Application application = applicationDAO.getApplicationById(applicationId, 0); // We'll get recruiter ID later
            if (application == null) {
                LOGGER.warning("Application not found: " + applicationId);
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(application.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + application.getJobSeekerId());
                return false;
            }
            
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("application_received");
            if (template == null) {
                LOGGER.warning("Application confirmation template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", jobSeeker.getFullName());
            variables.put("job_title", application.getPost().getTitle());
            variables.put("company_name", application.getPost().getCompanyName());
            variables.put("application_date", application.getCreatedAt().toString());
            variables.put("application_id", String.valueOf(applicationId));
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email
            boolean sent = JavaMail.sendEmail(jobSeeker.getEmail(), subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setApplicationId(applicationId);
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(jobSeeker.getEmail());
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending application confirmation email", e);
            return false;
        }
    }
    
    /**
     * Send interview invitation email to job seeker
     */
    public boolean sendInterviewInvitationEmail(int applicationId, int interviewScheduleId) {
        try {
            // Get interview schedule details
            InterviewSchedule interview = interviewScheduleDAO.getInterviewScheduleById(interviewScheduleId);
            if (interview == null) {
                LOGGER.warning("Interview schedule not found: " + interviewScheduleId);
                return false;
            }
            
            // Get application details
            Application application = applicationDAO.getApplicationById(applicationId, 0);
            if (application == null) {
                LOGGER.warning("Application not found: " + applicationId);
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(application.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + application.getJobSeekerId());
                return false;
            }
            
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("interview_invitation");
            if (template == null) {
                LOGGER.warning("Interview invitation template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", jobSeeker.getFullName());
            variables.put("job_title", application.getPost().getTitle());
            variables.put("company_name", application.getPost().getCompanyName());
            variables.put("interview_date", interview.getScheduledDate().toString());
            variables.put("interview_location", interview.getLocation());
            variables.put("interviewer_name", interview.getInterviewerName());
            variables.put("interview_type", interview.getInterviewType());
            variables.put("duration_minutes", String.valueOf(interview.getDurationMinutes()));
            variables.put("notes", interview.getNotes() != null ? interview.getNotes() : "");
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email
            boolean sent = JavaMail.sendEmail(jobSeeker.getEmail(), subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setApplicationId(applicationId);
            emailHistory.setInterviewScheduleId(interviewScheduleId);
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(jobSeeker.getEmail());
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending interview invitation email", e);
            return false;
        }
    }
    
    /**
     * Send rejection email to job seeker
     */
    public boolean sendRejectionEmail(int applicationId, String rejectionReason) {
        try {
            // Get application details
            Application application = applicationDAO.getApplicationById(applicationId, 0);
            if (application == null) {
                LOGGER.warning("Application not found: " + applicationId);
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(application.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + application.getJobSeekerId());
                return false;
            }
            
            // Send email directly to job seeker's email
            return sendRejectionEmailByEmail(jobSeeker.getEmail(), jobSeeker.getFullName(), 
                application.getPost().getTitle(), application.getPost().getCompanyName(), 
                rejectionReason, application.getId());
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending rejection email", e);
            return false;
        }
    }
    
    /**
     * Send rejection email directly to email address
     */
    public boolean sendRejectionEmailByEmail(String email, String candidateName, String jobTitle, String companyName, String rejectionReason, int applicationId) {
        try {
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("rejection");
            if (template == null) {
                LOGGER.warning("Application rejection template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", candidateName);
            variables.put("job_title", jobTitle);
            variables.put("company_name", companyName);
            variables.put("rejection_reason", rejectionReason != null ? rejectionReason : "Không phù hợp với yêu cầu công việc");
            variables.put("application_date", new Timestamp(System.currentTimeMillis()).toString());
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email directly to the email address
            boolean sent = JavaMail.sendEmail(email, subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setApplicationId(applicationId);
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(email);
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending rejection email to: " + email, e);
            return false;
        }
    }
    
    /**
     * Send acceptance email to job seeker
     */
    public boolean sendAcceptanceEmail(int applicationId, String offerDetails) {
        try {
            // Get application details
            Application application = applicationDAO.getApplicationById(applicationId, 0);
            if (application == null) {
                LOGGER.warning("Application not found: " + applicationId);
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(application.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + application.getJobSeekerId());
                return false;
            }
            
            // Send email directly to job seeker's email
            return sendAcceptanceEmailByEmail(jobSeeker.getEmail(), jobSeeker.getFullName(), 
                application.getPost().getTitle(), application.getPost().getCompanyName(), 
                offerDetails, application.getId());
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending acceptance email", e);
            return false;
        }
    }
    
    /**
     * Send acceptance email directly to email address
     */
    public boolean sendAcceptanceEmailByEmail(String email, String candidateName, String jobTitle, String companyName, String offerDetails, int applicationId) {
        try {
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("offer");
            if (template == null) {
                LOGGER.warning("Application acceptance template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", candidateName);
            variables.put("job_title", jobTitle);
            variables.put("company_name", companyName);
            variables.put("offer_details", offerDetails != null ? offerDetails : "Chúc mừng! Bạn đã được chọn cho vị trí này.");
            variables.put("application_date", new Timestamp(System.currentTimeMillis()).toString());
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email directly to the email address
            boolean sent = JavaMail.sendEmail(email, subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setApplicationId(applicationId);
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(email);
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending acceptance email to: " + email, e);
            return false;
        }
    }
    
    /**
     * Send interview reminder email to job seeker
     */
    public boolean sendInterviewReminderEmail(int interviewScheduleId) {
        try {
            // Get interview schedule details
            InterviewSchedule interview = interviewScheduleDAO.getInterviewScheduleById(interviewScheduleId);
            if (interview == null) {
                LOGGER.warning("Interview schedule not found: " + interviewScheduleId);
                return false;
            }
            
            // Get application details
            Application application = applicationDAO.getApplicationById(interview.getApplicationId(), 0);
            if (application == null) {
                LOGGER.warning("Application not found: " + interview.getApplicationId());
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(application.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + application.getJobSeekerId());
                return false;
            }
            
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("interview_reminder");
            if (template == null) {
                LOGGER.warning("Interview reminder template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", jobSeeker.getFullName());
            variables.put("job_title", application.getPost().getTitle());
            variables.put("company_name", application.getPost().getCompanyName());
            variables.put("interview_date", interview.getScheduledDate().toString());
            variables.put("interview_location", interview.getLocation());
            variables.put("interviewer_name", interview.getInterviewerName());
            variables.put("interview_type", interview.getInterviewType());
            variables.put("duration_minutes", String.valueOf(interview.getDurationMinutes()));
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email
            boolean sent = JavaMail.sendEmail(jobSeeker.getEmail(), subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setApplicationId(interview.getApplicationId());
            emailHistory.setInterviewScheduleId(interviewScheduleId);
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(jobSeeker.getEmail());
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            // Update reminder sent flag
            interviewScheduleDAO.updateReminderSent(interviewScheduleId, true);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending interview reminder email", e);
            return false;
        }
    }
    
    /**
     * Send job alert email to job seeker
     */
    public boolean sendJobAlertEmail(int jobAlertId, List<Posts> matchingJobs) {
        try {
            // Get job alert details
            JobAlert jobAlert = jobAlertDAO.getJobAlertById(jobAlertId);
            if (jobAlert == null) {
                LOGGER.warning("Job alert not found: " + jobAlertId);
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(jobAlert.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + jobAlert.getJobSeekerId());
                return false;
            }
            
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("job_alert");
            if (template == null) {
                LOGGER.warning("Job alert template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", jobSeeker.getFullName());
            variables.put("alert_name", jobAlert.getAlertName());
            variables.put("keyword", jobAlert.getKeyword() != null ? jobAlert.getKeyword() : "");
            variables.put("location", jobAlert.getLocation() != null ? jobAlert.getLocation() : "");
            variables.put("job_count", String.valueOf(matchingJobs.size()));
            
            // Build job list HTML
            StringBuilder jobListHtml = new StringBuilder();
            for (Posts job : matchingJobs) {
                jobListHtml.append("<div style='margin-bottom: 15px; padding: 10px; border: 1px solid #ddd; border-radius: 5px;'>");
                jobListHtml.append("<h3 style='margin: 0 0 5px 0; color: #333;'>").append(job.getTitle()).append("</h3>");
                jobListHtml.append("<p style='margin: 0 0 5px 0; color: #666;'>").append(job.getCompanyName()).append("</p>");
                jobListHtml.append("<p style='margin: 0 0 5px 0; color: #666;'>").append(job.getLocation()).append("</p>");
                                 if (job.getSalary() != null && !job.getSalary().trim().isEmpty()) {
                     jobListHtml.append("<p style='margin: 0; color: #28a745; font-weight: bold;'>");
                     jobListHtml.append("Lương: ").append(job.getSalary());
                     jobListHtml.append("</p>");
                 }
                jobListHtml.append("</div>");
            }
            variables.put("job_list", jobListHtml.toString());
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email
            boolean sent = JavaMail.sendEmail(jobSeeker.getEmail(), subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(jobSeeker.getEmail());
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            // Update last sent timestamp
            jobAlertDAO.updateLastSent(jobAlertId, new Timestamp(System.currentTimeMillis()));
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending job alert email", e);
            return false;
        }
    }
    
    /**
     * Send interview completed email to job seeker
     */
    public boolean sendInterviewCompletedEmail(int applicationId) {
        try {
            // Get application details
            Application application = applicationDAO.getApplicationById(applicationId, 0);
            if (application == null) {
                LOGGER.warning("Application not found: " + applicationId);
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(application.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + application.getJobSeekerId());
                return false;
            }
            
            // Send email directly to job seeker's email
            return sendInterviewCompletedEmailByEmail(jobSeeker.getEmail(), jobSeeker.getFullName(), 
                application.getPost().getTitle(), application.getPost().getCompanyName(), application.getId());
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending interview completed email", e);
            return false;
        }
    }
    
    /**
     * Send interview completed email directly to email address
     */
    public boolean sendInterviewCompletedEmailByEmail(String email, String candidateName, String jobTitle, String companyName, int applicationId) {
        try {
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("interview_completed");
            if (template == null) {
                LOGGER.warning("Interview completed template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", candidateName);
            variables.put("job_title", jobTitle);
            variables.put("company_name", companyName);
            variables.put("application_date", new Timestamp(System.currentTimeMillis()).toString());
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email directly to the email address
            boolean sent = JavaMail.sendEmail(email, subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setApplicationId(applicationId);
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(email);
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending interview completed email to: " + email, e);
            return false;
        }
    }
    
    /**
     * Send application reviewed email to job seeker
     */
    public boolean sendApplicationReviewedEmail(int applicationId) {
        try {
            // Get application details
            Application application = applicationDAO.getApplicationById(applicationId, 0);
            if (application == null) {
                LOGGER.warning("Application not found: " + applicationId);
                return false;
            }
            
            // Get job seeker details
            JobSeeker jobSeeker = jobSeekerDAO.getSpeccificJobSeeker(application.getJobSeekerId());
            if (jobSeeker == null) {
                LOGGER.warning("Job seeker not found: " + application.getJobSeekerId());
                return false;
            }
            
            // Send email directly to job seeker's email
            return sendApplicationReviewedEmailByEmail(jobSeeker.getEmail(), jobSeeker.getFullName(), 
                application.getPost().getTitle(), application.getPost().getCompanyName(), application.getId());
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending application reviewed email", e);
            return false;
        }
    }
    
    /**
     * Send application reviewed email directly to email address
     */
    public boolean sendApplicationReviewedEmailByEmail(String email, String candidateName, String jobTitle, String companyName, int applicationId) {
        try {
            // Get email template
            EmailTemplate template = emailTemplateDAO.getTemplateByType("application_reviewed");
            if (template == null) {
                LOGGER.warning("Application reviewed template not found");
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("candidate_name", candidateName);
            variables.put("job_title", jobTitle);
            variables.put("company_name", companyName);
            variables.put("application_date", new Timestamp(System.currentTimeMillis()).toString());
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email directly to the email address
            boolean sent = JavaMail.sendEmail(email, subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setApplicationId(applicationId);
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(email);
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending application reviewed email to: " + email, e);
            return false;
        }
    }
    
    /**
     * Send account verification email to recruiter
     */
    public boolean sendAccountVerificationEmail(int recruiterId, String verificationStatus) {
        try {
            // Get recruiter details
            Recruiter recruiter = recruiterDAO.getRecruiterById(recruiterId);
            if (recruiter == null) {
                LOGGER.warning("Recruiter not found: " + recruiterId);
                return false;
            }
            
            // Get email template based on verification status
            String templateType = "verification_" + verificationStatus.toLowerCase();
            EmailTemplate template = emailTemplateDAO.getTemplateByType(templateType);
            if (template == null) {
                LOGGER.warning("Verification template not found: " + templateType);
                return false;
            }
            
            // Prepare email data
            Map<String, String> variables = new HashMap<>();
            variables.put("recruiter_name", recruiter.getFullName());
            variables.put("company_name", recruiter.getCompanyName());
            variables.put("verification_status", verificationStatus);
            variables.put("verification_date", new Timestamp(System.currentTimeMillis()).toString());
            
            // Process template
            String subject = processTemplate(template.getSubject(), variables);
            String bodyHtml = processTemplate(template.getBodyHtml(), variables);
            
            // Send email
            boolean sent = JavaMail.sendEmail(recruiter.getEmail(), subject, bodyHtml);
            
            // Save email history
            EmailHistory emailHistory = new EmailHistory();
            emailHistory.setTemplateName(template.getTemplateName());
            emailHistory.setRecipientEmail(recruiter.getEmail());
            emailHistory.setSubject(subject);
            emailHistory.setBodyHtml(bodyHtml);
            emailHistory.setStatus(sent ? "sent" : "failed");
            emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
            emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            emailHistoryDAO.saveEmailHistory(emailHistory);
            
            return sent;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error sending account verification email", e);
            return false;
        }
    }
    
    /**
     * Process template by replacing variables
     */
    private String processTemplate(String template, Map<String, String> variables) {
        String result = template;
        for (Map.Entry<String, String> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            result = result.replace(placeholder, entry.getValue() != null ? entry.getValue() : "");
        }
        return result;
    }
    
    /**
     * Get email statistics
     */
    public Map<String, Object> getEmailStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        try {
            stats.put("total_emails", emailHistoryDAO.getTotalEmailCount());
            stats.put("sent_emails", emailHistoryDAO.getEmailCountByStatus("sent"));
            stats.put("failed_emails", emailHistoryDAO.getEmailCountByStatus("failed"));
            stats.put("pending_emails", emailHistoryDAO.getEmailCountByStatus("pending"));
            
            // Get recent email history
            List<EmailHistory> recentEmails = emailHistoryDAO.getAllEmailHistory(0, 10);
            stats.put("recent_emails", recentEmails);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting email statistics", e);
        }
        
        return stats;
    }
} 