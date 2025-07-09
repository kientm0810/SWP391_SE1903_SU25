package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import daos.ApplicationDAO;
import daos.JobDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Application;
import models.JobListing;
import models.JobSeeker;

@WebServlet(name = "ApplicationListController", urlPatterns = {"/applications"})
public class ApplicationListController extends HttpServlet {
    private ApplicationDAO applicationDAO;
    private JobDAO jobDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        jobDAO = new JobDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");
        if (jobSeeker == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            List<Application> apps = applicationDAO.getApplicationsByJobSeekerId(jobSeeker.getId());
            List<ApplicationView> appViews = new ArrayList<>();
            for (Application app : apps) {
                JobListing job = jobDAO.getJobListingById(app.getJobListingId());
                ApplicationView v = new ApplicationView();
                v.setId(app.getId());
                v.setJobTitle(job != null ? job.getTitle() : "");
                v.setCompanyName(job != null ? job.getCompanyName() : "");
                v.setAppliedAt(app.getAppliedAt());
                v.setStatus(app.getStatus());
                appViews.add(v);
            }
            request.setAttribute("applications", appViews);
        } catch (Exception e) {
            request.setAttribute("applications", new ArrayList<ApplicationView>());
            request.setAttribute("errorMsg", "Không thể lấy danh sách ứng tuyển: " + e.getMessage());
        }
        request.getRequestDispatcher("applications.jsp").forward(request, response);
    }

    // DTO cho view
    public static class ApplicationView {
        private int id;
        private String jobTitle;
        private String companyName;
        private Object appliedAt;
        private String status;
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getJobTitle() { return jobTitle; }
        public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }
        public String getCompanyName() { return companyName; }
        public void setCompanyName(String companyName) { this.companyName = companyName; }
        public Object getAppliedAt() { return appliedAt; }
        public void setAppliedAt(Object appliedAt) { this.appliedAt = appliedAt; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }
} 