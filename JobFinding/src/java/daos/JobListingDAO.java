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
public class JobListingDAO extends DBContext{
    public void updateJobPostType(int jobId, String postType, Timestamp paymentExpiry) {
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
