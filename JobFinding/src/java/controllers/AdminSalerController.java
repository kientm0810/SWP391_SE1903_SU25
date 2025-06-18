/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import daos.BlogDAO;
import models.Blog;
import models.Banner;
import daos.BannerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;

/**
 *
 * @author andin
 */
@WebServlet(name = "AdminSalerController", urlPatterns = {"/AdminSalerController"})
public class AdminSalerController extends HttpServlet {

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

        String target = request.getParameter("target");

        if (target == null) {
            target = "blog";
        }

        if (target.equals("blog")) {
            processBlog(request, response);
        } else if (target.equals("banner")) {
            processBanner(request, response);
        }
    }

    private void processBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");

        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            listAll(request, response);
        } else if (service.equals("listMy")) {

        } else if (service.equals("Add")) {
            addBlog(request, response);
        } else if (service.equals("Detail")) {
            detailBlog(request, response);
        } else if (service.equals("Update")){
            updateBlog(request, response);
        } else if (service.equals("Delete")){
            deleteBlog(request, response);
        }
    }

    private void listAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();
        Vector<Blog> blogs = new Vector<>();

        String who = request.getParameter("who");
        if (who == null) {
            who = "";
        }

        // never me
        if (who.equals("me")) {
            HttpSession session = request.getSession(true);
            int id = (int) session.getAttribute("userId");
            blogs = blogDAO.getBlogsByAdminId(id);
        } else {
            blogs = blogDAO.getAllBlogs(); // Lấy toàn bộ blog
        }
//        log("" + blogs.size());

        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("admin_manager_allpost.jsp").forward(request, response);
    }

    private void addBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submit = request.getParameter("submit");

        if (submit == null) {
            submit = "";
        }

        log(submit + " ye");
        
        if (submit.equals("submit")) {
            String title = request.getParameter("title");
            String thumbnail = request.getParameter("thumbnail");
            String description = request.getParameter("description");
            String status = "draft";
            int admin_id = 1;//Integer.parseInt(1); // can fix

            Blog blog = new Blog(admin_id, title, description, thumbnail, status);

            BlogDAO dao = new BlogDAO();

            boolean flag = dao.insertBlog(blog);
            log("add " + flag);

            response.sendRedirect("AdminSalerController");

        } else {
            request.getRequestDispatcher("admin_saler_add_blog.jsp").forward(request, response);
        }
    }
    
    private void detailBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        
        BlogDAO dao = new BlogDAO();
        Blog blog = dao.getBlogById(blogId);
        
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("admin_saler_detail_blog.jsp").forward(request, response);
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submit = request.getParameter("submit");

        if (submit == null) {
            submit = "";
        }

        if (submit.equals("submit")) {
            String title = request.getParameter("title");
            String thumbnail = request.getParameter("thumbnail");
            String description = request.getParameter("description");
            String status = "draft";
            int admin_id = 1;//Integer.parseInt(1); // can fix
            int blogID = Integer.parseInt(request.getParameter("blogId"));
           
            Blog blog = new Blog(blogID, admin_id, title, description, thumbnail, status);

            BlogDAO dao = new BlogDAO();

            boolean flag = dao.updateBlogFields(blog);
//            log("update " + flag);

            response.sendRedirect("AdminSalerController");

        } else {
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            BlogDAO dao = new BlogDAO();
            Blog blog = dao.getBlogById(blogId);
            
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("admin_saler_update_blog.jsp").forward(request, response);
        }
    }
    
    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogID = Integer.parseInt(request.getParameter("blogId"));
        
        BlogDAO dao = new BlogDAO();
        boolean flag = dao.deleteBlog(blogID);
        
//        log("delete " + flag);
        response.sendRedirect("AdminSalerController");
    }
    
    private void processBanner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        return "Short description";
    }// </editor-fold>

}
