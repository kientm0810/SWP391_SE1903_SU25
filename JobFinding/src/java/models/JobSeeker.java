/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author MY PC
 */

import java.util.Date;

public class JobSeeker {
    private int id;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private Date dateOfBirth;
    private String gender;
    private String address;
    private String profilePicture;
    private String cvFile;
    private String skills;
    private int experienceYears;
    private String education;
    private String desiredJobTitle;
    private double desiredSalary;
    private String jobCategory;
    private String preferredLocation;
    private String careerLevel;
    private String workType;
    private String profileSummary;
    private String portfolioUrl;
    private String languages;
    private Date createdAt;
    private Date updatedAt;
    private boolean isActive;

    // Add profile sections for recruiter modal
    private java.util.List<Experience> experiences;
    private java.util.List<Education> educations;
    private java.util.List<Certificate> certificates;
    private java.util.List<Award> awards;
    private java.util.List<CVTemplate> cvTemplates;

    public JobSeeker() {
    }

    public JobSeeker(String username, String password, String email, String fullName, String phone, Date dateOfBirth, String gender, String address, String profilePicture, String cvFile, String skills, int experienceYears, String education, String desiredJobTitle, double desiredSalary, String jobCategory, String preferredLocation, String careerLevel, String workType, String profileSummary, String portfolioUrl, String languages, Date createdAt, Date updatedAt, boolean isActive) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.address = address;
        this.profilePicture = profilePicture;
        this.cvFile = cvFile;
        this.skills = skills;
        this.experienceYears = experienceYears;
        this.education = education;
        this.desiredJobTitle = desiredJobTitle;
        this.desiredSalary = desiredSalary;
        this.jobCategory = jobCategory;
        this.preferredLocation = preferredLocation;
        this.careerLevel = careerLevel;
        this.workType = workType;
        this.profileSummary = profileSummary;
        this.portfolioUrl = portfolioUrl;
        this.languages = languages;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isActive = isActive;
    }

    public JobSeeker(int id, String username, String password, String email, String fullName, String phone, Date dateOfBirth, String gender, String address, String profilePicture, String cvFile, String skills, int experienceYears, String education, String desiredJobTitle, double desiredSalary, String jobCategory, String preferredLocation, String careerLevel, String workType, String profileSummary, String portfolioUrl, String languages, Date createdAt, Date updatedAt, boolean isActive) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.address = address;
        this.profilePicture = profilePicture;
        this.cvFile = cvFile;
        this.skills = skills;
        this.experienceYears = experienceYears;
        this.education = education;
        this.desiredJobTitle = desiredJobTitle;
        this.desiredSalary = desiredSalary;
        this.jobCategory = jobCategory;
        this.preferredLocation = preferredLocation;
        this.careerLevel = careerLevel;
        this.workType = workType;
        this.profileSummary = profileSummary;
        this.portfolioUrl = portfolioUrl;
        this.languages = languages;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isActive = isActive;
    }



    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public String getCvFile() {
        return cvFile;
    }

    public void setCvFile(String cvFile) {
        this.cvFile = cvFile;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public int getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(int experienceYears) {
        this.experienceYears = experienceYears;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getDesiredJobTitle() {
        return desiredJobTitle;
    }

    public void setDesiredJobTitle(String desiredJobTitle) {
        this.desiredJobTitle = desiredJobTitle;
    }

    public double getDesiredSalary() {
        return desiredSalary;
    }

    public void setDesiredSalary(double desiredSalary) {
        this.desiredSalary = desiredSalary;
    }

    public String getJobCategory() {
        return jobCategory;
    }

    public void setJobCategory(String jobCategory) {
        this.jobCategory = jobCategory;
    }

    public String getPreferredLocation() {
        return preferredLocation;
    }

    public void setPreferredLocation(String preferredLocation) {
        this.preferredLocation = preferredLocation;
    }

    public String getCareerLevel() {
        return careerLevel;
    }

    public void setCareerLevel(String careerLevel) {
        this.careerLevel = careerLevel;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public String getProfileSummary() {
        return profileSummary;
    }

    public void setProfileSummary(String profileSummary) {
        this.profileSummary = profileSummary;
    }

    public String getPortfolioUrl() {
        return portfolioUrl;
    }

    public void setPortfolioUrl(String portfolioUrl) {
        this.portfolioUrl = portfolioUrl;
    }

    public String getLanguages() {
        return languages;
    }

    public void setLanguages(String languages) {
        this.languages = languages;
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

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public java.util.List<Experience> getExperiences() {
        return experiences;
    }
    public void setExperiences(java.util.List<Experience> experiences) {
        this.experiences = experiences;
    }
    public java.util.List<Education> getEducations() {
        return educations;
    }
    public void setEducations(java.util.List<Education> educations) {
        this.educations = educations;
    }
    public java.util.List<Certificate> getCertificates() {
        return certificates;
    }
    public void setCertificates(java.util.List<Certificate> certificates) {
        this.certificates = certificates;
    }
    public java.util.List<Award> getAwards() {
        return awards;
    }
    public void setAwards(java.util.List<Award> awards) {
        this.awards = awards;
    }
    public java.util.List<CVTemplate> getCvTemplates() {
        return cvTemplates;
    }
    public void setCvTemplates(java.util.List<CVTemplate> cvTemplates) {
        this.cvTemplates = cvTemplates;
    }
}
