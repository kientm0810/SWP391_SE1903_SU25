package models;

import java.sql.Timestamp;

public class SavedJob {
    private int id;
    private Integer jobSeekerId;
    private Integer recruiterId;
    private int postId;
    private Timestamp savedAt;
    
    // Constructors
    public SavedJob() {
    }
    
    public SavedJob(Integer jobSeekerId, int postId) {
        this.jobSeekerId = jobSeekerId;
        this.postId = postId;
        this.savedAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public Integer getJobSeekerId() {
        return jobSeekerId;
    }
    
    public void setJobSeekerId(Integer jobSeekerId) {
        this.jobSeekerId = jobSeekerId;
    }
    
    public Integer getRecruiterId() {
        return recruiterId;
    }
    
    public void setRecruiterId(Integer recruiterId) {
        this.recruiterId = recruiterId;
    }
    
    public int getPostId() {
        return postId;
    }
    
    public void setPostId(int postId) {
        this.postId = postId;
    }
    
    public Timestamp getSavedAt() {
        return savedAt;
    }
    
    public void setSavedAt(Timestamp savedAt) {
        this.savedAt = savedAt;
    }
}
