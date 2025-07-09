package models;
import java.time.LocalDateTime; // Quan trọng: Sử dụng java.time cho ngày tháng hiện đại

public class Application {
<<<<<<< HEAD
    private int id;
    private int jobListingId;
    private int jobSeekerId;
=======
    private int applicationId;
    private int postId;
    private int jobSeekerId;
    private int cvId;
    private Posts post;
    private JobSeeker jobseeker;
    private String status;
    private Timestamp createdAt;
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
    private String cvFile;
    private String coverLetter;
    private String status;
    private LocalDateTime appliedAt;
    private LocalDateTime updatedAt;

    public Application() {
    }
<<<<<<< HEAD

    public Application(int id, int jobListingId, int jobSeekerId, String cvFile, String coverLetter, String status, LocalDateTime appliedAt, LocalDateTime updatedAt) {
        this.id = id;
        this.jobListingId = jobListingId;
        this.jobSeekerId = jobSeekerId;
        this.cvFile = cvFile;
        this.coverLetter = coverLetter;
=======
    
    public Application(int applicationId, int postId, int jobSeekerId, int cvId, String status, Timestamp createdAt) {
        this.applicationId = applicationId;
        this.postId = postId;
        this.jobSeekerId = jobSeekerId;
        this.cvId = cvId;
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
        this.status = status;
        this.appliedAt = appliedAt;
        this.updatedAt = updatedAt;
    }

    

    // Getters
    public int getId() {
        return id;
    }

    public int getJobListingId() {
        return jobListingId;
    }
<<<<<<< HEAD

    public int getJobSeekerId() {
        return jobSeekerId;
    }

=======
    
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
    
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
    public String getCvFile() {
        return cvFile;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getAppliedAt() {
        return appliedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setJobListingId(int jobListingId) {
        this.jobListingId = jobListingId;
    }

    public void setJobSeekerId(int jobSeekerId) {
        this.jobSeekerId = jobSeekerId;
    }

    public void setCvFile(String cvFile) {
        this.cvFile = cvFile;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }
<<<<<<< HEAD

    public void setStatus(String status) {
        // Tùy chọn: Thêm kiểm tra validation ở đây nếu muốn giới hạn các giá trị
        if (status != null && (status.equals("new") || status.equals("reviewed") ||
                               status.equals("interviewed") || status.equals("offered") ||
                               status.equals("rejected"))) {
            this.status = status;
        } else {
            // Xử lý lỗi hoặc ném ngoại lệ nếu giá trị không hợp lệ
            throw new IllegalArgumentException("Invalid status value: " + status);
        }
    }

    public void setAppliedAt(LocalDateTime appliedAt) {
        this.appliedAt = appliedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

   
}
=======
    
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
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
