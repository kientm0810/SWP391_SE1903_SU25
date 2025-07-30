package models;

import java.math.BigDecimal;
import java.util.Date;

public class Education {
    private int id;
    private int jobSeekerId;
    private String degree;
    private String fieldOfStudy;
    private String institutionName;
    private String location;
    private Date startDate;
    private Date endDate;
    private boolean isCurrent;
    private BigDecimal gpa;
    private String grade;
    private String activities;
    private String description;
    private Date createdAt;
    private Date updatedAt;

    // Default constructor
    public Education() {
    }

    // Constructor with all fields
    public Education(int id, int jobSeekerId, String degree, String fieldOfStudy, String institutionName,
                    String location, Date startDate, Date endDate, boolean isCurrent, BigDecimal gpa,
                    String grade, String activities, String description, Date createdAt, Date updatedAt) {
        this.id = id;
        this.jobSeekerId = jobSeekerId;
        this.degree = degree;
        this.fieldOfStudy = fieldOfStudy;
        this.institutionName = institutionName;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isCurrent = isCurrent;
        this.gpa = gpa;
        this.grade = grade;
        this.activities = activities;
        this.description = description;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Constructor without id (for creating new education)
    public Education(int jobSeekerId, String degree, String fieldOfStudy, String institutionName,
                    String location, Date startDate, Date endDate, boolean isCurrent, BigDecimal gpa,
                    String grade, String activities, String description) {
        this.jobSeekerId = jobSeekerId;
        this.degree = degree;
        this.fieldOfStudy = fieldOfStudy;
        this.institutionName = institutionName;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isCurrent = isCurrent;
        this.gpa = gpa;
        this.grade = grade;
        this.activities = activities;
        this.description = description;
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

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getFieldOfStudy() {
        return fieldOfStudy;
    }

    public void setFieldOfStudy(String fieldOfStudy) {
        this.fieldOfStudy = fieldOfStudy;
    }

    public String getInstitutionName() {
        return institutionName;
    }

    public void setInstitutionName(String institutionName) {
        this.institutionName = institutionName;
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

    public BigDecimal getGpa() {
        return gpa;
    }

    public void setGpa(BigDecimal gpa) {
        this.gpa = gpa;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getActivities() {
        return activities;
    }

    public void setActivities(String activities) {
        this.activities = activities;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
        return "Education{" +
                "id=" + id +
                ", jobSeekerId=" + jobSeekerId +
                ", degree='" + degree + '\'' +
                ", fieldOfStudy='" + fieldOfStudy + '\'' +
                ", institutionName='" + institutionName + '\'' +
                ", location='" + location + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", isCurrent=" + isCurrent +
                ", gpa=" + gpa +
                ", grade='" + grade + '\'' +
                '}';
    }
} 