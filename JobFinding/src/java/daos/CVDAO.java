package daos;

import context.DBContext;
import models.CV;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CVDAO extends DBContext {
    private static final Logger logger = LoggerFactory.getLogger(CVDAO.class);
    protected Connection connection; // Define connection field

    public CVDAO() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=project_SWP391", "hungld", "12345");
            }
        } catch (SQLException e) {
            logger.error("Failed to initialize connection", e);
        }
    }
    public boolean createCV(CV cv) {
        String cvSql = "INSERT INTO Job_Seeker_CVs (job_seeker_id, title, summary, education, experience, created_at, updated_at, is_active) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
        String skillSql = "INSERT INTO CV_Skills (cv_id, skill_name, proficiency_level) VALUES (?, ?, ?)";
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(cvSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, cv.getJobSeekerId());
                ps.setString(2, cv.getTitle());
                ps.setString(3, cv.getSummary());
                ps.setString(4, cv.getEducation());
                ps.setString(5, cv.getExperience());
                ps.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
                ps.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
                ps.executeUpdate();

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int cvId = rs.getInt(1);
                    cv.setId(cvId);
                    try (PreparedStatement skillPs = conn.prepareStatement(skillSql)) {
                        for (String skill : cv.getSkills()) {
                            skillPs.setInt(1, cvId);
                            skillPs.setString(2, skill.trim());
                            skillPs.setString(3, "intermediate");
                            skillPs.addBatch();
                        }
                        skillPs.executeBatch();
                    }
                    conn.commit();
                    return true;
                }
            } catch (SQLException e) {
                conn.rollback();
                logger.error("Error creating CV", e);
            }
        } catch (SQLException e) {
            logger.error("Connection error", e);
        }
        return false;
    }

    public boolean updateCV(CV cv) {
        String cvSql = "UPDATE Job_Seeker_CVs SET title = ?, summary = ?, education = ?, experience = ?, updated_at = ? WHERE id = ? AND job_seeker_id = ?";
        String deleteSkillsSql = "DELETE FROM CV_Skills WHERE cv_id = ?";
        String insertSkillSql = "INSERT INTO CV_Skills (cv_id, skill_name, proficiency_level) VALUES (?, ?, ?)";
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(cvSql)) {
                ps.setString(1, cv.getTitle());
                ps.setString(2, cv.getSummary());
                ps.setString(3, cv.getEducation());
                ps.setString(4, cv.getExperience());
                ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
                ps.setInt(6, cv.getId());
                ps.setInt(7, cv.getJobSeekerId());
                ps.executeUpdate();

                try (PreparedStatement deletePs = conn.prepareStatement(deleteSkillsSql)) {
                    deletePs.setInt(1, cv.getId());
                    deletePs.executeUpdate();
                }

                try (PreparedStatement skillPs = conn.prepareStatement(insertSkillSql)) {
                    for (String skill : cv.getSkills()) {
                        skillPs.setInt(1, cv.getId());
                        skillPs.setString(2, skill.trim());
                        skillPs.setString(3, "intermediate");
                        skillPs.addBatch();
                    }
                    skillPs.executeBatch();
                }
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                logger.error("Error updating CV", e);
            }
        } catch (SQLException e) {
            logger.error("Connection error", e);
        }
        return false;
    }

    public boolean deleteCV(int cvId, int jobSeekerId) {
        String sql = "DELETE FROM Job_Seeker_CVs WHERE id = ? AND job_seeker_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, jobSeekerId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            logger.error("Error deleting CV", e);
        }
        return false;
    }

    public List<CV> searchCVs(int jobSeekerId, String keyword) {
        List<CV> cvs = new ArrayList<>();
        String sql = "SELECT * FROM Job_Seeker_CVs WHERE job_seeker_id = ? AND is_active = 1 " +
                     "AND (title LIKE ? OR summary LIKE ? OR education LIKE ? OR experience LIKE ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchTerm = "%" + (keyword != null ? keyword : "") + "%";
            ps.setInt(1, jobSeekerId);
            ps.setString(2, searchTerm);
            ps.setString(3, searchTerm);
            ps.setString(4, searchTerm);
            ps.setString(5, searchTerm);
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
                cv.setSkills(getSkillsForCV(cv.getId(), conn));
                cvs.add(cv);
            }
        } catch (SQLException e) {
            logger.error("Error searching CVs", e);
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
}