package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.Certificate;

public class CertificateDAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(CertificateDAO.class.getName());

    // Get all certificates for a job seeker
    public List<Certificate> getCertificatesByJobSeeker(int jobSeekerId) throws SQLException {
        List<Certificate> certificates = new ArrayList<>();
        String sql = "SELECT * FROM Job_Seeker_Certificates WHERE job_seeker_id = ? ORDER BY issue_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Certificate certificate = new Certificate();
                    certificate.setId(rs.getInt("id"));
                    certificate.setJobSeekerId(rs.getInt("job_seeker_id"));
                    certificate.setCertificateName(rs.getString("certificate_name"));
                    certificate.setIssuingOrganization(rs.getString("issuing_organization"));
                    certificate.setIssueDate(rs.getDate("issue_date"));
                    certificate.setExpiryDate(rs.getDate("expiry_date"));
                    certificate.setCredentialId(rs.getString("credential_id"));
                    certificate.setCredentialUrl(rs.getString("credential_url"));
                    certificate.setDescription(rs.getString("description"));
                    certificate.setImagePath(rs.getString("image_path"));
                    certificate.setCreatedAt(rs.getTimestamp("created_at"));
                    certificate.setUpdatedAt(rs.getTimestamp("updated_at"));
                    certificates.add(certificate);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting certificates for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return certificates;
    }

    // Get certificate by ID
    public Certificate getCertificateById(int id) throws SQLException {
        String sql = "SELECT * FROM Job_Seeker_Certificates WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Certificate certificate = new Certificate();
                    certificate.setId(rs.getInt("id"));
                    certificate.setJobSeekerId(rs.getInt("job_seeker_id"));
                    certificate.setCertificateName(rs.getString("certificate_name"));
                    certificate.setIssuingOrganization(rs.getString("issuing_organization"));
                    certificate.setIssueDate(rs.getDate("issue_date"));
                    certificate.setExpiryDate(rs.getDate("expiry_date"));
                    certificate.setCredentialId(rs.getString("credential_id"));
                    certificate.setCredentialUrl(rs.getString("credential_url"));
                    certificate.setDescription(rs.getString("description"));
                    certificate.setImagePath(rs.getString("image_path"));
                    certificate.setCreatedAt(rs.getTimestamp("created_at"));
                    certificate.setUpdatedAt(rs.getTimestamp("updated_at"));
                    return certificate;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting certificate by ID: " + id, e);
            throw e;
        }
        
        return null;
    }

    // Add new certificate
    public boolean addCertificate(Certificate certificate) throws SQLException {
        String sql = "INSERT INTO Job_Seeker_Certificates (job_seeker_id, certificate_name, issuing_organization, " +
                    "issue_date, expiry_date, credential_id, credential_url, description, image_path) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, certificate.getJobSeekerId());
            ps.setString(2, certificate.getCertificateName());
            ps.setString(3, certificate.getIssuingOrganization());
            ps.setDate(4, certificate.getIssueDate() != null ? new java.sql.Date(certificate.getIssueDate().getTime()) : null);
            ps.setDate(5, certificate.getExpiryDate() != null ? new java.sql.Date(certificate.getExpiryDate().getTime()) : null);
            ps.setString(6, certificate.getCredentialId());
            ps.setString(7, certificate.getCredentialUrl());
            ps.setString(8, certificate.getDescription());
            ps.setString(9, certificate.getImagePath());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding certificate", e);
            throw e;
        }
    }

    // Update certificate
    public boolean updateCertificate(Certificate certificate) throws SQLException {
        String sql = "UPDATE Job_Seeker_Certificates SET certificate_name = ?, issuing_organization = ?, " +
                    "issue_date = ?, expiry_date = ?, credential_id = ?, credential_url = ?, " +
                    "description = ?, image_path = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, certificate.getCertificateName());
            ps.setString(2, certificate.getIssuingOrganization());
            ps.setDate(3, certificate.getIssueDate() != null ? new java.sql.Date(certificate.getIssueDate().getTime()) : null);
            ps.setDate(4, certificate.getExpiryDate() != null ? new java.sql.Date(certificate.getExpiryDate().getTime()) : null);
            ps.setString(5, certificate.getCredentialId());
            ps.setString(6, certificate.getCredentialUrl());
            ps.setString(7, certificate.getDescription());
            ps.setString(8, certificate.getImagePath());
            ps.setInt(9, certificate.getId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating certificate with ID: " + certificate.getId(), e);
            throw e;
        }
    }

    // Delete certificate
    public boolean deleteCertificate(int id) throws SQLException {
        String sql = "DELETE FROM Job_Seeker_Certificates WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting certificate with ID: " + id, e);
            throw e;
        }
    }

    // Count certificates for a job seeker
    public int countCertificatesByJobSeeker(int jobSeekerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Job_Seeker_Certificates WHERE job_seeker_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting certificates for job seeker: " + jobSeekerId, e);
            throw e;
        }
        
        return 0;
    }
} 