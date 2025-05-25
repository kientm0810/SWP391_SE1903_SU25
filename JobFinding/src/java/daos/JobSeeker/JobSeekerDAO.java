/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos.JobSeeker;

import context.DBContext;

import java.sql.*;
import models.JobSeeker;
import context.DBContext;

/**
 *
 * @author thaison
 */
public class JobSeekerDAO extends DBContext {

    public boolean isUsernameTaken(String username) {
        String sql = "INSERT INTO JobSeeker "
                + "(username, password, email, full_name, phone, date_of_birth, gender, address, resume, skills, experience, education_level) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    public boolean register(JobSeeker seeker) {
        String sql = "INSERT INTO JobSeeker "
                + "(username, password, email, full_name, phone, date_of_birth, gender, address, resume, skills, experience, education_level) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, seeker.getUsername());
            ps.setString(2, seeker.getPassword());
            ps.setString(3, seeker.getEmail());
            ps.setString(4, seeker.getFull_name());
            ps.setString(5, seeker.getPhone());
            ps.setDate(6, new java.sql.Date(seeker.getDate_of_birth().getTime()));
            ps.setString(7, seeker.getGender());
            ps.setString(8, seeker.getAddress());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public JobSeeker getJobSeekerByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM JobSeeker WHERE username = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                JobSeeker seeker = new JobSeeker();
                seeker.setId(rs.getInt("id"));
                seeker.setUsername(rs.getString("username"));
                seeker.setPassword(rs.getString("password"));
                seeker.setEmail(rs.getString("email"));
                seeker.setFull_name(rs.getString("full_name"));
                // Bạn có thể gán thêm các trường khác nếu cần
                return seeker;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(int seekerId, String newPassword) {
        String sql = "UPDATE JobSeeker SET password = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, seekerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
