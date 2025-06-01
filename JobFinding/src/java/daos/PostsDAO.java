package dao;

import models.Posts;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import context.DBContext;

public class PostsDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public PostsDAO() {
        try {
            conn = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy list all posts
    public List<Posts> getAllPosts() {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE deleted_at IS NULL ORDER BY created_at DESC";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(new Posts(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("user_type"),
                    rs.getInt("parent_id"),
                    rs.getString("post_type"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("status"),
                    rs.getInt("view_count"),
                    rs.getInt("like_count"),
                    rs.getInt("comment_count"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at"),
                    rs.getTimestamp("deleted_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Lấy list posts tbeo User_id
    public List<Posts> getPostsByUserId(int userId) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE user_id = ? AND deleted_at IS NULL ORDER BY created_at DESC";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(new Posts(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("user_type"),
                    rs.getInt("parent_id"),
                    rs.getString("post_type"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("status"),
                    rs.getInt("view_count"),
                    rs.getInt("like_count"),
                    rs.getInt("comment_count"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at"),
                    rs.getTimestamp("deleted_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Get post by ID
    public Posts getPostById(int id) {
        String query = "SELECT * FROM Posts WHERE id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Posts(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("user_type"),
                    rs.getInt("parent_id"),
                    rs.getString("post_type"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("status"),
                    rs.getInt("view_count"),
                    rs.getInt("like_count"),
                    rs.getInt("comment_count"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at"),
                    rs.getTimestamp("deleted_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create new post
    public boolean createPost(Posts post) {
        String query = "INSERT INTO Posts (user_id, user_type, parent_id, post_type, title, content, status, view_count, like_count, comment_count, created_at, updated_at) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, post.getUserId());
            ps.setString(2, post.getUserType());
            ps.setObject(3, post.getParentId());
            ps.setString(4, post.getPostType());
            ps.setString(5, post.getTitle());
            ps.setString(6, post.getContent());
            ps.setString(7, post.getStatus());
            ps.setInt(8, post.getViewCount());
            ps.setInt(9, post.getLikeCount());
            ps.setInt(10, post.getCommentCount());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update post
    public boolean updatePost(Posts post) {
        String query = "UPDATE Posts SET title = ?, content = ?, status = ?, updated_at = GETDATE() WHERE id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setString(3, post.getStatus());
            ps.setInt(4, post.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete post 
    public boolean deletePost(int id) {
        String query = "UPDATE Posts SET deleted_at = GETDATE() WHERE id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Tăng luot xem post
    public boolean incrementViewCount(int id) {
        String query = "UPDATE Posts SET view_count = view_count + 1 WHERE id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Close database connection
    public void closeConnection() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}