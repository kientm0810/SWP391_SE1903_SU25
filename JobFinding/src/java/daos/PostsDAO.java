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
                throw new SQLException("Failed to establish database connection");
            }
        } catch (Exception e) {
            System.err.println("Error initializing PostsDAO: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize PostsDAO: " + e.getMessage());
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
                post.setRank(rs.getString("rank"));
                post.setIndustry(rs.getString("industry"));
                post.setContactPerson(rs.getString("contact_person"));
                post.setCompanySize(rs.getString("company_size"));
                post.setCompanyWebsite(rs.getString("company_website"));
                post.setCompanyDescription(rs.getString("company_description"));
                post.setKeywords(rs.getString("keywords"));
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
                post.setRank(rs.getString("rank"));
                post.setIndustry(rs.getString("industry"));
                post.setContactPerson(rs.getString("contact_person"));
                post.setCompanySize(rs.getString("company_size"));
                post.setCompanyWebsite(rs.getString("company_website"));
                post.setCompanyDescription(rs.getString("company_description"));
                post.setKeywords(rs.getString("keywords"));
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
                post.setRank(rs.getString("rank"));
                post.setIndustry(rs.getString("industry"));
                post.setContactPerson(rs.getString("contact_person"));
                post.setCompanySize(rs.getString("company_size"));
                post.setCompanyWebsite(rs.getString("company_website"));
                post.setCompanyDescription(rs.getString("company_description"));
                post.setKeywords(rs.getString("keywords"));
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

        String query = "INSERT INTO Posts (user_id, user_type, parent_id, post_type, title, status, "
                + "view_count, like_count, comment_count, experience, deadline, working_time, "
                + "job_description, requirements, benefits, contact_address, application_method, "
                + "company_name, salary, location, job_type, company_logo, created_at, updated_at, rank, industry, contact_person, company_size, company_website, company_description, keywords) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE(), ?, ?, ?, ?, ?, ?, ?)";

        try {
            // Thiết lập giá trị mặc định cho các trường bắt buộc nếu chúng là null
            if (post.getUserType() == null) {
                post.setUserType("user");
            }
            if (post.getPostType() == null) {
                post.setPostType("job");
            }
            if (post.getStatus() == null) {
                post.setStatus("active");
            }
            if (post.getViewCount() == 0) {
                post.setViewCount(0);
            }
            if (post.getLikeCount() == 0) {
                post.setLikeCount(0);
            }
            if (post.getCommentCount() == 0) {
                post.setCommentCount(0);
            }

            // Kiểm tra trường userId có hợp lệ không
            if (post.getUserId() <= 0) {
                System.err.println("User ID is required and must be greater than 0");
                return false;
            }

            // Kiểm tra và log các trường bắt buộc
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
                // In ra giá trị các trường bắt buộc
                System.out.println(requiredFields[i] + ": [" + fieldValues[i] + "]");
                // Kiểm tra trường deadline có null không
                if (requiredFields[i].equals("deadline")) {
                    if (post.getDeadline() == null) {
                        System.err.println("Error: " + requiredFields[i] + " is required and null");
                        return false;
                    }
                } else if (fieldValues[i] == null || fieldValues[i].trim().isEmpty()) {
                    // Kiểm tra các trường khác có null hoặc rỗng không
                    System.err.println("Error: " + requiredFields[i] + " is required");
                    return false;
                }
            }

            // Log tất cả dữ liệu của post trước khi insert
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

            // Chuẩn bị truy vấn SQL và set các tham số
            ps = conn.prepareStatement(query);
            // Thiết lập các tham số theo thứ tự trong câu truy vấn SQL
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
            ps.setString(23, post.getRank());
            ps.setString(24, post.getIndustry());
            ps.setString(25, post.getContactPerson());
            ps.setString(26, post.getCompanySize());
            ps.setString(27, post.getCompanyWebsite());
            ps.setString(28, post.getCompanyDescription());
            ps.setString(29, post.getKeywords());

            // Log câu truy vấn SQL và các tham số
            System.out.println("\n=== Executing SQL Query ===");
            System.out.println("Query: " + query);
            System.out.println("Parameters set successfully");

            // Thực thi truy vấn và lấy kết quả
            int result = ps.executeUpdate();
            System.out.println("Query execution result: " + result);

            // Kiểm tra kết quả thực thi
            if (result > 0) {
                System.out.println("Post created successfully");
                return true;
            } else {
                System.err.println("No rows were affected by the insert");
                return false;
            }
        } catch (SQLException e) {
            // Xử lý lỗi SQL
            System.err.println("\n=== SQL Error Details ===");
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Stack trace:");
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            // Xử lý lỗi không xác định
            System.err.println("\n=== Unexpected Error Details ===");
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("Stack trace:");
            e.printStackTrace();
            return false;
        }
    }

    // Update post
    public boolean updatePost(Posts post) {
        String query = "UPDATE Posts SET title = ?, status = ?, experience = ?, deadline = ?, "
                + "working_time = ?, job_description = ?, requirements = ?, benefits = ?, contact_address = ?, "
                + "application_method = ?, company_name = ?, company_logo = ?, salary = ?, location = ?, "
                + "job_type = ?, rank = ?, industry = ?, contact_person = ?, company_size = ?, company_website = ?, company_description = ?, keywords = ?, updated_at = GETDATE() WHERE id = ? AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getStatus());
            ps.setString(3, post.getExperience());
            ps.setDate(4, post.getDeadline() != null ? new java.sql.Date(post.getDeadline().getTime()) : null);
            ps.setString(5, post.getWorkingTime());
            ps.setString(6, post.getJobDescription());
            ps.setString(7, post.getRequirements());
            ps.setString(8, post.getBenefits());
            ps.setString(9, post.getContactAddress());
            ps.setString(10, post.getApplicationMethod());
            ps.setString(11, post.getCompanyName());
            ps.setString(12, post.getCompanyLogo());
            ps.setString(13, post.getSalary());
            ps.setString(14, post.getLocation());
            ps.setString(15, post.getJobType());
            ps.setString(16, post.getRank());
            ps.setString(17, post.getIndustry());
            ps.setString(18, post.getContactPerson());
            ps.setString(19, post.getCompanySize());
            ps.setString(20, post.getCompanyWebsite());
            ps.setString(21, post.getCompanyDescription());
            ps.setString(22, post.getKeywords());
            ps.setInt(23, post.getId());
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
                post.setRank(rs.getString("rank"));
                post.setIndustry(rs.getString("industry"));
                post.setContactPerson(rs.getString("contact_person"));
                post.setCompanySize(rs.getString("company_size"));
                post.setCompanyWebsite(rs.getString("company_website"));
                post.setCompanyDescription(rs.getString("company_description"));
                post.setKeywords(rs.getString("keywords"));
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
                post.setRank(rs.getString("rank"));
                post.setIndustry(rs.getString("industry"));
                post.setContactPerson(rs.getString("contact_person"));
                post.setCompanySize(rs.getString("company_size"));
                post.setCompanyWebsite(rs.getString("company_website"));
                post.setCompanyDescription(rs.getString("company_description"));
                post.setKeywords(rs.getString("keywords"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Lấy tổng số posts của 1 user
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

    // Lấy danh sách posts của 1 user có phân trang
    public List<Posts> getPostsByUserIdWithPaging(int userId, int page, int pageSize) {
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
                post.setRank(rs.getString("rank"));
                post.setIndustry(rs.getString("industry"));
                post.setContactPerson(rs.getString("contact_person"));
                post.setCompanySize(rs.getString("company_size"));
                post.setCompanyWebsite(rs.getString("company_website"));
                post.setCompanyDescription(rs.getString("company_description"));
                post.setKeywords(rs.getString("keywords"));
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
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return conn;
    }
}
