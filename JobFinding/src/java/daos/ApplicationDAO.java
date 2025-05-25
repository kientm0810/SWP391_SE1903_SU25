package daos;

import context.DBContext;
import models.Application;
import models.JobListing;
import models.JobSeeker;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO extends DBContext {
    
    public List<Application> getRecentApplications(int recruiterId, int limit) throws SQLException {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, j.*, js.* FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_id = j.id " +
                    "INNER JOIN Job_Seekers js ON a.jobseeker_id = js.id " +
                    "WHERE j.recruiter_id = ? " +
                    "ORDER BY a.created_at DESC LIMIT ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("a.id"));
                app.setStatus(rs.getString("a.status"));
                app.setCreatedAt(rs.getTimestamp("a.created_at"));
                
                // Set job details
                JobListing job = new JobListing();
                job.setId(rs.getInt("j.id"));
                job.setTitle(rs.getString("j.title"));
                job.setLocation(rs.getString("j.location"));
                app.setJob(job);
                
                // Set jobseeker details
                JobSeeker jobseeker = new JobSeeker();
                jobseeker.setId(rs.getInt("js.id"));
                jobseeker.setFullName(rs.getString("js.full_name"));
                jobseeker.setEmail(rs.getString("js.email"));
                app.setJobseeker(jobseeker);
                
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
                    "INNER JOIN Job_Listings j ON a.job_id = j.id " +
                    "SET a.status = ? " +
                    "WHERE a.id = ? AND j.recruiter_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            ps.setInt(3, recruiterId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    public Application getApplicationById(int applicationId, int recruiterId) throws SQLException {
        String sql = "SELECT a.*, j.*, js.* FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_id = j.id " +
                    "INNER JOIN Job_Seekers js ON a.jobseeker_id = js.id " +
                    "WHERE a.id = ? AND j.recruiter_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ps.setInt(2, recruiterId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("a.id"));
                app.setStatus(rs.getString("a.status"));
                app.setCreatedAt(rs.getTimestamp("a.created_at"));
                
                // Set job details
                JobListing job = new JobListing();
                job.setId(rs.getInt("j.id"));
                job.setTitle(rs.getString("j.title"));
                job.setLocation(rs.getString("j.location"));
                app.setJob(job);
                
                // Set jobseeker details
                JobSeeker jobseeker = new JobSeeker();
                jobseeker.setId(rs.getInt("js.id"));
                jobseeker.setFullName(rs.getString("js.full_name"));
                jobseeker.setEmail(rs.getString("js.email"));
                app.setJobseeker(jobseeker);
                
                return app;
            }
        }
        return null;
    }
} 