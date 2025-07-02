/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author MY PC
 */
public final class Constants {
    private Constants() {
        // Private constructor to prevent instantiation
    }
    
    // User Roles
    public static final String ADMIN_ROLE = "admin";
    public static final String RECRUITER_ROLE = "recruiter";
    public static final String JOB_SEEKER_ROLE = "job_seeker";
    
    // User Status
    public static final String STATUS_ACTIVE = "active";
    public static final String STATUS_INACTIVE = "inactive";
    public static final String STATUS_DELETED = "deleted";
    
    // Page Paths
    public static final String LOGIN_PAGE = "login.jsp";
    public static final String ADMIN_HOME_PAGE = "admin_home.jsp";
    public static final String RECRUITER_HOME_PAGE = "recruiter_home.jsp";
    public static final String JOB_SEEKER_HOME_PAGE = "jobseeker_home.jsp";
    public static final String HOME_PAGE = "home.jsp";
    public static final String REGISTER_PAGE = "register.jsp";
    public static final String RESET_PASSWORD_PAGE = "reset_password.jsp";
    public static final String JOB_LISTING_PAGE = "job_listing.jsp";
    public static final String JOB_DETAIL_PAGE = "job_details.jsp";
    public static final String JOB_FORM_PAGE = "job_form.jsp";
    public static final String POST_LIST_PAGE = "posts.jsp";
    public static final String POST_DETAIL_PAGE = "post_detail.jsp";
    public static final String CREATE_POST_PAGE = "create_post.jsp";
    public static final String EDIT_POST_PAGE = "edit_post.jsp";
    
    // Verification Status for Recruiters
    public static final String VERIFICATION_PENDING = "pending";
    public static final String VERIFICATION_VERIFIED = "verified";
    public static final String VERIFICATION_REJECTED = "rejected";
    
    // Job Status
    public static final String JOB_STATUS_ACTIVE = "active";
    public static final String JOB_STATUS_PAUSED = "paused";
    public static final String JOB_STATUS_FILLED = "filled";
    public static final String JOB_STATUS_EXPIRED = "expired";
    
    // Application Status
    public static final String APPLICATION_NEW = "new";
    public static final String APPLICATION_REVIEWED = "reviewed";
    public static final String APPLICATION_INTERVIEWED = "interviewed";
    public static final String APPLICATION_OFFERED = "offered";
    public static final String APPLICATION_REJECTED = "rejected";
    
    // Job Types
    public static final String JOB_TYPE_FULL_TIME = "full_time";
    public static final String JOB_TYPE_PART_TIME = "part_time";
    public static final String JOB_TYPE_CONTRACT = "contract";
    public static final String JOB_TYPE_INTERNSHIP = "internship";
    public static final String JOB_TYPE_FREELANCE = "freelance";
    
    // Post Types
    public static final String POST_TYPE_POST = "post";
    public static final String POST_TYPE_COMMENT = "comment";
    public static final String POST_TYPE_LIKE = "like";
    
    // Post Status
    public static final String POST_STATUS_ACTIVE = "active";
    public static final String POST_STATUS_INACTIVE = "inactive";
    public static final String POST_STATUS_DELETED = "deleted";
    
    // Transaction Types
    public static final String TRANSACTION_TYPE_FEATURED_JOB = "featured_job";
    public static final String TRANSACTION_TYPE_ADVERTISING = "advertising";
    public static final String TRANSACTION_TYPE_SUBSCRIPTION = "subscription";
    public static final String TRANSACTION_TYPE_CV_SERVICE = "cv_service";
    public static final String TRANSACTION_TYPE_CHECKOUT = "checkout";
    public static final String TRANSACTION_TYPE_OTHER = "other";
    
    // Transaction Status
    public static final String TRANSACTION_STATUS_PENDING = "pending";
    public static final String TRANSACTION_STATUS_COMPLETED = "completed";
    public static final String TRANSACTION_STATUS_FAILED = "failed";
    
    // Report Types
    public static final String REPORT_TYPE_EMPLOYER = "employer_list";
    public static final String REPORT_TYPE_REVENUE = "revenue";
    public static final String REPORT_TYPE_LOYALTY = "loyalty";
    public static final String REPORT_TYPE_JOB_SEEKER = "job_seeker_activity";
    public static final String REPORT_TYPE_APPLICATION = "job_application_stats";
    
    // File Upload Constants
    public static final String UPLOAD_DIRECTORY = "uploads";
    public static final String PROFILE_PICTURES_DIR = "profile_pictures";
    public static final String COMPANY_LOGOS_DIR = "company_logos";
    public static final String CV_FILES_DIR = "cv_files";
    public static final int MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    
    // Pagination Constants
    public static final int DEFAULT_PAGE_SIZE = 10;
    public static final int MAX_PAGE_SIZE = 50;
    
    // Session Attributes
    public static final String SESSION_USER = "user";
    public static final String SESSION_USER_ID = "userId";
    public static final String SESSION_USER_TYPE = "userType";
    public static final String SESSION_ERROR = "error";
    public static final String SESSION_SUCCESS = "success";
    
    // Date Format Patterns
    public static final String DATE_FORMAT = "yyyy-MM-dd";
    public static final String DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    
    // Email Configuration
    public static final String SMTP_HOST = "smtp.gmail.com";
    public static final int SMTP_PORT = 587;
    public static final String EMAIL_FROM = "noreply@jobfinding.com";
    public static final String EMAIL_USERNAME = "fcareinsurance@gmail.com";
    public static final String EMAIL_PASSWWORD = "cifxowsnfwdnywed";
    // Xac thuc
    public static final String XACTHUC = "<html>"
                    + " <body style='font-family: Arial, sans-serif;'>"
                    + "     <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>"
                    + "         <h2 style='color: #2e7d32; margin-bottom: 20px;'>Xác thực tài khoản</h2>"
                    + "         <p>Xin chào,</p>"
                    + "         <p>Tài khoản của bạn đã được phê duyệt</p>"
                    + "         <p><strong>Từ giờ bạn có thể:</strong></p>"
                    + "         <ul>"
                    + "             <li>Đăng bài tuyển dụng.</li>"
                    + "             <li>Đăng kí các gói đăng tin của chúng tôi.</li>"
                    + "         </ul>"
                    + "         <p style='margin-top: 30px;'>Trân trọng,<br>Đội ngũ Job Finding</p>"
                    + "     </div>"
                    + " </body>"
                    + "</html>";
    public static final String TITLEXACTHUC = "[Notification - Job Finding] ACCOUNT_APPROVED";
    
    // Security Constants
    public static final int PASSWORD_MIN_LENGTH = 8;
    public static final int MAX_LOGIN_ATTEMPTS = 5;
    public static final int ACCOUNT_LOCK_DURATION = 30; // minutes
    public static final int SESSION_TIMEOUT = 30 * 60; // 30 minutes in seconds
    
    // API Response Messages
    public static final String SUCCESS_MESSAGE = "Operation completed successfully";
    public static final String ERROR_MESSAGE = "An error occurred";
    public static final String UNAUTHORIZED_MESSAGE = "Unauthorized access";
    public static final String INVALID_INPUT_MESSAGE = "Invalid input provided";
    public static final String NOT_FOUND_MESSAGE = "Resource not found";
    
    // Validation Messages
    public static final String REQUIRED_FIELDS_MESSAGE = "Please provide all required fields";
    public static final String INVALID_CREDENTIALS_MESSAGE = "Invalid username or password";
    public static final String ACCOUNT_INACTIVE_MESSAGE = "Account is inactive";
    public static final String ACCOUNT_REJECTED_MESSAGE = "Your account has been rejected. Please contact support.";
    public static final String ACCOUNT_PENDING_MESSAGE = "Your account is pending verification. Please wait for approval.";
    public static final String LOGIN_ERROR_MESSAGE = "An error occurred during login. Please try again.";
} 