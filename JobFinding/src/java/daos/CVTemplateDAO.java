package daos;

import context.DBContext;
import models.CVTemplate;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class CVTemplateDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(CVTemplateDAO.class.getName());

    private void checkConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            throw new SQLException("Database connection is null or closed");
        }
    }

    public boolean createCV(CVTemplate cv) throws SQLException {
        checkConnection();
        String sql = "INSERT INTO cv_templates (job_seeker_id, full_name, job_position, phone, email, address, " +
                     "certificates, work_experience, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cv.getJobSeekerId());
            ps.setString(2, cv.getFullName());
            ps.setString(3, cv.getJobPosition());
            ps.setString(4, cv.getPhone());
            ps.setString(5, cv.getEmail());
            ps.setString(6, cv.getAddress());
            ps.setString(7, cv.getCertificates());
            ps.setString(8, cv.getWorkExperience());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating CV for jobSeekerId: " + cv.getJobSeekerId(), e);
            throw e;
        }
    }

    public List<CVTemplate> getCVsByJobSeeker(int jobSeekerId) throws SQLException {
        return getCVsByJobSeeker(jobSeekerId, null);
    }

    public List<CVTemplate> getCVsByJobSeeker(int jobSeekerId, String searchTerm) throws SQLException {
        checkConnection();
        List<CVTemplate> cvs = new ArrayList<>();
        String sql = "SELECT * FROM cv_templates WHERE job_seeker_id = ?";
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += " AND (full_name LIKE ? OR job_position LIKE ?)";
        }
        sql += " ORDER BY updated_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                String likeTerm = "%" + searchTerm.trim() + "%";
                ps.setString(2, likeTerm);
                ps.setString(3, likeTerm);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CVTemplate cv = new CVTemplate(
                    rs.getInt("id"),
                    rs.getInt("job_seeker_id"),
                    rs.getString("full_name"),
                    rs.getString("job_position"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getString("certificates"),
                    rs.getString("work_experience"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
                cvs.add(cv);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching CVs for jobSeekerId: " + jobSeekerId, e);
            throw e;
        }
        return cvs;
    }

    public CVTemplate getCVById(int cvId, int jobSeekerId) throws SQLException {
        checkConnection();
        String sql = "SELECT * FROM cv_templates WHERE id = ? AND job_seeker_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, jobSeekerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CVTemplate(
                    rs.getInt("id"),
                    rs.getInt("job_seeker_id"),
                    rs.getString("full_name"),
                    rs.getString("job_position"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getString("certificates"),
                    rs.getString("work_experience"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching CV with id: " + cvId, e);
            throw e;
        }
        return null;
    }

    public boolean updateCV(CVTemplate cv) throws SQLException {
        checkConnection();
        String sql = "UPDATE cv_templates SET full_name = ?, job_position = ?, phone = ?, email = ?, " +
                     "address = ?, certificates = ?, work_experience = ?, updated_at = GETDATE() " +
                     "WHERE id = ? AND job_seeker_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, cv.getFullName());
            ps.setString(2, cv.getJobPosition());
            ps.setString(3, cv.getPhone());
            ps.setString(4, cv.getEmail());
            ps.setString(5, cv.getAddress());
            ps.setString(6, cv.getCertificates());
            ps.setString(7, cv.getWorkExperience());
            ps.setInt(8, cv.getId());
            ps.setInt(9, cv.getJobSeekerId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating CV with id: " + cv.getId(), e);
            throw e;
        }
    }

    public boolean deleteCV(int cvId, int jobSeekerId) throws SQLException {
        checkConnection();
        String sql = "DELETE FROM cv_templates WHERE id = ? AND job_seeker_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, jobSeekerId);
            int rowsAffected = ps.executeUpdate();
            LOGGER.log(Level.INFO, "CV deleted: cvId={0}, jobSeekerId={1}, rowsAffected={2}", 
                      new Object[]{cvId, jobSeekerId, rowsAffected});
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting CV with id: " + cvId, e);
            throw e;
        }
    }
}
