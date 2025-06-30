package controllers;

import daos.SavedJobDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;

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
            out.println("TestController: SavedJobDAO created successfully");
            
            // Test a simple query
            int count = dao.getSavedJobsCount(1);
            out.println("TestController: Saved jobs count for user 1: " + count);
            
            out.println("TestController: All tests passed!");
            
        } catch (Exception e) {
            out.println("TestController: Error: " + e.getMessage());
            e.printStackTrace(out);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 