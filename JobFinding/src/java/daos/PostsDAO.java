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
import java.util.Vector;
import models.Posts;

public class PostsDAO extends DBContext {

    // Lấy danh sách bài viết của người dùng có phân trang
    public List<Posts> getUserPosts(int userId, String userType, int page, int pageSize) throws SQLException {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE user_id = ? ";
//                +
//                     "ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, userId);
            ResultSet rs = ptm.executeQuery();
            //ps.setString(2, userType);
//            ps.setInt(3, (page - 1) * pageSize);
//            ps.setInt(4, pageSize);
            
            //try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapPost(rs));
                }
           // }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return posts;
    }

    // Lấy thông tin chi tiết bài viết theo ID
    public Posts getPostDetail(int postId) throws SQLException {
        String sql = "SELECT * FROM Posts WHERE id = ? AND status != 'deleted'";
        
        try (Connection conn = getConnection();
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

    // Lấy danh sách bình luận của một bài viết
    public List<Posts> getPostComments(int parentId) throws SQLException {
        List<Posts> comments = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE parent_id = ? " +
                    "AND post_type = 'comment' AND status != 'deleted' " +
                    "ORDER BY created_at DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, parentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    comments.add(mapPost(rs));
                }
            }
        }
        return comments;
    }

    // Tạo mới bài viết (hỗ trợ transaction)
    public boolean createPost(Posts post) throws SQLException {
        validatePostType(post.getPostType());
        validateUserType(post.getUserType());
        
        String sql = "INSERT INTO Posts (user_id, user_type, parent_id, post_type, title, content, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
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
                ps.setString(7, "active");
                
                int affectedRows = ps.executeUpdate();
                
                if (affectedRows > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            post.setId(rs.getInt(1));
                            
                            if ("comment".equals(post.getPostType()) && post.getParentId() != null) {
                                updateCommentCount(conn, post.getParentId());
                            }
                            
                            conn.commit();
                            return true;
                        }
                    }
                }
                
                conn.rollback();
                return false;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    // Cập nhật bài viết
    public boolean updatePost(Posts post) throws SQLException {
        validatePostType(post.getPostType());
        validateUserType(post.getUserType());
        
        String sql = "UPDATE Posts SET title = ?, content = ?, status = ?, updated_at = CURRENT_TIMESTAMP " +
                    "WHERE id = ? AND user_id = ? AND status != 'deleted'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setString(3, post.getStatus());
            ps.setInt(4, post.getId());
            ps.setInt(5, post.getUserId());
            
            return ps.executeUpdate() > 0;
        }
    }

    // Xoá bài viết (xoá mềm)
    public boolean deletePost(int postId, int userId) throws SQLException {
        String sql = "UPDATE Posts SET status = 'deleted', deleted_at = CURRENT_TIMESTAMP " +
                    "WHERE (id = ? OR parent_id = ?) AND user_id = ? AND status != 'deleted'";
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, postId);
                ps.setInt(2, postId);
                ps.setInt(3, userId);
                
                boolean success = ps.executeUpdate() > 0;
                if (success) {
                    conn.commit();
                    return true;
                }
                
                conn.rollback();
                return false;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    // Kiểm tra người dùng đã like bài viết chưa
    private boolean hasUserLiked(int postId, int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Posts " +
                    "WHERE parent_id = ? AND user_id = ? AND post_type = 'like' " +
                    "AND status != 'deleted'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Like hoặc bỏ like bài viết
    public boolean toggleLike(int postId, int userId, String userType) throws SQLException {
        validateUserType(userType);
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            
            try {
                if (hasUserLiked(postId, userId)) {
                    String deleteLike = "UPDATE Posts SET status = 'deleted', deleted_at = CURRENT_TIMESTAMP " +
                                      "WHERE parent_id = ? AND user_id = ? AND post_type = 'like'";
                    try (PreparedStatement ps = conn.prepareStatement(deleteLike)) {
                        ps.setInt(1, postId);
                        ps.setInt(2, userId);
                        ps.executeUpdate();
                    }
                    decrementLikeCount(conn, postId);
                } else {
                    String createLike = "INSERT INTO Posts (user_id, user_type, parent_id, post_type, status) " +
                                      "VALUES (?, ?, ?, 'like', 'active')";
                    try (PreparedStatement ps = conn.prepareStatement(createLike)) {
                        ps.setInt(1, userId);
                        ps.setString(2, userType);
                        ps.setInt(3, postId);
                        ps.executeUpdate();
                    }
                    incrementLikeCount(conn, postId);
                }
                
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    // Tăng số lượng like
    private boolean incrementLikeCount(Connection conn, int postId) throws SQLException {
        String sql = "UPDATE Posts SET like_count = like_count + 1 " +
                    "WHERE id = ? AND status != 'deleted'";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }

    // Giảm số lượng like
    private boolean decrementLikeCount(Connection conn, int postId) throws SQLException {
        String sql = "UPDATE Posts SET like_count = GREATEST(like_count - 1, 0) " +
                    "WHERE id = ? AND status != 'deleted'";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }

    // Cập nhật số lượng bình luận của bài viết cha
    private boolean updateCommentCount(Connection conn, int parentId) throws SQLException {
        String sql = "UPDATE Posts SET comment_count = " +
                    "(SELECT COUNT(*) FROM Posts WHERE parent_id = ? AND post_type = 'comment' AND status != 'deleted') " +
                    "WHERE id = ? AND status != 'deleted'";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, parentId);
            ps.setInt(2, parentId);
            return ps.executeUpdate() > 0;
        }
    }

    // Tăng số lượt xem
    public boolean incrementViewCount(int postId) throws SQLException {
        String sql = "UPDATE Posts SET view_count = view_count + 1 " +
                    "WHERE id = ? AND status != 'deleted'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }

    // Validate post_type
    private void validatePostType(String postType) throws SQLException {
        if (postType == null || !postType.matches("^(post|comment|like)$")) {
            throw new SQLException("Invalid post_type. Must be 'post', 'comment', or 'like'");
        }
    }

    // Validate user_type
    private void validateUserType(String userType) throws SQLException {
        if (userType == null || !userType.matches("^(admin|recruiter|job_seeker)$")) {
            throw new SQLException("Invalid user_type. Must be 'admin', 'recruiter', or 'job_seeker'");
        }
    }

    // Ánh xạ dữ liệu từ ResultSet sang đối tượng Posts
    private Posts mapPost(ResultSet rs) throws SQLException {
        Posts post = new Posts();
        post.setId(rs.getInt("id"));
        post.setUserId(rs.getInt("user_id"));
        post.setUserType(rs.getString("user_type"));
        
        int parentId = rs.getInt("parent_id");
        if (!rs.wasNull()) {
            post.setParentId(parentId);
        }
        
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

   
    // Lấy tổng số bài viết theo bộ lọc
    public int getTotalPosts(int userId, String status, String type, String search) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM Posts WHERE user_id = ? "
        );
        
        List<Object> params = new ArrayList<>();
        params.add(userId);
        
        sql.append("AND post_type = 'post' ");
        
        if (status != null && !status.isEmpty()) {
            sql.append("AND status = ? ");
            params.add(status);
        } else {
            sql.append("AND status != 'deleted' ");
        }
        
        if (type != null && !type.isEmpty()) {
            sql.append("AND post_type = ? ");
            params.add(type);
        }
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (title LIKE ? OR content LIKE ?) ");
            String searchPattern = "%" + search.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Lấy tổng số lượt xem của người dùng
    public int getTotalViews(int userId) throws SQLException {
        String sql = "SELECT SUM(view_count) FROM Posts WHERE user_id = ? AND status != 'deleted'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Lấy tổng số lượt thích của người dùng
    public int getTotalLikes(int userId) throws SQLException {
        String sql = "SELECT SUM(like_count) FROM Posts WHERE user_id = ? AND status != 'deleted'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Lấy tổng số bình luận của người dùng
    public int getTotalComments(int userId) throws SQLException {
        String sql = "SELECT SUM(comment_count) FROM Posts WHERE user_id = ? AND status != 'deleted'";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Get recruiter's posts with filters and sorting
    public List<Posts> getRecruiterPosts(int recruiterId, String sortBy, String filterStatus, int page, int pageSize) throws SQLException {
        List<Posts> posts = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM Posts WHERE user_id = ? AND user_type = 'recruiter' "
        );
        
        List<Object> params = new ArrayList<>();
        params.add(recruiterId);
        
        if (filterStatus != null && !filterStatus.isEmpty()) {
            sql.append("AND status = ? ");
            params.add(filterStatus);
        } else {
            sql.append("AND status != 'deleted' ");
        }
        
        // Add sorting
        sql.append("ORDER BY ");
        switch (sortBy) {
            case "newest":
                sql.append("created_at DESC");
                break;
            case "oldest":
                sql.append("created_at ASC");
                break;
            case "most_viewed":
                sql.append("view_count DESC");
                break;
            case "most_liked":
                sql.append("like_count DESC");
                break;
            case "most_commented":
                sql.append("comment_count DESC");
                break;
            default:
                sql.append("created_at DESC");
        }
        
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapPost(rs));
                }
            }
        }
        return posts;
    }

    // Get total number of recruiter's posts
    public int getTotalRecruiterPosts(int recruiterId, String filterStatus) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM Posts WHERE user_id = ? AND user_type = 'recruiter' "
        );
        
        List<Object> params = new ArrayList<>();
        params.add(recruiterId);
        
        if (filterStatus != null && !filterStatus.isEmpty()) {
            sql.append("AND status = ? ");
            params.add(filterStatus);
        } else {
            sql.append("AND status != 'deleted' ");
        }
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    

   
}
