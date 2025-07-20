package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.Education;

public class EducationDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(EducationDAO.class.getName());

    // Get all education records for a job seeker
    public List<Education> getEducationsByJobSeeker(int jobSeekerId) throws SQLException {
        List<Education> educations = new ArrayList<>();
        String sql = "SELECT * FROM Job_Seeker_Educations WHERE job_seeker_id = ? ORDER BY start_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Education education = new Education();
                    education.setId(rs.getInt("id"));
                    education.setJobSeekerId(rs.getInt("job_seeker_id"));
                    education.setDegree(rs.getString("degree"));
                    education.setFieldOfStudy(rs.getString("field_of_study"));
                    education.setInstitutionName(rs.getString("institution_name"));
                    education.setLocation(rs.getString("location"));
                    education.setStartDate(rs.getDate("start_date"));
                    education.setEndDate(rs.getDate("end_date"));
                    education.setCurrent(rs.getBoolean("is_current"));
                    education.setGpa(rs.getBigDecimal("gpa"));
                    education.setGrade(rs.getString("grade"));
                    education.setActivities(rs.getString("activities"));
                    education.setDescription(rs.getString("description"));
                    education.setCreatedAt(rs.getTimestamp("created_at"));
                    education.setUpdatedAt(rs.getTimestamp("updated_at"));
                    educations.add(education);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting education records for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return educations;
    }

    // Get education by ID
    public Education getEducationById(int id) throws SQLException {
        String sql = "SELECT * FROM Job_Seeker_Educations WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Education education = new Education();
                    education.setId(rs.getInt("id"));
                    education.setJobSeekerId(rs.getInt("job_seeker_id"));
                    education.setDegree(rs.getString("degree"));
                    education.setFieldOfStudy(rs.getString("field_of_study"));
                    education.setInstitutionName(rs.getString("institution_name"));
                    education.setLocation(rs.getString("location"));
                    education.setStartDate(rs.getDate("start_date"));
                    education.setEndDate(rs.getDate("end_date"));
                    education.setCurrent(rs.getBoolean("is_current"));
                    education.setGpa(rs.getBigDecimal("gpa"));
                    education.setGrade(rs.getString("grade"));
                    education.setActivities(rs.getString("activities"));
                    education.setDescription(rs.getString("description"));
                    education.setCreatedAt(rs.getTimestamp("created_at"));
                    education.setUpdatedAt(rs.getTimestamp("updated_at"));
                    return education;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting education by ID: " + id, e);
            throw e;
        }
        
        return null;
    }

    // Add new education
    public boolean addEducation(Education education) throws SQLException {
        String sql = "INSERT INTO Job_Seeker_Educations (job_seeker_id, degree, field_of_study, institution_name, " +
                    "location, start_date, end_date, is_current, gpa, grade, activities, description) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, education.getJobSeekerId());
            ps.setString(2, education.getDegree());
            ps.setString(3, education.getFieldOfStudy());
            ps.setString(4, education.getInstitutionName());
            ps.setString(5, education.getLocation());
            ps.setDate(6, education.getStartDate() != null ? new java.sql.Date(education.getStartDate().getTime()) : null);
            ps.setDate(7, education.getEndDate() != null ? new java.sql.Date(education.getEndDate().getTime()) : null);
            ps.setBoolean(8, education.isCurrent());
            ps.setBigDecimal(9, education.getGpa());
            ps.setString(10, education.getGrade());
            ps.setString(11, education.getActivities());
            ps.setString(12, education.getDescription());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding education", e);
            throw e;
        }
    }

    // Update education
    public boolean updateEducation(Education education) throws SQLException {
        String sql = "UPDATE Job_Seeker_Educations SET degree = ?, field_of_study = ?, institution_name = ?, " +
                    "location = ?, start_date = ?, end_date = ?, is_current = ?, gpa = ?, grade = ?, " +
                    "activities = ?, description = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, education.getDegree());
            ps.setString(2, education.getFieldOfStudy());
            ps.setString(3, education.getInstitutionName());
            ps.setString(4, education.getLocation());
            ps.setDate(5, education.getStartDate() != null ? new java.sql.Date(education.getStartDate().getTime()) : null);
            ps.setDate(6, education.getEndDate() != null ? new java.sql.Date(education.getEndDate().getTime()) : null);
            ps.setBoolean(7, education.isCurrent());
            ps.setBigDecimal(8, education.getGpa());
            ps.setString(9, education.getGrade());
            ps.setString(10, education.getActivities());
            ps.setString(11, education.getDescription());
            ps.setInt(12, education.getId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating education with ID: " + education.getId(), e);
            throw e;
        }
    }

    // Delete education
    public boolean deleteEducation(int id) throws SQLException {
        String sql = "DELETE FROM Job_Seeker_Educations WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting education with ID: " + id, e);
            throw e;
        }
    }

    // Count education records for a job seeker
    public int countEducationsByJobSeeker(int jobSeekerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Job_Seeker_Educations WHERE job_seeker_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting education records for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return 0;
    }
} 