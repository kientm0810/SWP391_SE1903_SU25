package models;

import java.sql.Timestamp;

public class EmailTemplate {
    private int Id;
    private String templateName;
    private String templateType;
    private String subject;
    private String bodyHtml;
    private String bodyText;
    private String variables;
    private boolean isActive;
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructors
    public EmailTemplate() {
    }

    public EmailTemplate(int Id, String templateName, String templateType, String subject, 
                        String bodyHtml, String bodyText, String variables, boolean isActive, 
                        int createdBy, Timestamp createdAt, Timestamp updatedAt) {
        this.Id = Id;
        this.templateName = templateName;
        this.templateType = templateType;
        this.subject = subject;
        this.bodyHtml = bodyHtml;
        this.bodyText = bodyText;
        this.variables = variables;
        this.isActive = isActive;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public boolean isIsActive() {
        return isActive;
    }

    // Getters and Setters
    public void setIsActive(boolean isActive) {    
        this.isActive = isActive;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public String getTemplateType() {
        return templateType;
    }

    public void setTemplateType(String templateType) {
        this.templateType = templateType;
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

    public String getBodyText() {
        return bodyText;
    }

    public void setBodyText(String bodyText) {
        this.bodyText = bodyText;
    }

    public String getVariables() {
        return variables;
    }

    public void setVariables(String variables) {
        this.variables = variables;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "EmailTemplate{" +
                "Id=" + Id +
                ", templateName='" + templateName + '\'' +
                ", templateType='" + templateType + '\'' +
                ", subject='" + subject + '\'' +
                ", isActive=" + isActive +
                '}';
    }
} 