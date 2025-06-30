package daos;

import java.sql.*;
import java.util.*;
import models.ScreeningResult;
import context.DBContext;

public class ScreeningResultDAO extends DBContext {
    
    public void insert(ScreeningResult result) throws Exception {
        String sql = "INSERT INTO Screening_Results (recruitmentProcessId, screeningType, result, score, feedback, reviewerName, reviewedAt, criteria) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, result.getRecruitmentProcessId());
            ps.setString(2, result.getScreeningType());
            ps.setString(3, result.getResult());
            ps.setInt(4, result.getScore());
            ps.setString(5, result.getFeedback());
            ps.setString(6, result.getReviewerName());
            ps.setTimestamp(7, result.getReviewedAt());
            ps.setString(8, result.getCriteria());
            ps.executeUpdate();
        }
    }
    
    public ScreeningResult getById(int id) throws Exception {
        String sql = "SELECT * FROM Screening_Results WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        }
        return null;
    }
    
    public List<ScreeningResult> getByRecruitmentProcessId(int processId) throws Exception {
        List<ScreeningResult> list = new ArrayList<>();
        String sql = "SELECT * FROM Screening_Results WHERE recruitmentProcessId=? ORDER BY reviewedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, processId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<ScreeningResult> getByResult(String result) throws Exception {
        List<ScreeningResult> list = new ArrayList<>();
        String sql = "SELECT * FROM Screening_Results WHERE result=? ORDER BY reviewedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, result);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<ScreeningResult> getByScreeningType(String screeningType) throws Exception {
        List<ScreeningResult> list = new ArrayList<>();
        String sql = "SELECT * FROM Screening_Results WHERE screeningType=? ORDER BY reviewedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, screeningType);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<ScreeningResult> getAll() throws Exception {
        List<ScreeningResult> list = new ArrayList<>();
        String sql = "SELECT * FROM Screening_Results ORDER BY reviewedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public boolean update(ScreeningResult result) throws Exception {
        String sql = "UPDATE Screening_Results SET screeningType=?, result=?, score=?, feedback=?, reviewerName=?, reviewedAt=?, criteria=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, result.getScreeningType());
            ps.setString(2, result.getResult());
            ps.setInt(3, result.getScore());
            ps.setString(4, result.getFeedback());
            ps.setString(5, result.getReviewerName());
            ps.setTimestamp(6, result.getReviewedAt());
            ps.setString(7, result.getCriteria());
            ps.setInt(8, result.getId());
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean delete(int id) throws Exception {
        String sql = "DELETE FROM Screening_Results WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    
    private ScreeningResult map(ResultSet rs) throws SQLException {
        ScreeningResult result = new ScreeningResult();
        result.setId(rs.getInt("id"));
        result.setRecruitmentProcessId(rs.getInt("recruitmentProcessId"));
        result.setScreeningType(rs.getString("screeningType"));
        result.setResult(rs.getString("result"));
        result.setScore(rs.getInt("score"));
        result.setFeedback(rs.getString("feedback"));
        result.setReviewerName(rs.getString("reviewerName"));
        result.setReviewedAt(rs.getTimestamp("reviewedAt"));
        result.setCriteria(rs.getString("criteria"));
        return result;
    }
} 