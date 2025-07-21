package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.SavedJob;

public class SavedJobDAO {
    
    public boolean saveJob(SavedJob savedJob) throws SQLException {
        String sql = "INSERT INTO Saved_Jobs (job_seeker_id, post_id, saved_at) VALUES (?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, savedJob.getJobSeekerId());
            ps.setInt(2, savedJob.getPostId());
            ps.setTimestamp(3, savedJob.getSavedAt());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        savedJob.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }
    
    public boolean isJobSaved(Integer jobSeekerId, int postId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Saved_Jobs WHERE job_seeker_id = ? AND post_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, postId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    public List<SavedJob> getSavedJobsByJobSeeker(Integer jobSeekerId) throws SQLException {
        List<SavedJob> savedJobs = new ArrayList<>();
        String sql = "SELECT * FROM Saved_Jobs WHERE job_seeker_id = ? ORDER BY saved_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    savedJobs.add(mapResultSetToSavedJob(rs));
                }
            }
        }
        return savedJobs;
    }
    
    public boolean deleteSavedJob(Integer jobSeekerId, int postId) throws SQLException {
        String sql = "DELETE FROM Saved_Jobs WHERE job_seeker_id = ? AND post_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, postId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    public int getSavedJobCount(Integer jobSeekerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Saved_Jobs WHERE job_seeker_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public List<SavedJob> getRecentSavedJobs(Integer jobSeekerId, int limit) throws SQLException {
        List<SavedJob> savedJobs = new ArrayList<>();
        String sql = "SELECT TOP(?) * FROM Saved_Jobs WHERE job_seeker_id = ? ORDER BY saved_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ps.setInt(2, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    savedJobs.add(mapResultSetToSavedJob(rs));
                }
            }
        }
        return savedJobs;
    }
    
    // Methods for recruiter functionality
    public List<SavedJob> getSavedJobsByRecruiter(Integer recruiterId) throws SQLException {
        List<SavedJob> savedJobs = new ArrayList<>();
        String sql = "SELECT * FROM Saved_Jobs WHERE recruiter_id = ? ORDER BY saved_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, recruiterId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    savedJobs.add(mapResultSetToSavedJob(rs));
                }
            }
        }
        return savedJobs;
    }
    
    public boolean isJobSavedByJobSeeker(int jobSeekerId, int postId) throws SQLException {
        return isJobSaved(jobSeekerId, postId);
    }
    
    public boolean isJobSavedByRecruiter(int recruiterId, int postId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Saved_Jobs WHERE recruiter_id = ? AND post_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, recruiterId);
            ps.setInt(2, postId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    public boolean saveJobForJobSeeker(int jobSeekerId, int postId) throws SQLException {
        SavedJob savedJob = new SavedJob(jobSeekerId, postId);
        return saveJob(savedJob);
    }
    
    public boolean saveJobForRecruiter(int recruiterId, int postId) throws SQLException {
        String sql = "INSERT INTO Saved_Jobs (recruiter_id, post_id, saved_at) VALUES (?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, recruiterId);
            ps.setInt(2, postId);
            ps.setTimestamp(3, new java.sql.Timestamp(System.currentTimeMillis()));
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    public boolean unsaveJobForJobSeeker(int jobSeekerId, int postId) throws SQLException {
        return deleteSavedJob(jobSeekerId, postId);
    }
    
    public boolean unsaveJobForRecruiter(int recruiterId, int postId) throws SQLException {
        String sql = "DELETE FROM Saved_Jobs WHERE recruiter_id = ? AND post_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, recruiterId);
            ps.setInt(2, postId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    private SavedJob mapResultSetToSavedJob(ResultSet rs) throws SQLException {
        SavedJob savedJob = new SavedJob();
        savedJob.setId(rs.getInt("id"));
        savedJob.setJobSeekerId(rs.getInt("job_seeker_id"));
        savedJob.setRecruiterId(rs.getInt("recruiter_id"));
        savedJob.setPostId(rs.getInt("post_id"));
        savedJob.setSavedAt(rs.getTimestamp("saved_at"));
        return savedJob;
    }
} 