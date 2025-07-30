package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.AdvancedSearchCriteria;
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
        String query = "SELECT * FROM Posts WHERE deleted_at IS NULL AND (updated_at >= GETDATE()  OR updated_at IS NULL) ORDER BY created_at DESC";
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
        String query = "SELECT * FROM Posts WHERE user_id = ? AND deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL) ORDER BY created_at DESC";
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
        String query = "SELECT * FROM Posts WHERE id = ? AND deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL)";
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
                + "company_name, salary, location, job_type, company_logo, created_at, updated_at, rank, industry, contact_person, company_size, company_website, company_description, keywords, salary_min, salary_max, experience_years) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            if (post.getUpdatedAt() != null) {
                ps.setTimestamp(23, new java.sql.Timestamp(post.getUpdatedAt().getTime()));
            } else {
                ps.setTimestamp(23, new java.sql.Timestamp(System.currentTimeMillis()));
            }
            ps.setString(24, post.getRank());
            ps.setString(25, post.getIndustry());
            ps.setString(26, post.getContactPerson());
            ps.setString(27, post.getCompanySize());
            ps.setString(28, post.getCompanyWebsite());
            ps.setString(29, post.getCompanyDescription());
            ps.setString(30, post.getKeywords());
            ps.setObject(31, post.getSalaryMin());
            ps.setObject(32, post.getSalaryMax());
            ps.setObject(33, post.getExperienceYears());

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
                + "job_type = ?, rank = ?, industry = ?, contact_person = ?, company_size = ?, company_website = ?, company_description = ?, keywords = ?, salary_min = ?, salary_max = ?, experience_years = ?, updated_at = GETDATE() WHERE id = ? AND deleted_at IS NULL";
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
            ps.setObject(23, post.getSalaryMin());
            ps.setObject(24, post.getSalaryMax());
            ps.setObject(25, post.getExperienceYears());
            ps.setInt(26, post.getId());
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

    // Delete posts with updated_at < current date (soft delete)
    public int deleteOldPosts() {
        String query = "UPDATE Posts SET deleted_at = GETDATE() WHERE updated_at < GETDATE() AND updated_at IS NOT NULL AND deleted_at IS NULL";
        try {
            ps = conn.prepareStatement(query);
            int affectedRows = ps.executeUpdate();
            System.out.println("Deleted " + affectedRows + " old posts (updated_at < current date)");
            return affectedRows;
        } catch (SQLException e) {
            System.err.println("Error deleting old posts: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    // Get count of old posts (updated_at < current date)
    public int getOldPostsCount() {
        String query = "SELECT COUNT(*) FROM Posts WHERE updated_at < GETDATE() AND updated_at IS NOT NULL AND deleted_at IS NULL";
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
        String query = "SELECT COUNT(*) FROM Posts WHERE deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL)";
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
        String query = "SELECT * FROM Posts WHERE deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL) ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
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
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM Posts WHERE deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL)");
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

    // Lấy posts theo tìm kiếm 
    public List<Posts> getPostsByPageWithSearch(int page, int pageSize, String keyword, String jobType, String location) {
        List<Posts> posts = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Posts WHERE deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL)");
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

    // Lấy danh sách posts của 1 recruiter
    public List<Posts> getPostsByUserIdWithPaging(int userId, int page, int pageSize) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE user_id = ? AND deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL) ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
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

    // Get latest posts for homepage or recommendation
    public List<Posts> getLatestPosts(int limit) {
        List<Posts> posts = new ArrayList<>();
        String query = "SELECT TOP (?) * FROM Posts WHERE deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL) ORDER BY created_at DESC";
        
        System.out.println("Getting latest posts with query: " + query);
        
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                Posts post = mapResultSetToPost(rs);
                posts.add(post);
                count++;
                System.out.println("Latest post: ID=" + post.getId() + ", Title=" + post.getTitle() + ", User ID=" + post.getUserId());
            }
            System.out.println("Found " + count + " latest posts");
        } catch (SQLException e) {
            System.out.println("Error getting latest posts: " + e.getMessage());
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * Tìm kiếm việc làm với nhiều điều kiện
     */
    public List<Posts> searchJobs(String keyword, String location, String jobType, 
                                 String industry, Double minSalary, Double maxSalary, 
                                 String experience, int page, int pageSize) {
        List<Posts> posts = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("SELECT * FROM Posts WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL");
        
        // Từ khóa tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR company_name LIKE ? OR job_description LIKE ? OR keywords LIKE ?)");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        // Địa điểm
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
            params.add("%" + location.trim() + "%");
        }
        
        // Loại công việc
        if (jobType != null && !jobType.trim().isEmpty()) {
            sql.append(" AND job_type = ?");
            params.add(jobType.trim());
        }
        
        // Ngành nghề
        if (industry != null && !industry.trim().isEmpty()) {
            sql.append(" AND industry LIKE ?");
            params.add("%" + industry.trim() + "%");
        }
        
        // Mức lương tối thiểu
        if (minSalary != null && minSalary > 0) {
            sql.append(" AND (salary_min >= ? OR CAST(REPLACE(REPLACE(salary, ',', ''), ' ', '') AS DECIMAL(12,2)) >= ?)");
            params.add(minSalary);
            params.add(minSalary);
        }
        
        // Mức lương tối đa
        if (maxSalary != null && maxSalary > 0) {
            sql.append(" AND (salary_max <= ? OR CAST(REPLACE(REPLACE(salary, ',', ''), ' ', '') AS DECIMAL(12,2)) <= ?)");
            params.add(maxSalary);
            params.add(maxSalary);
        }
        
        // Kinh nghiệm
        if (experience != null && !experience.trim().isEmpty()) {
            sql.append(" AND experience LIKE ?");
            params.add("%" + experience.trim() + "%");
        }
        
        sql.append(" ORDER BY created_at DESC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        
        try {
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Posts post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return posts;
    }
    
    /**
     * Đếm tổng số kết quả tìm kiếm
     */
    public int countSearchResults(String keyword, String location, String jobType, 
                                 String industry, Double minSalary, Double maxSalary, 
                                 String experience) {
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("SELECT COUNT(*) FROM Posts WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL");
        
        // Từ khóa tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR company_name LIKE ? OR job_description LIKE ? OR keywords LIKE ?)");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        // Địa điểm
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
            params.add("%" + location.trim() + "%");
        }
        
        // Loại công việc
        if (jobType != null && !jobType.trim().isEmpty()) {
            sql.append(" AND job_type = ?");
            params.add(jobType.trim());
        }
        
        // Ngành nghề
        if (industry != null && !industry.trim().isEmpty()) {
            sql.append(" AND industry LIKE ?");
            params.add("%" + industry.trim() + "%");
        }
        
        // Mức lương tối thiểu
        if (minSalary != null && minSalary > 0) {
            sql.append(" AND (salary_min >= ? OR CAST(REPLACE(REPLACE(salary, ',', ''), ' ', '') AS DECIMAL(12,2)) >= ?)");
            params.add(minSalary);
            params.add(minSalary);
        }
        
        // Mức lương tối đa
        if (maxSalary != null && maxSalary > 0) {
            sql.append(" AND (salary_max <= ? OR CAST(REPLACE(REPLACE(salary, ',', ''), ' ', '') AS DECIMAL(12,2)) <= ?)");
            params.add(maxSalary);
            params.add(maxSalary);
        }
        
        // Kinh nghiệm
        if (experience != null && !experience.trim().isEmpty()) {
            sql.append(" AND experience LIKE ?");
            params.add("%" + experience.trim() + "%");
        }
        
        try {
            ps = conn.prepareStatement(sql.toString());
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
    
    /**
     * Lấy việc làm gợi ý dựa trên lịch sử tìm kiếm
     */
    public List<Posts> getRelatedJobs(String keyword, String industry, String jobType, int limit) {
        List<Posts> posts = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("SELECT TOP(?) * FROM Posts WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL");
        params.add(limit);
        
        // Tìm kiếm theo từ khóa hoặc ngành nghề hoặc loại công việc
        if ((keyword != null && !keyword.trim().isEmpty()) || 
            (industry != null && !industry.trim().isEmpty()) || 
            (jobType != null && !jobType.trim().isEmpty())) {
            
            sql.append(" AND (");
            List<String> conditions = new ArrayList<>();
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                conditions.add("(title LIKE ? OR company_name LIKE ? OR keywords LIKE ?)");
                String searchPattern = "%" + keyword.trim() + "%";
                params.add(searchPattern);
                params.add(searchPattern);
                params.add(searchPattern);
            }
            
            if (industry != null && !industry.trim().isEmpty()) {
                conditions.add("industry LIKE ?");
                params.add("%" + industry.trim() + "%");
            }
            
            if (jobType != null && !jobType.trim().isEmpty()) {
                conditions.add("job_type = ?");
                params.add(jobType.trim());
            }
            
            sql.append(String.join(" OR ", conditions));
            sql.append(")");
        }
        
        sql.append(" ORDER BY created_at DESC");
        
        try {
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Posts post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return posts;
    }
    
    /**
     * Lấy việc làm nổi bật
     */
    public List<Posts> getFeaturedJobs(int limit) {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT TOP(?) * FROM Posts WHERE post_type = 'post' AND status = 'active' " +
                    "AND deleted_at IS NULL AND view_count > 10 ORDER BY view_count DESC, created_at DESC";
        
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Posts post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return posts;
    }
    
    /**
     * Lấy danh sách địa điểm phổ biến
     */
    public List<String> getPopularLocations(int limit) {
        List<String> locations = new ArrayList<>();
        String sql = "SELECT TOP(?) location, COUNT(*) as count FROM Posts " +
                    "WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL " +
                    "AND location IS NOT NULL AND location != '' " +
                    "GROUP BY location ORDER BY count DESC";
        
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                locations.add(rs.getString("location"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return locations;
    }
    
    /**
     * Lấy danh sách ngành nghề phổ biến
     */
    public List<String> getPopularIndustries(int limit) {
        List<String> industries = new ArrayList<>();
        String sql = "SELECT TOP(?) industry, COUNT(*) as count FROM Posts " +
                    "WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL " +
                    "AND industry IS NOT NULL AND industry != '' " +
                    "GROUP BY industry ORDER BY count DESC";
        
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                industries.add(rs.getString("industry"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return industries;
    }
    
    /**
     * Helper method để map ResultSet thành Posts object
     */
    private Posts mapResultSetToPost(ResultSet rs) throws SQLException {
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
        
        // Map new fields for advanced search
        try {
            post.setSalaryMin(rs.getDouble("salary_min"));
        } catch (SQLException e) {
            post.setSalaryMin(null);
        }
        
        try {
            post.setSalaryMax(rs.getDouble("salary_max"));
        } catch (SQLException e) {
            post.setSalaryMax(null);
        }
        
        try {
            post.setExperienceYears(rs.getInt("experience_years"));
        } catch (SQLException e) {
            post.setExperienceYears(null);
        }
        
        return post;
    }

    /**
     * Lấy việc làm liên quan dựa trên bài đăng hiện tại
     */
    public List<Posts> getRelatedPostsByPostId(int postId, int limit) {
        List<Posts> posts = new ArrayList<>();
        
        // Đầu tiên lấy thông tin bài đăng hiện tại
        Posts currentPost = getPostById(postId);
        if (currentPost == null) {
            return posts;
        }
        
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("SELECT TOP(?) * FROM Posts WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL AND id != ?");
        params.add(limit);
        params.add(postId);
        
        // Tìm kiếm theo các tiêu chí liên quan
        List<String> conditions = new ArrayList<>();
        
        // Theo ngành nghề
        if (currentPost.getIndustry() != null && !currentPost.getIndustry().trim().isEmpty()) {
            conditions.add("industry LIKE ?");
            params.add("%" + currentPost.getIndustry().trim() + "%");
        }
        
        // Theo loại công việc
        if (currentPost.getJobType() != null && !currentPost.getJobType().trim().isEmpty()) {
            conditions.add("job_type = ?");
            params.add(currentPost.getJobType().trim());
        }
        
        // Theo địa điểm
        if (currentPost.getLocation() != null && !currentPost.getLocation().trim().isEmpty()) {
            conditions.add("location LIKE ?");
            params.add("%" + currentPost.getLocation().trim() + "%");
        }
        
        // Theo từ khóa
        if (currentPost.getKeywords() != null && !currentPost.getKeywords().trim().isEmpty()) {
            String[] keywords = currentPost.getKeywords().split(",");
            for (String keyword : keywords) {
                if (!keyword.trim().isEmpty()) {
                    conditions.add("(title LIKE ? OR company_name LIKE ? OR keywords LIKE ?)");
                    String searchPattern = "%" + keyword.trim() + "%";
                    params.add(searchPattern);
                    params.add(searchPattern);
                    params.add(searchPattern);
                }
            }
        }
        
        // Theo tiêu đề (tìm các từ khóa chung)
        if (currentPost.getTitle() != null && !currentPost.getTitle().trim().isEmpty()) {
            String[] titleWords = currentPost.getTitle().split("\\s+");
            for (String word : titleWords) {
                if (word.length() > 3) { // Chỉ tìm từ có độ dài > 3
                    conditions.add("(title LIKE ? OR company_name LIKE ?)");
                    String searchPattern = "%" + word.trim() + "%";
                    params.add(searchPattern);
                    params.add(searchPattern);
                }
            }
        }
        
        if (!conditions.isEmpty()) {
            sql.append(" AND (");
            sql.append(String.join(" OR ", conditions));
            sql.append(")");
        }
        
        sql.append(" ORDER BY created_at DESC");
        
        try {
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Posts post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return posts;
    }

    /**
     * Lấy các bài đăng liên quan cùng recruiter (userId), loại trừ bài hiện tại
     */
    public List<Posts> getRelatedPostsByRecruiter(int userId, int excludePostId, int limit) {
        List<Posts> posts = new ArrayList<>();
        String sql = "SELECT TOP(?) * FROM Posts WHERE user_id = ? AND id != ? AND deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL) ORDER BY created_at DESC";
        
        System.out.println("SQL Query: " + sql);
        System.out.println("Parameters: limit=" + limit + ", userId=" + userId + ", excludePostId=" + excludePostId);
        
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ps.setInt(2, userId);
            ps.setInt(3, excludePostId);
            rs = ps.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                Posts post = mapResultSetToPost(rs);
                posts.add(post);
                count++;
            }
            System.out.println("Found " + count + " related posts in database");
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return posts;
    }
    
    /**
     * Lấy các bài đăng từ các recruiter khác (không phải recruiter của bài đăng hiện tại)
     */
    public List<Posts> getRelatedPostsFromOtherRecruiters(int excludePostId, int limit) {
        List<Posts> posts = new ArrayList<>();
        
        // Đầu tiên lấy thông tin bài đăng hiện tại để biết recruiter
        Posts currentPost = getPostById(excludePostId);
        if (currentPost == null) {
            System.out.println("Current post not found for ID: " + excludePostId);
            return posts;
        }
        
        System.out.println("Current post - ID: " + currentPost.getId() + ", User ID: " + currentPost.getUserId());
        
        // Kiểm tra xem có bao nhiêu bài đăng trong database
        try {
            String countSql = "SELECT COUNT(*) FROM Posts WHERE deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL)";
            ps = conn.prepareStatement(countSql);
            rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Total posts in database: " + rs.getInt(1));
            }
        } catch (SQLException e) {
            System.out.println("Error counting total posts: " + e.getMessage());
        }
        
        // Kiểm tra xem có bao nhiêu bài đăng của các recruiter khác
        try {
            String countOtherSql = "SELECT COUNT(*) FROM Posts WHERE user_id != ? AND deleted_at IS NULL";
            ps = conn.prepareStatement(countOtherSql);
            ps.setInt(1, currentPost.getUserId());
            rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Posts from other recruiters: " + rs.getInt(1));
            }
        } catch (SQLException e) {
            System.out.println("Error counting other recruiter posts: " + e.getMessage());
        }
        
        String sql = "SELECT TOP(?) * FROM Posts WHERE user_id != ? AND id != ? AND deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL) ORDER BY created_at DESC";
        
        System.out.println("SQL Query: " + sql);
        System.out.println("Parameters: limit=" + limit + ", excludeUserId=" + currentPost.getUserId() + ", excludePostId=" + excludePostId);
        
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ps.setInt(2, currentPost.getUserId()); // Loại trừ recruiter hiện tại
            ps.setInt(3, excludePostId); // Loại trừ bài đăng hiện tại
            rs = ps.executeQuery();
            
            int count = 0;
            while (rs.next()) {
                Posts post = mapResultSetToPost(rs);
                posts.add(post);
                count++;
                System.out.println("Found post: ID=" + post.getId() + ", Title=" + post.getTitle() + ", User ID=" + post.getUserId());
            }
            System.out.println("Found " + count + " related posts from other recruiters");
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return posts;
    }
    
    /**
     * Tìm kiếm nâng cao với AdvancedSearchCriteria
     */
    public List<Posts> advancedSearch(AdvancedSearchCriteria criteria) {
        List<Posts> posts = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("SELECT * FROM Posts WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL");
        
        // Từ khóa tìm kiếm
        if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR company_name LIKE ? OR job_description LIKE ? OR keywords LIKE ?)");
            String searchPattern = "%" + criteria.getKeyword().trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        // Địa điểm
        if (criteria.getLocation() != null && !criteria.getLocation().trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
            params.add("%" + criteria.getLocation().trim() + "%");
        }
        
        // Ngành nghề
        if (criteria.getIndustry() != null && !criteria.getIndustry().trim().isEmpty()) {
            sql.append(" AND industry LIKE ?");
            params.add("%" + criteria.getIndustry().trim() + "%");
        }
        
        // Loại công việc
        if (criteria.getJobType() != null && !criteria.getJobType().trim().isEmpty()) {
            sql.append(" AND job_type = ?");
            params.add(criteria.getJobType().trim());
        }
        
        // Kinh nghiệm - Tìm kiếm chính xác hơn
        if (criteria.getExperience() != null && !criteria.getExperience().trim().isEmpty()) {
            String experienceSearch = criteria.getExperience().trim();
            // Tìm kiếm chính xác hơn cho kinh nghiệm
            sql.append(" AND (experience LIKE ? OR experience LIKE ? OR experience LIKE ?)");
            params.add(experienceSearch + "%"); // Bắt đầu với giá trị tìm kiếm
            params.add("% " + experienceSearch + "%"); // Có khoảng trắng trước
            params.add("%" + experienceSearch); // Kết thúc với giá trị tìm kiếm
        }
        
        // Cấp bậc
        if (criteria.getRank() != null && !criteria.getRank().trim().isEmpty()) {
            sql.append(" AND rank LIKE ?");
            params.add("%" + criteria.getRank().trim() + "%");
        }
        
        // Thời gian làm việc
        if (criteria.getWorkingTime() != null && !criteria.getWorkingTime().trim().isEmpty()) {
            sql.append(" AND working_time LIKE ?");
            params.add("%" + criteria.getWorkingTime().trim() + "%");
        }
        
        // Mức lương
        if (criteria.getSalary() != null && !criteria.getSalary().trim().isEmpty()) {
            sql.append(" AND salary LIKE ?");
            params.add("%" + criteria.getSalary().trim() + "%");
        }
        
        // Tên công ty
        if (criteria.getCompanyName() != null && !criteria.getCompanyName().trim().isEmpty()) {
            sql.append(" AND company_name LIKE ?");
            params.add("%" + criteria.getCompanyName().trim() + "%");
        }
        
        // Quy mô công ty
        if (criteria.getCompanySize() != null && !criteria.getCompanySize().trim().isEmpty()) {
            sql.append(" AND company_size LIKE ?");
            params.add("%" + criteria.getCompanySize().trim() + "%");
        }
        
        // Địa chỉ làm việc
        if (criteria.getContactAddress() != null && !criteria.getContactAddress().trim().isEmpty()) {
            sql.append(" AND contact_address LIKE ?");
            params.add("%" + criteria.getContactAddress().trim() + "%");
        }
        
        // Yêu cầu ứng viên
        if (criteria.getRequirements() != null && !criteria.getRequirements().trim().isEmpty()) {
            sql.append(" AND requirements LIKE ?");
            params.add("%" + criteria.getRequirements().trim() + "%");
        }
        
        // Phúc lợi
        if (criteria.getBenefits() != null && !criteria.getBenefits().trim().isEmpty()) {
            sql.append(" AND benefits LIKE ?");
            params.add("%" + criteria.getBenefits().trim() + "%");
        }
        
        // Cách thức ứng tuyển
        if (criteria.getApplicationMethod() != null && !criteria.getApplicationMethod().trim().isEmpty()) {
            sql.append(" AND application_method LIKE ?");
            params.add("%" + criteria.getApplicationMethod().trim() + "%");
        }
        
        // Sắp xếp
        sql.append(" ORDER BY ").append(criteria.getSortBy()).append(" ").append(criteria.getSortOrder());
        
        // Phân trang
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((criteria.getPage() - 1) * criteria.getPageSize());
        params.add(criteria.getPageSize());
        
        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Posts post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return posts;
    }
    
    /**
     * Đếm tổng số kết quả tìm kiếm nâng cao
     */
    public int countAdvancedSearchResults(AdvancedSearchCriteria criteria) {
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("SELECT COUNT(*) FROM Posts WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL");
        
        // Từ khóa tìm kiếm
        if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR company_name LIKE ? OR job_description LIKE ? OR keywords LIKE ?)");
            String searchPattern = "%" + criteria.getKeyword().trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        // Địa điểm
        if (criteria.getLocation() != null && !criteria.getLocation().trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
            params.add("%" + criteria.getLocation().trim() + "%");
        }
        
        // Ngành nghề
        if (criteria.getIndustry() != null && !criteria.getIndustry().trim().isEmpty()) {
            sql.append(" AND industry LIKE ?");
            params.add("%" + criteria.getIndustry().trim() + "%");
        }
        
        // Loại công việc
        if (criteria.getJobType() != null && !criteria.getJobType().trim().isEmpty()) {
            sql.append(" AND job_type = ?");
            params.add(criteria.getJobType().trim());
        }
        
        // Kinh nghiệm - Tìm kiếm chính xác hơn
        if (criteria.getExperience() != null && !criteria.getExperience().trim().isEmpty()) {
            String experienceSearch = criteria.getExperience().trim();
            // Tìm kiếm chính xác hơn cho kinh nghiệm
            sql.append(" AND (experience LIKE ? OR experience LIKE ? OR experience LIKE ?)");
            params.add(experienceSearch + "%"); // Bắt đầu với giá trị tìm kiếm
            params.add("% " + experienceSearch + "%"); // Có khoảng trắng trước
            params.add("%" + experienceSearch); // Kết thúc với giá trị tìm kiếm
        }
        
        // Cấp bậc
        if (criteria.getRank() != null && !criteria.getRank().trim().isEmpty()) {
            sql.append(" AND rank LIKE ?");
            params.add("%" + criteria.getRank().trim() + "%");
        }
        
        // Thời gian làm việc
        if (criteria.getWorkingTime() != null && !criteria.getWorkingTime().trim().isEmpty()) {
            sql.append(" AND working_time LIKE ?");
            params.add("%" + criteria.getWorkingTime().trim() + "%");
        }
        
        // Mức lương
        if (criteria.getSalary() != null && !criteria.getSalary().trim().isEmpty()) {
            sql.append(" AND salary LIKE ?");
            params.add("%" + criteria.getSalary().trim() + "%");
        }
        
        // Tên công ty
        if (criteria.getCompanyName() != null && !criteria.getCompanyName().trim().isEmpty()) {
            sql.append(" AND company_name LIKE ?");
            params.add("%" + criteria.getCompanyName().trim() + "%");
        }
        
        // Quy mô công ty
        if (criteria.getCompanySize() != null && !criteria.getCompanySize().trim().isEmpty()) {
            sql.append(" AND company_size LIKE ?");
            params.add("%" + criteria.getCompanySize().trim() + "%");
        }
        
        // Địa chỉ làm việc
        if (criteria.getContactAddress() != null && !criteria.getContactAddress().trim().isEmpty()) {
            sql.append(" AND contact_address LIKE ?");
            params.add("%" + criteria.getContactAddress().trim() + "%");
        }
        
        // Yêu cầu ứng viên
        if (criteria.getRequirements() != null && !criteria.getRequirements().trim().isEmpty()) {
            sql.append(" AND requirements LIKE ?");
            params.add("%" + criteria.getRequirements().trim() + "%");
        }
        
        // Phúc lợi
        if (criteria.getBenefits() != null && !criteria.getBenefits().trim().isEmpty()) {
            sql.append(" AND benefits LIKE ?");
            params.add("%" + criteria.getBenefits().trim() + "%");
        }
        
        // Cách thức ứng tuyển
        if (criteria.getApplicationMethod() != null && !criteria.getApplicationMethod().trim().isEmpty()) {
            sql.append(" AND application_method LIKE ?");
            params.add("%" + criteria.getApplicationMethod().trim() + "%");
        }
        
        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
}
