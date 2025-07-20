package models;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class JobSearch {
    private int id;
    private int jobSeekerId;
    private String searchType;
    private String keyword;
    private String location;
    private String industry;
    private String jobLevel;
    private String jobType;
    private BigDecimal minSalary;
    private BigDecimal maxSalary;
    private Integer minExperience;
    private String benefits;
    private String language;
    private String sortBy;
    private String sortOrder;
    private Boolean isSaved;
    private String searchName;
    private Timestamp createdAt;
    private Timestamp lastUsed;
    private Integer resultCount;
    
    // Constructors
    public JobSearch() {
        this.searchType = "basic";
        this.sortBy = "created_at";
        this.sortOrder = "DESC";
        this.isSaved = false;
        this.resultCount = 0;
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
    
    public String getSearchType() {
        return searchType;
    }
    
    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }
    
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
    
    public String getJobLevel() {
        return jobLevel;
    }
    
    public void setJobLevel(String jobLevel) {
        this.jobLevel = jobLevel;
    }
    
    public String getJobType() {
        return jobType;
    }
    
    public void setJobType(String jobType) {
        this.jobType = jobType;
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
    
    public Integer getMinExperience() {
        return minExperience;
    }
    
    public void setMinExperience(Integer minExperience) {
        this.minExperience = minExperience;
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
    
    public Boolean getIsSaved() {
        return isSaved;
    }
    
    public void setIsSaved(Boolean isSaved) {
        this.isSaved = isSaved;
    }
    
    public String getSearchName() {
        return searchName;
    }
    
    public void setSearchName(String searchName) {
        this.searchName = searchName;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getLastUsed() {
        return lastUsed;
    }
    
    public void setLastUsed(Timestamp lastUsed) {
        this.lastUsed = lastUsed;
    }
    
    public Integer getResultCount() {
        return resultCount;
    }
    
    public void setResultCount(Integer resultCount) {
        this.resultCount = resultCount;
    }
    
    // Helper methods
    public boolean isAdvancedSearch() {
        return "advanced".equals(searchType);
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