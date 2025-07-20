package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;

public class SearchSuggestionDAO {
    
    public void updateKeywordFrequency(String keyword, String suggestionType) throws SQLException {
        // First try to update existing record
        String updateSql = "UPDATE Search_Suggestions SET frequency = frequency + 1, last_used = GETDATE() " +
                          "WHERE keyword = ? AND suggestion_type = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(updateSql)) {
            
            ps.setString(1, keyword);
            ps.setString(2, suggestionType);
            
            int updatedRows = ps.executeUpdate();
            
            // If no rows were updated, insert new record
            if (updatedRows == 0) {
                String insertSql = "INSERT INTO Search_Suggestions (keyword, suggestion_type, frequency, last_used, created_at) " +
                                 "VALUES (?, ?, 1, GETDATE(), GETDATE())";
                
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                    insertPs.setString(1, keyword);
                    insertPs.setString(2, suggestionType);
                    insertPs.executeUpdate();
                }
            }
        }
    }
    
    public List<String> getPopularKeywords(int limit) throws SQLException {
        List<String> keywords = new ArrayList<>();
        String sql = "SELECT keyword FROM Search_Suggestions " +
                    "WHERE suggestion_type = 'job_title' AND frequency > 1 " +
                    "ORDER BY frequency DESC, last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    keywords.add(rs.getString("keyword"));
                }
            }
        }
        return keywords;
    }
    
    public List<String> getPopularLocations(int limit) throws SQLException {
        List<String> locations = new ArrayList<>();
        String sql = "SELECT keyword FROM Search_Suggestions " +
                    "WHERE suggestion_type = 'location' AND frequency > 1 " +
                    "ORDER BY frequency DESC, last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    locations.add(rs.getString("keyword"));
                }
            }
        }
        return locations;
    }
    
    public List<String> getPopularIndustries(int limit) throws SQLException {
        List<String> industries = new ArrayList<>();
        String sql = "SELECT keyword FROM Search_Suggestions " +
                    "WHERE suggestion_type = 'industry' AND frequency > 1 " +
                    "ORDER BY frequency DESC, last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    industries.add(rs.getString("keyword"));
                }
            }
        }
        return industries;
    }
    
    public List<String> getSuggestionsByType(String suggestionType, int limit) throws SQLException {
        List<String> suggestions = new ArrayList<>();
        String sql = "SELECT keyword FROM Search_Suggestions " +
                    "WHERE suggestion_type = ? AND frequency > 0 " +
                    "ORDER BY frequency DESC, last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, suggestionType);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    suggestions.add(rs.getString("keyword"));
                }
            }
        }
        return suggestions;
    }
    
    public List<String> searchSuggestions(String query, String suggestionType, int limit) throws SQLException {
        List<String> suggestions = new ArrayList<>();
        String sql = "SELECT keyword FROM Search_Suggestions " +
                    "WHERE suggestion_type = ? AND keyword LIKE ? " +
                    "ORDER BY frequency DESC, last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, suggestionType);
            ps.setString(2, "%" + query + "%");
            ps.setInt(3, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    suggestions.add(rs.getString("keyword"));
                }
            }
        }
        return suggestions;
    }
    
    public void addSuggestion(String keyword, String suggestionType) throws SQLException {
        // First try to update existing record
        String updateSql = "UPDATE Search_Suggestions SET last_used = GETDATE() " +
                          "WHERE keyword = ? AND suggestion_type = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(updateSql)) {
            
            ps.setString(1, keyword);
            ps.setString(2, suggestionType);
            
            int updatedRows = ps.executeUpdate();
            
            // If no rows were updated, insert new record
            if (updatedRows == 0) {
                String insertSql = "INSERT INTO Search_Suggestions (keyword, suggestion_type, frequency, last_used, created_at) " +
                                 "VALUES (?, ?, 1, GETDATE(), GETDATE())";
                
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                    insertPs.setString(1, keyword);
                    insertPs.setString(2, suggestionType);
                    insertPs.executeUpdate();
                }
            }
        }
    }
    
    public void deleteOldSuggestions(int daysOld) throws SQLException {
        String sql = "DELETE FROM Search_Suggestions WHERE last_used < DATEADD(day, -?, GETDATE()) AND frequency <= 1";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, daysOld);
            ps.executeUpdate();
        }
    }
    
    public int getSuggestionCount(String suggestionType) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Search_Suggestions WHERE suggestion_type = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, suggestionType);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public List<String> getRecentSuggestions(int jobSeekerId, int limit) throws SQLException {
        List<String> suggestions = new ArrayList<>();
        String sql = "SELECT DISTINCT keyword FROM Job_Searches " +
                    "WHERE job_seeker_id = ? AND keyword IS NOT NULL " +
                    "ORDER BY last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    suggestions.add(rs.getString("keyword"));
                }
            }
        }
        return suggestions;
    }
    
    public List<String> getRecentLocations(int jobSeekerId, int limit) throws SQLException {
        List<String> locations = new ArrayList<>();
        String sql = "SELECT DISTINCT location FROM Job_Searches " +
                    "WHERE job_seeker_id = ? AND location IS NOT NULL " +
                    "ORDER BY last_used DESC LIMIT ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobSeekerId);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    locations.add(rs.getString("location"));
                }
            }
        }
        return locations;
    }
} 