package models;

import java.sql.Timestamp;

/**
 * Model cho Interview Schedule
 */
public class InterviewSchedule {
    private int id;
    private int applicationId;
    private String interviewType;
    private Timestamp scheduledDate;
    private Integer durationMinutes;
    private String location;
    private String interviewerName;
    private String interviewerEmail;
    private String candidateEmail;
    private String status;
    private String notes;
    private Boolean reminderSent;
    private Timestamp createdAt;
    private int createdBy;

    // Additional fields for convenience
    private String candidateName;
    private String jobTitle;
    private String companyName;

    public InterviewSchedule() {
    }

    public InterviewSchedule(int id, int applicationId, String interviewType, Timestamp scheduledDate, 
                           Integer durationMinutes, String location, String interviewerName, 
                           String interviewerEmail, String candidateEmail, String status, 
                           String notes, Boolean reminderSent, Timestamp createdAt, int createdBy) {
        this.id = id;
        this.applicationId = applicationId;
        this.interviewType = interviewType;
        this.scheduledDate = scheduledDate;
        this.durationMinutes = durationMinutes;
        this.location = location;
        this.interviewerName = interviewerName;
        this.interviewerEmail = interviewerEmail;
        this.candidateEmail = candidateEmail;
        this.status = status;
        this.notes = notes;
        this.reminderSent = reminderSent;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public String getInterviewType() {
        return interviewType;
    }

    public void setInterviewType(String interviewType) {
        this.interviewType = interviewType;
    }

    public Timestamp getScheduledDate() {
        return scheduledDate;
    }

    public void setScheduledDate(Timestamp scheduledDate) {
        this.scheduledDate = scheduledDate;
    }

    public Integer getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(Integer durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getInterviewerName() {
        return interviewerName;
    }

    public void setInterviewerName(String interviewerName) {
        this.interviewerName = interviewerName;
    }

    public String getInterviewerEmail() {
        return interviewerEmail;
    }

    public void setInterviewerEmail(String interviewerEmail) {
        this.interviewerEmail = interviewerEmail;
    }

    public String getCandidateEmail() {
        return candidateEmail;
    }

    public void setCandidateEmail(String candidateEmail) {
        this.candidateEmail = candidateEmail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Boolean getReminderSent() {
        return reminderSent;
    }

    public void setReminderSent(Boolean reminderSent) {
        this.reminderSent = reminderSent;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getCandidateName() {
        return candidateName;
    }

    public void setCandidateName(String candidateName) {
        this.candidateName = candidateName;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    @Override
    public String toString() {
        return "InterviewSchedule{" +
                "id=" + id +
                ", applicationId=" + applicationId +
                ", interviewType='" + interviewType + '\'' +
                ", scheduledDate=" + scheduledDate +
                ", location='" + location + '\'' +
                ", interviewerName='" + interviewerName + '\'' +
                ", candidateEmail='" + candidateEmail + '\'' +
                ", status='" + status + '\'' +
                ", reminderSent=" + reminderSent +
                '}';
    }
} 