package models;
import java.time.LocalDateTime; // Quan trọng: Sử dụng java.time cho ngày tháng hiện đại

public class Application {
    private int id;
    private int jobListingId;
    private int jobSeekerId;
    private String cvFile;
    private String coverLetter;
    private String status;
    private LocalDateTime appliedAt;
    private LocalDateTime updatedAt;

    public Application() {
    }

    public Application(int id, int jobListingId, int jobSeekerId, String cvFile, String coverLetter, String status, LocalDateTime appliedAt, LocalDateTime updatedAt) {
        this.id = id;
        this.jobListingId = jobListingId;
        this.jobSeekerId = jobSeekerId;
        this.cvFile = cvFile;
        this.coverLetter = coverLetter;
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

    public int getJobSeekerId() {
        return jobSeekerId;
    }

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