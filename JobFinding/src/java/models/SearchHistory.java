package models;

import java.util.Date;

/**
 * Model class for Search History
 * Represents job seeker search history data
 */
public class SearchHistory {
    private int id;
    private int jobSeekerId;
    private String searchQuery;
    private String searchFilters;
    private Date searchDate;
    
    public SearchHistory() {
    }
    
    public SearchHistory(int id, int jobSeekerId, String searchQuery, String searchFilters, Date searchDate) {
        this.id = id;
        this.jobSeekerId = jobSeekerId;
        this.searchQuery = searchQuery;
        this.searchFilters = searchFilters;
        this.searchDate = searchDate;
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
    
    public String getSearchQuery() {
        return searchQuery;
    }
    
    public void setSearchQuery(String searchQuery) {
        this.searchQuery = searchQuery;
    }
    
    public String getSearchFilters() {
        return searchFilters;
    }
    
    public void setSearchFilters(String searchFilters) {
        this.searchFilters = searchFilters;
    }
    
    public Date getSearchDate() {
        return searchDate;
    }
    
    public void setSearchDate(Date searchDate) {
        this.searchDate = searchDate;
    }
    
    @Override
    public String toString() {
        return "SearchHistory{" +
                "id=" + id +
                ", jobSeekerId=" + jobSeekerId +
                ", searchQuery='" + searchQuery + '\'' +
                ", searchFilters='" + searchFilters + '\'' +
                ", searchDate=" + searchDate +
                '}';
    }
} 