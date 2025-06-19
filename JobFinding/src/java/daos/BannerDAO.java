package daos;

import context.DBContext;
import models.Banner;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class BannerDAO extends DBContext {

    public Vector<Banner> getAllBanners() {
        Vector<Banner> banners = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Banner]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                banners.add(mapResultSetToBanner(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }

    public Vector<Banner> getBannersByAdminId(int adminId) {
        Vector<Banner> banners = new Vector<>();
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Banner] WHERE admin_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                banners.add(mapResultSetToBanner(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }

    public Banner getBannerById(int id) {
        String sql = "SELECT * FROM [project_SWP391].[dbo].[Banner] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToBanner(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertBanner(Banner banner) {
        String sql = "INSERT INTO [project_SWP391].[dbo].[Banner] " +
                "(admin_id, title, image_url, redirect_url, position, is_active, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, banner.getAdmin_id());
            ps.setString(2, banner.getTitle());
            ps.setString(3, banner.getImage_url());
            ps.setString(4, banner.getRedirect_url());
            ps.setInt(5, banner.getPosition());
            ps.setBoolean(6, banner.isIs_active());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBanner(Banner banner) {
        String sql = "UPDATE [project_SWP391].[dbo].[Banner] SET " +
                "title = ?, image_url = ?, redirect_url = ?, position = ?, is_active = ? " +
                "WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, banner.getTitle());
            ps.setString(2, banner.getImage_url());
            ps.setString(3, banner.getRedirect_url());
            ps.setInt(4, banner.getPosition());
            ps.setBoolean(5, banner.isIs_active());
            ps.setInt(6, banner.getId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBanner(int id) {
        String sql = "DELETE FROM [project_SWP391].[dbo].[Banner] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Banner mapResultSetToBanner(ResultSet rs) throws SQLException {
        return new Banner(
                rs.getInt("id"),
                rs.getInt("admin_id"),
                rs.getString("title"),
                rs.getString("image_url"),
                rs.getString("redirect_url"),
                rs.getInt("position"),
                rs.getBoolean("is_active"),
                rs.getDate("created_at")
        );
    }
}
