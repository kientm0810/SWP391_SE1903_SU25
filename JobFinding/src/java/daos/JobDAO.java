package daos;

import context.DBContext;
import models.JobListing;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO extends DBContext {
    
    public List<JobListing> getJobListingsByRecruiter(int recruiterId) throws SQLException {
        List<JobListing> jobs = new ArrayList<>();
        String sql = "SELECT * FROM Job_Listings WHERE recruiter_id = ? AND status = 'active'";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                JobListing job = new JobListing();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setRecruiterName(rs.getString("recruiter_name"));
                job.setLocation(rs.getString("location"));
                job.setSalaryMin(rs.getDouble("salary_min"));
                job.setSalaryMax(rs.getDouble("salary_max"));
                job.setDescription(rs.getString("description"));
                job.setRequirements(rs.getString("requirements"));
                job.setCreatedAt(rs.getTimestamp("created_at"));
                job.setStatus(rs.getString("status"));
                jobs.add(job);
            }
        }
        return jobs;
    }
    
    public JobListing getJobListingById(int jobId) throws SQLException {
        String sql = "SELECT * FROM Job_Listings WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                JobListing job = new JobListing();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setRecruiterName(rs.getString("recruiter_name"));
                job.setLocation(rs.getString("location"));
                job.setSalaryMin(rs.getDouble("salary_min"));
                job.setSalaryMax(rs.getDouble("salary_max"));
                job.setDescription(rs.getString("description"));
                job.setRequirements(rs.getString("requirements"));
                job.setCreatedAt(rs.getTimestamp("created_at"));
                job.setStatus(rs.getString("status"));
                return job;
            }
        }
        return null;
    }
    
    public boolean createJobListing(JobListing job, int recruiterId) throws SQLException {
        String sql = "INSERT INTO Job_Listings (recruiter_id, recruiter_name, title, location, salary_min, " +
                    "salary_max, description, requirements, created_at, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 'active')";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setString(2, job.getRecruiterName());
            ps.setString(3, job.getTitle());
            ps.setString(4, job.getLocation());
            ps.setDouble(5, job.getSalaryMin());
            ps.setDouble(6, job.getSalaryMax());
            ps.setString(7, job.getDescription());
            ps.setString(8, job.getRequirements());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean updateJobListing(JobListing job, int recruiterId) throws SQLException {
        String sql = "UPDATE Job_Listings SET title = ?, location = ?, salary_min = ?, " +
                    "salary_max = ?, description = ?, requirements = ? " +
                    "WHERE id = ? AND recruiter_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, job.getTitle());
            ps.setString(2, job.getLocation());
            ps.setDouble(3, job.getSalaryMin());
            ps.setDouble(4, job.getSalaryMax());
            ps.setString(5, job.getDescription());
            ps.setString(6, job.getRequirements());
            ps.setInt(7, job.getId());
            ps.setInt(8, recruiterId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean deleteJobListing(int jobId, int recruiterId) throws SQLException {
        String sql = "UPDATE Job_Listings SET status = 'deleted' WHERE id = ? AND recruiter_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, recruiterId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    public List<JobListing> searchJobs(String keyword) throws SQLException {
        List<JobListing> jobs = new ArrayList<>();
        String sql = "SELECT * FROM Job_Listings WHERE status = 'active' AND " +
                    "(title LIKE ? OR description LIKE ? OR requirements LIKE ? OR location LIKE ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobListing job = new JobListing();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setRecruiterName(rs.getString("recruiter_name"));
                job.setLocation(rs.getString("location"));
                job.setSalaryMin(rs.getDouble("salary_min"));
                job.setSalaryMax(rs.getDouble("salary_max"));
                job.setDescription(rs.getString("description"));
                job.setRequirements(rs.getString("requirements"));
                job.setCreatedAt(rs.getTimestamp("created_at"));
                job.setStatus(rs.getString("status"));
                jobs.add(job);
            }
        }
        return jobs;
    }
} 