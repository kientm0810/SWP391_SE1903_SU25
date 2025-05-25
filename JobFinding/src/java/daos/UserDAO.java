package daos;

import context.DBContext;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import models.Admin;
import models.JobSeeker;
import models.Recruiter;


public class UserDAO extends DBContext {
    
    
    public boolean isUsernameTaken(String username) {
        String sql = "SELECT username FROM Admin WHERE username = ? " +
                      "UNION SELECT username FROM Recruiter WHERE username = ? " +
                      "UNION SELECT username FROM Job_Seekers WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Admin loginAdmin(String username, String password) {
        String sql = "SELECT * FROM Admin WHERE username = ? AND password = ? AND is_active = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                admin.setEmail(rs.getString("email"));
                admin.setFullName(rs.getString("full_name"));
                admin.setPhone(rs.getString("phone"));
                admin.setDateOfBirth(rs.getDate("date_of_birth"));
                admin.setGender(rs.getString("gender"));
                admin.setAddress(rs.getString("address"));
                admin.setProfilePicture(rs.getString("profile_picture"));
                admin.setCreatedAt(rs.getTimestamp("created_at"));
                admin.setUpdatedAt(rs.getTimestamp("updated_at"));
                admin.setActive(rs.getBoolean("is_active"));
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Recruiter loginRecruiter(String username, String password) {
        String sql = "SELECT * FROM Recruiter WHERE username = ? AND password = ? AND is_active = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setId(rs.getInt("id"));
                recruiter.setUsername(rs.getString("username"));
                recruiter.setPassword(rs.getString("password"));
                recruiter.setEmail(rs.getString("email"));
                recruiter.setFullName(rs.getString("full_name"));
                recruiter.setPhone(rs.getString("phone"));
                recruiter.setDateOfBirth(rs.getDate("date_of_birth"));
                recruiter.setGender(rs.getString("gender"));
                recruiter.setAddress(rs.getString("address"));
                recruiter.setProfilePicture(rs.getString("profile_picture"));
                recruiter.setCompanyName(rs.getString("company_name"));
                recruiter.setCompanyDescription(rs.getString("company_description"));
                recruiter.setLogo(rs.getString("logo"));
                recruiter.setWebsite(rs.getString("website"));
                recruiter.setCompanyAddress(rs.getString("company_address"));
                recruiter.setCompanySize(rs.getString("company_size"));
                recruiter.setIndustry(rs.getString("industry"));
                recruiter.setTaxCode(rs.getString("tax_code"));
                recruiter.setLoyaltyScore(rs.getDouble("loyalty_score"));
                recruiter.setVerificationStatus(rs.getString("verification_status"));
                recruiter.setCreatedAt(rs.getTimestamp("created_at"));
                recruiter.setUpdatedAt(rs.getTimestamp("updated_at"));
                recruiter.setActive(rs.getBoolean("is_active"));
                return recruiter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public JobSeeker loginJobSeeker(String username, String password) {
        String sql = "SELECT * FROM Job_Seekers WHERE username = ? AND password = ? AND is_active = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                JobSeeker jobSeeker = new JobSeeker();
                jobSeeker.setId(rs.getInt("id"));
                jobSeeker.setUsername(rs.getString("username"));
                jobSeeker.setPassword(rs.getString("password"));
                jobSeeker.setEmail(rs.getString("email"));
                jobSeeker.setFullName(rs.getString("full_name"));
                jobSeeker.setPhone(rs.getString("phone"));
                jobSeeker.setDateOfBirth(rs.getDate("date_of_birth"));
                jobSeeker.setGender(rs.getString("gender"));
                jobSeeker.setAddress(rs.getString("address"));
                jobSeeker.setProfilePicture(rs.getString("profile_picture"));
                jobSeeker.setCvFile(rs.getString("cv_file"));
                jobSeeker.setSkills(rs.getString("skills"));
                jobSeeker.setExperienceYears(rs.getInt("experience_years"));
                jobSeeker.setEducation(rs.getString("education"));
                jobSeeker.setDesiredJobTitle(rs.getString("desired_job_title"));
                jobSeeker.setDesiredSalary(rs.getDouble("desired_salary"));
                jobSeeker.setJobCategory(rs.getString("job_category"));
                jobSeeker.setPreferredLocation(rs.getString("preferred_location"));
                jobSeeker.setCareerLevel(rs.getString("career_level"));
                jobSeeker.setWorkType(rs.getString("work_type"));
                jobSeeker.setProfileSummary(rs.getString("profile_summary"));
                jobSeeker.setPortfolioUrl(rs.getString("portfolio_url"));
                jobSeeker.setLanguages(rs.getString("languages"));
                jobSeeker.setCreatedAt(rs.getTimestamp("created_at"));
                jobSeeker.setUpdatedAt(rs.getTimestamp("updated_at"));
                jobSeeker.setActive(rs.getBoolean("is_active"));
                return jobSeeker;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean registerJobSeeker(JobSeeker jobSeeker) {
        String sql = "INSERT INTO Job_Seekers (username, password, email, full_name, phone, date_of_birth, gender, address, " +
                     "profile_picture, cv_file, skills, experience_years, education, desired_job_title, desired_salary, " +
                     "job_category, preferred_location, career_level, work_type, profile_summary, portfolio_url, languages, " +
                     "created_at, updated_at, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE(), 1)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, jobSeeker.getUsername());
            ps.setString(2, jobSeeker.getPassword());
            ps.setString(3, jobSeeker.getEmail());
            ps.setString(4, jobSeeker.getFullName());
            ps.setString(5, jobSeeker.getPhone());
            ps.setDate(6, new java.sql.Date(jobSeeker.getDateOfBirth().getTime()));
            ps.setString(7, jobSeeker.getGender());
            ps.setString(8, jobSeeker.getAddress());
            ps.setString(9, jobSeeker.getProfilePicture());
            ps.setString(10, jobSeeker.getCvFile());
            ps.setString(11, jobSeeker.getSkills());
            ps.setInt(12, jobSeeker.getExperienceYears());
            ps.setString(13, jobSeeker.getEducation());
            ps.setString(14, jobSeeker.getDesiredJobTitle());
            ps.setDouble(15, jobSeeker.getDesiredSalary());
            ps.setString(16, jobSeeker.getJobCategory());
            ps.setString(17, jobSeeker.getPreferredLocation());
            ps.setString(18, jobSeeker.getCareerLevel());
            ps.setString(19, jobSeeker.getWorkType());
            ps.setString(20, jobSeeker.getProfileSummary());
            ps.setString(21, jobSeeker.getPortfolioUrl());
            ps.setString(22, jobSeeker.getLanguages());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerRecruiter(Recruiter recruiter) {
        String sql = "INSERT INTO Recruiter (username, password, email, full_name, phone, date_of_birth, gender, address, " +
                     "profile_picture, company_name, company_description, logo, website, company_address, company_size, " +
                     "industry, tax_code, verification_status, created_at, updated_at, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', GETDATE(), GETDATE(), 1)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, recruiter.getUsername());
            ps.setString(2, recruiter.getPassword());
            ps.setString(3, recruiter.getEmail());
            ps.setString(4, recruiter.getFullName());
            ps.setString(5, recruiter.getPhone());
            ps.setDate(6, new java.sql.Date(recruiter.getDateOfBirth().getTime()));
            ps.setString(7, recruiter.getGender());
            ps.setString(8, recruiter.getAddress());
            ps.setString(9, recruiter.getProfilePicture());
            ps.setString(10, recruiter.getCompanyName());
            ps.setString(11, recruiter.getCompanyDescription());
            ps.setString(12, recruiter.getLogo());
            ps.setString(13, recruiter.getWebsite());
            ps.setString(14, recruiter.getCompanyAddress());
            ps.setString(15, recruiter.getCompanySize());
            ps.setString(16, recruiter.getIndustry());
            ps.setString(17, recruiter.getTaxCode());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Map<String, String> getUserByEmail(String email) {
        String query = "SELECT id, username, email, 'admin' as role FROM Admin WHERE email = ? " +
                       "UNION SELECT id, username, email, 'recruiter' as role FROM Recruiter WHERE email = ? " +
                       "UNION SELECT id, username, email, 'job_seeker' as role FROM Job_Seekers WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, email);
            ps.setString(3, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, String> userInfo = new HashMap<>();
                userInfo.put("id", String.valueOf(rs.getInt("id")));
                userInfo.put("username", rs.getString("username"));
                userInfo.put("email", rs.getString("email")); 
                userInfo.put("role", rs.getString("role"));
                return userInfo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Object[] getUserInfoByEmail(String email) {
        String query = "SELECT id, 'admin' as user_type, is_active FROM Admin WHERE email = ? " +
                      "UNION SELECT id, 'recruiter' as user_type, is_active FROM Recruiter WHERE email = ? " +
                      "UNION SELECT id, 'job_seeker' as user_type, is_active FROM Job_Seekers WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, email);
            ps.setString(3, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Object[] userInfo = new Object[3];
                userInfo[0] = rs.getInt("id");
                userInfo[1] = rs.getString("user_type");
                userInfo[2] = rs.getBoolean("is_active");
                return userInfo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePassword(int userId, String newPassword) {
        // First, determine the user type
        String query = "SELECT 'admin' as user_type FROM Admin WHERE id = ? " +
                      "UNION SELECT 'recruiter' as user_type FROM Recruiter WHERE id = ? " +
                      "UNION SELECT 'job_seeker' as user_type FROM Job_Seekers WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setInt(3, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String userType = rs.getString("user_type");
                String tableName;
                switch (userType) {
                    case "admin":
                        tableName = "Admin";
                        break;
                    case "recruiter":
                        tableName = "Recruiter";
                        break;
                    case "job_seeker":
                        tableName = "Job_Seekers";
                        break;
                    default:
                        return false;
                }
                
                // Update the password
                String updateQuery = "UPDATE " + tableName + " SET password = ?, updated_at = GETDATE() WHERE id = ?";
                try (PreparedStatement updatePs = connection.prepareStatement(updateQuery)) {
                    updatePs.setString(1, newPassword);
                    updatePs.setInt(2, userId);
                    return updatePs.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Admin getAdminDetails(int adminId) {
        String sql = "SELECT * FROM Admin WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, adminId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                admin.setEmail(rs.getString("email"));
                admin.setFullName(rs.getString("full_name"));
                admin.setPhone(rs.getString("phone"));
                admin.setDateOfBirth(rs.getDate("date_of_birth"));
                admin.setGender(rs.getString("gender"));
                admin.setAddress(rs.getString("address"));
                admin.setProfilePicture(rs.getString("profile_picture"));
                admin.setCreatedAt(rs.getTimestamp("created_at"));
                admin.setUpdatedAt(rs.getTimestamp("updated_at"));
                admin.setActive(rs.getBoolean("is_active"));
                
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Recruiter getRecruiterDetails(int recruiterId) {
        String sql = "SELECT * FROM Recruiter WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, recruiterId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setId(rs.getInt("id"));
                recruiter.setUsername(rs.getString("username"));
                recruiter.setPassword(rs.getString("password"));
                recruiter.setEmail(rs.getString("email"));
                recruiter.setFullName(rs.getString("full_name"));
                recruiter.setPhone(rs.getString("phone"));
                recruiter.setDateOfBirth(rs.getDate("date_of_birth"));
                recruiter.setGender(rs.getString("gender"));
                recruiter.setAddress(rs.getString("address"));
                recruiter.setProfilePicture(rs.getString("profile_picture"));
                recruiter.setCompanyName(rs.getString("company_name"));
                recruiter.setCompanyDescription(rs.getString("company_description"));
                recruiter.setLogo(rs.getString("logo"));
                recruiter.setWebsite(rs.getString("website"));
                recruiter.setCompanyAddress(rs.getString("company_address"));
                recruiter.setCompanySize(rs.getString("company_size"));
                recruiter.setIndustry(rs.getString("industry"));
                recruiter.setTaxCode(rs.getString("tax_code"));
                recruiter.setLoyaltyScore(rs.getDouble("loyalty_score"));
                recruiter.setVerificationStatus(rs.getString("verification_status"));
                recruiter.setCreatedAt(rs.getTimestamp("created_at"));
                recruiter.setUpdatedAt(rs.getTimestamp("updated_at"));
                recruiter.setActive(rs.getBoolean("is_active"));
                
                return recruiter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public JobSeeker getJobSeekerDetails(int jobSeekerId) {
        String sql = "SELECT * FROM Job_Seekers WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobSeekerId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                JobSeeker jobSeeker = new JobSeeker();
                jobSeeker.setId(rs.getInt("id"));
                jobSeeker.setUsername(rs.getString("username"));
                jobSeeker.setPassword(rs.getString("password"));
                jobSeeker.setEmail(rs.getString("email"));
                jobSeeker.setFullName(rs.getString("full_name"));
                jobSeeker.setPhone(rs.getString("phone"));
                jobSeeker.setDateOfBirth(rs.getDate("date_of_birth"));
                jobSeeker.setGender(rs.getString("gender"));
                jobSeeker.setAddress(rs.getString("address"));
                jobSeeker.setProfilePicture(rs.getString("profile_picture"));
                jobSeeker.setCvFile(rs.getString("cv_file"));
                jobSeeker.setSkills(rs.getString("skills"));
                jobSeeker.setExperienceYears(rs.getInt("experience_years"));
                jobSeeker.setEducation(rs.getString("education"));
                jobSeeker.setDesiredJobTitle(rs.getString("desired_job_title"));
                jobSeeker.setDesiredSalary(rs.getDouble("desired_salary"));
                jobSeeker.setJobCategory(rs.getString("job_category"));
                jobSeeker.setPreferredLocation(rs.getString("preferred_location"));
                jobSeeker.setCareerLevel(rs.getString("career_level"));
                jobSeeker.setWorkType(rs.getString("work_type"));
                jobSeeker.setProfileSummary(rs.getString("profile_summary"));
                jobSeeker.setPortfolioUrl(rs.getString("portfolio_url"));
                jobSeeker.setLanguages(rs.getString("languages"));
                jobSeeker.setCreatedAt(rs.getTimestamp("created_at"));
                jobSeeker.setUpdatedAt(rs.getTimestamp("updated_at"));
                jobSeeker.setActive(rs.getBoolean("is_active"));
                
                return jobSeeker;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


   
}