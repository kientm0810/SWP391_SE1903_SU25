package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.JobAlert;

/**
 * DAO cho Job Alert
 */
public class JobAlertDAO {
    private static final Logger LOGGER = Logger.getLogger(JobAlertDAO.class.getName());

    /**
     * Lấy danh sách job alerts đang hoạt động
     */
    public List<JobAlert> getActiveJobAlerts() {
        List<JobAlert> alerts = new ArrayList<>();
        String sql = "SELECT ja.*, js.email as recipient_email, js.full_name as candidate_name " +
                    "FROM Job_Alerts ja " +
                    "INNER JOIN Job_Seekers js ON ja.job_seeker_id = js.id " +
                    "WHERE ja.is_active = 1";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                JobAlert alert = mapResultSetToJobAlert(rs);
                alerts.add(alert);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting active job alerts", e);
        }
        return alerts;
    }

    /**
     * Tìm việc làm phù hợp với job alert
     */
    public List<Object[]> findMatchingJobs(JobAlert alert) {
        List<Object[]> matchingJobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.title, r.company_name, p.location, p.salary, CONCAT('http://localhost:9999/JobFinding/view-post?id=', p.id) as job_url ");
        sql.append("FROM Posts p ");
        sql.append("INNER JOIN Recruiter r ON p.user_id = r.id ");
        sql.append("WHERE p.status = 'active' AND p.deadline >= GETDATE() ");
        
        List<Object> parameters = new ArrayList<>();
        int paramIndex = 1;
        
        // Thêm điều kiện tìm kiếm
        if (alert.getKeyword() != null && !alert.getKeyword().trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR p.job_description LIKE ? OR p.requirements LIKE ?) ");
            String keyword = "%" + alert.getKeyword().trim() + "%";
            parameters.add(keyword);
            parameters.add(keyword);
            parameters.add(keyword);
            paramIndex += 3;
        }
        
        if (alert.getLocation() != null && !alert.getLocation().trim().isEmpty()) {
            sql.append("AND p.location LIKE ? ");
            parameters.add("%" + alert.getLocation().trim() + "%");
            paramIndex++;
        }
        
        if (alert.getIndustry() != null && !alert.getIndustry().trim().isEmpty()) {
            sql.append("AND p.industry LIKE ? ");
            parameters.add("%" + alert.getIndustry().trim() + "%");
            paramIndex++;
        }
        
        if (alert.getJobType() != null && !alert.getJobType().trim().isEmpty()) {
            sql.append("AND p.job_type = ? ");
            parameters.add(alert.getJobType().trim());
            paramIndex++;
        }
        
        if (alert.getMinSalary() != null) {
            sql.append("AND CAST(REPLACE(REPLACE(p.salary, ',', ''), ' ', '') AS DECIMAL(12,2)) >= ? ");
            parameters.add(alert.getMinSalary());
            paramIndex++;
        }
        
        if (alert.getMaxSalary() != null) {
            sql.append("AND CAST(REPLACE(REPLACE(p.salary, ',', ''), ' ', '') AS DECIMAL(12,2)) <= ? ");
            parameters.add(alert.getMaxSalary());
            paramIndex++;
        }
        
        sql.append("ORDER BY p.created_at DESC ");
        sql.append("OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY");
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            // Set parameters
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Object[] job = new Object[5];
                    job[0] = rs.getString("title");
                    job[1] = rs.getString("company_name");
                    job[2] = rs.getString("location");
                    job[3] = rs.getString("salary");
                    job[4] = rs.getString("job_url");
                    matchingJobs.add(job);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding matching jobs for alert ID: " + alert.getId(), e);
        }
        return matchingJobs;
    }

    /**
     * Cập nhật thời gian gửi cuối
     */
    public boolean updateLastSent(int alertId, Timestamp lastSent) {
        String sql = "UPDATE Job_Alerts SET last_sent = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setTimestamp(1, lastSent);
            ps.setInt(2, alertId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating last sent for alert ID: " + alertId, e);
        }
        return false;
    }

    /**
     * Lấy job alerts theo job seeker ID
     */
    public List<JobAlert> getJobAlertsByJobSeeker(int jobSeekerId) {
        List<JobAlert> alerts = new ArrayList<>();
        String sql = "SELECT * FROM Job_Alerts WHERE job_seeker_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    JobAlert alert = mapResultSetToJobAlert(rs);
                    alerts.add(alert);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting job alerts by job seeker: " + jobSeekerId, e);
        }
        return alerts;
    }

    /**
     * Tạo job alert mới
     */
    public boolean createJobAlert(JobAlert alert) {
        String sql = "INSERT INTO Job_Alerts (job_seeker_id, alert_name, keyword, location, industry, " +
                    "job_type, min_salary, max_salary, frequency, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, alert.getJobSeekerId());
            ps.setString(2, alert.getAlertName());
            ps.setString(3, alert.getKeyword());
            ps.setString(4, alert.getLocation());
            ps.setString(5, alert.getIndustry());
            ps.setString(6, alert.getJobType());
            ps.setObject(7, alert.getMinSalary());
            ps.setObject(8, alert.getMaxSalary());
            ps.setString(9, alert.getFrequency());
            ps.setBoolean(10, alert.getIsActive());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        alert.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating job alert", e);
        }
        return false;
    }

    /**
     * Cập nhật job alert
     */
    public boolean updateJobAlert(JobAlert alert) {
        String sql = "UPDATE Job_Alerts SET alert_name = ?, keyword = ?, location = ?, industry = ?, " +
                    "job_type = ?, min_salary = ?, max_salary = ?, frequency = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, alert.getAlertName());
            ps.setString(2, alert.getKeyword());
            ps.setString(3, alert.getLocation());
            ps.setString(4, alert.getIndustry());
            ps.setString(5, alert.getJobType());
            ps.setObject(6, alert.getMinSalary());
            ps.setObject(7, alert.getMaxSalary());
            ps.setString(8, alert.getFrequency());
            ps.setBoolean(9, alert.getIsActive());
            ps.setInt(10, alert.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating job alert: " + alert.getId(), e);
        }
        return false;
    }

    /**
     * Xóa job alert
     */
    public boolean deleteJobAlert(int id) {
        String sql = "DELETE FROM Job_Alerts WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting job alert: " + id, e);
        }
        return false;
    }

    /**
     * Kích hoạt/vô hiệu hóa job alert
     */
    public boolean toggleJobAlertStatus(int id, boolean isActive) {
        String sql = "UPDATE Job_Alerts SET is_active = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, isActive);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error toggling job alert status: " + id, e);
        }
        return false;
    }

    /**
     * Lấy job alert theo ID
     */
    public JobAlert getJobAlertById(int id) {
        String sql = "SELECT ja.*, js.email as recipient_email, js.full_name as candidate_name " +
                    "FROM Job_Alerts ja " +
                    "INNER JOIN Job_Seekers js ON ja.job_seeker_id = js.id " +
                    "WHERE ja.id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToJobAlert(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting job alert by ID: " + id, e);
        }
        return null;
    }

    /**
     * Map ResultSet thành JobAlert object
     */
    private JobAlert mapResultSetToJobAlert(ResultSet rs) throws SQLException {
        JobAlert alert = new JobAlert();
        alert.setId(rs.getInt("id"));
        alert.setJobSeekerId(rs.getInt("job_seeker_id"));
        alert.setAlertName(rs.getString("alert_name"));
        alert.setKeyword(rs.getString("keyword"));
        alert.setLocation(rs.getString("location"));
        alert.setIndustry(rs.getString("industry"));
        alert.setJobType(rs.getString("job_type"));
        alert.setMinSalary(rs.getObject("min_salary") != null ? rs.getDouble("min_salary") : null);
        alert.setMaxSalary(rs.getObject("max_salary") != null ? rs.getDouble("max_salary") : null);
        alert.setFrequency(rs.getString("frequency"));
        alert.setIsActive(rs.getObject("is_active") != null ? rs.getBoolean("is_active") : null);
        alert.setCreatedAt(rs.getTimestamp("created_at"));
        alert.setLastSent(rs.getTimestamp("last_sent"));
        
        // Additional fields
        if (rs.getMetaData().getColumnCount() > 12) {
            alert.setRecipientEmail(rs.getString("recipient_email"));
            alert.setCandidateName(rs.getString("candidate_name"));
        }
        
        return alert;
    }
} 