//package controllers;
//
//import daos.JobSeekerDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.List;
//import models.JobSeeker;
//
//@WebServlet(name = "JobSeekerSearchController", urlPatterns = {"/jobseeker-search"})
//public class JobSeekerSearchController extends HttpServlet {
//    private JobSeekerDAO jobSeekerDAO;
//    @Override
//    public void init() throws ServletException {
//        jobSeekerDAO = new JobSeekerDAO();
//    }
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String skills = request.getParameter("skills");
//        String experienceStr = request.getParameter("experience");
//        String education = request.getParameter("education");
//        String desiredPosition = request.getParameter("desiredPosition");
//        String location = request.getParameter("location");
//        Integer experience = null;
//        try {
//            if (experienceStr != null && !experienceStr.isEmpty()) experience = Integer.parseInt(experienceStr);
//        } catch (Exception e) { experience = null; }
//        List<JobSeeker> jobseekers = jobSeekerDAO.advancedSearch(skills, experience, education, desiredPosition, location);
//        request.setAttribute("jobseekers", jobseekers);
//        request.getRequestDispatcher("jobseeker_search.jsp").forward(request, response);
//    }
//} 