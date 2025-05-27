/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

/**
 *
 * @author thaison
 */
import context.DBContext;
import java.sql.*;
import models.Recruiter;
import context.DBContext;
import java.util.Vector;

public class RecruiterDAO extends DBContext {

    private String getAll = "SELECT *"
            + "  FROM [project_SWP391].[dbo].[Recruiter]";

    public Vector<Recruiter> getAllRecruiter() {
        String sql = getAll;
        Vector<Recruiter> listRecruiters = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                Recruiter p = new Recruiter(res.getInt(1),
                        res.getString(2),
                        res.getString(3),
                        res.getString(4),
                        res.getString(5),
                        res.getString(6),
                        res.getDate(7),
                        res.getString(8),
                        res.getString(9),
                        res.getString(10),
                        res.getString(11),
                        res.getString(12),
                        res.getString(13),
                        res.getString(14),
                        res.getString(15),
                        res.getString(16),
                        res.getString(17),
                        res.getString(18),
                        res.getDouble(19),
                        res.getString(20),
                        res.getDate(21),
                        res.getDate(22),
                        res.getBoolean(23));

                listRecruiters.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }

        /*
            private int id;
            private String username;
            private String password;
            private String email;
            private String fullName;
            private String phone;
            private Date dateOfBirth;
            private String gender;
            private String address;
            private String profilePicture;
            private String companyName;
            private String companyDescription;
            private String logo;
            private String website;
            private String companyAddress;
            private String companySize;
            private String industry;
            private String taxCode;
            private double loyaltyScore;
            private String verificationStatus;
            private Date createdAt;
            private Date updatedAt;
            private boolean isActive;
         */
        return listRecruiters;
    }

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
        String sql = "INSERT INTO Recruiter "
                + "(username, password, email, full_name, phone, date_of_birth, gender, address, company_name, company_description, logo, website, company_address, company_size, industry) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, recruiter.getUsername());
            ps.setString(2, recruiter.getPassword());
            ps.setString(3, recruiter.getEmail());
            ps.setString(4, recruiter.getFullName());
            ps.setString(5, recruiter.getPhone());
            ps.setDate(6, new java.sql.Date(recruiter.getDateOfBirth().getTime()));
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
                r.setFullName(rs.getString("full_name"));
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
    
    public void changeStatus(int ID, boolean status) {
        String sql = "UPDATE [dbo].[Recruiter]\n"
                + "   SET [is_active] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setBoolean(1, status == true ? false : true);
            ptm.setInt(2, ID);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
    }
    
    public Recruiter getSpeccificRecruiter(int id){
        String sql = "SELECT *\n"
            + "  FROM [project_SWP391].[dbo].[Recruiter]"
            + " WHERE id = ?";
        
        Recruiter p = new Recruiter();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                p = new Recruiter(res.getInt(1),
                        res.getString(2),
                        res.getString(3),
                        res.getString(4),
                        res.getString(5),
                        res.getString(6),
                        res.getDate(7),
                        res.getString(8),
                        res.getString(9),
                        res.getString(10),
                        res.getString(11),
                        res.getString(12),
                        res.getString(13),
                        res.getString(14),
                        res.getString(15),
                        res.getString(16),
                        res.getString(17),
                        res.getString(18),
                        res.getDouble(19),
                        res.getString(20),
                        res.getDate(21),
                        res.getDate(22),
                        res.getBoolean(23));

            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        
        return p;
    }
}
