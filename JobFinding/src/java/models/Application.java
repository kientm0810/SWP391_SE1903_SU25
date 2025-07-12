package models;

import java.sql.Timestamp;

public class Application {
    private int applicationId;
    private int postId;
    private int jobSeekerId;
    private int cvId;
    private Posts post;
    private JobSeeker jobseeker;
    private String status;
    private Timestamp createdAt;
    private String cvFile;
    private String coverLetter;
    
    public Application() {
    }
    
    public Application(int applicationId, int postId, int jobSeekerId, int cvId, String status, Timestamp createdAt) {
        this.applicationId = applicationId;
        this.postId = postId;
        this.jobSeekerId = jobSeekerId;
        this.cvId = cvId;
        this.status = status;
        this.createdAt = createdAt;
    }
    
    public int getApplicationId() {
        return applicationId;
    }
    
    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }
    
    public Posts getPost() {
        return post;
    }
    
    public void setPost(Posts post) {
        this.post = post;
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
    
    // Convenience methods for JSP access
    public int getJobId() {
        return post != null ? post.getId() : 0;
    }
    
    public String getJobTitle() {
        return post != null ? post.getTitle() : "";
    }
    
    public String getCompanyName() {
        return post != null ? post.getCompanyName() : "";
    }
    
    public String getCompanyLogo() {
        return post != null ? post.getCompanyLogo() : "";
    }
    
    public String getLocation() {
        return post != null ? post.getLocation() : "";
    }
    
    public String getSalary() {
        return post != null ? post.getSalary() : "";
    }
    
    public String getJobType() {
        return post != null ? post.getJobType() : "";
    }
    
    public String getExperience() {
        return post != null ? post.getExperience() : "";
    }
    
    // Additional convenience methods for applications.jsp
    public Timestamp getAppliedAt() {
        return createdAt;
    }
    
    public String getStatusColor() {
        if (status == null) return "secondary";
        switch (status.toLowerCase()) {
            case "new":
                return "primary";
            case "reviewed":
                return "info";
            case "interviewed":
                return "warning";
            case "offered":
                return "success";
            case "rejected":
                return "danger";
            default:
                return "secondary";
        }
    }
    
    public int getId() {
        return applicationId;
    }
    
    public int getPostId() {
        return postId;
    }
    
    public void setPostId(int postId) {
        this.postId = postId;
    }
    
    public int getJobSeekerId() {
        return jobSeekerId;
    }
    
    public void setJobSeekerId(int jobSeekerId) {
        this.jobSeekerId = jobSeekerId;
    }
    
    public int getCvId() {
        return cvId;
    }
    
    public void setCvId(int cvId) {
        this.cvId = cvId;
    }
    
    public String getCvName() {
        if (cvFile != null && !cvFile.isEmpty()) {
            // Extract filename from path
            String[] parts = cvFile.split("/");
            return parts[parts.length - 1];
        }
        return "CV đã nộp";
    }
    
    public boolean getCanWithdraw() {
        // Allow withdrawal only for new and reviewed applications
        return status != null && (status.equals("new") || status.equals("reviewed"));
    }
} 