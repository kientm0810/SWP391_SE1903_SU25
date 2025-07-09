package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.Application;
import utils.JavaMail;

public class ApplicationDAO extends DBContext {
    
    public List<Application> getRecentApplications(int recruiterId, int limit) throws SQLException {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, j.company_name, js.full_name, js.email FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_listing_id = j.id " +
                    "INNER JOIN Job_Seekers js ON a.job_seeker_id = js.id " +
                    "WHERE j.recruiter_id = ? " +
                    "ORDER BY a.created_at DESC LIMIT ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("a.id"));
                app.setStatus(rs.getString("a.status"));
                app.setJobListingId(rs.getInt("a.job_listing_id"));
                app.setJobSeekerId(rs.getInt("a.job_seeker_id"));
                app.setCvFile(rs.getString("a.cv_file"));
                app.setCoverLetter(rs.getString("a.cover_letter"));
                applications.add(app);
            }
        }
        return applications;
    }
    
    public int getTotalApplicationsCount(int recruiterId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_id = j.id " +
                    "WHERE j.recruiter_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public int getNewApplicationsCount(int recruiterId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_id = j.id " +
                    "WHERE j.recruiter_id = ? AND a.status = 'pending'";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public boolean updateApplicationStatus(int applicationId, String status, int recruiterId) throws SQLException {
        String sql = "UPDATE Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_listing_id = j.id " +
                    "SET a.status = ? " +
                    "WHERE a.id = ? AND j.recruiter_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            ps.setInt(3, recruiterId);
            boolean updated = ps.executeUpdate() > 0;
            if (updated) {
                // Gửi email thông báo cho ứng viên
                Application app = getApplicationById(applicationId, recruiterId);
                if (app != null) {
                    // Lấy email ứng viên (giả sử đã join được email trong getApplicationById)
                    String email = "";
                    String name = "Ứng viên";
                    // Nếu Application có trường email, fullName thì lấy, nếu không thì cần join thêm
                    try {
                        java.lang.reflect.Method getEmail = app.getClass().getMethod("getEmail");
                        email = (String) getEmail.invoke(app);
                    } catch(Exception e) {}
                    try {
                        java.lang.reflect.Method getFullName = app.getClass().getMethod("getFullName");
                        name = (String) getFullName.invoke(app);
                    } catch(Exception e) {}
                    if (email != null && !email.isEmpty()) {
                        String subject = "Cập nhật trạng thái hồ sơ ứng tuyển";
                        String body = "Xin chào " + name + ",\n\n" +
                            "Trạng thái hồ sơ ứng tuyển của bạn đã được cập nhật thành: " + status + ".\n" +
                            "Vui lòng đăng nhập hệ thống để xem chi tiết.\n\n" +
                            "Trân trọng,\nHệ thống JobFinding";
                        JavaMail.sendMail(email, subject, body);
                    }
                }
            }
            return updated;
        }
    }
    
    public Application getApplicationById(int applicationId, int recruiterId) throws SQLException {
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, j.company_name, js.full_name, js.email FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_listing_id = j.id " +
                    "INNER JOIN Job_Seekers js ON a.job_seeker_id = js.id " +
                    "WHERE a.id = ? AND j.recruiter_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ps.setInt(2, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("a.id"));
                app.setStatus(rs.getString("a.status"));
                app.setJobListingId(rs.getInt("a.job_listing_id"));
                app.setJobSeekerId(rs.getInt("a.job_seeker_id"));
                app.setCvFile(rs.getString("a.cv_file"));
                app.setCoverLetter(rs.getString("a.cover_letter"));
                return app;
            }
        }
        return null;
    }
    
    public int insertApplication(Application app) throws SQLException {
        String sql = "INSERT INTO Applications (job_listing_id, job_seeker_id, cv_file, cover_letter, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, app.getJobListingId());
            ps.setInt(2, app.getJobSeekerId());
            ps.setString(3, app.getCvFile());
            ps.setString(4, app.getCoverLetter());
            ps.setString(5, app.getStatus());
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating application failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating application failed, no ID obtained.");
                }
            }
        }
    }
    
    public List<Application> getApplicationsByJobSeekerId(int jobSeekerId) throws SQLException {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM Applications WHERE job_seeker_id = ? ORDER BY id DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Application app = new Application();
                    app.setId(rs.getInt("id"));
                    app.setJobListingId(rs.getInt("job_listing_id"));
                    app.setJobSeekerId(rs.getInt("job_seeker_id"));
                    app.setCvFile(rs.getString("cv_file"));
                    app.setCoverLetter(rs.getString("cover_letter"));
                    app.setStatus(rs.getString("status"));
                    list.add(app);
                }
            }
        }
        return list;
    }
} 