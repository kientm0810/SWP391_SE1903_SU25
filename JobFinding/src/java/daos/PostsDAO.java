package daos;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Posts;

public class PostsDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public PostsDAO() {
        try {
            conn = new DBContext().getConnection();
            if (conn == null) {
                System.err.println("Failed to establish database connection");
            }
        } catch (Exception e) {
            System.err.println("Error initializing PostsDAO: " + e.getMessage());
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
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Lấy list posts của 1 người dùng cụ thể
    public List<Posts> getPostsByUserId(int userId) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE user_id = ? AND deleted_at IS NULL ORDER BY created_at DESC";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Lấy list posts của 1 recruiter cụ thể
    public List<Posts> getPostsByRecruiterId(int recruiterId) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE user_id = ? AND user_type = 'recruiter' AND deleted_at IS NULL ORDER BY created_at DESC";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, recruiterId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Lấy list posts của 1 recruiter cụ thể có phân trang
    public List<Posts> getPostsByRecruiterIdWithPagination(int recruiterId, int page, int pageSize) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE user_id = ? AND user_type = 'recruiter' AND deleted_at IS NULL ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, recruiterId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Get total number of posts for a specific recruiter
    public int getTotalPostsByRecruiterId(int recruiterId) {
        String query = "SELECT COUNT(*) FROM Posts WHERE user_id = ? AND user_type = 'recruiter' AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, recruiterId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy details info của 1 post
    public Posts getPostById(int id) {
        String query = "SELECT * FROM Posts WHERE id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create new post
    public boolean createPost(Posts post) {
        if (conn == null) {
            System.err.println("Database connection is null");
            return false;
        }

        String query = "INSERT INTO Posts (user_id, user_type, parent_id, post_type, title, content, status, " +
                      "view_count, like_count, comment_count, experience, deadline, working_time, " +
                      "job_description, requirements, benefits, contact_address, application_method, " +
                      "company_name, salary, location, job_type, company_logo, created_at, updated_at) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";

        try {
            // Set default values if null
            if (post.getUserType() == null)
                post.setUserType("recruiter");
            if (post.getPostType() == null)
                post.setPostType("job");
            if (post.getStatus() == null)
                post.setStatus("active");
            if (post.getViewCount() == 0)
                post.setViewCount(0);
            if (post.getLikeCount() == 0)
                post.setLikeCount(0);
            if (post.getCommentCount() == 0)
                post.setCommentCount(0);
            if (post.getContent() == null)
                post.setContent("");

            // Validate required fields
            if (post.getUserId() <= 0) {
                System.err.println("User ID is required and must be greater than 0");
                return false;
            }

            if (post.getTitle() == null || post.getTitle().trim().isEmpty()) {
                System.err.println("Title is required");
                return false;
            }

            if (post.getCompanyName() == null || post.getCompanyName().trim().isEmpty()) {
                System.err.println("Company name is required");
                return false;
            }

            if (post.getJobDescription() == null || post.getJobDescription().trim().isEmpty()) {
                System.err.println("Job description is required");
                return false;
            }

            if (post.getRequirements() == null || post.getRequirements().trim().isEmpty()) {
                System.err.println("Requirements are required");
                return false;
            }

            if (post.getBenefits() == null || post.getBenefits().trim().isEmpty()) {
                System.err.println("Benefits are required");
                return false;
            }

            if (post.getContactAddress() == null || post.getContactAddress().trim().isEmpty()) {
                System.err.println("Contact address is required");
                return false;
            }

            if (post.getApplicationMethod() == null || post.getApplicationMethod().trim().isEmpty()) {
                System.err.println("Application method is required");
                return false;
            }

            if (post.getWorkingTime() == null || post.getWorkingTime().trim().isEmpty()) {
                System.err.println("Working time is required");
                return false;
            }

            if (post.getExperience() == null || post.getExperience().trim().isEmpty()) {
                System.err.println("Experience is required");
                return false;
            }

            if (post.getDeadline() == null) {
                System.err.println("Deadline is required");
                return false;
            }

            if (post.getCompanyLogo() == null || post.getCompanyLogo().trim().isEmpty()) {
                System.err.println("Company logo is required");
                return false;
            }

            if (post.getSalary() == null || post.getSalary().trim().isEmpty()) {
                System.err.println("Salary is required");
                return false;
            }

            if (post.getLocation() == null || post.getLocation().trim().isEmpty()) {
                System.err.println("Location is required");
                return false;
            }

            if (post.getJobType() == null || post.getJobType().trim().isEmpty()) {
                System.err.println("Job type is required");
                return false;
            }

            // Prepare and execute query
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
            ps.setString(11, post.getExperience());
            ps.setDate(12, new java.sql.Date(post.getDeadline().getTime()));
            ps.setString(13, post.getWorkingTime());
            ps.setString(14, post.getJobDescription());
            ps.setString(15, post.getRequirements());
            ps.setString(16, post.getBenefits());
            ps.setString(17, post.getContactAddress());
            ps.setString(18, post.getApplicationMethod());
            ps.setString(19, post.getCompanyName());
            ps.setString(20, post.getSalary());
            ps.setString(21, post.getLocation());
            ps.setString(22, post.getJobType());
            ps.setString(23, post.getCompanyLogo());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.err.println("\n=== SQL Error Details ===");
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("\n=== Unexpected Error Details ===");
            System.err.println("Error Message: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Update post
    public boolean updatePost(Posts post) {
        String query = "UPDATE Posts SET title = ?, content = ?, status = ?, experience = ?, deadline = ?, " +
                      "working_time = ?, job_description = ?, requirements = ?, benefits = ?, contact_address = ?, " +
                      "application_method = ?, company_name = ?, company_logo = ?, salary = ?, location = ?, " +
                      "job_type = ?, updated_at = GETDATE() WHERE id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent()); 
            ps.setString(3, post.getStatus());
            ps.setString(4, post.getExperience());
            ps.setDate(5, post.getDeadline() != null ? new java.sql.Date(post.getDeadline().getTime()) : null);
            ps.setString(6, post.getWorkingTime());
            ps.setString(7, post.getJobDescription());
            ps.setString(8, post.getRequirements());
            ps.setString(9, post.getBenefits());
            ps.setString(10, post.getContactAddress());
            ps.setString(11, post.getApplicationMethod());
            ps.setString(12, post.getCompanyName());
            ps.setString(13, post.getCompanyLogo());
            ps.setString(14, post.getSalary());
            ps.setString(15, post.getLocation());
            ps.setString(16, post.getJobType());
            ps.setInt(17, post.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete post (soft delete)
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

    // Tăng lượt xem post
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

    // Get total number of posts
    public int getTotalPosts() {
        String query = "SELECT COUNT(*) FROM Posts WHERE deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get posts by page
    public List<Posts> getPostsByPage(int page, int pageSize) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE deleted_at IS NULL ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Get total number of posts with search
    public int getTotalPostsWithSearch(String keyword, String jobType, String location) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM Posts WHERE deleted_at IS NULL");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (title LIKE ? OR company_name LIKE ?)");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (jobType != null && !jobType.trim().isEmpty()) {
            query.append(" AND job_type = ?");
            params.add(jobType.trim());
        }

        if (location != null && !location.trim().isEmpty()) {
            query.append(" AND location = ?");
            params.add(location.trim());
        }

        try {
            ps = conn.prepareStatement(query.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get posts by page with search
    public List<Posts> getPostsByPageWithSearch(int page, int pageSize, String keyword, String jobType, String location) {
        List<Posts> posts = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Posts WHERE deleted_at IS NULL");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (title LIKE ? OR company_name LIKE ?)");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (jobType != null && !jobType.trim().isEmpty()) {
            query.append(" AND job_type = ?");
            params.add(jobType.trim());
        }

        if (location != null && !location.trim().isEmpty()) {
            query.append(" AND location = ?");
            params.add(location.trim());
        }

        query.append(" ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try {
            ps = conn.prepareStatement(query.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    
  public List<Posts> getRecentPosts(int limit) {
    List<Posts> posts = new ArrayList<>();
    String query = "SELECT TOP (?) * FROM Posts WHERE deleted_at IS NULL ORDER BY created_at DESC";
    
    try {
        ps = conn.prepareStatement(query);
        ps.setInt(1, limit);
        rs = ps.executeQuery();
        
        while (rs.next()) {
            Posts post = new Posts();
            post.setId(rs.getInt("id"));
            post.setUserId(rs.getInt("user_id"));
            post.setUserType(rs.getString("user_type"));
            post.setParentId(rs.getInt("parent_id"));
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
            post.setExperience(rs.getString("experience"));
            post.setDeadline(rs.getDate("deadline"));
            post.setWorkingTime(rs.getString("working_time"));
            post.setJobDescription(rs.getString("job_description"));
            post.setRequirements(rs.getString("requirements"));
            post.setBenefits(rs.getString("benefits"));
            post.setContactAddress(rs.getString("contact_address"));
            post.setApplicationMethod(rs.getString("application_method"));
            post.setCompanyName(rs.getString("company_name"));
            post.setCompanyLogo(rs.getString("company_logo"));
            post.setSalary(rs.getString("salary"));
            post.setLocation(rs.getString("location"));
            post.setJobType(rs.getString("job_type"));
            posts.add(post);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return posts;
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

    // Get posts by user_id with pagination
    public List<Posts> getPostsByUserIdWithPagination(int userId, int page, int pageSize) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE user_id = ? AND deleted_at IS NULL ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                Posts post = new Posts();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserType(rs.getString("user_type"));
                post.setParentId(rs.getInt("parent_id"));
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
                post.setExperience(rs.getString("experience"));
                post.setDeadline(rs.getDate("deadline"));
                post.setWorkingTime(rs.getString("working_time"));
                post.setJobDescription(rs.getString("job_description"));
                post.setRequirements(rs.getString("requirements"));
                post.setBenefits(rs.getString("benefits"));
                post.setContactAddress(rs.getString("contact_address"));
                post.setApplicationMethod(rs.getString("application_method"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setSalary(rs.getString("salary"));
                post.setLocation(rs.getString("location"));
                post.setJobType(rs.getString("job_type"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Get total posts by user_id
    public int getTotalPostsByUserId(int userId) {
        String query = "SELECT COUNT(*) FROM Posts WHERE user_id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}