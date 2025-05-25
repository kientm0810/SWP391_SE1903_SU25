/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos.Recruiter;

/**
 *
 * @author thaison
 */
import context.DBContext;
import java.sql.*;
import models.Recruiter;
import context.DBContext;

public class RecruiterDAO extends DBContext{

   public boolean isUsernameTaken(String username) {
        String sql = "SELECT username FROM Recruiter WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean register(Recruiter recruiter) {
        String sql = "INSERT INTO Recruiter " +
                "(username, password, email, full_name, phone, date_of_birth, gender, address, company_name, company_description, logo, website, company_address, company_size, industry) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, recruiter.getUsername());
            ps.setString(2, recruiter.getPassword());
            ps.setString(3, recruiter.getEmail());
            ps.setString(4, recruiter.getFull_name());
            ps.setString(5, recruiter.getPhone());
            ps.setDate(6, new java.sql.Date(recruiter.getDate_of_birth().getTime()));
            ps.setString(7, recruiter.getGender());
            ps.setString(8, recruiter.getAddress());
          

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Recruiter getRecruiterByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Recruiter WHERE username = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Recruiter r = new Recruiter();
                r.setId(rs.getInt("id"));
                r.setUsername(rs.getString("username"));
                r.setPassword(rs.getString("password"));
                r.setEmail(rs.getString("email"));
                r.setFull_name((String)rs.getString("full_name"));
                // Gán thêm các trường khác nếu cần
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(int recruiterId, String newPassword) {
        String sql = "UPDATE Recruiter SET password = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, recruiterId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
