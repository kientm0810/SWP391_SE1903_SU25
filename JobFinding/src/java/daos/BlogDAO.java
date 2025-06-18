/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import models.Blog;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

/**
 *
 * @author andin
 */
public class BlogDAO extends DBContext{
    
    public Vector<Blog> getAllBlogs() {
        Vector<Blog> blogs = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Blog]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public Vector<Blog> getBlogsByAdminId(int adminId) {
        Vector<Blog> blogs = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Blog] WHERE admin_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public Blog getBlogById(int id) {
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Blog] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToBlog(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertBlog(Blog blog) {
        String sql = "INSERT INTO [project_SWP391].[dbo].[Blog] (admin_id, title, description, thumbnail, status, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blog.getAdmin_id());
            ps.setString(2, blog.getTitle());
            ps.setString(3, blog.getDescription());
            ps.setString(4, blog.getThumbnail());
            ps.setString(5, blog.getStatus());
            //ps.setDate(6, blog.getCreated_at());
            //ps.setDate(7, blog.getUpdated_at());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBlogFields(Blog blog) {
        String sql = "UPDATE [project_SWP391].[dbo].[Blog] SET " +
                     "title = ?, description = ?, thumbnail = ?, status = ? , updated_at = GETDATE()" +
                     "WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getDescription());
            ps.setString(3, blog.getThumbnail());
            ps.setString(4, blog.getStatus());
            ps.setInt(5, blog.getId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBlog(int id) {
        String sql = "DELETE FROM [project_SWP391].[dbo].[Blog] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setId(rs.getInt("id"));
        blog.setAdmin_id(rs.getInt("admin_id"));
        blog.setTitle(rs.getString("title"));
        blog.setDescription(rs.getString("description"));
        blog.setThumbnail(rs.getString("thumbnail"));
        blog.setStatus(rs.getString("status"));
        blog.setCreated_at(rs.getDate("created_at"));
        blog.setUpdated_at(rs.getDate("updated_at"));
        return blog;
    }

}
