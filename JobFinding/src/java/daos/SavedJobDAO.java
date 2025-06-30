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

    public boolean saveJob(int userId, int postId) {
        String sql = "INSERT INTO Saved_Jobs (user_id, post_id) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean unsaveJob(int userId, int postId) {
        String sql = "DELETE FROM Saved_Jobs WHERE user_id = ? AND post_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Integer> getSavedPostIds(int userId) {
        List<Integer> postIds = new ArrayList<>();
        String sql = "SELECT post_id FROM Saved_Jobs WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                postIds.add(rs.getInt("post_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postIds;
    }

    public List<SavedJob> getSavedJobs(int userId) {
        List<SavedJob> savedJobs = new ArrayList<>();
        String sql = "SELECT id, user_id, post_id, saved_at FROM Saved_Jobs WHERE user_id = ? ORDER BY saved_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavedJob savedJob = new SavedJob();
                savedJob.setId(rs.getInt("id"));
                savedJob.setUserId(rs.getInt("user_id"));
                savedJob.setPostId(rs.getInt("post_id"));
                savedJob.setSavedAt(rs.getTimestamp("saved_at"));
                savedJobs.add(savedJob);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savedJobs;
    }

    public boolean isJobSaved(int userId, int postId) {
        String sql = "SELECT COUNT(*) FROM Saved_Jobs WHERE user_id = ? AND post_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
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

    public int getSavedJobsCount(int userId) {
        String sql = "SELECT COUNT(*) FROM Saved_Jobs WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean deleteSavedJob(int id) {
        String sql = "DELETE FROM Saved_Jobs WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 