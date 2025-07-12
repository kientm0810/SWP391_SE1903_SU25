package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.RecruitmentProcess;

public class RecruitmentProcessDAO extends DBContext {
    
    public void insert(RecruitmentProcess process) throws Exception {
        String sql = "INSERT INTO Recruitment_Process (applicationId, currentStage, status, createdAt, updatedAt, notes, assignedHrId, assignedRecruiterId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, process.getApplicationId());
            ps.setString(2, process.getCurrentStage());
            ps.setString(3, process.getStatus());
            ps.setTimestamp(4, process.getCreatedAt());
            ps.setTimestamp(5, process.getUpdatedAt());
            ps.setString(6, process.getNotes());
            ps.setInt(7, process.getAssignedHrId());
            ps.setInt(8, process.getAssignedRecruiterId());
            ps.executeUpdate();
        }
    }
    
    public void update(RecruitmentProcess process) throws Exception {
        String sql = "UPDATE Recruitment_Process SET currentStage=?, status=?, updatedAt=?, notes=?, assignedHrId=?, assignedRecruiterId=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, process.getCurrentStage());
            ps.setString(2, process.getStatus());
            ps.setTimestamp(3, process.getUpdatedAt());
            ps.setString(4, process.getNotes());
            ps.setInt(5, process.getAssignedHrId());
            ps.setInt(6, process.getAssignedRecruiterId());
            ps.setInt(7, process.getId());
            ps.executeUpdate();
        }
    }
    
    public RecruitmentProcess getById(int id) throws Exception {
        String sql = "SELECT * FROM Recruitment_Process WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        }
        return null;
    }
    
    public RecruitmentProcess getByApplicationId(int applicationId) throws Exception {
        String sql = "SELECT * FROM Recruitment_Process WHERE applicationId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return map(rs);
            }
        }
        return null;
    }
    
    public List<RecruitmentProcess> getByStatus(String status) throws Exception {
        List<RecruitmentProcess> list = new ArrayList<>();
        String sql = "SELECT * FROM Recruitment_Process WHERE status=? ORDER BY updatedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<RecruitmentProcess> getByStage(String stage) throws Exception {
        List<RecruitmentProcess> list = new ArrayList<>();
        String sql = "SELECT * FROM Recruitment_Process WHERE currentStage=? ORDER BY updatedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, stage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<RecruitmentProcess> getByHrId(int hrId) throws Exception {
        List<RecruitmentProcess> list = new ArrayList<>();
        String sql = "SELECT * FROM Recruitment_Process WHERE assignedHrId=? ORDER BY updatedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, hrId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public List<RecruitmentProcess> getAll() throws Exception {
        List<RecruitmentProcess> list = new ArrayList<>();
        String sql = "SELECT * FROM Recruitment_Process ORDER BY updatedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    
    public boolean updateStage(int processId, String newStage, String notes) throws Exception {
        String sql = "UPDATE Recruitment_Process SET currentStage=?, updatedAt=CURRENT_TIMESTAMP, notes=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStage);
            ps.setString(2, notes);
            ps.setInt(3, processId);
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean updateStatus(int processId, String newStatus, String notes) throws Exception {
        String sql = "UPDATE Recruitment_Process SET status=?, updatedAt=CURRENT_TIMESTAMP, notes=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, notes);
            ps.setInt(3, processId);
            return ps.executeUpdate() > 0;
        }
    }
    
    private RecruitmentProcess map(ResultSet rs) throws SQLException {
        RecruitmentProcess p = new RecruitmentProcess();
        p.setId(rs.getInt("id"));
        p.setApplicationId(rs.getInt("applicationId"));
        p.setCurrentStage(rs.getString("currentStage"));
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("createdAt"));
        p.setUpdatedAt(rs.getTimestamp("updatedAt"));
        p.setNotes(rs.getString("notes"));
        p.setAssignedHrId(rs.getInt("assignedHrId"));
        p.setAssignedRecruiterId(rs.getInt("assignedRecruiterId"));
        return p;
    }
} 