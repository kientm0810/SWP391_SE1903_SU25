/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.util.List;
import java.util.Vector;

import daos.JobDAO;
import daos.PostsDAO;
import daos.RecruiterNotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.JobListing;
import models.JobTypeCount;
import models.Posts;
import models.RecruiterNotification;
import utils.Constants;

/**
 *
 * @author andin
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home", "/"})
public class HomeController extends HttpServlet {

    private PostsDAO postsDAO;
    private JobDAO jobDAO;

    @Override
    public void init() throws ServletException {
        postsDAO = new PostsDAO();
        jobDAO = new JobDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Get page number from request parameter
            int page = 1;
            int pageSize = 6;
            
            try {
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            // Get search parameters
            String keyword = request.getParameter("keyword");
            String jobType = request.getParameter("jobType");
            String location = request.getParameter("location");
            
            // Get total posts and calculate total pages
            int totalPosts = postsDAO.getTotalPostsWithSearch(keyword, jobType, location);
            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
            
            // Get posts for current page with search
            List<Posts> recentPosts = postsDAO.getPostsByPageWithSearch(page, pageSize, keyword, jobType, location);
            
            // Latest job listings for homepage (guest view)
            List<JobListing> latestJobs = jobDAO.getLatestJobListings(10);
            request.setAttribute("latestJobs", latestJobs);
            
            // Top job categories (job types) for displaying in Browse Top Categories
            List<JobTypeCount> jobCategories = jobDAO.getJobTypeCounts(8);
            request.setAttribute("jobCategories", jobCategories);
            
            // Set attributes for JSP
            request.setAttribute("recentPosts", recentPosts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keyword", keyword);
            request.setAttribute("jobType", jobType);
            request.setAttribute("location", location);
            
            // request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        HttpSession session = request.getSession(true);

        String role = (String) session.getAttribute("role");
        if (Constants.RECRUITER_ROLE.equals(role)) {
            processRecruiter(request, response);
            return;
        }
        if (Constants.JOB_SEEKER_ROLE.equals(role) || "job-seeker".equals(role)) {
            processJobSeeker(request, response);
            return;
        }

        // Mặc định (khách, job-seeker, hoặc role khác) hiển thị home.jsp như chưa đăng nhập
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    private void processRecruiter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        if (service == null) {
            service = "list";
        }

        if (service.equals("list")){
            listNoticeRecruiter(request, response);
        } else if (service.equals("")){
            
        }
    }

    private void listNoticeRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = (String) session.getAttribute("role");
        int id = (int) session.getAttribute("userId");
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();
        
        int topk = 5;
        Vector<RecruiterNotification> list = dao.getNotice(id, topk);
        Vector<RecruiterNotification> unread = dao.getUnreadNotice(id, topk);
        request.setAttribute("notice", list);
        request.setAttribute("unread", unread);

//        String sql = "SELECT " + (topk == -1 ? "*" : "TOP (" + topk + ")")
//                + "  FROM [project_SWP391].[dbo].[RecruiterNotification]\n"
//                + "  WHERE [recruiter_id] = " + id 
//                + " ORDER BY created_at DESC";
//        
//        log(sql);
        
                log("" + list.size());
//                log("" + id);
//                response.sendRedirect("admin_dashboard.jsp");
//                return;
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
    
    private void processJobSeeker(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            
            // Get page number from request parameter
            int page = 1;
            int pageSize = 6;
            
            try {
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            // Get search parameters
            String keyword = request.getParameter("keyword");
            String jobType = request.getParameter("jobType");
            String location = request.getParameter("location");
            
            // Get total posts and calculate total pages
            int totalPosts = postsDAO.getTotalPostsWithSearch(keyword, jobType, location);
            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
            
            // Get posts for current page with search
            List<Posts> recentPosts = postsDAO.getPostsByPageWithSearch(page, pageSize, keyword, jobType, location);
            
            // Recommended jobs for job seeker: fetch latest 6 active job listings
            List<JobListing> recommendedJobs = jobDAO.getLatestJobListings(6);
            request.setAttribute("recommendedJobs", recommendedJobs);
            
            // Top job categories (job types)
            List<JobTypeCount> jobCategories = jobDAO.getJobTypeCounts(8);
            request.setAttribute("jobCategories", jobCategories);
            
            // Set attributes for JSP
            request.setAttribute("recentPosts", recentPosts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keyword", keyword);
            request.setAttribute("jobType", jobType);
            request.setAttribute("location", location);
            
            // Forward to jobseeker home page
            request.getRequestDispatcher("jobseeker_home.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
