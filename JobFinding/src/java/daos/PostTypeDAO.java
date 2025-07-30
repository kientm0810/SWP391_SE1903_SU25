package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import context.DBContext;
import models.PostType;

/**
 * DAO cho bảng PostType - quản lý các loại bài đăng
 */
public class PostTypeDAO extends DBContext {
    
    /**
     * Lấy tất cả các loại bài đăng
     */
    public Vector<PostType> getAllPostTypes() {
        Vector<PostType> postTypes = new Vector<>();
        String sql = "SELECT * FROM PostType WHERE is_active = 1 ORDER BY priority_level ASC, type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                PostType postType = mapResultSetToPostType(rs);
                postTypes.add(postType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postTypes;
    }
    
    /**
     * Lấy loại bài đăng theo ID
     */
    public PostType getPostTypeById(int id) {
        String sql = "SELECT * FROM PostType WHERE id = ? AND is_active = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPostType(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Lấy loại bài đăng theo mã code
     */
    public PostType getPostTypeByCode(String typeCode) {
        String sql = "SELECT * FROM PostType WHERE type_code = ? AND is_active = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, typeCode);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPostType(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Lấy các loại bài đăng theo category
     */
    public Vector<PostType> getPostTypesByCategory(String category) {
        Vector<PostType> postTypes = new Vector<>();
        String sql = "SELECT * FROM PostType WHERE category = ? AND is_active = 1 ORDER BY priority_level ASC, type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                PostType postType = mapResultSetToPostType(rs);
                postTypes.add(postType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postTypes;
    }
    
    /**
     * Lấy các loại bài đăng job posting
     */
    public Vector<PostType> getJobPostingTypes() {
        return getPostTypesByCategory("job_posting");
    }
    
    /**
     * Lấy các loại bài đăng content
     */
    public Vector<PostType> getContentTypes() {
        return getPostTypesByCategory("content");
    }
    
    /**
     * Tạo loại bài đăng mới
     */
    public boolean createPostType(PostType postType) {
        String sql = "INSERT INTO PostType (type_code, type_name, description, category, priority_level, " +
                    "is_active, icon_class, color_code, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, postType.getTypeCode());
            ps.setString(2, postType.getTypeName());
            ps.setString(3, postType.getDescription());
            ps.setString(4, postType.getCategory());
            ps.setInt(5, postType.getPriorityLevel());
            ps.setBoolean(6, postType.isActive());
            ps.setString(7, postType.getIconClass());
            ps.setString(8, postType.getColorCode());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Cập nhật loại bài đăng
     */
    public boolean updatePostType(PostType postType) {
        String sql = "UPDATE PostType SET type_code = ?, type_name = ?, description = ?, " +
                    "category = ?, priority_level = ?, is_active = ?, icon_class = ?, " +
                    "color_code = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, postType.getTypeCode());
            ps.setString(2, postType.getTypeName());
            ps.setString(3, postType.getDescription());
            ps.setString(4, postType.getCategory());
            ps.setInt(5, postType.getPriorityLevel());
            ps.setBoolean(6, postType.isActive());
            ps.setString(7, postType.getIconClass());
            ps.setString(8, postType.getColorCode());
            ps.setInt(9, postType.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Xóa loại bài đăng (soft delete)
     */
    public boolean deletePostType(int id) {
        String sql = "UPDATE PostType SET is_active = 0, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Kiểm tra mã code đã tồn tại chưa
     */
    public boolean isTypeCodeExists(String typeCode) {
        String sql = "SELECT COUNT(*) FROM PostType WHERE type_code = ? AND is_active = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, typeCode);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Lấy thống kê số lượng bài đăng theo loại
     */
    public Vector<Object[]> getPostTypeStats() {
        Vector<Object[]> stats = new Vector<>();
        String sql = "SELECT pt.type_name, pt.type_code, COUNT(p.id) as post_count, " +
                    "COUNT(CASE WHEN p.status = 'active' THEN 1 END) as active_count " +
                    "FROM PostType pt " +
                    "LEFT JOIN Posts p ON pt.id = p.post_type_id " +
                    "WHERE pt.is_active = 1 " +
                    "GROUP BY pt.id, pt.type_name, pt.type_code " +
                    "ORDER BY post_count DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Object[] row = new Object[4];
                row[0] = rs.getString("type_name");
                row[1] = rs.getString("type_code");
                row[2] = rs.getInt("post_count");
                row[3] = rs.getInt("active_count");
                stats.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    /**
     * Map ResultSet thành PostType object
     */
    private PostType mapResultSetToPostType(ResultSet rs) throws SQLException {
        PostType postType = new PostType();
        postType.setId(rs.getInt("id"));
        postType.setTypeCode(rs.getString("type_code"));
        postType.setTypeName(rs.getString("type_name"));
        postType.setDescription(rs.getString("description"));
        postType.setCategory(rs.getString("category"));
        postType.setPriorityLevel(rs.getInt("priority_level"));
        postType.setActive(rs.getBoolean("is_active"));
        postType.setIconClass(rs.getString("icon_class"));
        postType.setColorCode(rs.getString("color_code"));
        postType.setCreatedAt(rs.getTimestamp("created_at"));
        postType.setUpdatedAt(rs.getTimestamp("updated_at"));
        return postType;
    }
} 