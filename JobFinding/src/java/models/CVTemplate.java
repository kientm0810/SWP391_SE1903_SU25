/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;
import java.sql.Timestamp;
/**
 *
 * @author PC
 */
public class CVTemplate {
    private int id;
    private int jobSeekerId;
    private String fullName;
    private String jobPosition;
    private String phone;
    private String email;
    private String address;
    private String certificates;
    private String workExperience;
    private String pdfFilePath;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public CVTemplate() {}

    public CVTemplate(int id, int jobSeekerId, String fullName, String jobPosition, String phone, String email,
                      String address, String certificates, String workExperience, String pdfFilePath, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.jobSeekerId = jobSeekerId;
        this.fullName = fullName;
        this.jobPosition = jobPosition;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.certificates = certificates;
        this.workExperience = workExperience;
        this.pdfFilePath = pdfFilePath;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getJobSeekerId() { return jobSeekerId; }
    public void setJobSeekerId(int jobSeekerId) { this.jobSeekerId = jobSeekerId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getJobPosition() { return jobPosition; }
    public void setJobPosition(String jobPosition) { this.jobPosition = jobPosition; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCertificates() { return certificates; }
    public void setCertificates(String certificates) { this.certificates = certificates; }
    public String getWorkExperience() { return workExperience; }
    public void setWorkExperience(String workExperience) { this.workExperience = workExperience; }
    public String getPdfFilePath() { return pdfFilePath; }
    public void setPdfFilePath(String pdfFilePath) { this.pdfFilePath = pdfFilePath; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}