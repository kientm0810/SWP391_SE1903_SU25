/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import context.DBContext;
import models.CV;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CVDAO extends DBContext {
    private static final Logger logger = LoggerFactory.getLogger(CVDAO.class);

    public boolean createCV(CV cv) {
        String cvSql = "INSERT INTO Job_Seeker_CVs (job_seeker_id, title, summary, education, experience, created_at, updated_at) " +
                       "VALUES (?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        String skillSql = "INSERT INTO CV_Skills (cv_id, skill_name, proficiency_level) VALUES (?, ?, 'intermediate')";
        try (Connection conn = getConnection();
             PreparedStatement cvPs = conn.prepareStatement(cvSql, Statement.RETURN_GENERATED_KEYS)) {
            cvPs.setInt(1, cv.getJobSeekerId());
            cvPs.setString(2, cv.getTitle());
            cvPs.setString(3, cv.getSummary());
            cvPs.setString(4, cv.getEducation());
            cvPs.setString(5, cv.getExperience());
            int affectedRows = cvPs.executeUpdate();
            if (affectedRows == 0) {
                return false;
            }
            try (ResultSet generatedKeys = cvPs.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int cvId = generatedKeys.getInt(1);
                    if (cv.getSkills() != null) {
                        try (PreparedStatement skillPs = conn.prepareStatement(skillSql)) {
                            for (String skill : cv.getSkills()) {
                                skillPs.setInt(1, cvId);
                                skillPs.setString(2, skill);
                                skillPs.addBatch();
                            }
                            skillPs.executeBatch();
                        }
                    }
                }
            }
            return true;
        } catch (SQLException e) {
            logger.error("Lỗi khi tạo CV cho job_seeker_id: {}", cv.getJobSeekerId(), e);
            return false;
        }
    }

    public boolean updateCV(CV cv) {
        String cvSql = "UPDATE Job_Seeker_CVs SET title = ?, summary = ?, education = ?, experience = ?, updated_at = GETDATE() WHERE id = ? AND job_seeker_id = ?";
        String deleteSkillsSql = "DELETE FROM CV_Skills WHERE cv_id = ?";
        String insertSkillSql = "INSERT INTO CV_Skills (cv_id, skill_name, proficiency_level) VALUES (?, ?, 'intermediate')";
        try (Connection conn = getConnection();
             PreparedStatement cvPs = conn.prepareStatement(cvSql)) {
            cvPs.setString(1, cv.getTitle());
            cvPs.setString(2, cv.getSummary());
            cvPs.setString(3, cv.getEducation());
            cvPs.setString(4, cv.getExperience());
            cvPs.setInt(5, cv.getId());
            cvPs.setInt(6, cv.getJobSeekerId());
            int affectedRows = cvPs.executeUpdate();
            if (affectedRows == 0) {
                return false;
            }
            // Xóa kỹ năng cũ
            try (PreparedStatement deletePs = conn.prepareStatement(deleteSkillsSql)) {
                deletePs.setInt(1, cv.getId());
                deletePs.executeUpdate();
            }
            // Thêm kỹ năng mới
            if (cv.getSkills() != null) {
                try (PreparedStatement insertPs = conn.prepareStatement(insertSkillSql)) {
                    for (String skill : cv.getSkills()) {
                        insertPs.setInt(1, cv.getId());
                        insertPs.setString(2, skill);
                        insertPs.addBatch();
                    }
                    insertPs.executeBatch();
                }
            }
            return true;
        } catch (SQLException e) {
            logger.error("Lỗi khi cập nhật CV id: {}", cv.getId(), e);
            return false;
        }
    }

    public boolean deleteCV(int cvId, int jobSeekerId) {
        String skillSql = "DELETE FROM CV_Skills WHERE cv_id = ?";
        String cvSql = "DELETE FROM Job_Seeker_CVs WHERE id = ? AND job_seeker_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement skillPs = conn.prepareStatement(skillSql);
             PreparedStatement cvPs = conn.prepareStatement(cvSql)) {
            skillPs.setInt(1, cvId);
            skillPs.executeUpdate();
            cvPs.setInt(1, cvId);
            cvPs.setInt(2, jobSeekerId);
            return cvPs.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Lỗi khi xóa CV id: {} cho job_seeker_id: {}", cvId, jobSeekerId, e);
            return false;
        }
    }

    public List<CV> searchCVs(int jobSeekerId, String keyword) {
        List<CV> cvs = new ArrayList<>();
        String sql = "SELECT c.id, c.job_seeker_id, c.title, c.summary, c.education, c.experience, c.created_at, c.updated_at " +
                     "FROM Job_Seeker_CVs c " +
                     "LEFT JOIN CV_Skills s ON c.id = s.cv_id " +
                     "WHERE c.job_seeker_id = ? AND (c.title LIKE ? OR s.skill_name LIKE ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setInt(1, jobSeekerId);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CV cv = new CV();
                cv.setId(rs.getInt("id"));
                cv.setJobSeekerId(rs.getInt("job_seeker_id"));
                cv.setTitle(rs.getString("title"));
                cv.setSummary(rs.getString("summary"));
                cv.setEducation(rs.getString("education"));
                cv.setExperience(rs.getString("experience"));
                cv.setCreatedAt(rs.getTimestamp("created_at"));
                cv.setUpdatedAt(rs.getTimestamp("updated_at"));
                // Lấy kỹ năng
                cv.setSkills(getSkillsForCV(cv.getId(), conn));
                cvs.add(cv);
            }
        } catch (SQLException e) {
            logger.error("Lỗi khi tìm kiếm CV cho job_seeker_id: {}, keyword: {}", jobSeekerId, keyword, e);
        }
        return cvs;
    }

    private List<String> getSkillsForCV(int cvId, Connection conn) throws SQLException {
        List<String> skills = new ArrayList<>();
        String sql = "SELECT skill_name FROM CV_Skills WHERE cv_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                skills.add(rs.getString("skill_name"));
            }
        }
        return skills;
    }

    private Connection getConnection() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
