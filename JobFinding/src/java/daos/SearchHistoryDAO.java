package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import models.SearchHistory;

/**
 * Data Access Object for Search History operations
 * Handles database operations related to job seeker search history
 */
public class SearchHistoryDAO extends DBContext {
    
    private static final Logger LOGGER = Logger.getLogger(SearchHistoryDAO.class.getName());
    
    public SearchHistoryDAO() {
        super();
    }
    
    /**
     * Get search history for a job seeker
     * 
     * @param jobSeekerId The job seeker ID
     * @param limit Maximum number of records to return
     * @return List of search history records
     */
    public List<SearchHistory> getSearchHistoryByJobSeeker(int jobSeekerId, int limit) {
        List<SearchHistory> searchHistory = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Search_History WHERE job_seeker_id = ? ORDER BY search_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ps.setInt(2, jobSeekerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SearchHistory history = new SearchHistory();
                    history.setId(rs.getInt("id"));
                    history.setJobSeekerId(rs.getInt("job_seeker_id"));
                    history.setSearchQuery(rs.getString("search_query"));
                    history.setSearchFilters(rs.getString("search_filters"));
                    history.setSearchDate(rs.getTimestamp("search_date"));
                    searchHistory.add(history);
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting search history for job seeker: " + jobSeekerId, e);
        }
        
        return searchHistory;
    }
    
    /**
     * Add a new search history record
     * 
     * @param searchHistory The search history object to add
     * @return true if successful, false otherwise
     */
    public boolean addSearchHistory(SearchHistory searchHistory) {
        String sql = "INSERT INTO Search_History (job_seeker_id, search_query, search_filters, search_date) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setInt(1, searchHistory.getJobSeekerId());
            ps.setString(2, searchHistory.getSearchQuery());
            ps.setString(3, searchHistory.getSearchFilters());
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding search history", e);
            return false;
        }
    }
    
    /**
     * Get popular search queries (for collaborative filtering)
     * 
     * @param limit Maximum number of queries to return
     * @return List of popular search queries with counts
     */
    public List<String> getPopularSearchQueries(int limit) {
        List<String> popularQueries = new ArrayList<>();
        String sql = "SELECT TOP (?) search_query, COUNT(*) as query_count " +
                    "FROM Search_History " +
                    "WHERE search_query IS NOT NULL AND search_query != '' " +
                    "GROUP BY search_query " +
                    "ORDER BY query_count DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    popularQueries.add(rs.getString("search_query"));
                }
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting popular search queries", e);
        }
        
        return popularQueries;
    }
    
    /**
     * Delete old search history records (cleanup)
     * 
     * @param daysOld Number of days old to delete
     * @return Number of records deleted
     */
    public int deleteOldSearchHistory(int daysOld) {
        String sql = "DELETE FROM Search_History WHERE search_date < DATEADD(day, -?, GETDATE())";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setInt(1, daysOld);
            return ps.executeUpdate();
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting old search history", e);
            return 0;
        }
    }
} 