//package controllers;
//
//import daos.JobDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.List;
//import models.JobListing;
//
//@WebServlet(name = "JobSearchController", urlPatterns = {"/job-search"})
//public class JobSearchController extends HttpServlet {
//    private JobDAO jobDAO;
//    @Override
//    public void init() throws ServletException {
//        jobDAO = new JobDAO();
//    }
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String keyword = request.getParameter("keyword");
//        String position = request.getParameter("position");
//        String industry = request.getParameter("industry");
//        String location = request.getParameter("location");
//        String salaryStr = request.getParameter("salary");
//        String jobType = request.getParameter("jobType");
//        Integer salary = null;
//        try {
//            if (salaryStr != null && !salaryStr.isEmpty()) salary = Integer.parseInt(salaryStr);
//        } catch (Exception e) { salary = null; }
//        List<JobListing> jobs = jobDAO.advancedSearch(keyword, position, industry, location, salary, jobType);
//        request.setAttribute("jobs", jobs);
//        request.getRequestDispatcher("job_search.jsp").forward(request, response);
//    }
//} 