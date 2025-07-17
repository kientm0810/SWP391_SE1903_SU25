package models;

import java.sql.Timestamp;

public class SearchHistory {
    private int id;
    private int jobSeekerId;
    private String searchQuery;
    private String searchFilters;
    private Timestamp searchDate;

    public SearchHistory() {
    }

    public SearchHistory(int jobSeekerId, String searchQuery, String searchFilters) {
        this.jobSeekerId = jobSeekerId;
        this.searchQuery = searchQuery;
        this.searchFilters = searchFilters;
        this.searchDate = new Timestamp(System.currentTimeMillis());
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

    public Timestamp getSearchDate() {
        return searchDate;
    }

    public void setSearchDate(Timestamp searchDate) {
        this.searchDate = searchDate;
    }
} 