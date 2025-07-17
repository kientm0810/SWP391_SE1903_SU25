package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.InterviewSchedule;

/**
 * DAO cho Interview Schedule
 */
public class InterviewScheduleDAO {
    private static final Logger LOGGER = Logger.getLogger(InterviewScheduleDAO.class.getName());

    /**
     * Lấy danh sách phỏng vấn sắp tới cần gửi nhắc nhở
     */
    public List<InterviewSchedule> getUpcomingInterviewsForReminder() {
        List<InterviewSchedule> interviews = new ArrayList<>();
        String sql = "SELECT is.*, js.full_name as candidate_name, p.title as job_title, r.company_name " +
                    "FROM Interview_Schedule is " +
                    "INNER JOIN Applications a ON is.application_id = a.id " +
                    "INNER JOIN Job_Seekers js ON a.job_seeker_id = js.id " +
                    "INNER JOIN Posts p ON a.job_listing_id = p.id " +
                    "INNER JOIN Recruiter r ON p.user_id = r.id " +
                    "WHERE is.scheduled_date BETWEEN GETDATE() AND DATEADD(hour, 24, GETDATE()) " +
                    "AND (is.reminder_sent = 0 OR is.reminder_sent IS NULL) " +
                    "AND is.status = 'scheduled'";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                InterviewSchedule interview = mapResultSetToInterviewSchedule(rs);
                interviews.add(interview);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting upcoming interviews for reminder", e);
        }
        return interviews;
    }

    /**
     * Cập nhật trạng thái đã gửi nhắc nhở
     */
    public boolean updateReminderSent(int interviewId, boolean reminderSent) {
        String sql = "UPDATE Interview_Schedule SET reminder_sent = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, reminderSent);
            ps.setInt(2, interviewId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating reminder sent for interview ID: " + interviewId, e);
        }
        return false;
    }

    /**
     * Lấy lịch phỏng vấn theo application ID
     */
    public List<InterviewSchedule> getInterviewsByApplication(int applicationId) {
        List<InterviewSchedule> interviews = new ArrayList<>();
        String sql = "SELECT * FROM Interview_Schedule WHERE application_id = ? ORDER BY scheduled_date DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, applicationId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    InterviewSchedule interview = mapResultSetToInterviewSchedule(rs);
                    interviews.add(interview);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting interviews by application: " + applicationId, e);
        }
        return interviews;
    }

    /**
     * Tạo lịch phỏng vấn mới
     */
    public boolean createInterviewSchedule(InterviewSchedule interview) {
        String sql = "INSERT INTO Interview_Schedule (application_id, interview_type, scheduled_date, " +
                    "duration_minutes, location, interviewer_name, interviewer_email, candidate_email, " +
                    "status, notes, reminder_sent, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, interview.getApplicationId());
            ps.setString(2, interview.getInterviewType());
            ps.setTimestamp(3, interview.getScheduledDate());
            ps.setObject(4, interview.getDurationMinutes());
            ps.setString(5, interview.getLocation());
            ps.setString(6, interview.getInterviewerName());
            ps.setString(7, interview.getInterviewerEmail());
            ps.setString(8, interview.getCandidateEmail());
            ps.setString(9, interview.getStatus());
            ps.setString(10, interview.getNotes());
            ps.setBoolean(11, interview.getReminderSent());
            ps.setInt(12, interview.getCreatedBy());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        interview.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating interview schedule", e);
        }
        return false;
    }

    /**
     * Cập nhật lịch phỏng vấn
     */
    public boolean updateInterviewSchedule(InterviewSchedule interview) {
        String sql = "UPDATE Interview_Schedule SET interview_type = ?, scheduled_date = ?, " +
                    "duration_minutes = ?, location = ?, interviewer_name = ?, interviewer_email = ?, " +
                    "candidate_email = ?, status = ?, notes = ?, reminder_sent = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, interview.getInterviewType());
            ps.setTimestamp(2, interview.getScheduledDate());
            ps.setObject(3, interview.getDurationMinutes());
            ps.setString(4, interview.getLocation());
            ps.setString(5, interview.getInterviewerName());
            ps.setString(6, interview.getInterviewerEmail());
            ps.setString(7, interview.getCandidateEmail());
            ps.setString(8, interview.getStatus());
            ps.setString(9, interview.getNotes());
            ps.setBoolean(10, interview.getReminderSent());
            ps.setInt(11, interview.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating interview schedule: " + interview.getId(), e);
        }
        return false;
    }

    /**
     * Xóa lịch phỏng vấn
     */
    public boolean deleteInterviewSchedule(int id) {
        String sql = "DELETE FROM Interview_Schedule WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting interview schedule: " + id, e);
        }
        return false;
    }

    /**
     * Lấy lịch phỏng vấn theo ID
     */
    public InterviewSchedule getInterviewScheduleById(int id) {
        String sql = "SELECT * FROM Interview_Schedule WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToInterviewSchedule(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting interview schedule by ID: " + id, e);
        }
        return null;
    }

    /**
     * Map ResultSet thành InterviewSchedule object
     */
    private InterviewSchedule mapResultSetToInterviewSchedule(ResultSet rs) throws SQLException {
        InterviewSchedule interview = new InterviewSchedule();
        interview.setId(rs.getInt("id"));
        interview.setApplicationId(rs.getInt("application_id"));
        interview.setInterviewType(rs.getString("interview_type"));
        interview.setScheduledDate(rs.getTimestamp("scheduled_date"));
        interview.setDurationMinutes(rs.getObject("duration_minutes") != null ? rs.getInt("duration_minutes") : null);
        interview.setLocation(rs.getString("location"));
        interview.setInterviewerName(rs.getString("interviewer_name"));
        interview.setInterviewerEmail(rs.getString("interviewer_email"));
        interview.setCandidateEmail(rs.getString("candidate_email"));
        interview.setStatus(rs.getString("status"));
        interview.setNotes(rs.getString("notes"));
        interview.setReminderSent(rs.getObject("reminder_sent") != null ? rs.getBoolean("reminder_sent") : null);
        interview.setCreatedAt(rs.getTimestamp("created_at"));
        interview.setCreatedBy(rs.getInt("created_by"));
        
        // Additional fields
        if (rs.getMetaData().getColumnCount() > 12) {
            interview.setCandidateName(rs.getString("candidate_name"));
            interview.setJobTitle(rs.getString("job_title"));
            interview.setCompanyName(rs.getString("company_name"));
        }
        
        return interview;
    }
} 