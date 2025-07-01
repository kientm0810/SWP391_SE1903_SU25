package daos;

import context.DBContext;
import models.SavedJob;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SavedJobDAO {
    private Connection conn;

    public SavedJobDAO() throws Exception {
        conn = new DBContext().getConnection();
    }

    // =========================================================================
    // == PHƯƠNG THỨC MỚI CHO JOB SEEKER VÀ RECRUITER
    // =========================================================================

    // --- Methods for Job Seeker ---

    public List<SavedJob> getSavedJobsByJobSeeker(int jobSeekerId) {
        List<SavedJob> savedJobs = new ArrayList<>();
        String sql = "SELECT id, job_seeker_id, post_id, saved_at FROM Saved_Jobs WHERE job_seeker_id = ? ORDER BY saved_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavedJob savedJob = new SavedJob();
                savedJob.setId(rs.getInt("id"));
                savedJob.setJob_seeker_id(rs.getInt("job_seeker_id"));
                savedJob.setPostId(rs.getInt("post_id"));
                savedJob.setSavedAt(rs.getTimestamp("saved_at"));
                savedJobs.add(savedJob);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savedJobs;
    }

    public boolean isJobSavedByJobSeeker(int jobSeekerId, int postId) {
        String sql = "SELECT COUNT(*) FROM Saved_Jobs WHERE job_seeker_id = ? AND post_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveJobForJobSeeker(int jobSeekerId, int postId) {
        String sql = "INSERT INTO Saved_Jobs (job_seeker_id, post_id) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean unsaveJobForJobSeeker(int jobSeekerId, int postId) {
        String sql = "DELETE FROM Saved_Jobs WHERE job_seeker_id = ? AND post_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- Methods for Recruiter ---

    public List<SavedJob> getSavedJobsByRecruiter(int recruiterId) {
        List<SavedJob> savedJobs = new ArrayList<>();
        String sql = "SELECT id, recruiter_id, post_id, saved_at FROM Saved_Jobs WHERE recruiter_id = ? ORDER BY saved_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavedJob savedJob = new SavedJob();
                savedJob.setId(rs.getInt("id"));
                savedJob.setRecruiter_id(rs.getInt("recruiter_id"));
                savedJob.setPostId(rs.getInt("post_id"));
                savedJob.setSavedAt(rs.getTimestamp("saved_at"));
                savedJobs.add(savedJob);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savedJobs;
    }

    public boolean isJobSavedByRecruiter(int recruiterId, int postId) {
        String sql = "SELECT COUNT(*) FROM Saved_Jobs WHERE recruiter_id = ? AND post_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setInt(2, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveJobForRecruiter(int recruiterId, int postId) {
        String sql = "INSERT INTO Saved_Jobs (recruiter_id, post_id) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean unsaveJobForRecruiter(int recruiterId, int postId) {
        String sql = "DELETE FROM Saved_Jobs WHERE recruiter_id = ? AND post_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 