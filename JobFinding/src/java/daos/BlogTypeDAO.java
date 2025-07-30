package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import context.DBContext;
import models.BlogType;

/**
 * DAO cho bảng BlogType - quản lý các loại blog
 */
public class BlogTypeDAO extends DBContext {
    
    /**
     * Lấy tất cả các loại blog
     */
    public Vector<BlogType> getAllBlogTypes() {
        Vector<BlogType> blogTypes = new Vector<>();
        String sql = "SELECT * FROM BlogType WHERE is_active = 1 ORDER BY type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                BlogType blogType = mapResultSetToBlogType(rs);
                blogTypes.add(blogType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogTypes;
    }
    
    /**
     * Lấy loại blog theo ID
     */
    public BlogType getBlogTypeById(int id) {
        String sql = "SELECT * FROM BlogType WHERE id = ? AND is_active = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBlogType(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Lấy loại blog theo mã code
     */
    public BlogType getBlogTypeByCode(String typeCode) {
        String sql = "SELECT * FROM BlogType WHERE type_code = ? AND is_active = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, typeCode);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBlogType(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Lấy các loại blog theo category
     */
    public Vector<BlogType> getBlogTypesByCategory(String category) {
        Vector<BlogType> blogTypes = new Vector<>();
        String sql = "SELECT * FROM BlogType WHERE category = ? AND is_active = 1 ORDER BY type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BlogType blogType = mapResultSetToBlogType(rs);
                blogTypes.add(blogType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogTypes;
    }
    
    /**
     * Lấy các loại blog theo target audience
     */
    public Vector<BlogType> getBlogTypesByTargetAudience(String targetAudience) {
        Vector<BlogType> blogTypes = new Vector<>();
        String sql = "SELECT * FROM BlogType WHERE target_audience = ? AND is_active = 1 ORDER BY type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, targetAudience);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BlogType blogType = mapResultSetToBlogType(rs);
                blogTypes.add(blogType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogTypes;
    }
    
    /**
     * Lấy các loại blog theo content format
     */
    public Vector<BlogType> getBlogTypesByContentFormat(String contentFormat) {
        Vector<BlogType> blogTypes = new Vector<>();
        String sql = "SELECT * FROM BlogType WHERE content_format = ? AND is_active = 1 ORDER BY type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, contentFormat);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BlogType blogType = mapResultSetToBlogType(rs);
                blogTypes.add(blogType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogTypes;
    }
    
    /**
     * Lấy các loại blog cho job seekers
     */
    public Vector<BlogType> getBlogTypesForJobSeekers() {
        Vector<BlogType> blogTypes = new Vector<>();
        String sql = "SELECT * FROM BlogType WHERE (target_audience = 'job_seekers' OR target_audience = 'all') " +
                    "AND is_active = 1 ORDER BY type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                BlogType blogType = mapResultSetToBlogType(rs);
                blogTypes.add(blogType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogTypes;
    }
    
    /**
     * Lấy các loại blog cho professionals
     */
    public Vector<BlogType> getBlogTypesForProfessionals() {
        Vector<BlogType> blogTypes = new Vector<>();
        String sql = "SELECT * FROM BlogType WHERE (target_audience = 'professionals' OR target_audience = 'all') " +
                    "AND is_active = 1 ORDER BY type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                BlogType blogType = mapResultSetToBlogType(rs);
                blogTypes.add(blogType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogTypes;
    }
    
    /**
     * Tạo loại blog mới
     */
    public boolean createBlogType(BlogType blogType) {
        String sql = "INSERT INTO BlogType (type_code, type_name, description, category, target_audience, " +
                    "content_format, is_active, icon_class, color_code, seo_keywords, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blogType.getTypeCode());
            ps.setString(2, blogType.getTypeName());
            ps.setString(3, blogType.getDescription());
            ps.setString(4, blogType.getCategory());
            ps.setString(5, blogType.getTargetAudience());
            ps.setString(6, blogType.getContentFormat());
            ps.setBoolean(7, blogType.isActive());
            ps.setString(8, blogType.getIconClass());
            ps.setString(9, blogType.getColorCode());
            ps.setString(10, blogType.getSeoKeywords());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Cập nhật loại blog
     */
    public boolean updateBlogType(BlogType blogType) {
        String sql = "UPDATE BlogType SET type_code = ?, type_name = ?, description = ?, " +
                    "category = ?, target_audience = ?, content_format = ?, is_active = ?, " +
                    "icon_class = ?, color_code = ?, seo_keywords = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blogType.getTypeCode());
            ps.setString(2, blogType.getTypeName());
            ps.setString(3, blogType.getDescription());
            ps.setString(4, blogType.getCategory());
            ps.setString(5, blogType.getTargetAudience());
            ps.setString(6, blogType.getContentFormat());
            ps.setBoolean(7, blogType.isActive());
            ps.setString(8, blogType.getIconClass());
            ps.setString(9, blogType.getColorCode());
            ps.setString(10, blogType.getSeoKeywords());
            ps.setInt(11, blogType.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Xóa loại blog (soft delete)
     */
    public boolean deleteBlogType(int id) {
        String sql = "UPDATE BlogType SET is_active = 0, updated_at = GETDATE() WHERE id = ?";
        
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
        String sql = "SELECT COUNT(*) FROM BlogType WHERE type_code = ? AND is_active = 1";
        
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
     * Lấy thống kê số lượng blog theo loại
     */
    public Vector<Object[]> getBlogTypeStats() {
        Vector<Object[]> stats = new Vector<>();
        String sql = "SELECT bt.type_name, bt.type_code, bt.category, bt.target_audience, " +
                    "COUNT(b.id) as blog_count, COUNT(CASE WHEN b.status = 'published' THEN 1 END) as published_count " +
                    "FROM BlogType bt " +
                    "LEFT JOIN Blog b ON bt.id = b.blog_type_id " +
                    "WHERE bt.is_active = 1 " +
                    "GROUP BY bt.id, bt.type_name, bt.type_code, bt.category, bt.target_audience " +
                    "ORDER BY blog_count DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Object[] row = new Object[6];
                row[0] = rs.getString("type_name");
                row[1] = rs.getString("type_code");
                row[2] = rs.getString("category");
                row[3] = rs.getString("target_audience");
                row[4] = rs.getInt("blog_count");
                row[5] = rs.getInt("published_count");
                stats.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    /**
     * Tìm kiếm blog types theo từ khóa
     */
    public Vector<BlogType> searchBlogTypes(String keyword) {
        Vector<BlogType> blogTypes = new Vector<>();
        String sql = "SELECT * FROM BlogType WHERE (type_name LIKE ? OR description LIKE ? OR seo_keywords LIKE ?) " +
                    "AND is_active = 1 ORDER BY type_name ASC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BlogType blogType = mapResultSetToBlogType(rs);
                blogTypes.add(blogType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogTypes;
    }
    
    /**
     * Map ResultSet thành BlogType object
     */
    private BlogType mapResultSetToBlogType(ResultSet rs) throws SQLException {
        BlogType blogType = new BlogType();
        blogType.setId(rs.getInt("id"));
        blogType.setTypeCode(rs.getString("type_code"));
        blogType.setTypeName(rs.getString("type_name"));
        blogType.setDescription(rs.getString("description"));
        blogType.setCategory(rs.getString("category"));
        blogType.setTargetAudience(rs.getString("target_audience"));
        blogType.setContentFormat(rs.getString("content_format"));
        blogType.setActive(rs.getBoolean("is_active"));
        blogType.setIconClass(rs.getString("icon_class"));
        blogType.setColorCode(rs.getString("color_code"));
        blogType.setSeoKeywords(rs.getString("seo_keywords"));
        blogType.setCreatedAt(rs.getTimestamp("created_at"));
        blogType.setUpdatedAt(rs.getTimestamp("updated_at"));
        return blogType;
    }
} 