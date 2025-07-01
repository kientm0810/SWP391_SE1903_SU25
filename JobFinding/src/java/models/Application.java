package models;

import java.sql.Timestamp;

public class Application {
    private int applicationId;
    private JobListing job;
    private JobSeeker jobseeker;
    private String status;
    private Timestamp createdAt;
    private String cvFile;
    private String coverLetter;
    
    public Application() {
    }
    
    public Application(int applicationId, JobListing job, JobSeeker jobseeker, String status, Timestamp createdAt) {
        this.applicationId = applicationId;
        this.job = job;
        this.jobseeker = jobseeker;
        this.status = status;
        this.createdAt = createdAt;
    }
    
    public int getApplicationId() {
        return applicationId;
    }
    
    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }
    
    public JobListing getJob() {
        return job;
    }
    
    public void setJob(JobListing job) {
        this.job = job;
    }
    
    public JobSeeker getJobseeker() {
        return jobseeker;
    }
    
    public void setJobseeker(JobSeeker jobseeker) {
        this.jobseeker = jobseeker;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getCvFile() {
        return cvFile;
    }
    
    public void setCvFile(String cvFile) {
        this.cvFile = cvFile;
    }
    
    public String getCoverLetter() {
        return coverLetter;
    }
    
    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }
} 