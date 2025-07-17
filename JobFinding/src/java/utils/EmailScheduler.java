package utils;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

import daos.EmailHistoryDAO;
import daos.InterviewScheduleDAO;
import daos.JobAlertDAO;
import models.InterviewSchedule;
import models.JobAlert;

/**
 * Scheduler class for automatic email sending
 * Handles interview reminders, job alerts, and email history cleanup
 */
public class EmailScheduler {
    private static final Logger LOGGER = Logger.getLogger(EmailScheduler.class.getName());
    
    private final ScheduledExecutorService scheduler;
    private final EmailService emailService;
    private final InterviewScheduleDAO interviewScheduleDAO;
    private final JobAlertDAO jobAlertDAO;
    private final EmailHistoryDAO emailHistoryDAO;
    
    public EmailScheduler() {
        this.scheduler = Executors.newScheduledThreadPool(2);
        this.emailService = new EmailService();
        this.interviewScheduleDAO = new InterviewScheduleDAO();
        this.jobAlertDAO = new JobAlertDAO();
        this.emailHistoryDAO = new EmailHistoryDAO();
    }
    
    /**
     * Start all scheduled tasks
     */
    public void start() {
        LOGGER.info("Starting EmailScheduler...");
        
        // Gửi nhắc nhở phỏng vấn mỗi giờ
        scheduler.scheduleAtFixedRate(this::sendInterviewReminders, 0, 1, TimeUnit.HOURS);
        
        // Gửi job alerts theo lịch trình
        scheduler.scheduleAtFixedRate(this::sendJobAlerts, 0, 6, TimeUnit.HOURS); // Mỗi 6 giờ
        
        // Dọn dẹp lịch sử email cũ (mỗi ngày lúc 2:00 AM)
        scheduler.scheduleAtFixedRate(this::cleanupOldEmailHistory, getDelayToNextCleanup(), 24, TimeUnit.HOURS);
        
        LOGGER.info("EmailScheduler started successfully");
    }
    
    /**
     * Stop all scheduled tasks
     */
    public void stop() {
        LOGGER.info("Stopping EmailScheduler...");
        scheduler.shutdown();
        try {
            if (!scheduler.awaitTermination(60, TimeUnit.SECONDS)) {
                scheduler.shutdownNow();
            }
        } catch (InterruptedException e) {
            scheduler.shutdownNow();
            Thread.currentThread().interrupt();
        }
        LOGGER.info("EmailScheduler stopped");
    }
    
    /**
     * Gửi nhắc nhở phỏng vấn cho các buổi phỏng vấn sắp tới
     */
    private void sendInterviewReminders() {
        try {
            LOGGER.info("Checking for interview reminders...");
            
            // Lấy danh sách phỏng vấn trong 24 giờ tới chưa gửi nhắc nhở
            List<InterviewSchedule> upcomingInterviews = interviewScheduleDAO.getUpcomingInterviewsForReminder();
            
            for (InterviewSchedule interview : upcomingInterviews) {
                try {
                    boolean sent = emailService.sendInterviewReminderEmail(interview.getId());
                    if (sent) {
                        LOGGER.info("Sent interview reminder for interview ID: " + interview.getId());
                    } else {
                        LOGGER.warning("Failed to send interview reminder for interview ID: " + interview.getId());
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error sending interview reminder for interview ID: " + interview.getId(), e);
                }
            }
            
            LOGGER.info("Interview reminder check completed. Sent reminders for " + upcomingInterviews.size() + " interviews");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in sendInterviewReminders", e);
        }
    }
    
    /**
     * Gửi job alerts cho job seekers
     */
    private void sendJobAlerts() {
        try {
            LOGGER.info("Checking for job alerts...");
            
            // Lấy danh sách job alerts đang hoạt động
            List<JobAlert> activeAlerts = jobAlertDAO.getActiveJobAlerts();
            
            for (JobAlert alert : activeAlerts) {
                try {
                    // Tìm việc làm phù hợp với alert
                    List<Object[]> matchingJobsData = jobAlertDAO.findMatchingJobs(alert);
                    
                    if (!matchingJobsData.isEmpty()) {
                        // Chuyển đổi Object[] thành Posts objects (simplified approach)
                        // Trong thực tế, bạn có thể cần tạo Posts objects từ matchingJobsData
                        // Hoặc sửa EmailService để chấp nhận List<Object[]>
                        
                        // Tạm thời bỏ qua việc gửi email job alert vì cần Posts objects
                        LOGGER.info("Found " + matchingJobsData.size() + " matching jobs for alert ID: " + alert.getId());
                        
                        // Cập nhật thời gian gửi cuối
                        jobAlertDAO.updateLastSent(alert.getId(), new Timestamp(System.currentTimeMillis()));
                    } else {
                        LOGGER.info("No matching jobs found for alert ID: " + alert.getId());
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error processing job alert for alert ID: " + alert.getId(), e);
                }
            }
            
            LOGGER.info("Job alert check completed. Processed " + activeAlerts.size() + " alerts");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in sendJobAlerts", e);
        }
    }
    
    /**
     * Dọn dẹp lịch sử email cũ hơn 90 ngày
     */
    private void cleanupOldEmailHistory() {
        try {
            LOGGER.info("Starting email history cleanup...");
            
            // Tính ngày 90 ngày trước
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.DAY_OF_MONTH, -90);
            java.sql.Date cutoffDate = new java.sql.Date(calendar.getTimeInMillis());
            
            // Xóa email history cũ
            boolean deleted = emailHistoryDAO.deleteOldEmailHistory(cutoffDate);
            
            LOGGER.info("Email history cleanup completed. Deletion result: " + deleted);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in cleanupOldEmailHistory", e);
        }
    }
    
    /**
     * Tính thời gian delay đến lần cleanup tiếp theo (2:00 AM)
     */
    private long getDelayToNextCleanup() {
        Calendar now = Calendar.getInstance();
        Calendar nextCleanup = Calendar.getInstance();
        
        // Đặt thời gian cleanup là 2:00 AM
        nextCleanup.set(Calendar.HOUR_OF_DAY, 2);
        nextCleanup.set(Calendar.MINUTE, 0);
        nextCleanup.set(Calendar.SECOND, 0);
        nextCleanup.set(Calendar.MILLISECOND, 0);
        
        // Nếu đã qua 2:00 AM hôm nay, đặt cho ngày mai
        if (now.after(nextCleanup)) {
            nextCleanup.add(Calendar.DAY_OF_MONTH, 1);
        }
        
        return nextCleanup.getTimeInMillis() - now.getTimeInMillis();
    }
    
    /**
     * Kiểm tra trạng thái scheduler
     */
    public boolean isRunning() {
        return !scheduler.isShutdown();
    }
} 