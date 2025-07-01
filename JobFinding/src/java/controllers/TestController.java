package controllers;

import daos.SavedJobDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import models.SavedJob;

@WebServlet(name = "TestController", urlPatterns = {"/test"})
public class TestController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            out.println("TestController: Starting test...");
            
            // Test database connection
            out.println("TestController: Testing database connection...");
            SavedJobDAO dao = new SavedJobDAO();
            out.println("TestController: SavedJobDAO created successfully.");
            
            // Test a simple query for a job seeker
            out.println("TestController: Testing query for job seeker with ID=1...");
            List<SavedJob> savedJobs = dao.getSavedJobsByJobSeeker(1);
            out.println("TestController: Found " + savedJobs.size() + " saved jobs for job seeker 1.");

            out.println("TestController: All tests passed!");
            
        } catch (Exception e) {
            out.println("TestController: FATAL ERROR: " + e.getMessage());
            e.printStackTrace(out);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 