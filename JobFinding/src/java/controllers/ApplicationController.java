package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
        List<Posts> recommendedJobs = getJobRecommendations(jobSeeker);

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
        request.setAttribute("recommendedJobs", recommendedJobs);

        // Forward to jobseeker applications page
        request.getRequestDispatcher("applications.jsp").forward(request, response);
    }

    private List<Posts> getJobRecommendations(JobSeeker jobSeeker) {
        List<Posts> recommendedJobs = new ArrayList<>();
        
        try {
            // Get all active job posts
            List<Posts> allJobs = postsDAO.getAllPosts();
            List<Posts> scoredJobs = new ArrayList<>();
            
            // Score each job based on user profile
            for (Posts job : allJobs) {
                int score = calculateMatchScore(jobSeeker, job);
                if (score > 0) {
                    // Add score as a property we can use for sorting
                    job.setViewCount(score); // Temporarily use viewCount to store score
                    scoredJobs.add(job);
                }
            }
            
            // Sort by score (descending) and take top jobs
            scoredJobs.sort((a, b) -> Integer.compare(b.getViewCount(), a.getViewCount()));
            
            // Return at least 3 jobs, maximum 6
            int jobCount = Math.max(3, Math.min(6, scoredJobs.size()));
            for (int i = 0; i < jobCount && i < scoredJobs.size(); i++) {
                recommendedJobs.add(scoredJobs.get(i));
            }
            
            // If we don't have enough scored jobs, fill with latest jobs
            if (recommendedJobs.size() < 3) {
                List<Posts> latestJobs = postsDAO.getLatestPosts(6);
                for (Posts job : latestJobs) {
                    if (recommendedJobs.size() >= 3) break;
                    
                    // Avoid duplicates
                    boolean alreadyAdded = false;
                    for (Posts existingJob : recommendedJobs) {
                        if (existingJob.getId() == job.getId()) {
                            alreadyAdded = true;
                            break;
                        }
                    }
                    
                    if (!alreadyAdded) {
                        recommendedJobs.add(job);
                    }
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // Fallback: return latest jobs if recommendation fails
            try {
                recommendedJobs = postsDAO.getLatestPosts(3);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        
        return recommendedJobs;
    }
    
    private int calculateMatchScore(JobSeeker jobSeeker, Posts job) {
        int score = 0;
        
        try {
            // Score based on desired job title match
            if (jobSeeker.getDesiredJobTitle() != null && job.getTitle() != null) {
                String desiredTitle = jobSeeker.getDesiredJobTitle().toLowerCase();
                String jobTitle = job.getTitle().toLowerCase();
                
                if (jobTitle.contains(desiredTitle) || desiredTitle.contains(jobTitle)) {
                    score += 30;
                } else {
                    // Check for partial matches with keywords
                    String[] desiredWords = desiredTitle.split("\\s+");
                    String[] jobWords = jobTitle.split("\\s+");
                    
                    for (String desired : desiredWords) {
                        for (String jobWord : jobWords) {
                            if (desired.length() > 3 && jobWord.length() > 3 && 
                                (desired.contains(jobWord) || jobWord.contains(desired))) {
                                score += 10;
                                break;
                            }
                        }
                    }
                }
            }
            
            // Score based on location match
            if (jobSeeker.getPreferredLocation() != null && job.getLocation() != null) {
                String preferredLocation = jobSeeker.getPreferredLocation().toLowerCase();
                String jobLocation = job.getLocation().toLowerCase();
                
                if (jobLocation.contains(preferredLocation) || preferredLocation.contains(jobLocation)) {
                    score += 20;
                }
            }
            
            // Score based on skills match
            if (jobSeeker.getSkills() != null && job.getRequirements() != null) {
                String[] userSkills = jobSeeker.getSkills().toLowerCase().split("[,;\\s]+");
                String jobRequirements = job.getRequirements().toLowerCase();
                
                for (String skill : userSkills) {
                    if (skill.length() > 2 && jobRequirements.contains(skill.trim())) {
                        score += 15;
                    }
                }
            }
            
            // Score based on experience level
            if (jobSeeker.getExperienceYears() > 0 && job.getExperience() != null) {
                String experienceReq = job.getExperience().toLowerCase();
                int userExperience = jobSeeker.getExperienceYears();
                
                if (userExperience <= 1 && (experienceReq.contains("fresher") || experienceReq.contains("entry") || experienceReq.contains("junior"))) {
                    score += 25;
                } else if (userExperience >= 2 && userExperience <= 4 && (experienceReq.contains("mid") || experienceReq.contains("intermediate"))) {
                    score += 25;
                } else if (userExperience >= 5 && (experienceReq.contains("senior") || experienceReq.contains("lead"))) {
                    score += 25;
                }
            }
            
            // Score based on job category match
            if (jobSeeker.getJobCategory() != null && job.getIndustry() != null) {
                String userCategory = jobSeeker.getJobCategory().toLowerCase();
                String jobIndustry = job.getIndustry().toLowerCase();
                
                if (jobIndustry.contains(userCategory) || userCategory.contains(jobIndustry)) {
                    score += 20;
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return score;
    }

    private void handleRecruiterApplications(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, int page, int pageSize, String status, String keyword, String sortBy) 
            throws SQLException, ServletException, IOException {
        
        Recruiter recruiter = (Recruiter) session.getAttribute("user");
        if (recruiter == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get applications for recruiter with pagination and filters
        List<Application> applications = applicationDAO.getApplicationsByRecruiter(
            recruiter.getId(), page, pageSize, status, keyword, sortBy);
        
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