package models;

import java.util.Date;

public class SavedJob {

    private int id;
    private int userId;
    private int job_seeker_id;
    private int recruiter_id;
    private int postId;
    private Date savedAt;

    public SavedJob() {
    }

    public SavedJob(int id, int userId, int job_seeker_id, int recruiter_id, int postId, Date savedAt) {
        this.id = id;
        this.userId = userId;
        this.job_seeker_id = job_seeker_id;
        this.recruiter_id = recruiter_id;
        this.postId = postId;
        this.savedAt = savedAt;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public Date getSavedAt() {
        return savedAt;
    }

    public void setSavedAt(Date savedAt) {
        this.savedAt = savedAt;
    }

    public int getJob_seeker_id() {
        return job_seeker_id;
    }

    public void setJob_seeker_id(int job_seeker_id) {
        this.job_seeker_id = job_seeker_id;
    }

    public int getRecruiter_id() {
        return recruiter_id;
    }

    public void setRecruiter_id(int recruiter_id) {
        this.recruiter_id = recruiter_id;
    }
    
    

    
}
