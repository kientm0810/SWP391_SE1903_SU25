package models;

import java.util.Date;

public class Posts {

    private int id;
    private int userId;
    private String userType;
    private Integer parentId;
    private String postType;
    private String title;
    private String status;
    private int viewCount;
    private int likeCount;
    private int commentCount;
    private Date createdAt;
    private Date updatedAt;
    private Date deletedAt;
    private String companyName;
    private String companyLogo;
    private String salary;
    private String location;
    private String jobType;
    private String experience;
    private Date deadline;
    private String workingTime;
    private String jobDescription;
    private String requirements;
    private String benefits;
    private String contactAddress;
    private String applicationMethod;
    private Integer quantity;
    private String rank;
    private String industry;
    private String contactPerson;
    private String companySize;
    private String companyWebsite;
    private String companyDescription;
    private String keywords;
    private Double salaryMin;
    private Double salaryMax;
    private Integer experienceYears;

    public Posts() {
    }

    public Posts(int id, int userId, String userType, Integer parentId, String postType, String title, String status, int viewCount, int likeCount, int commentCount, Date createdAt, Date updatedAt, Date deletedAt, String companyName, String companyLogo, String salary, String location, String jobType, String experience, Date deadline, String workingTime, String jobDescription, String requirements, String benefits, String contactAddress, String applicationMethod, Integer quantity, String rank, String industry, String contactPerson, String companySize, String companyWebsite, String companyDescription, String keywords) {
        this.id = id;
        this.userId = userId;

        this.userType = userType;
        this.parentId = parentId;
        this.postType = postType;
        this.title = title;
        this.status = status;
        this.viewCount = viewCount;
        this.likeCount = likeCount;
        this.commentCount = commentCount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.deletedAt = deletedAt;
        this.companyName = companyName;
        this.companyLogo = companyLogo;
        this.salary = salary;
        this.location = location;
        this.jobType = jobType;
        this.experience = experience;
        this.deadline = deadline;
        this.workingTime = workingTime;
        this.jobDescription = jobDescription;
        this.requirements = requirements;
        this.benefits = benefits;
        this.contactAddress = contactAddress;
        this.applicationMethod = applicationMethod;
        this.quantity = quantity;
        this.rank = rank;
        this.industry = industry;
        this.contactPerson = contactPerson;
        this.companySize = companySize;
        this.companyWebsite = companyWebsite;
        this.companyDescription = companyDescription;
        this.keywords = keywords;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
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

    public Date getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(Date deletedAt) {
        this.deletedAt = deletedAt;
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

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
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

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public String getWorkingTime() {
        return workingTime;
    }

    public void setWorkingTime(String workingTime) {
        this.workingTime = workingTime;
    }

    public String getJobDescription() {
        return jobDescription;
    }

    public void setJobDescription(String jobDescription) {
        this.jobDescription = jobDescription;
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

    public String getContactAddress() {
        return contactAddress;
    }

    public void setContactAddress(String contactAddress) {
        this.contactAddress = contactAddress;
    }

    public String getApplicationMethod() {
        return applicationMethod;
    }

    public void setApplicationMethod(String applicationMethod) {
        this.applicationMethod = applicationMethod;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getCompanySize() {
        return companySize;
    }

    public void setCompanySize(String companySize) {
        this.companySize = companySize;
    }

    public String getCompanyWebsite() {
        return companyWebsite;
    }

    public void setCompanyWebsite(String companyWebsite) {
        this.companyWebsite = companyWebsite;
    }

    public String getCompanyDescription() {
        return companyDescription;
    }

    public void setCompanyDescription(String companyDescription) {
        this.companyDescription = companyDescription;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public Double getSalaryMin() {
        return salaryMin;
    }

    public void setSalaryMin(Double salaryMin) {
        this.salaryMin = salaryMin;
    }

    public Double getSalaryMax() {
        return salaryMax;
    }

    public void setSalaryMax(Double salaryMax) {
        this.salaryMax = salaryMax;
    }

    public Integer getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(Integer experienceYears) {
        this.experienceYears = experienceYears;
    }

    // Helper methods for advanced search
    public String getFormattedSalary() {
        if (salaryMin != null && salaryMax != null) {
            return String.format("%.0f - %.0f triệu VND", salaryMin, salaryMax);
        } else if (salaryMin != null) {
            return String.format("Từ %.0f triệu VND", salaryMin);
        } else if (salaryMax != null) {
            return String.format("Đến %.0f triệu VND", salaryMax);
        } else if (salary != null && !salary.trim().isEmpty()) {
            return salary;
        }
        return "Thương lượng";
    }

    public String getFormattedExperience() {
        if (experienceYears != null) {
            if (experienceYears == 0) {
                return "Mới tốt nghiệp";
            } else if (experienceYears == 1) {
                return "1 năm kinh nghiệm";
            } else {
                return experienceYears + " năm kinh nghiệm";
            }
        } else if (experience != null && !experience.trim().isEmpty()) {
            return experience;
        }
        return "Không yêu cầu";
    }

    public boolean isRemote() {
        return workingTime != null && workingTime.toLowerCase().contains("remote");
    }

    public boolean isHybrid() {
        return workingTime != null && workingTime.toLowerCase().contains("hybrid");
    }

    public boolean isOnSite() {
        return workingTime != null && workingTime.toLowerCase().contains("on-site");
    }

    public String getWorkType() {
        if (isRemote()) return "remote";
        if (isHybrid()) return "hybrid";
        if (isOnSite()) return "on_site";
        return "on_site"; // default
    }
}
