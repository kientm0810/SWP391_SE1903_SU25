package models;

import java.util.Date;

public class Experience {
    private int id;
    private int jobSeekerId;
    private String position;
    private String companyName;
    private String companyLogo;
    private String location;
    private Date startDate;
    private Date endDate;
    private boolean isCurrent;
    private String description;
    private String achievements;
    private String skillsUsed;
    private Date createdAt;
    private Date updatedAt;

    // Default constructor
    public Experience() {
    }

    // Constructor with all fields
    public Experience(int id, int jobSeekerId, String position, String companyName, String companyLogo, 
                     String location, Date startDate, Date endDate, boolean isCurrent, 
                     String description, String achievements, String skillsUsed, Date createdAt, Date updatedAt) {
        this.id = id;
        this.jobSeekerId = jobSeekerId;
        this.position = position;
        this.companyName = companyName;
        this.companyLogo = companyLogo;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isCurrent = isCurrent;
        this.description = description;
        this.achievements = achievements;
        this.skillsUsed = skillsUsed;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Constructor without id (for creating new experiences)
    public Experience(int jobSeekerId, String position, String companyName, String companyLogo, 
                     String location, Date startDate, Date endDate, boolean isCurrent, 
                     String description, String achievements, String skillsUsed) {
        this.jobSeekerId = jobSeekerId;
        this.position = position;
        this.companyName = companyName;
        this.companyLogo = companyLogo;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isCurrent = isCurrent;
        this.description = description;
        this.achievements = achievements;
        this.skillsUsed = skillsUsed;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getJobSeekerId() {
        return jobSeekerId;
    }

    public void setJobSeekerId(int jobSeekerId) {
        this.jobSeekerId = jobSeekerId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyLogo() {
        return companyLogo;
    }

    public void setCompanyLogo(String companyLogo) {
        this.companyLogo = companyLogo;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isCurrent() {
        return isCurrent;
    }

    public void setCurrent(boolean current) {
        isCurrent = current;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAchievements() {
        return achievements;
    }

    public void setAchievements(String achievements) {
        this.achievements = achievements;
    }

    public String getSkillsUsed() {
        return skillsUsed;
    }

    public void setSkillsUsed(String skillsUsed) {
        this.skillsUsed = skillsUsed;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Experience{" +
                "id=" + id +
                ", jobSeekerId=" + jobSeekerId +
                ", position='" + position + '\'' +
                ", companyName='" + companyName + '\'' +
                ", location='" + location + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", isCurrent=" + isCurrent +
                ", description='" + description + '\'' +
                '}';
    }
} 