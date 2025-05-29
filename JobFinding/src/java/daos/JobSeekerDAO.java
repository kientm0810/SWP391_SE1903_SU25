/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;

import java.sql.*;
import models.JobSeeker;
import context.DBContext;
import java.util.Vector;

/**
 *
 * @author thaison
 */
public class JobSeekerDAO extends DBContext {

    private String getAll = "SELECT *\n"
            + "  FROM [project_SWP391].[dbo].[Job_Seekers]";

    public JobSeekerDAO() {
    }

    public Vector<JobSeeker> getAllJobSeeker() {
        String sql = getAll;
        Vector<JobSeeker> listJobSeekers = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                JobSeeker p = new JobSeeker(res.getInt(1),
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
                        res.getInt(13),
                        res.getString(14),
                        res.getString(15),
                        res.getDouble(16),
                        res.getString(17),
                        res.getString(18),
                        res.getString(19),
                        res.getString(20),
                        res.getString(21),
                        res.getString(22),
                        res.getString(23),
                        res.getDate(24),
                        res.getDate(25),
                        res.getBoolean(26));

                listJobSeekers.add(p);
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
            private String cvFile;
            private String skills;
            private int experienceYears;
            private String education;
            private String desiredJobTitle;
            private double desiredSalary;
            private String jobCategory;
            private String preferredLocation;
            private String careerLevel;
            private String workType;
            private String profileSummary;
            private String portfolioUrl;
            private String languages;
            private Date createdAt;
            private Date updatedAt;
            private boolean isActive;
         */
        return listJobSeekers;
    }

    public Vector<JobSeeker> getJobSeekerByName(String name) {
        String sql = "SELECT *"
                + "  FROM [project_SWP391].[dbo].[Job_Seekers]"
                + "WHERE [full_name] like N'%" + name + "%'";
        
        Vector<JobSeeker> listJobSeekers = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                JobSeeker p = new JobSeeker(res.getInt(1),
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
                        res.getInt(13),
                        res.getString(14),
                        res.getString(15),
                        res.getDouble(16),
                        res.getString(17),
                        res.getString(18),
                        res.getString(19),
                        res.getString(20),
                        res.getString(21),
                        res.getString(22),
                        res.getString(23),
                        res.getDate(24),
                        res.getDate(25),
                        res.getBoolean(26));

                listJobSeekers.add(p);
            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }
        return listJobSeekers;
    }

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
        String sql = "INSERT INTO Job_Seekers "
                + "(username, password, email, full_name, phone, date_of_birth, gender, address, skills, experience_years, education) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, seeker.getUsername());
            ps.setString(2, seeker.getPassword());
            ps.setString(3, seeker.getEmail());
            ps.setString(4, seeker.getFullName());
            ps.setString(5, seeker.getPhone());
            ps.setDate(6, new java.sql.Date(seeker.getDateOfBirth().getTime()));
            ps.setString(7, seeker.getGender());
            ps.setString(8, seeker.getAddress());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public JobSeeker getJobSeekerByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Job_Seekers WHERE username = ? AND password = ?";
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
                seeker.setFullName(rs.getString("full_name"));
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

    public int insertJobSeeker(JobSeeker p) {
        String sql = "INSERT INTO [dbo].[Job_Seekers]\n"
                + "           ([username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[full_name]\n"
                + "           ,[is_active])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?)";

        int n = 0;

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, p.getUsername());
            ptm.setString(2, p.getPassword());
            ptm.setString(3, p.getEmail());
            ptm.setString(4, p.getFullName());
            ptm.setBoolean(5, p.isActive());
//            ptm.setDate(6, p.getImportDate());
//            ptm.setDate(7, p.getUsingDate());
//            ptm.setInt(8, p.getStatus());
            n = ptm.executeUpdate();
            //System.out.println("vcl " + n);
        } catch (SQLException ex) {
            ex.getStackTrace();
        }

        return n;
    }

    public void changeStatus(int ID, boolean status) {
        String sql = "UPDATE [dbo].[Job_Seekers]\n"
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

    public JobSeeker getSpeccificJobSeeker(int id) {
        String sql = "SELECT *\n"
                + "  FROM [project_SWP391].[dbo].[Job_Seekers]"
                + " WHERE id = ?";

        JobSeeker p = new JobSeeker();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet res = ptm.executeQuery();
            while (res.next()) {
                p = new JobSeeker(res.getInt(1),
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
                        res.getInt(13),
                        res.getString(14),
                        res.getString(15),
                        res.getDouble(16),
                        res.getString(17),
                        res.getString(18),
                        res.getString(19),
                        res.getString(20),
                        res.getString(21),
                        res.getString(22),
                        res.getString(23),
                        res.getDate(24),
                        res.getDate(25),
                        res.getBoolean(26));

            }
        } catch (SQLException ex) {
            //System.out.println(ex);
            ex.getStackTrace();
        }

        return p;
    }
}
