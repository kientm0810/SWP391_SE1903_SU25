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

        String query = "INSERT INTO Posts (user_id, user_type, parent_id, post_type, title, status, " +
                      "view_count, like_count, comment_count, experience, deadline, working_time, " +
                      "job_description, requirements, benefits, contact_address, application_method, " +
                      "company_name, salary, location, job_type, company_logo, created_at, updated_at) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try {
            // Set default values for required fields if they are null
            if (post.getUserType() == null) post.setUserType("user");
            if (post.getPostType() == null) post.setPostType("job");
            if (post.getStatus() == null) post.setStatus("active");
            if (post.getViewCount() == 0) post.setViewCount(0);
            if (post.getLikeCount() == 0) post.setLikeCount(0);
            if (post.getCommentCount() == 0) post.setCommentCount(0);

            // Validate required fields
            if (post.getUserId() <= 0) {
                System.err.println("User ID is required and must be greater than 0");
                return false;
            }

            // Check all required fields and log their values
            System.out.println("\n=== Checking Required Fields ===");
            String[] requiredFields = {
                "title", "companyName", "salary", "location", "jobType",
                "experience", "workingTime", "jobDescription", "requirements",
                "benefits", "contactAddress", "applicationMethod", "deadline", "companyLogo"
            };
            
            String[] fieldValues = {
                post.getTitle(), post.getCompanyName(), post.getSalary(),
                post.getLocation(), post.getJobType(), post.getExperience(), 
                post.getWorkingTime(), post.getJobDescription(), post.getRequirements(), 
                post.getBenefits(), post.getContactAddress(), post.getApplicationMethod(), 
                String.valueOf(post.getDeadline()), post.getCompanyLogo()
            };
            
            for (int i = 0; i < requiredFields.length; i++) {
                System.out.println(requiredFields[i] + ": [" + fieldValues[i] + "]");
                // Special check for deadline date object being null after parsing
                if (requiredFields[i].equals("deadline")) {
                     if (post.getDeadline() == null) {
                         System.err.println("Error: " + requiredFields[i] + " is required and null");
                         return false;
                     }
                } else if (fieldValues[i] == null || fieldValues[i].trim().isEmpty()) {
                    System.err.println("Error: " + requiredFields[i] + " is required");
                    return false;
                }
            }

            // Log all post data before insertion
            System.out.println("\n=== Post Data Before Insertion ===");
            System.out.println("User ID: " + post.getUserId());
            System.out.println("User Type: " + post.getUserType());
            System.out.println("Parent ID: " + post.getParentId());
            System.out.println("Post Type: " + post.getPostType());
            System.out.println("Title: " + post.getTitle());
            System.out.println("Status: " + post.getStatus());
            System.out.println("Company Name: " + post.getCompanyName());
            System.out.println("Company Logo: " + post.getCompanyLogo());
            System.out.println("Salary: " + post.getSalary());
            System.out.println("Location: " + post.getLocation());
            System.out.println("Job Type: " + post.getJobType());
            System.out.println("Experience: " + post.getExperience());
            System.out.println("Deadline: " + post.getDeadline());
            System.out.println("Working Time: " + post.getWorkingTime());
            System.out.println("Job Description: " + post.getJobDescription());
            System.out.println("Requirements: " + post.getRequirements());
            System.out.println("Benefits: " + post.getBenefits());
            System.out.println("Contact Address: " + post.getContactAddress());
            System.out.println("Application Method: " + post.getApplicationMethod());

            ps = conn.prepareStatement(query);
            // Set parameters in the same order as the SQL query
            ps.setInt(1, post.getUserId());
            ps.setString(2, post.getUserType());
            ps.setObject(3, post.getParentId());
            ps.setString(4, post.getPostType());
            ps.setString(5, post.getTitle());
            ps.setString(6, post.getStatus());
            ps.setInt(7, post.getViewCount());
            ps.setInt(8, post.getLikeCount());
            ps.setInt(9, post.getCommentCount());
            ps.setString(10, post.getExperience());
            ps.setDate(11, new java.sql.Date(post.getDeadline().getTime()));
            ps.setString(12, post.getWorkingTime());
            ps.setString(13, post.getJobDescription());
            ps.setString(14, post.getRequirements());
            ps.setString(15, post.getBenefits());
            ps.setString(16, post.getContactAddress());
            ps.setString(17, post.getApplicationMethod());
            ps.setString(18, post.getCompanyName());
            ps.setString(19, post.getSalary());
            ps.setString(20, post.getLocation());
            ps.setString(21, post.getJobType());
            ps.setString(22, post.getCompanyLogo());

            // Log the SQL query and parameters
            System.out.println("\n=== Executing SQL Query ===");
            System.out.println("Query: " + query);
            System.out.println("Parameters set successfully");

            int result = ps.executeUpdate();
            System.out.println("Query execution result: " + result);
            
            if (result > 0) {
                System.out.println("Post created successfully");
                return true;
            } else {
                System.err.println("No rows were affected by the insert");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("\n=== SQL Error Details ===");
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Stack trace:");
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("\n=== Unexpected Error Details ===");
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("Stack trace:");
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