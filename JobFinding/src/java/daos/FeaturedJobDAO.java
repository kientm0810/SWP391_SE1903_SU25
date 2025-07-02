/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import java.sql.SQLException;
import java.sql.*;

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
}
