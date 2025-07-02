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
    
    public List<Posts> listPostBaseOnFeature(int id){
        HomeDAO homeDao = new HomeDAO();
        PostsDAO postDao = new PostsDAO();
        List<Integer> list = homeDao.getAllPostsIDbaseOnID(id);
        List<Posts> premiumPost = new ArrayList<>();
        Set<Integer> visitedIds = new HashSet<>(); // Dùng để đánh dấu ID đã duyệt

        for (int i : list) {
            if (!visitedIds.contains(i)) {
                Posts post = postDao.getPostById(i);
                if (post != null) {
                    premiumPost.add(post);
                    visitedIds.add(i); // đánh dấu đã đi qua
                }
            } else {
                System.out.println("Đã bỏ qua ID trùng: " + i);
            }
        }
        
        return premiumPost;
    }
}
