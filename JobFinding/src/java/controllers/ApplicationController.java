package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daos.ApplicationDAO;
import daos.PostsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Application;
import models.JobSeeker;
import models.Posts;
import models.Recruiter;

@WebServlet(name = "ApplicationController", urlPatterns = {"/applications"})
public class ApplicationController extends HttpServlet {
    
    private ApplicationDAO applicationDAO;
    private PostsDAO postsDAO;
    
    public ApplicationController() {
        try {
            applicationDAO = new ApplicationDAO();
            postsDAO = new PostsDAO();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Pagination parameters
            int page = 1;
            int pageSize = 10;
            
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Filter parameters
            String status = request.getParameter("status");
            String keyword = request.getParameter("keyword");
            String sortBy = request.getParameter("sortBy");
            
            // Set default sort
            if (sortBy == null || sortBy.trim().isEmpty()) {
                sortBy = "created_at_desc";
            }

            if ("job-seeker".equals(role)) {
                handleJobSeekerApplications(request, response, session, page, pageSize, status, keyword, sortBy);
            } else if ("recruiter".equals(role)) {
                handleRecruiterApplications(request, response, session, page, pageSize, status, keyword, sortBy);
            } else {
                response.sendRedirect("home");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách ứng tuyển");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleJobSeekerApplications(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, int page, int pageSize, String status, String keyword, String sortBy) 
            throws SQLException, ServletException, IOException {
        
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        if (jobSeeker == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get applications for jobseeker with pagination and filters
        List<Application> applications = applicationDAO.getApplicationsByJobSeeker(
            jobSeeker.getId(), page, pageSize, status, keyword, sortBy);
        
        int totalApplications = applicationDAO.countApplicationsByJobSeeker(
            jobSeeker.getId(), status, keyword);
        
        int totalPages = (int) Math.ceil((double) totalApplications / pageSize);

        // Get job recommendations based on user profile
        List<Map<String, Object>> recommendedJobsWithScores = getJobRecommendations(jobSeeker);

        // Set attributes for JSP
        request.setAttribute("applications", applications);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("status", status);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("userType", "jobseeker");
        request.setAttribute("recommendedJobsWithScores", recommendedJobsWithScores);

        // Forward to jobseeker applications page
        request.getRequestDispatcher("applications.jsp").forward(request, response);
    }

    private List<Map<String, Object>> getJobRecommendations(JobSeeker jobSeeker) {
        List<Map<String, Object>> recommendedJobsWithScores = new ArrayList<>();
        
        try {
            // Use the advanced job recommendation service
            services.JobRecommendationService recommendationService = new services.JobRecommendationService();
            List<services.JobRecommendationService.JobRecommendation> recommendations = 
                recommendationService.getRecommendations(jobSeeker, 6);
            
            // Convert to Map with job and score
            for (services.JobRecommendationService.JobRecommendation rec : recommendations) {
                Map<String, Object> jobWithScore = new HashMap<>();
                jobWithScore.put("job", rec.getJob());
                jobWithScore.put("score", rec.getScore());
                recommendedJobsWithScores.add(jobWithScore);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // Fallback: return latest jobs if recommendation fails
            try {
                List<Posts> latestJobs = postsDAO.getLatestPosts(3);
                for (Posts job : latestJobs) {
                    Map<String, Object> jobWithScore = new HashMap<>();
                    jobWithScore.put("job", job);
                    jobWithScore.put("score", 0.0); // Fallback score
                    recommendedJobsWithScores.add(jobWithScore);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        
        return recommendedJobsWithScores;
    }
    

    


    private void handleRecruiterApplications(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, int page, int pageSize, String status, String keyword, String sortBy) 
            throws SQLException, ServletException, IOException {
        
        Recruiter recruiter = (Recruiter) session.getAttribute("user");
        if (recruiter == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // DAOs for profile sections
        daos.ExperienceDAO experienceDAO = new daos.ExperienceDAO();
        daos.EducationDAO educationDAO = new daos.EducationDAO();
        daos.CertificateDAO certificateDAO = new daos.CertificateDAO();
        daos.AwardDAO awardDAO = new daos.AwardDAO();
        daos.CVTemplateDAO cvTemplateDAO = new daos.CVTemplateDAO();

        // Get applications for recruiter with pagination and filters
        List<Application> applications = applicationDAO.getApplicationsByRecruiter(
            recruiter.getId(), page, pageSize, status, keyword, sortBy);
        
        // Enrich each application's job seeker with full profile data
        for (Application app : applications) {
            JobSeeker js = app.getJobseeker();
            if (js != null) {
                try {
                    js.setExperiences(experienceDAO.getExperiencesByJobSeeker(js.getId()));
                } catch (Exception e) { js.setExperiences(new java.util.ArrayList<>()); }
                try {
                    js.setEducations(educationDAO.getEducationsByJobSeeker(js.getId()));
                } catch (Exception e) { js.setEducations(new java.util.ArrayList<>()); }
                try {
                    js.setCertificates(certificateDAO.getCertificatesByJobSeeker(js.getId()));
                } catch (Exception e) { js.setCertificates(new java.util.ArrayList<>()); }
                try {
                    js.setAwards(awardDAO.getAwardsByJobSeeker(js.getId()));
                } catch (Exception e) { js.setAwards(new java.util.ArrayList<>()); }
                try {
                    js.setCvTemplates(cvTemplateDAO.getCVsByJobSeeker(js.getId()));
                } catch (Exception e) { js.setCvTemplates(new java.util.ArrayList<>()); }
            }
        }
        
        int totalApplications = applicationDAO.countApplicationsByRecruiter(
            recruiter.getId(), status, keyword);
        
        int totalPages = (int) Math.ceil((double) totalApplications / pageSize);

        // Set attributes for JSP
        request.setAttribute("applications", applications);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("status", status);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("userType", "recruiter");

        // Forward to recruiter applications page
        request.getRequestDispatcher("recruiter-applications.jsp").forward(request, response);
    }
} 