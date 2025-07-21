package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.Application;
import models.CVTemplate;
import models.JobSeeker;
import models.Posts;

public class ApplicationDAO extends DBContext {
    
    public int getNewApplicationsCount(int recruiterId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Applications a " +
                    "INNER JOIN Posts p ON a.job_listing_id = p.id " +
                    "WHERE p.user_id = ? AND a.status = 'new'";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public Application getApplicationById(int applicationId, int recruiterId) throws SQLException {
        String sql = "SELECT a.id as app_id, a.status, a.applied_at, a.cv_file, " +
                     "p.id as post_id, p.title, " +
                     "js.id as seeker_id, js.full_name, js.email, js.phone, js.profile_picture " +
                     "FROM Applications a " +
                     "INNER JOIN Posts p ON a.job_listing_id = p.id " +
                     "INNER JOIN Job_Seekers js ON a.job_seeker_id = js.id " +
                     "WHERE a.id = ? AND p.user_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ps.setInt(2, recruiterId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("app_id"));
                app.setStatus(rs.getString("status"));
                app.setCreatedAt(rs.getTimestamp("applied_at"));
                app.setCvFile(rs.getString("cv_file"));
                
                Posts post = new Posts();
                post.setId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                app.setPost(post);
                
                JobSeeker jobseeker = new JobSeeker();
                jobseeker.setId(rs.getInt("seeker_id"));
                jobseeker.setFullName(rs.getString("full_name"));
                jobseeker.setEmail(rs.getString("email"));
                jobseeker.setPhone(rs.getString("phone"));
                jobseeker.setProfilePicture(rs.getString("profile_picture"));
                app.setJobseeker(jobseeker);
                
                return app;
            }
        }
        return null;
    }
    
    public Application getApplicationByIdForJobSeeker(int applicationId, int jobSeekerId) throws SQLException {
        String sql = "SELECT a.*, p.title, p.company_name, p.id as post_id FROM Applications a " +
                    "INNER JOIN Posts p ON a.job_listing_id = p.id " +
                    "WHERE a.id = ? AND a.job_seeker_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ps.setInt(2, jobSeekerId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("id"));
                app.setStatus(rs.getString("status"));
                app.setCreatedAt(rs.getTimestamp("applied_at"));
                app.setCvFile(rs.getString("cv_file"));
                
                Posts post = new Posts();
                post.setId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setCompanyName(rs.getString("company_name"));
                app.setPost(post);
                
                return app;
            }
        }
        return null;
    }
    
    public int insertApplication(Application app) throws SQLException {
        String sql = "INSERT INTO Applications (job_listing_id, job_seeker_id, cv_id, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, app.getPostId());
            ps.setInt(2, app.getJobSeekerId());
            ps.setInt(3, app.getCvId());
            ps.setString(4, app.getStatus());
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating application failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating application failed, no ID obtained.");
                }
            }
        }
    }

    public boolean saveApplicationAndCreateProcess(Application application, int recruiterId, int hrId) {
        String insertAppSql = "INSERT INTO Applications (job_listing_id, job_seeker_id, cv_file, status, applied_at) VALUES (?, ?, ?, ?, GETDATE())";
        String insertProcessSql = "INSERT INTO Recruitment_Process (applicationId, currentStage, status, notes, assignedRecruiterId, assignedHrId) VALUES (?, ?, ?, ?, ?, ?)";
        CVTemplateDAO cvDAO = new CVTemplateDAO();

        try {
            CVTemplate cv = cvDAO.getCVById(application.getCvId(), application.getJobSeekerId());
            if (cv == null) {
                return false; 
            }
            String cvFilePath = cv.getPdfFilePath(); 

            connection.setAutoCommit(false);

            int applicationId = 0;
            try (PreparedStatement psApp = connection.prepareStatement(insertAppSql, Statement.RETURN_GENERATED_KEYS)) {
                psApp.setInt(1, application.getPostId());
                psApp.setInt(2, application.getJobSeekerId());
                psApp.setString(3, cvFilePath);
                psApp.setString(4, application.getStatus());
                
                int affectedRows = psApp.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating application failed, no rows affected.");
                }

                try (ResultSet generatedKeys = psApp.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        applicationId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Creating application failed, no ID obtained.");
                    }
                }
            }

            try (PreparedStatement psProcess = connection.prepareStatement(insertProcessSql)) {
                psProcess.setInt(1, applicationId);
                psProcess.setString(2, "initial_screening");
                psProcess.setString(3, "in_progress");
                psProcess.setString(4, "Ứng viên vừa ứng tuyển");
                psProcess.setInt(5, recruiterId);
                psProcess.setInt(6, hrId);
                psProcess.executeUpdate();
            }

            connection.commit();
            return true;

        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Get applications for a jobseeker with pagination, filtering and search
     */
    public List<Application> getApplicationsByJobSeeker(int jobSeekerId, int page, int pageSize, 
            String status, String keyword, String sortBy) throws SQLException {
        List<Application> applications = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT a.id AS application_id, a.status, a.applied_at, a.cv_file, a.cover_letter, ");
        sql.append("p.id AS post_id, p.title, p.company_name, p.company_logo, p.location, p.salary ");
        sql.append("FROM Applications a ");
        sql.append("INNER JOIN Posts p ON a.job_listing_id = p.id ");
        sql.append("WHERE a.job_seeker_id = ? ");
        
        List<Object> params = new ArrayList<>();
        params.add(jobSeekerId);
        
        if (status != null && !status.trim().isEmpty() && !"all".equals(status)) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR p.company_name LIKE ? OR p.location LIKE ?) ");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        // Add sorting logic based on sortBy parameter
        
        sql.append("ORDER BY a.applied_at DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setStatus(rs.getString("status"));
                app.setCreatedAt(rs.getTimestamp("applied_at"));
                app.setCvFile(rs.getString("cv_file"));
                
                Posts post = new Posts();
                post.setId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setCompanyName(rs.getString("company_name"));
                post.setCompanyLogo(rs.getString("company_logo"));
                post.setLocation(rs.getString("location"));
                post.setSalary(rs.getString("salary"));
                app.setPost(post);
                
                applications.add(app);
            }
        }
        return applications;
    }
     
    public int countApplicationsByJobSeeker(int jobSeekerId, String status, String keyword) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM Applications a ");
        sql.append("INNER JOIN Posts p ON a.job_listing_id = p.id ");
        sql.append("WHERE a.job_seeker_id = ? ");
        
        List<Object> params = new ArrayList<>();
        params.add(jobSeekerId);
        
        if (status != null && !status.trim().isEmpty() && !"all".equals(status)) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR p.company_name LIKE ? OR p.location LIKE ?) ");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public List<Application> getApplicationsByRecruiter(int recruiterId, int page, int pageSize, String status, String keyword, String sortBy) throws SQLException {
        List<Application> applications = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT a.id as application_id, a.status, a.applied_at, a.cv_file, ")
                .append("p.id as post_id, p.title, p.company_name, ")
                .append("js.id as job_seeker_id, js.full_name as job_seeker_name, js.email as job_seeker_email, js.phone as job_seeker_phone ")
                .append("FROM Applications a ")
                .append("JOIN Posts p ON a.job_listing_id = p.id ")
                .append("JOIN Job_Seekers js ON a.job_seeker_id = js.id ")
                .append("WHERE p.user_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        if (status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status)) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR js.full_name LIKE ? OR js.email LIKE ?) ");
            String searchPattern = "%" + keyword + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        sql.append("ORDER BY a.applied_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setStatus(rs.getString("status"));
                app.setCreatedAt(rs.getTimestamp("applied_at"));
                app.setCvFile(rs.getString("cv_file"));

                Posts post = new Posts();
                post.setId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setCompanyName(rs.getString("company_name"));
                app.setPost(post);

                JobSeeker jobSeeker = new JobSeeker();
                jobSeeker.setId(rs.getInt("job_seeker_id"));
                jobSeeker.setFullName(rs.getString("job_seeker_name"));
                jobSeeker.setEmail(rs.getString("job_seeker_email"));
                jobSeeker.setPhone(rs.getString("job_seeker_phone"));
                app.setJobseeker(jobSeeker);

                applications.add(app);
            }
        }
        return applications;
    }

    public int countApplicationsByRecruiter(int recruiterId, String status, String keyword) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Applications a ")
                .append("JOIN Posts p ON a.job_listing_id = p.id ")
                .append("JOIN Job_Seekers js ON a.job_seeker_id = js.id ")
                .append("WHERE p.user_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        if (status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status)) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR js.full_name LIKE ? OR js.email LIKE ?) ");
            String searchPattern = "%" + keyword + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public boolean updateApplicationStatusByJobSeeker(int applicationId, String newStatus, int jobSeekerId) throws SQLException {
        String sql = "UPDATE Applications SET status = ? WHERE id = ? AND job_seeker_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, applicationId);
            ps.setInt(3, jobSeekerId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }

    public boolean updateApplicationStatusByRecruiter(int applicationId, String newStatus, int recruiterId) throws SQLException {
        String sql = "UPDATE Applications SET status = ? WHERE id = ? AND job_listing_id IN (SELECT id FROM Posts WHERE user_id = ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, applicationId);
            ps.setInt(3, recruiterId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }
} 