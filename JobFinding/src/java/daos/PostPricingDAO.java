package daos;

import context.DBContext;
import models.PostPricing;
//import utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostPricingDAO extends DBContext {

    public PostPricing getPricingByCode(String positionCode) {
        String sql = "SELECT * FROM Post_Pricing WHERE position_code = ? AND is_active = 1";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, positionCode);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToPricing(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PostPricing> getJobPostPricing() {
        List<PostPricing> pricings = new ArrayList<>();
        String sql = "SELECT * FROM Post_Pricing WHERE position_code IN ('normal', 'featured', 'premium') AND is_active = 1 ORDER BY price";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                pricings.add(mapResultSetToPricing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pricings;
    }

    public boolean updatePostPricings(String type, double cost, int duration) {
        String sql = "UPDATE [dbo].[Post_Pricing]\n"
                + "   SET [price] = ?, \n"
                + "   [duration_days] = ? \n"
                + " WHERE [position_code] = ?";
        
        int n = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDouble(1, cost);
            stmt.setInt(2, duration);
            stmt.setString(3, type);

            n = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return n > 0;
    }

    private PostPricing mapResultSetToPricing(ResultSet rs) throws SQLException {
        PostPricing pricing = new PostPricing();
        pricing.setId(rs.getInt("id"));
        pricing.setPositionName(rs.getString("position_name"));
        pricing.setPositionCode(rs.getString("position_code"));
        pricing.setPrice(rs.getDouble("price"));
        pricing.setDurationDays(rs.getInt("duration_days"));
        pricing.setDescription(rs.getString("description"));
        pricing.setActive(rs.getBoolean("is_active"));
        pricing.setCreatedAt(rs.getTimestamp("created_at"));
        return pricing;
    }
    
    public static void main(String[] args) {
        PostPricingDAO dao = new PostPricingDAO();
        System.out.println(dao.updatePostPricings("normal", 100000, 30));
    }
}