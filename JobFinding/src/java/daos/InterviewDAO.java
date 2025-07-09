package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.Interview;

public class InterviewDAO extends DBContext {
    public boolean insertInterview(Interview interview) {
        String sql = "INSERT INTO Interview (application_id, interviewer_id, time, location, round, status, result, note) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, interview.getApplicationId());
            ps.setInt(2, interview.getInterviewerId());
            ps.setTimestamp(3, Timestamp.valueOf(interview.getTime()));
            ps.setString(4, interview.getLocation());
            ps.setString(5, interview.getRound());
            ps.setString(6, interview.getStatus());
            ps.setString(7, interview.getResult());
            ps.setString(8, interview.getNote());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Interview> getInterviewsByApplicationId(int applicationId) {
        List<Interview> list = new ArrayList<>();
        String sql = "SELECT * FROM Interview WHERE application_id = ? ORDER BY time DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Interview iv = new Interview();
                iv.setId(rs.getInt("id"));
                iv.setApplicationId(rs.getInt("application_id"));
                iv.setInterviewerId(rs.getInt("interviewer_id"));
                iv.setTime(rs.getTimestamp("time").toLocalDateTime());
                iv.setLocation(rs.getString("location"));
                iv.setRound(rs.getString("round"));
                iv.setStatus(rs.getString("status"));
                iv.setResult(rs.getString("result"));
                iv.setNote(rs.getString("note"));
                list.add(iv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Interview> getInterviewsByInterviewerId(int interviewerId) {
        List<Interview> list = new ArrayList<>();
        String sql = "SELECT * FROM Interview WHERE interviewer_id = ? ORDER BY time DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, interviewerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Interview iv = new Interview();
                iv.setId(rs.getInt("id"));
                iv.setApplicationId(rs.getInt("application_id"));
                iv.setInterviewerId(rs.getInt("interviewer_id"));
                iv.setTime(rs.getTimestamp("time").toLocalDateTime());
                iv.setLocation(rs.getString("location"));
                iv.setRound(rs.getString("round"));
                iv.setStatus(rs.getString("status"));
                iv.setResult(rs.getString("result"));
                iv.setNote(rs.getString("note"));
                list.add(iv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
} 