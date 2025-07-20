/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.Post;

/**
 *
 * @author Admin
 */
public class PostDAO {
    Connection cnn;
    PreparedStatement ps;
    ResultSet rs;

    public List<Post> getPostsByRecruiterId(int recruiterId) throws Exception {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM Posts WHERE user_id = ? AND user_type = 'recruiter' ORDER BY created_at DESC";
        cnn = new DBContext().getConnection();
        ps = cnn.prepareStatement(query);
        ps.setInt(1, recruiterId);
        rs = ps.executeQuery();
        while (rs.next()) {
            Post post = new Post();
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
            post.setCompanyName(rs.getString("company_name"));
            post.setCompanyLogo(rs.getString("company_logo"));
            post.setSalary(rs.getString("salary"));
            post.setLocation(rs.getString("location"));
            post.setJobType(rs.getString("job_type"));
            post.setExperience(rs.getString("experience"));
            post.setDeadline(rs.getDate("deadline"));
            post.setWorkingTime(rs.getString("working_time"));
            post.setJobDescription(rs.getString("job_description"));
            post.setRequirements(rs.getString("requirements"));
            post.setBenefits(rs.getString("benefits"));
            post.setContactAddress(rs.getString("contact_address"));
            post.setApplicationMethod(rs.getString("application_method"));
            post.setQuantity(rs.getInt("quantity"));
            post.setRank(rs.getString("rank"));
            post.setIndustry(rs.getString("industry"));
            post.setContactPerson(rs.getString("contact_person"));
            post.setCompanySize(rs.getString("company_size"));
            post.setCompanyWebsite(rs.getString("company_website"));
            post.setCompanyDescription(rs.getString("company_description"));
            post.setKeywords(rs.getString("keywords"));
            posts.add(post);
        }
        return posts;
    }
    
    public Post getPostById(int postId) throws Exception {
        Post post = null;
        String query = "SELECT * FROM Posts WHERE id = ?";
        cnn = new DBContext().getConnection();
        ps = cnn.prepareStatement(query);
        ps.setInt(1, postId);
        rs = ps.executeQuery();
        if (rs.next()) {
            post = new Post();
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
            post.setCompanyName(rs.getString("company_name"));
            post.setCompanyLogo(rs.getString("company_logo"));
            post.setSalary(rs.getString("salary"));
            post.setLocation(rs.getString("location"));
            post.setJobType(rs.getString("job_type"));
            post.setExperience(rs.getString("experience"));
            post.setDeadline(rs.getDate("deadline"));
            post.setWorkingTime(rs.getString("working_time"));
            post.setJobDescription(rs.getString("job_description"));
            post.setRequirements(rs.getString("requirements"));
            post.setBenefits(rs.getString("benefits"));
            post.setContactAddress(rs.getString("contact_address"));
            post.setApplicationMethod(rs.getString("application_method"));
            post.setQuantity(rs.getInt("quantity"));
            post.setRank(rs.getString("rank"));
            post.setIndustry(rs.getString("industry"));
            post.setContactPerson(rs.getString("contact_person"));
            post.setCompanySize(rs.getString("company_size"));
            post.setCompanyWebsite(rs.getString("company_website"));
            post.setCompanyDescription(rs.getString("company_description"));
            post.setKeywords(rs.getString("keywords"));
        }
        return post;
    }
}
