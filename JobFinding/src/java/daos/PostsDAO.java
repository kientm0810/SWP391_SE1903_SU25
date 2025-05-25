package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.Posts;

public class PostsDAO extends DBContext {
    
    // Get posts with pagination
    public List<Posts> getUserPosts(int userId, String userType, int page, int pageSize) throws SQLException {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE user_id = ? AND user_type = ? AND post_type = 'post' AND status != 'deleted' "
                   + "ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setString(2, userType);
            ps.setInt(3, (page - 1) * pageSize);
            ps.setInt(4, pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapPost(rs));
                }
            }
        }
        return posts;
    }

    // Get post details with proper error handling
    public Posts getPostDetail(int postId) throws SQLException {
        String sql = "SELECT * FROM Posts WHERE id = ? AND status != 'deleted'";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapPost(rs);
                }
            }
        }
        return null;
    }

    // Get comments for a post
    public List<Posts> getPostComments(int postId) throws SQLException {
        List<Posts> comments = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE parent_id = ? AND post_type = 'comment' AND status != 'deleted' "
                   + "ORDER BY created_at DESC";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    comments.add(mapPost(rs));
                }
            }
        }
        return comments;
    }

    // Create new post with transaction support
    public boolean createPost(Posts post) throws SQLException {
        String sql = "INSERT INTO Posts (user_id, user_type, parent_id, post_type, title, content, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = super.getConnection();
            conn.setAutoCommit(false);
            
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, post.getUserId());
            ps.setString(2, post.getUserType());
            
            if (post.getParentId() != null) {
                ps.setInt(3, post.getParentId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            
            ps.setString(4, post.getPostType());
            ps.setString(5, post.getTitle());
            ps.setString(6, post.getContent());
            ps.setString(7, post.getStatus());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    post.setId(rs.getInt(1));
                }
                
                // If this is a comment, update the parent's comment count
                if ("comment".equals(post.getPostType()) && post.getParentId() != null) {
                    updateCommentCount(conn, post.getParentId());
                }
                
                conn.commit();
                return true;
            }
            
            conn.rollback();
            return false;
            
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // Update post with transaction
    public boolean updatePost(Posts post) throws SQLException {
        String sql = "UPDATE Posts SET title = ?, content = ?, status = ?, updated_at = CURRENT_TIMESTAMP "
                   + "WHERE id = ? AND user_id = ? AND status != 'deleted'";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setString(3, post.getStatus());
            ps.setInt(4, post.getId());
            ps.setInt(5, post.getUserId());
            
            return ps.executeUpdate() > 0;
        }
    }

    // Delete post (soft delete) with transaction
    public boolean deletePost(int postId, int userId) throws SQLException {
        String sql = "UPDATE Posts SET status = 'deleted', deleted_at = CURRENT_TIMESTAMP "
                   + "WHERE id = ? AND user_id = ? AND status != 'deleted'";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = super.getConnection();
            conn.setAutoCommit(false);
            
            // First get post details to check if it's a comment
            Posts post = getPostDetail(postId);
            if (post == null) {
                return false;
            }
            
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                // If this is a comment, update the parent's comment count
                if ("comment".equals(post.getPostType()) && post.getParentId() != null) {
                    updateCommentCount(conn, post.getParentId());
                }
                
                conn.commit();
                return true;
            }
            
            conn.rollback();
            return false;
            
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    // Get total posts count for pagination
    public int getTotalUserPosts(int userId, String userType) throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM Posts WHERE user_id = ? AND user_type = ? "
                   + "AND post_type = 'post' AND status != 'deleted'";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setString(2, userType);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        }
        return 0;
    }

    // Get all active posts
    public List<Posts> getAllPosts() throws SQLException {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE post_type = 'post' AND status = 'active' ORDER BY created_at DESC";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                posts.add(mapPost(rs));
            }
        }
        return posts;
    }

    // Get posts by specific user
    public List<Posts> getPostsByUser(int userId) throws SQLException {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE user_id = ? AND status != 'deleted' ORDER BY created_at DESC";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapPost(rs));
                }
            }
        }
        return posts;
    }

    // Increment view count
    public boolean incrementViewCount(int postId) throws SQLException {
        String sql = "UPDATE Posts SET view_count = view_count + 1 WHERE id = ? AND status != 'deleted'";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }

    // Like management methods
    public boolean incrementLikeCount(int postId) throws SQLException {
        String sql = "UPDATE Posts SET like_count = like_count + 1 WHERE id = ? AND status != 'deleted'";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean decrementLikeCount(int postId) throws SQLException {
        String sql = "UPDATE Posts SET like_count = GREATEST(like_count - 1, 0) "
                   + "WHERE id = ? AND status != 'deleted'";
        
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }

    // Update comment count (used internally)
    private boolean updateCommentCount(Connection conn, int postId) throws SQLException {
        String sql = "UPDATE Posts SET comment_count = ("
                   + "SELECT COUNT(*) FROM Posts WHERE parent_id = ? AND post_type = 'comment' AND status != 'deleted'"
                   + ") WHERE id = ? AND status != 'deleted'";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        }
    }

    // Map ResultSet to Posts object
    private Posts mapPost(ResultSet rs) throws SQLException {
        Posts post = new Posts();
        post.setId(rs.getInt("id"));
        post.setUserId(rs.getInt("user_id"));
        post.setUserType(rs.getString("user_type"));
        
        int parentId = rs.getInt("parent_id");
        post.setParentId(rs.wasNull() ? null : parentId);
        
        post.setPostType(rs.getString("post_type"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setStatus(rs.getString("status"));
        post.setViewCount(rs.getInt("view_count"));
        post.setLikeCount(rs.getInt("like_count"));
        post.setCommentCount(rs.getInt("comment_count"));
        post.setCreatedAt(rs.getTimestamp("created_at"));
        post.setUpdatedAt(rs.getTimestamp("updated_at"));
        post.setDeletedAt(rs.getTimestamp("deleted_at"));
        return post;
    }
}