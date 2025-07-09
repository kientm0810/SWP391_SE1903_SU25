package daos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.Application;
<<<<<<< HEAD
import utils.JavaMail;

public class ApplicationDAO extends DBContext {
    
    public List<Application> getRecentApplications(int recruiterId, int limit) throws SQLException {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, j.company_name, js.full_name, js.email FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_listing_id = j.id " +
                    "INNER JOIN Job_Seekers js ON a.job_seeker_id = js.id " +
                    "WHERE j.recruiter_id = ? " +
                    "ORDER BY a.created_at DESC LIMIT ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("a.id"));
                app.setStatus(rs.getString("a.status"));
                app.setJobListingId(rs.getInt("a.job_listing_id"));
                app.setJobSeekerId(rs.getInt("a.job_seeker_id"));
                app.setCvFile(rs.getString("a.cv_file"));
                app.setCoverLetter(rs.getString("a.cover_letter"));
                applications.add(app);
            }
        }
        return applications;
    }
    
    public int getTotalApplicationsCount(int recruiterId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_id = j.id " +
                    "WHERE j.recruiter_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
=======
import models.JobSeeker;
import models.Posts;
import models.CVTemplate;

public class ApplicationDAO extends DBContext {
    
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
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
    
    public boolean updateApplicationStatus(int applicationId, String status, int recruiterId) throws SQLException {
<<<<<<< HEAD
        String sql = "UPDATE Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_listing_id = j.id " +
                    "SET a.status = ? " +
                    "WHERE a.id = ? AND j.recruiter_id = ?";
=======
        String sql = "UPDATE Applications SET status = ? WHERE id = ? AND job_listing_id IN (SELECT id FROM Posts WHERE user_id = ?)";
        
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            ps.setInt(3, recruiterId);
            boolean updated = ps.executeUpdate() > 0;
            if (updated) {
                // Gửi email thông báo cho ứng viên
                Application app = getApplicationById(applicationId, recruiterId);
                if (app != null) {
                    // Lấy email ứng viên (giả sử đã join được email trong getApplicationById)
                    String email = "";
                    String name = "Ứng viên";
                    // Nếu Application có trường email, fullName thì lấy, nếu không thì cần join thêm
                    try {
                        java.lang.reflect.Method getEmail = app.getClass().getMethod("getEmail");
                        email = (String) getEmail.invoke(app);
                    } catch(Exception e) {}
                    try {
                        java.lang.reflect.Method getFullName = app.getClass().getMethod("getFullName");
                        name = (String) getFullName.invoke(app);
                    } catch(Exception e) {}
                    if (email != null && !email.isEmpty()) {
                        String subject = "Cập nhật trạng thái hồ sơ ứng tuyển";
                        String body = "Xin chào " + name + ",\n\n" +
                            "Trạng thái hồ sơ ứng tuyển của bạn đã được cập nhật thành: " + status + ".\n" +
                            "Vui lòng đăng nhập hệ thống để xem chi tiết.\n\n" +
                            "Trân trọng,\nHệ thống JobFinding";
                        JavaMail.sendMail(email, subject, body);
                    }
                }
            }
            return updated;
        }
    }
    
    public Application getApplicationById(int applicationId, int recruiterId) throws SQLException {
<<<<<<< HEAD
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, j.company_name, js.full_name, js.email FROM Applications a " +
                    "INNER JOIN Job_Listings j ON a.job_listing_id = j.id " +
                    "INNER JOIN Job_Seekers js ON a.job_seeker_id = js.id " +
                    "WHERE a.id = ? AND j.recruiter_id = ?";
=======
        String sql = "SELECT a.id as app_id, a.status, a.applied_at, a.cv_file, " +
                     "p.id as post_id, p.title, " +
                     "js.id as seeker_id, js.full_name, js.email, js.phone, js.profile_picture " +
                     "FROM Applications a " +
                     "INNER JOIN Posts p ON a.job_listing_id = p.id " +
                     "INNER JOIN Job_Seekers js ON a.job_seeker_id = js.id " +
                     "WHERE a.id = ? AND p.user_id = ?";
        
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            ps.setInt(2, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Application app = new Application();
<<<<<<< HEAD
                app.setId(rs.getInt("a.id"));
                app.setStatus(rs.getString("a.status"));
                app.setJobListingId(rs.getInt("a.job_listing_id"));
                app.setJobSeekerId(rs.getInt("a.job_seeker_id"));
                app.setCvFile(rs.getString("a.cv_file"));
                app.setCoverLetter(rs.getString("a.cover_letter"));
=======
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
                
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
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
<<<<<<< HEAD
            ps.setInt(1, app.getJobListingId());
            ps.setInt(2, app.getJobSeekerId());
            ps.setString(3, app.getCvFile());
            ps.setString(4, app.getCoverLetter());
            ps.setString(5, app.getStatus());
=======
            ps.setInt(1, app.getPostId());
            ps.setInt(2, app.getJobSeekerId());
            ps.setInt(3, app.getCvId());
            ps.setString(4, app.getStatus());
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
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
<<<<<<< HEAD
    
    public List<Application> getApplicationsByJobSeekerId(int jobSeekerId) throws SQLException {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM Applications WHERE job_seeker_id = ? ORDER BY id DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, jobSeekerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Application app = new Application();
                    app.setId(rs.getInt("id"));
                    app.setJobListingId(rs.getInt("job_listing_id"));
                    app.setJobSeekerId(rs.getInt("job_seeker_id"));
                    app.setCvFile(rs.getString("cv_file"));
                    app.setCoverLetter(rs.getString("cover_letter"));
                    app.setStatus(rs.getString("status"));
                    list.add(app);
                }
            }
        }
        return list;
=======

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
                .append("p.id as post_id, p.title, ")
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
>>>>>>> 88ff8a51c9b264a79c1b7fbd08f09a2f1f33a622
    }
} 