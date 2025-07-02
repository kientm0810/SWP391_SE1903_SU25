/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import models.Posts;
import models.PromotionProgram;
import models.FeaturedJob;

/**
 *
 * @author andin
 */
public class FeaturedJobDAO extends DBContext {

    public int addFeaturedJob(int postID, int promotionID, int transactionID, int expireTime) {
        String sql = "INSERT INTO [dbo].[Featured_Jobs]\n"
                + "           ([post_id]\n"
                + "           ,[promotion_id]\n"
                + "           ,[start_date]\n"
                + "           ,[end_date]\n"
                + "           ,[transaction_id])\n"
                + "VALUES (?, ?, GETDATE(), DATEADD(DAY, ?, GETDATE()), ?)";

        int n = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, postID);
            stmt.setInt(2, promotionID);
            stmt.setInt(3, expireTime);
            stmt.setInt(4, transactionID);

            n = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public void updateFeaturedJob(int jobId, String postType, Timestamp paymentExpiry) {
        String sql = "UPDATE Job_Listings SET post_type = ?, payment_expiry = ? WHERE id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, postType);
            stmt.setTimestamp(2, paymentExpiry);
            stmt.setInt(3, jobId);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cải tiến: Lấy danh sách posts theo promotion program ID
    public List<Posts> listPostBaseOnFeature(int promotionId) {
        PostsDAO postDao = new PostsDAO();
        List<Posts> featuredPosts = new ArrayList<>();

        String sql = "SELECT DISTINCT fj.post_id, fj.start_date, fj.end_date, fj.transaction_id "
                + "FROM Featured_Jobs fj "
                + "INNER JOIN Posts p ON fj.post_id = p.id "
                + "WHERE fj.promotion_id = ? "
                + "ORDER BY fj.start_date DESC";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            ResultSet rs = stmt.executeQuery();

            Set<Integer> visitedIds = new HashSet<>();

            while (rs.next()) {
                int postId = rs.getInt("post_id");

                if (!visitedIds.contains(postId)) {
                    Posts post = postDao.getPostById(postId);
                    if (post != null) {
                        featuredPosts.add(post);
                        visitedIds.add(postId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return featuredPosts;
    }

    // Lấy thông tin chi tiết featured job
    public List<FeaturedJob> getFeaturedJobsByPromotionId(int promotionId) {
        List<FeaturedJob> featuredJobs = new ArrayList<>();
        String sql = "SELECT * FROM Featured_Jobs WHERE promotion_id = ? ORDER BY start_date DESC";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                FeaturedJob fj = new FeaturedJob();
                fj.setId(rs.getInt("id"));
                fj.setPost_id(rs.getInt("post_id"));
                fj.setPromotion_id(rs.getInt("promotion_id"));
                fj.setStart_date(rs.getDate("start_date"));
                fj.setEnd_date(rs.getDate("end_date"));
                fj.setTransaction_id(rs.getInt("transaction_id"));

                featuredJobs.add(fj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return featuredJobs;
    }

    // Đếm số lượng posts theo promotion program
    public int countPostsByPromotionId(int promotionId) {
        String sql = "SELECT COUNT(DISTINCT fj.post_id) FROM Featured_Jobs fj "
                + "INNER JOIN Posts p ON fj.post_id = p.id "
                + "WHERE fj.promotion_id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Lấy tổng doanh thu từ promotion program
    public double getTotalRevenueByPromotionId(int promotionId) {
        String sql = "SELECT SUM(ft.amount) FROM Featured_Jobs fj "
                + "INNER JOIN Financial_Transactions ft ON fj.transaction_id = ft.id "
                + "WHERE fj.promotion_id = ? AND ft.status = 'completed'";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0.0;
    }

    // Lấy danh sách posts với phân trang và sorting - FIX TEXT sorting issue
    public List<PostPromotionInfo> getPostsByPromotionIdWithPaging(int promotionId, int page, int pageSize, String sortField, String sortOrder) {
        List<PostPromotionInfo> featuredPosts = new ArrayList<>();

        // Chỉ SELECT các cột cần thiết, không phải TEXT fields
        String sql = "SELECT p.id, p.user_id, p.user_type, p.parent_id, p.post_type, p.title, " +
                     "p.status, p.view_count, p.like_count, p.comment_count, p.created_at, p.updated_at, p.deleted_at, " +
                     "p.company_name, p.company_logo, p.salary, p.location, p.job_type, p.experience, p.deadline, " +
                     "p.working_time, p.contact_address, p.quantity, p.rank, p.industry, p.contact_person, " +
                     "p.company_size, p.company_website, p.keywords, " +
                     "COUNT(fj.id) as registration_count, " +
                     "MAX(fj.start_date) as latest_registration " +
                     "FROM Featured_Jobs fj " +
                     "INNER JOIN Posts p ON fj.post_id = p.id " +
                     "WHERE fj.promotion_id = ? AND p.deleted_at IS NULL " +
                     "GROUP BY p.id, p.user_id, p.user_type, p.parent_id, p.post_type, p.title, " +
                     "p.status, p.view_count, p.like_count, p.comment_count, p.created_at, p.updated_at, p.deleted_at, " +
                     "p.company_name, p.company_logo, p.salary, p.location, p.job_type, p.experience, p.deadline, " +
                     "p.working_time, p.contact_address, p.quantity, p.rank, p.industry, p.contact_person, " +
                     "p.company_size, p.company_website, p.keywords " +
                     "ORDER BY p." + sortField + " " + sortOrder + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            stmt.setInt(2, (page - 1) * pageSize);
            stmt.setInt(3, pageSize);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Lấy thêm TEXT fields từ Posts table riêng biệt
                int postId = rs.getInt("id");
                Posts post = getPostDetails(postId, rs);
                int registrationCount = rs.getInt("registration_count");
                Timestamp latestRegistration = rs.getTimestamp("latest_registration");

                PostPromotionInfo info = new PostPromotionInfo(post, registrationCount, latestRegistration);
                featuredPosts.add(info);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return featuredPosts;
    }

    // Search posts theo promotion ID với pagination - chỉ theo title
    public List<PostPromotionInfo> searchPostsByPromotionIdWithPaging(int promotionId, String title, int page, int pageSize, String sortField, String sortOrder) {
        List<PostPromotionInfo> featuredPosts = new ArrayList<>();

        String sql = "SELECT p.id, p.user_id, p.user_type, p.parent_id, p.post_type, p.title, " +
                     "p.status, p.view_count, p.like_count, p.comment_count, p.created_at, p.updated_at, p.deleted_at, " +
                     "p.company_name, p.company_logo, p.salary, p.location, p.job_type, p.experience, p.deadline, " +
                     "p.working_time, p.contact_address, p.quantity, p.rank, p.industry, p.contact_person, " +
                     "p.company_size, p.company_website, p.keywords, " +
                     "COUNT(fj.id) as registration_count, " +
                     "MAX(fj.start_date) as latest_registration " +
                     "FROM Featured_Jobs fj " +
                     "INNER JOIN Posts p ON fj.post_id = p.id " +
                     "WHERE fj.promotion_id = ? AND p.deleted_at IS NULL " +
                     "AND p.title LIKE ? " +
                     "GROUP BY p.id, p.user_id, p.user_type, p.parent_id, p.post_type, p.title, " +
                     "p.status, p.view_count, p.like_count, p.comment_count, p.created_at, p.updated_at, p.deleted_at, " +
                     "p.company_name, p.company_logo, p.salary, p.location, p.job_type, p.experience, p.deadline, " +
                     "p.working_time, p.contact_address, p.quantity, p.rank, p.industry, p.contact_person, " +
                     "p.company_size, p.company_website, p.keywords " +
                     "ORDER BY p." + sortField + " " + sortOrder + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            stmt.setString(2, "%" + title + "%");
            stmt.setInt(3, (page - 1) * pageSize);
            stmt.setInt(4, pageSize);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt("id");
                Posts post = getPostDetails(postId, rs);
                int registrationCount = rs.getInt("registration_count");
                Timestamp latestRegistration = rs.getTimestamp("latest_registration");

                PostPromotionInfo info = new PostPromotionInfo(post, registrationCount, latestRegistration);
                featuredPosts.add(info);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return featuredPosts;
    }

    // Đếm unique posts search results theo title
    public int countSearchPostsByPromotionId(int promotionId, String title) {
        String sql = "SELECT COUNT(DISTINCT p.id) FROM Featured_Jobs fj "
                + "INNER JOIN Posts p ON fj.post_id = p.id "
                + "WHERE fj.promotion_id = ? AND p.deleted_at IS NULL "
                + "AND p.title LIKE ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            stmt.setString(2, "%" + title + "%");
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Đếm unique posts theo promotion program
    public int countUniquePostsByPromotionId(int promotionId) {
        String sql = "SELECT COUNT(DISTINCT p.id) FROM Featured_Jobs fj "
                + "INNER JOIN Posts p ON fj.post_id = p.id "
                + "WHERE fj.promotion_id = ? AND p.deleted_at IS NULL";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, promotionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Helper method để lấy post details từ ResultSet và TEXT fields riêng biệt
    private Posts getPostDetails(int postId, ResultSet rs) throws SQLException {
        Posts post = new Posts();
        
        // Set các field từ ResultSet hiện tại
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
        post.setCompanyName(rs.getString("company_name"));
        post.setCompanyLogo(rs.getString("company_logo"));
        post.setSalary(rs.getString("salary"));
        post.setLocation(rs.getString("location"));
        post.setJobType(rs.getString("job_type"));
        post.setExperience(rs.getString("experience"));
        post.setDeadline(rs.getDate("deadline"));
        post.setWorkingTime(rs.getString("working_time"));
        post.setContactAddress(rs.getString("contact_address"));
        post.setQuantity(rs.getInt("quantity"));
        post.setRank(rs.getString("rank"));
        post.setIndustry(rs.getString("industry"));
        post.setContactPerson(rs.getString("contact_person"));
        post.setCompanySize(rs.getString("company_size"));
        post.setCompanyWebsite(rs.getString("company_website"));
        post.setKeywords(rs.getString("keywords"));

        // Lấy TEXT fields riêng biệt nếu cần
        String textSql = "SELECT job_description, requirements, benefits, application_method, company_description " +
                        "FROM Posts WHERE id = ?";
        try {
            PreparedStatement textStmt = connection.prepareStatement(textSql);
            textStmt.setInt(1, postId);
            ResultSet textRs = textStmt.executeQuery();
            
            if (textRs.next()) {
                post.setJobDescription(textRs.getString("job_description"));
                post.setRequirements(textRs.getString("requirements"));
                post.setBenefits(textRs.getString("benefits"));
                post.setApplicationMethod(textRs.getString("application_method"));
                post.setCompanyDescription(textRs.getString("company_description"));
            }
            textRs.close();
            textStmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return post;
    }

    // Inner class để chứa thông tin post + promotion info
    public static class PostPromotionInfo {

        private Posts post;
        private int registrationCount;
        private Timestamp latestRegistration;

        public PostPromotionInfo(Posts post, int registrationCount, Timestamp latestRegistration) {
            this.post = post;
            this.registrationCount = registrationCount;
            this.latestRegistration = latestRegistration;
        }

        // Getters
        public Posts getPost() {
            return post;
        }

        public int getRegistrationCount() {
            return registrationCount;
        }

        public Timestamp getLatestRegistration() {
            return latestRegistration;
        }
    }

    public static void main(String[] args) {
        FeaturedJobDAO dao = new FeaturedJobDAO();
        List<PostPromotionInfo> result = dao.getPostsByPromotionIdWithPaging(4, 1, 10, "created_at", "ASC");
        System.out.println("Found " + result.size() + " posts");
        for (PostPromotionInfo info : result) {
            System.out.println("Post: " + info.getPost().getTitle() + 
                             " - Registrations: " + info.getRegistrationCount() + 
                             " - Latest: " + info.getLatestRegistration());
        }
    }
}