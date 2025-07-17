package daos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.EmailHistory;

/**
 * DAO cho Email History
 */
public class EmailHistoryDAO {
    private static final Logger LOGGER = Logger.getLogger(EmailHistoryDAO.class.getName());

    /**
     * Lưu lịch sử email
     */
    public boolean saveEmailHistory(EmailHistory emailHistory) {
        String sql = "INSERT INTO Email_History (application_id, interview_schedule_id, template_name, recipient_email, subject, body_html, status, error_message, sent_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setObject(1, emailHistory.getApplicationId());
            ps.setObject(2, emailHistory.getInterviewScheduleId());
            ps.setString(3, emailHistory.getTemplateName());
            ps.setString(4, emailHistory.getRecipientEmail());
            ps.setString(5, emailHistory.getSubject());
            ps.setString(6, emailHistory.getBodyHtml());
            ps.setString(7, emailHistory.getStatus());
            ps.setString(8, emailHistory.getErrorMessage());
            ps.setTimestamp(9, emailHistory.getSentAt());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        emailHistory.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error saving email history", e);
        }
        return false;
    }

    /**
     * Lấy lịch sử email theo application ID
     */
    public List<EmailHistory> getEmailHistoryByApplication(int applicationId) {
        List<EmailHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM Email_History WHERE application_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, applicationId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EmailHistory emailHistory = mapResultSetToEmailHistory(rs);
                    history.add(emailHistory);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting email history by application: " + applicationId, e);
        }
        return history;
    }

    /**
     * Lấy lịch sử email theo email người nhận
     */
    public List<EmailHistory> getEmailHistoryByRecipient(String recipientEmail) {
        List<EmailHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM Email_History WHERE recipient_email = ? ORDER BY created_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, recipientEmail);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EmailHistory emailHistory = mapResultSetToEmailHistory(rs);
                    history.add(emailHistory);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting email history by recipient: " + recipientEmail, e);
        }
        return history;
    }

    /**
     * Lấy lịch sử email theo trạng thái
     */
    public List<EmailHistory> getEmailHistoryByStatus(String status) {
        List<EmailHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM Email_History WHERE status = ? ORDER BY created_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EmailHistory emailHistory = mapResultSetToEmailHistory(rs);
                    history.add(emailHistory);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting email history by status: " + status, e);
        }
        return history;
    }

    /**
     * Lấy tất cả lịch sử email (có phân trang)
     */
    public List<EmailHistory> getAllEmailHistory(int offset, int limit) {
        List<EmailHistory> history = new ArrayList<>();
        String sql = "SELECT * FROM Email_History ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EmailHistory emailHistory = mapResultSetToEmailHistory(rs);
                    history.add(emailHistory);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all email history", e);
        }
        return history;
    }

    /**
     * Cập nhật trạng thái email
     */
    public boolean updateEmailStatus(int id, String status, String errorMessage) {
        String sql = "UPDATE Email_History SET status = ?, error_message = ?, sent_at = GETDATE() WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setString(2, errorMessage);
            ps.setInt(3, id);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating email status: " + id, e);
        }
        return false;
    }

    /**
     * Đếm tổng số email đã gửi
     */
    public int getTotalEmailCount() {
        String sql = "SELECT COUNT(*) FROM Email_History";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting total email count", e);
        }
        return 0;
    }

    /**
     * Đếm số email theo trạng thái
     */
    public int getEmailCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM Email_History WHERE status = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting email count by status: " + status, e);
        }
        return 0;
    }

    /**
     * Xóa lịch sử email cũ (trước ngày chỉ định)
     */
    public boolean deleteOldEmailHistory(Date beforeDate) {
        String sql = "DELETE FROM Email_History WHERE created_at < ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDate(1, beforeDate);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting old email history", e);
        }
        return false;
    }

    /**
     * Map ResultSet thành EmailHistory object
     */
    private EmailHistory mapResultSetToEmailHistory(ResultSet rs) throws SQLException {
        EmailHistory emailHistory = new EmailHistory();
        emailHistory.setId(rs.getInt("id"));
        emailHistory.setApplicationId(rs.getObject("application_id") != null ? rs.getInt("application_id") : null);
        emailHistory.setInterviewScheduleId(rs.getObject("interview_schedule_id") != null ? rs.getInt("interview_schedule_id") : null);
        emailHistory.setTemplateName(rs.getString("template_name"));
        emailHistory.setRecipientEmail(rs.getString("recipient_email"));
        emailHistory.setSubject(rs.getString("subject"));
        emailHistory.setBodyHtml(rs.getString("body_html"));
        emailHistory.setStatus(rs.getString("status"));
        emailHistory.setErrorMessage(rs.getString("error_message"));
        emailHistory.setSentAt(rs.getTimestamp("sent_at"));
        emailHistory.setCreatedAt(rs.getTimestamp("created_at"));
        return emailHistory;
    }
} 