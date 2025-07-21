package models;

import java.math.BigDecimal;

public class AdvancedSearchCriteria {
    private String keyword;
    private String location;
    private String industry;
    private String jobType;
    private String experienceLevel;
    private BigDecimal minSalary;
    private BigDecimal maxSalary;
    private String companySize;
    private String workType; // remote, hybrid, on-site
    private String education;
    private String skills;
    private String benefits;
    private String language;
    private String sortBy;
    private String sortOrder;
    private int page;
    private int pageSize;
    private boolean isSaved;
    private String searchName;
    
    // Constructors
    public AdvancedSearchCriteria() {
        this.page = 1;
        this.pageSize = 10;
        this.sortBy = "created_at";
        this.sortOrder = "DESC";
        this.isSaved = false;
    }
    
    // Getters and Setters
    public String getKeyword() {
        return keyword;
    }
    
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getIndustry() {
        return industry;
    }
    
    public void setIndustry(String industry) {
        this.industry = industry;
    }
    
    public String getJobType() {
        return jobType;
    }
    
    public void setJobType(String jobType) {
        this.jobType = jobType;
    }
    
    public String getExperienceLevel() {
        return experienceLevel;
    }
    
    public void setExperienceLevel(String experienceLevel) {
        this.experienceLevel = experienceLevel;
    }
    
    public BigDecimal getMinSalary() {
        return minSalary;
    }
    
    public void setMinSalary(BigDecimal minSalary) {
        this.minSalary = minSalary;
    }
    
    public BigDecimal getMaxSalary() {
        return maxSalary;
    }
    
    public void setMaxSalary(BigDecimal maxSalary) {
        this.maxSalary = maxSalary;
    }
    
    public String getCompanySize() {
        return companySize;
    }
    
    public void setCompanySize(String companySize) {
        this.companySize = companySize;
    }
    
    public String getWorkType() {
        return workType;
    }
    
    public void setWorkType(String workType) {
        this.workType = workType;
    }
    
    public String getEducation() {
        return education;
    }
    
    public void setEducation(String education) {
        this.education = education;
    }
    
    public String getSkills() {
        return skills;
    }
    
    public void setSkills(String skills) {
        this.skills = skills;
    }
    
    public String getBenefits() {
        return benefits;
    }
    
    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }
    
    public String getLanguage() {
        return language;
    }
    
    public void setLanguage(String language) {
        this.language = language;
    }
    
    public String getSortBy() {
        return sortBy;
    }
    
    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }
    
    public String getSortOrder() {
        return sortOrder;
    }
    
    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }
    
    public int getPage() {
        return page;
    }
    
    public void setPage(int page) {
        this.page = page;
    }
    
    public int getPageSize() {
        return pageSize;
    }
    
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    
    public boolean isSaved() {
        return isSaved;
    }
    
    public void setSaved(boolean saved) {
        isSaved = saved;
    }
    
    public String getSearchName() {
        return searchName;
    }
    
    public void setSearchName(String searchName) {
        this.searchName = searchName;
    }
    
    // Helper methods
    public boolean hasFilters() {
        return (keyword != null && !keyword.trim().isEmpty()) ||
               (location != null && !location.trim().isEmpty()) ||
               (industry != null && !industry.trim().isEmpty()) ||
               (jobType != null && !jobType.trim().isEmpty()) ||
               (experienceLevel != null && !experienceLevel.trim().isEmpty()) ||
               (minSalary != null && minSalary.compareTo(BigDecimal.ZERO) > 0) ||
               (maxSalary != null && maxSalary.compareTo(BigDecimal.ZERO) > 0) ||
               (companySize != null && !companySize.trim().isEmpty()) ||
               (workType != null && !workType.trim().isEmpty()) ||
               (education != null && !education.trim().isEmpty()) ||
               (skills != null && !skills.trim().isEmpty()) ||
               (benefits != null && !benefits.trim().isEmpty()) ||
               (language != null && !language.trim().isEmpty());
    }
    
    public String getSearchSummary() {
        StringBuilder summary = new StringBuilder();
        if (keyword != null && !keyword.trim().isEmpty()) {
            summary.append("Từ khóa: ").append(keyword).append(" ");
        }
        if (location != null && !location.trim().isEmpty()) {
            summary.append("Địa điểm: ").append(location).append(" ");
        }
        if (industry != null && !industry.trim().isEmpty()) {
            summary.append("Ngành: ").append(industry).append(" ");
        }
        if (jobType != null && !jobType.trim().isEmpty()) {
            summary.append("Loại việc: ").append(jobType).append(" ");
        }
        return summary.toString().trim();
    }
} 