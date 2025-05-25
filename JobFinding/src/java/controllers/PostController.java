/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

import daos.PostsDAO;
import java.io.PrintWriter;
import models.Posts;

/**
 *
 * @author MY PC
 */
@WebServlet(name = "PostController", urlPatterns = {"/post"})
public class PostController extends HttpServlet {
    private PostsDAO postsDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        postsDAO = new PostsDAO();
    }

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all posts
                List<Posts> posts = postsDAO.getAllPosts();
                request.setAttribute("posts", posts);
                request.getRequestDispatcher("/views/posts/list.jsp").forward(request, response);
            } else if (pathInfo.matches("/\\d+")) {
                // View single post
                int postId = Integer.parseInt(pathInfo.substring(1));
                Posts post = postsDAO.getPostDetail(postId);
                
                if (post != null) {
                    // Increment view count
                    postsDAO.incrementViewCount(postId);
                    
                    // Get comments
                    List<Posts> comments = postsDAO.getPostComments(postId);
                    
                    request.setAttribute("post", post);
                    request.setAttribute("comments", comments);
                    request.getRequestDispatcher("/views/posts/detail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                createPost(request, response);
            } else if ("update".equals(action)) {
                updatePost(request, response);
            } else if ("delete".equals(action)) {
                deletePost(request, response);
            } else if ("comment".equals(action)) {
                createComment(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void createPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || userType == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Posts post = new Posts();
        post.setUserId(userId);
        post.setUserType(userType);
        post.setTitle(request.getParameter("title"));
        post.setContent(request.getParameter("content"));
        post.setPostType("post");
        post.setStatus("active");

        if (postsDAO.createPost(post)) {
            response.sendRedirect(request.getContextPath() + "/post/" + post.getId());
        } else {
            request.setAttribute("error", "Failed to create post");
            request.getRequestDispatcher("/create_post.jsp").forward(request, response);
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int postId = Integer.parseInt(request.getParameter("postId"));
        Posts post = postsDAO.getPostDetail(postId);
        
        if (post == null || post.getUserId() != userId) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        post.setTitle(request.getParameter("title"));
        post.setContent(request.getParameter("content"));
        
        if (postsDAO.updatePost(post)) {
            response.sendRedirect(request.getContextPath() + "/post/" + postId);
        } else {
            request.setAttribute("error", "Failed to update post");
            request.setAttribute("post", post);
            request.getRequestDispatcher("/edit_post.jsp").forward(request, response);
        }
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int postId = Integer.parseInt(request.getParameter("postId"));
        
        if (postsDAO.deletePost(postId, userId)) {
            response.sendRedirect(request.getContextPath() + "/post");
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }

    private void createComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || userType == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int parentId = Integer.parseInt(request.getParameter("parentId"));
        
        Posts comment = new Posts();
        comment.setUserId(userId);
        comment.setUserType(userType);
        comment.setParentId(parentId);
        comment.setContent(request.getParameter("content"));
        comment.setPostType("comment");
        comment.setStatus("active");

        if (postsDAO.createPost(comment)) {
            response.sendRedirect(request.getContextPath() + "/post/" + parentId);
        } else {
            request.setAttribute("error", "Failed to create comment");
            response.sendRedirect(request.getContextPath() + "/post/" + parentId);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Post Controller handles post and comment management";
    }// </editor-fold>

}
