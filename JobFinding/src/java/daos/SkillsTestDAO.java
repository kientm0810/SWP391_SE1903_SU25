package daos;

import java.sql.*;
import java.util.*;
import models.SkillsTest;
import context.DBContext;

public class SkillsTestDAO extends DBContext {
    
    public void insert(SkillsTest test) throws Exception {
        String sql = "INSERT INTO Skills_Tests (recruitmentProcessId, testType, testName, testUrl, scheduledAt, deadline, completedAt, status, score, result, feedback, testInstructions) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, test.getRecruitmentProcessId());
            ps.setString(2, test.getTestType());
            ps.setString(3, test.getTestName());
            ps.setString(4, test.getTestUrl());
            ps.setTimestamp(5, test.getScheduledAt());
            ps.setTimestamp(6, test.getDeadline());
            ps.setTimestamp(7, test.getCompletedAt());
            ps.setString(8, test.getStatus());
            ps.setInt(9, test.getScore());
            ps.setString(10, test.getResult());
            ps.setString(11, test.getFeedback());
            ps.setString(12, test.getTestInstructions());
            ps.executeUpdate();
        }
    }
    
    public SkillsTest getById(int id) throws Exception {
        String sql = "SELECT * FROM Skills_Tests WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        }
        return null;
    }
    
    public List<SkillsTest> getByRecruitmentProcessId(int processId) throws Exception {
        List<SkillsTest> list = new ArrayList<>();
        String sql = "SELECT * FROM Skills_Tests WHERE recruitmentProcessId=? ORDER BY scheduledAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, processId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<SkillsTest> getByStatus(String status) throws Exception {
        List<SkillsTest> list = new ArrayList<>();
        String sql = "SELECT * FROM Skills_Tests WHERE status=? ORDER BY scheduledAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<SkillsTest> getByTestType(String testType) throws Exception {
        List<SkillsTest> list = new ArrayList<>();
        String sql = "SELECT * FROM Skills_Tests WHERE testType=? ORDER BY scheduledAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, testType);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<SkillsTest> getExpiredTests() throws Exception {
        List<SkillsTest> list = new ArrayList<>();
        String sql = "SELECT * FROM Skills_Tests WHERE deadline < CURRENT_TIMESTAMP AND status = 'scheduled'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<SkillsTest> getAll() throws Exception {
        List<SkillsTest> list = new ArrayList<>();
        String sql = "SELECT * FROM Skills_Tests ORDER BY scheduledAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public boolean update(SkillsTest test) throws Exception {
        String sql = "UPDATE Skills_Tests SET testType=?, testName=?, testUrl=?, scheduledAt=?, deadline=?, completedAt=?, status=?, score=?, result=?, feedback=?, testInstructions=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, test.getTestType());
            ps.setString(2, test.getTestName());
            ps.setString(3, test.getTestUrl());
            ps.setTimestamp(4, test.getScheduledAt());
            ps.setTimestamp(5, test.getDeadline());
            ps.setTimestamp(6, test.getCompletedAt());
            ps.setString(7, test.getStatus());
            ps.setInt(8, test.getScore());
            ps.setString(9, test.getResult());
            ps.setString(10, test.getFeedback());
            ps.setString(11, test.getTestInstructions());
            ps.setInt(12, test.getId());
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean updateStatus(int testId, String status) throws Exception {
        String sql = "UPDATE Skills_Tests SET status=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, testId);
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean updateResult(int testId, int score, String result, String feedback) throws Exception {
        String sql = "UPDATE Skills_Tests SET score=?, result=?, feedback=?, completedAt=CURRENT_TIMESTAMP, status='completed' WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, score);
            ps.setString(2, result);
            ps.setString(3, feedback);
            ps.setInt(4, testId);
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean delete(int id) throws Exception {
        String sql = "DELETE FROM Skills_Tests WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    
    private SkillsTest map(ResultSet rs) throws SQLException {
        SkillsTest test = new SkillsTest();
        test.setId(rs.getInt("id"));
        test.setRecruitmentProcessId(rs.getInt("recruitmentProcessId"));
        test.setTestType(rs.getString("testType"));
        test.setTestName(rs.getString("testName"));
        test.setTestUrl(rs.getString("testUrl"));
        test.setScheduledAt(rs.getTimestamp("scheduledAt"));
        test.setDeadline(rs.getTimestamp("deadline"));
        test.setCompletedAt(rs.getTimestamp("completedAt"));
        test.setStatus(rs.getString("status"));
        test.setScore(rs.getInt("score"));
        test.setResult(rs.getString("result"));
        test.setFeedback(rs.getString("feedback"));
        test.setTestInstructions(rs.getString("testInstructions"));
        return test;
    }
} 