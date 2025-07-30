package models;

public class AdvancedSearchCriteria {
    private String keyword;
    private String location;
    private String industry;
    private String jobType;
    private String experience;
    private String rank;
    private String workingTime;
    private String salary;
    private String companyName;
    private String companySize;
    private String contactAddress;
    private String requirements;
    private String benefits;
    private String applicationMethod;
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
    
    public String getExperience() {
        return experience;
    }
    
    public void setExperience(String experience) {
        this.experience = experience;
    }
    
    public String getRank() {
        return rank;
    }
    
    public void setRank(String rank) {
        this.rank = rank;
    }
    
    public String getWorkingTime() {
        return workingTime;
    }
    
    public void setWorkingTime(String workingTime) {
        this.workingTime = workingTime;
    }
    
    public String getSalary() {
        return salary;
    }
    
    public void setSalary(String salary) {
        this.salary = salary;
    }
    
    public String getCompanyName() {
        return companyName;
    }
    
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    
    public String getCompanySize() {
        return companySize;
    }
    
    public void setCompanySize(String companySize) {
        this.companySize = companySize;
    }
    
    public String getContactAddress() {
        return contactAddress;
    }
    
    public void setContactAddress(String contactAddress) {
        this.contactAddress = contactAddress;
    }
    
    public String getRequirements() {
        return requirements;
    }
    
    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }
    
    public String getBenefits() {
        return benefits;
    }
    
    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }
    
    public String getApplicationMethod() {
        return applicationMethod;
    }
    
    public void setApplicationMethod(String applicationMethod) {
        this.applicationMethod = applicationMethod;
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
               (experience != null && !experience.trim().isEmpty()) ||
               (rank != null && !rank.trim().isEmpty()) ||
               (workingTime != null && !workingTime.trim().isEmpty()) ||
               (salary != null && !salary.trim().isEmpty()) ||
               (companyName != null && !companyName.trim().isEmpty()) ||
               (companySize != null && !companySize.trim().isEmpty()) ||
               (contactAddress != null && !contactAddress.trim().isEmpty()) ||
               (requirements != null && !requirements.trim().isEmpty()) ||
               (benefits != null && !benefits.trim().isEmpty()) ||
               (applicationMethod != null && !applicationMethod.trim().isEmpty());
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