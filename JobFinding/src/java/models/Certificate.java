package models;

import java.util.Date;

public class Certificate {
    private int id;
    private int jobSeekerId;
    private String certificateName;
    private String issuingOrganization;
    private Date issueDate;
    private Date expiryDate;
    private String credentialId;
    private String credentialUrl;
    private String description;
    private String imagePath;
    private Date createdAt;
    private Date updatedAt;

    // Default constructor
    public Certificate() {
    }

    // Constructor with all fields
    public Certificate(int id, int jobSeekerId, String certificateName, String issuingOrganization,
                      Date issueDate, Date expiryDate, String credentialId, String credentialUrl,
                      String description, String imagePath, Date createdAt, Date updatedAt) {
        this.id = id;
        this.jobSeekerId = jobSeekerId;
        this.certificateName = certificateName;
        this.issuingOrganization = issuingOrganization;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
        this.credentialId = credentialId;
        this.credentialUrl = credentialUrl;
        this.description = description;
        this.imagePath = imagePath;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Constructor without id (for creating new certificates)
    public Certificate(int jobSeekerId, String certificateName, String issuingOrganization,
                      Date issueDate, Date expiryDate, String credentialId, String credentialUrl,
                      String description, String imagePath) {
        this.jobSeekerId = jobSeekerId;
        this.certificateName = certificateName;
        this.issuingOrganization = issuingOrganization;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
        this.credentialId = credentialId;
        this.credentialUrl = credentialUrl;
        this.description = description;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getJobSeekerId() {
        return jobSeekerId;
    }

    public void setJobSeekerId(int jobSeekerId) {
        this.jobSeekerId = jobSeekerId;
    }

    public String getCertificateName() {
        return certificateName;
    }

    public void setCertificateName(String certificateName) {
        this.certificateName = certificateName;
    }

    public String getIssuingOrganization() {
        return issuingOrganization;
    }

    public void setIssuingOrganization(String issuingOrganization) {
        this.issuingOrganization = issuingOrganization;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCredentialId() {
        return credentialId;
    }

    public void setCredentialId(String credentialId) {
        this.credentialId = credentialId;
    }

    public String getCredentialUrl() {
        return credentialUrl;
    }

    public void setCredentialUrl(String credentialUrl) {
        this.credentialUrl = credentialUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Certificate{" +
                "id=" + id +
                ", jobSeekerId=" + jobSeekerId +
                ", certificateName='" + certificateName + '\'' +
                ", issuingOrganization='" + issuingOrganization + '\'' +
                ", issueDate=" + issueDate +
                ", expiryDate=" + expiryDate +
                ", credentialId='" + credentialId + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
} 