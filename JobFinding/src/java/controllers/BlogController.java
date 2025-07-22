/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import daos.BlogDAO;
import models.Blog;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import utils.InputSanitizer;

/**
 *
 * @author andin
 */
@WebServlet(name = "BlogController", urlPatterns = {"/BlogController"})
public class BlogController extends HttpServlet {

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

        String service = request.getParameter("service");
        if (service == null) {
            service = "list";
        }

        switch (service) {
            case "list":
                listBlogs(request, response);
                break;
            case "detail":
                viewBlogDetail(request, response);
                break;
            default:
                listBlogs(request, response);
                break;
        }
    }

    private void listBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();
        
        String pageStr = request.getParameter("page");
        String recordsPerPageStr = request.getParameter("recordsPerPage");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");
        String submit = request.getParameter("submit");
        String searchTitle = request.getParameter("title");

        // Set default values
        int page = 1;
        int pageSize = 6; // 6 blogs per page for better display
        
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        if (recordsPerPageStr != null && !recordsPerPageStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(recordsPerPageStr);
            } catch (NumberFormatException e) {
                pageSize = 6;
            }
        }
        
        if (sortField == null || sortField.isEmpty()) {
            sortField = "created_at";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "DESC";
        }

        Vector<Blog> blogs;
        int totalBlogs;

        // Handle search
        if (submit != null && submit.equals("Search") && searchTitle != null && !searchTitle.trim().isEmpty()) {
            String cleanTitle = InputSanitizer.cleanSearchQuery(searchTitle);
            blogs = blogDAO.searchBlogsByTitleWithPaging(cleanTitle, page, pageSize, sortField, sortOrder);
            totalBlogs = blogDAO.getTotalBlogsByTitle(cleanTitle);
            request.setAttribute("searchTitle", cleanTitle);
        } else {
            // Get all published blogs only
            blogs = blogDAO.getAllBlogsWithPagingAndSorting(page, pageSize, sortField, sortOrder);
            totalBlogs = blogDAO.getTotalBlogs();
            log("num of blog:" + blogs.size());
        }

        // Filter only published blogs (in case database contains draft blogs)
        Vector<Blog> publishedBlogs = blogs;//new Vector<>();
//        for (Blog blog : blogs) {
//            if ("published".equals(blog.getStatus())) {
//                publishedBlogs.add(blog);
//            }
//        }

        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

        // Set attributes for JSP
        request.setAttribute("blogs", publishedBlogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("recordsPerPage", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalBlogs);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("blog.jsp").forward(request, response);
    }

    private void viewBlogDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        log("id " + idStr);
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("BlogController");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            BlogDAO blogDAO = new BlogDAO();
            Blog blog = blogDAO.getBlogById(id);

//            if (blog == null || !"published".equals(blog.getStatus())) {
//                response.sendRedirect("BlogController");
//                return;
//            }

            // Get related blogs (latest 4 blogs excluding current one)
            Vector<Blog> relatedBlogs = blogDAO.getLatestBlogs(5);
            Vector<Blog> filteredRelatedBlogs = new Vector<>();
            
            for (Blog relatedBlog : relatedBlogs) {
                if (relatedBlog.getId() != id && filteredRelatedBlogs.size() < 4) {
                    filteredRelatedBlogs.add(relatedBlog);
                }
            }

            request.setAttribute("blog", blog);
            request.setAttribute("relatedBlogs", filteredRelatedBlogs);
            request.getRequestDispatcher("blog_detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            log("biloi");
            response.sendRedirect("BlogController");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Blog Controller for managing blog views";
    }// </editor-fold>
}