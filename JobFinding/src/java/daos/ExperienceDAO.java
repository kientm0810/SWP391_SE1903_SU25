package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.Experience;

public class ExperienceDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(ExperienceDAO.class.getName());

    // Get all experiences for a job seeker
    public List<Experience> getExperiencesByJobSeeker(int jobSeekerId) throws SQLException {
        List<Experience> experiences = new ArrayList<>();
        String sql = "SELECT * FROM Job_Seeker_Experiences WHERE job_seeker_id = ? ORDER BY start_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Experience experience = new Experience();
                    experience.setId(rs.getInt("id"));
                    experience.setJobSeekerId(rs.getInt("job_seeker_id"));
                    experience.setPosition(rs.getString("position"));
                    experience.setCompanyName(rs.getString("company_name"));
                    experience.setCompanyLogo(rs.getString("company_logo"));
                    experience.setLocation(rs.getString("location"));
                    experience.setStartDate(rs.getDate("start_date"));
                    experience.setEndDate(rs.getDate("end_date"));
                    experience.setCurrent(rs.getBoolean("is_current"));
                    experience.setDescription(rs.getString("description"));
                    experience.setAchievements(rs.getString("achievements"));
                    experience.setSkillsUsed(rs.getString("skills_used"));
                    experience.setCreatedAt(rs.getTimestamp("created_at"));
                    experience.setUpdatedAt(rs.getTimestamp("updated_at"));
                    experiences.add(experience);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting experiences for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return experiences;
    }

    // Get experience by ID
    public Experience getExperienceById(int id) throws SQLException {
        String sql = "SELECT * FROM Job_Seeker_Experiences WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Experience experience = new Experience();
                    experience.setId(rs.getInt("id"));
                    experience.setJobSeekerId(rs.getInt("job_seeker_id"));
                    experience.setPosition(rs.getString("position"));
                    experience.setCompanyName(rs.getString("company_name"));
                    experience.setCompanyLogo(rs.getString("company_logo"));
                    experience.setLocation(rs.getString("location"));
                    experience.setStartDate(rs.getDate("start_date"));
                    experience.setEndDate(rs.getDate("end_date"));
                    experience.setCurrent(rs.getBoolean("is_current"));
                    experience.setDescription(rs.getString("description"));
                    experience.setAchievements(rs.getString("achievements"));
                    experience.setSkillsUsed(rs.getString("skills_used"));
                    experience.setCreatedAt(rs.getTimestamp("created_at"));
                    experience.setUpdatedAt(rs.getTimestamp("updated_at"));
                    return experience;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting experience by ID: " + id, e);
            throw e;
        }
        
        return null;
    }

    // Add new experience
    public boolean addExperience(Experience experience) throws SQLException {
        String sql = "INSERT INTO Job_Seeker_Experiences (job_seeker_id, position, company_name, company_logo, " +
                    "location, start_date, end_date, is_current, description, achievements, skills_used) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, experience.getJobSeekerId());
            ps.setString(2, experience.getPosition());
            ps.setString(3, experience.getCompanyName());
            ps.setString(4, experience.getCompanyLogo());
            ps.setString(5, experience.getLocation());
            ps.setDate(6, experience.getStartDate() != null ? new java.sql.Date(experience.getStartDate().getTime()) : null);
            ps.setDate(7, experience.getEndDate() != null ? new java.sql.Date(experience.getEndDate().getTime()) : null);
            ps.setBoolean(8, experience.isCurrent());
            ps.setString(9, experience.getDescription());
            ps.setString(10, experience.getAchievements());
            ps.setString(11, experience.getSkillsUsed());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding experience", e);
            throw e;
        }
    }

    // Update experience
    public boolean updateExperience(Experience experience) throws SQLException {
        String sql = "UPDATE Job_Seeker_Experiences SET position = ?, company_name = ?, company_logo = ?, " +
                    "location = ?, start_date = ?, end_date = ?, is_current = ?, description = ?, " +
                    "achievements = ?, skills_used = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, experience.getPosition());
            ps.setString(2, experience.getCompanyName());
            ps.setString(3, experience.getCompanyLogo());
            ps.setString(4, experience.getLocation());
            ps.setDate(5, experience.getStartDate() != null ? new java.sql.Date(experience.getStartDate().getTime()) : null);
            ps.setDate(6, experience.getEndDate() != null ? new java.sql.Date(experience.getEndDate().getTime()) : null);
            ps.setBoolean(7, experience.isCurrent());
            ps.setString(8, experience.getDescription());
            ps.setString(9, experience.getAchievements());
            ps.setString(10, experience.getSkillsUsed());
            ps.setInt(11, experience.getId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating experience with ID: " + experience.getId(), e);
            throw e;
        }
    }

    // Delete experience
    public boolean deleteExperience(int id) throws SQLException {
        String sql = "DELETE FROM Job_Seeker_Experiences WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting experience with ID: " + id, e);
            throw e;
        }
    }

    // Count experiences for a job seeker
    public int countExperiencesByJobSeeker(int jobSeekerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Job_Seeker_Experiences WHERE job_seeker_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting experiences for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return 0;
    }
} 