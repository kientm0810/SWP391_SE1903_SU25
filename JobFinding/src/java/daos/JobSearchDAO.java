package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.JobSearch;

public class JobSearchDAO {
    
    public void saveJobSearch(JobSearch jobSearch) throws SQLException {
        String sql = "INSERT INTO Job_Searches (job_seeker_id, search_type, keyword, location, industry, " +
                    "job_level, job_type, min_salary, max_salary, min_experience, benefits, language, " +
                    "sort_by, sort_order, is_saved, search_name, result_count, created_at, last_used) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, jobSearch.getJobSeekerId());
            ps.setString(2, jobSearch.getSearchType());
            ps.setString(3, jobSearch.getKeyword());
            ps.setString(4, jobSearch.getLocation());
            ps.setString(5, jobSearch.getIndustry());
            ps.setString(6, jobSearch.getJobLevel());
            ps.setString(7, jobSearch.getJobType());
            ps.setBigDecimal(8, jobSearch.getMinSalary());
            ps.setBigDecimal(9, jobSearch.getMaxSalary());
            ps.setInt(10, jobSearch.getMinExperience() != null ? jobSearch.getMinExperience() : 0);
            ps.setString(11, jobSearch.getBenefits());
            ps.setString(12, jobSearch.getLanguage());
            ps.setString(13, jobSearch.getSortBy());
            ps.setString(14, jobSearch.getSortOrder());
            ps.setBoolean(15, jobSearch.getIsSaved());
            ps.setString(16, jobSearch.getSearchName());
            ps.setInt(17, jobSearch.getResultCount());
            ps.setTimestamp(18, jobSearch.getCreatedAt() != null ? jobSearch.getCreatedAt() : new java.sql.Timestamp(System.currentTimeMillis()));
            ps.setTimestamp(19, jobSearch.getLastUsed() != null ? jobSearch.getLastUsed() : new java.sql.Timestamp(System.currentTimeMillis()));
            
            ps.executeUpdate();
            
            // Get generated ID
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    jobSearch.setId(rs.getInt(1));
                }
            }
        }
    }
    
    public List<JobSearch> getSearchHistoryByJobSeeker(int jobSeekerId, int limit) throws SQLException {
        List<JobSearch> searches = new ArrayList<>();
        String sql = "SELECT * FROM Job_Searches WHERE job_seeker_id = ? ORDER BY last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    searches.add(mapResultSetToJobSearch(rs));
                }
            }
        }
        return searches;
    }
    
    public List<JobSearch> getSavedSearches(int jobSeekerId) throws SQLException {
        List<JobSearch> searches = new ArrayList<>();
        String sql = "SELECT * FROM Job_Searches WHERE job_seeker_id = ? AND is_saved = 1 ORDER BY created_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    searches.add(mapResultSetToJobSearch(rs));
                }
            }
        }
        return searches;
    }
    
    public void updateSearchLastUsed(int searchId) throws SQLException {
        String sql = "UPDATE Job_Searches SET last_used = GETDATE() WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, searchId);
            
            ps.executeUpdate();
        }
    }
    
    public void deleteSearch(int searchId, int jobSeekerId) throws SQLException {
        String sql = "DELETE FROM Job_Searches WHERE id = ? AND job_seeker_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, searchId);
            ps.setInt(2, jobSeekerId);
            
            ps.executeUpdate();
        }
    }
    
    public void toggleSavedSearch(int searchId, int jobSeekerId, boolean isSaved) throws SQLException {
        String sql = "UPDATE Job_Searches SET is_saved = ? WHERE id = ? AND job_seeker_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, isSaved);
            ps.setInt(2, searchId);
            ps.setInt(3, jobSeekerId);
            
            ps.executeUpdate();
        }
    }
    
    public List<JobSearch> getPopularSearches(int limit) throws SQLException {
        List<JobSearch> searches = new ArrayList<>();
        String sql = "SELECT keyword, location, industry, job_type, COUNT(*) as search_count " +
                    "FROM Job_Searches " +
                    "WHERE keyword IS NOT NULL OR location IS NOT NULL " +
                    "GROUP BY keyword, location, industry, job_type " +
                    "ORDER BY search_count DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    JobSearch search = new JobSearch();
                    search.setKeyword(rs.getString("keyword"));
                    search.setLocation(rs.getString("location"));
                    search.setIndustry(rs.getString("industry"));
                    search.setJobType(rs.getString("job_type"));
                    searches.add(search);
                }
            }
        }
        return searches;
    }
    
    public void deleteOldSearchHistory(int daysOld) throws SQLException {
        String sql = "DELETE FROM Job_Searches WHERE last_used < DATEADD(day, -?, GETDATE()) AND is_saved = 0";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, daysOld);
            ps.executeUpdate();
        }
    }
    
    public int getSearchCountByJobSeeker(int jobSeekerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Job_Searches WHERE job_seeker_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public List<JobSearch> getAdvancedSearches(int jobSeekerId) throws SQLException {
        List<JobSearch> searches = new ArrayList<>();
        String sql = "SELECT * FROM Job_Searches WHERE job_seeker_id = ? AND search_type = 'advanced' ORDER BY created_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    searches.add(mapResultSetToJobSearch(rs));
                }
            }
        }
        return searches;
    }
    
    private JobSearch mapResultSetToJobSearch(ResultSet rs) throws SQLException {
        JobSearch jobSearch = new JobSearch();
        jobSearch.setId(rs.getInt("id"));
        jobSearch.setJobSeekerId(rs.getInt("job_seeker_id"));
        jobSearch.setSearchType(rs.getString("search_type"));
        jobSearch.setKeyword(rs.getString("keyword"));
        jobSearch.setLocation(rs.getString("location"));
        jobSearch.setIndustry(rs.getString("industry"));
        jobSearch.setJobLevel(rs.getString("job_level"));
        jobSearch.setJobType(rs.getString("job_type"));
        jobSearch.setMinSalary(rs.getBigDecimal("min_salary"));
        jobSearch.setMaxSalary(rs.getBigDecimal("max_salary"));
        jobSearch.setMinExperience(rs.getInt("min_experience"));
        jobSearch.setBenefits(rs.getString("benefits"));
        jobSearch.setLanguage(rs.getString("language"));
        jobSearch.setSortBy(rs.getString("sort_by"));
        jobSearch.setSortOrder(rs.getString("sort_order"));
        jobSearch.setIsSaved(rs.getBoolean("is_saved"));
        jobSearch.setSearchName(rs.getString("search_name"));
        jobSearch.setCreatedAt(rs.getTimestamp("created_at"));
        jobSearch.setLastUsed(rs.getTimestamp("last_used"));
        jobSearch.setResultCount(rs.getInt("result_count"));
        return jobSearch;
    }
} 