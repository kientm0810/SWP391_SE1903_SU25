package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.Award;

public class AwardDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(AwardDAO.class.getName());

    // Get all awards for a job seeker
    public List<Award> getAwardsByJobSeeker(int jobSeekerId) throws SQLException {
        List<Award> awards = new ArrayList<>();
        String sql = "SELECT * FROM Job_Seeker_Awards WHERE job_seeker_id = ? ORDER BY date_received DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Award award = new Award();
                    award.setId(rs.getInt("id"));
                    award.setJobSeekerId(rs.getInt("job_seeker_id"));
                    award.setAwardName(rs.getString("award_name"));
                    award.setIssuingOrganization(rs.getString("issuing_organization"));
                    award.setDateReceived(rs.getDate("date_received"));
                    award.setDescription(rs.getString("description"));
                    award.setImagePath(rs.getString("image_path"));
                    award.setCertificateUrl(rs.getString("certificate_url"));
                    award.setCreatedAt(rs.getTimestamp("created_at"));
                    award.setUpdatedAt(rs.getTimestamp("updated_at"));
                    awards.add(award);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting awards for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return awards;
    }

    // Get award by ID
    public Award getAwardById(int id) throws SQLException {
        String sql = "SELECT * FROM Job_Seeker_Awards WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Award award = new Award();
                    award.setId(rs.getInt("id"));
                    award.setJobSeekerId(rs.getInt("job_seeker_id"));
                    award.setAwardName(rs.getString("award_name"));
                    award.setIssuingOrganization(rs.getString("issuing_organization"));
                    award.setDateReceived(rs.getDate("date_received"));
                    award.setDescription(rs.getString("description"));
                    award.setImagePath(rs.getString("image_path"));
                    award.setCertificateUrl(rs.getString("certificate_url"));
                    award.setCreatedAt(rs.getTimestamp("created_at"));
                    award.setUpdatedAt(rs.getTimestamp("updated_at"));
                    return award;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting award by ID: " + id, e);
            throw e;
        }
        
        return null;
    }

    // Add new award
    public boolean addAward(Award award) throws SQLException {
        String sql = "INSERT INTO Job_Seeker_Awards (job_seeker_id, award_name, issuing_organization, " +
                    "date_received, description, image_path, certificate_url) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, award.getJobSeekerId());
            ps.setString(2, award.getAwardName());
            ps.setString(3, award.getIssuingOrganization());
            ps.setDate(4, award.getDateReceived() != null ? new java.sql.Date(award.getDateReceived().getTime()) : null);
            ps.setString(5, award.getDescription());
            ps.setString(6, award.getImagePath());
            ps.setString(7, award.getCertificateUrl());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding award", e);
            throw e;
        }
    }

    // Update award
    public boolean updateAward(Award award) throws SQLException {
        String sql = "UPDATE Job_Seeker_Awards SET award_name = ?, issuing_organization = ?, " +
                    "date_received = ?, description = ?, image_path = ?, certificate_url = ?, " +
                    "updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, award.getAwardName());
            ps.setString(2, award.getIssuingOrganization());
            ps.setDate(3, award.getDateReceived() != null ? new java.sql.Date(award.getDateReceived().getTime()) : null);
            ps.setString(4, award.getDescription());
            ps.setString(5, award.getImagePath());
            ps.setString(6, award.getCertificateUrl());
            ps.setInt(7, award.getId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating award with ID: " + award.getId(), e);
            throw e;
        }
    }

    // Delete award
    public boolean deleteAward(int id) throws SQLException {
        String sql = "DELETE FROM Job_Seeker_Awards WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting award with ID: " + id, e);
            throw e;
        }
    }

    // Count awards for a job seeker
    public int countAwardsByJobSeeker(int jobSeekerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Job_Seeker_Awards WHERE job_seeker_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting awards for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return 0;
    }
} 