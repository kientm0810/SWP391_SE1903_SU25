package models;

import java.sql.Timestamp;

/**
 * Model cho Email History
 */
public class EmailHistory {
    private int id;
    private Integer applicationId;
    private Integer interviewScheduleId;
    private String templateName;
    private String recipientEmail;
    private String subject;
    private String bodyHtml;
    private String status;
    private String errorMessage;
    private Timestamp sentAt;
    private Timestamp createdAt;

    public EmailHistory() {
    }

    public EmailHistory(int id, Integer applicationId, Integer interviewScheduleId, 
                       String templateName, String recipientEmail, String subject, 
                       String bodyHtml, String status, String errorMessage, 
                       Timestamp sentAt, Timestamp createdAt) {
        this.id = id;
        this.applicationId = applicationId;
        this.interviewScheduleId = interviewScheduleId;
        this.templateName = templateName;
        this.recipientEmail = recipientEmail;
        this.subject = subject;
        this.bodyHtml = bodyHtml;
        this.status = status;
        this.errorMessage = errorMessage;
        this.sentAt = sentAt;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(Integer applicationId) {
        this.applicationId = applicationId;
    }

    public Integer getInterviewScheduleId() {
        return interviewScheduleId;
    }

    public void setInterviewScheduleId(Integer interviewScheduleId) {
        this.interviewScheduleId = interviewScheduleId;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public String getRecipientEmail() {
        return recipientEmail;
    }

    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBodyHtml() {
        return bodyHtml;
    }

    public void setBodyHtml(String bodyHtml) {
        this.bodyHtml = bodyHtml;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public Timestamp getSentAt() {
        return sentAt;
    }

    public void setSentAt(Timestamp sentAt) {
        this.sentAt = sentAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "EmailHistory{" +
                "id=" + id +
                ", applicationId=" + applicationId +
                ", interviewScheduleId=" + interviewScheduleId +
                ", templateName='" + templateName + '\'' +
                ", recipientEmail='" + recipientEmail + '\'' +
                ", subject='" + subject + '\'' +
                ", status='" + status + '\'' +
                ", sentAt=" + sentAt +
                ", createdAt=" + createdAt +
                '}';
    }
} 