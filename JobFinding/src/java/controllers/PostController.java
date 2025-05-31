package controller;

import dao.PostsDAO;
import models.Posts;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "PostController", urlPatterns = {"/post/*"})
public class PostController extends HttpServlet {
    private PostsDAO postsDAO;

    @Override
    public void init() throws ServletException {
        postsDAO = new PostsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getPathInfo();
        
        if (path == null || path.equals("/")) {
            // View post list
            listPosts(request, response);
        } else if (path.equals("/view")) {
            // View post detail
            viewPost(request, response);
        } else if (path.equals("/create")) {
            // Show create post form
            showCreateForm(request, response);
        } else if (path.equals("/edit")) {
            // Show edit post form
            showEditForm(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getPathInfo();
        
        if (path == null || path.equals("/")) {
            // Create new post
            createPost(request, response);
        } else if (path.equals("/update")) {
            // Update post
            updatePost(request, response);
        } else if (path.equals("/delete")) {
            // Delete post
            deletePost(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listPosts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        List<Posts> posts;
        if (userId != null) {
            posts = postsDAO.getPostsByUserId(userId);
        } else {
            posts = postsDAO.getAllPosts();
        }
        
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/posts.jsp").forward(request, response);
    }

    private void viewPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Posts post = postsDAO.getPostById(postId);
        
        if (post != null) {
            postsDAO.incrementViewCount(postId);
            request.setAttribute("post", post);
            request.getRequestDispatcher("/post-detail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/create-post.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Posts post = postsDAO.getPostById(postId);
        
        if (post != null) {
            request.setAttribute("post", post);
            request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void createPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || userType == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Posts post = new Posts();
        post.setUserId(userId);
        post.setUserType(userType);
        post.setTitle(request.getParameter("title"));
        post.setContent(request.getParameter("content"));
        post.setPostType("post");
        post.setStatus("active");
        post.setViewCount(0);
        post.setLikeCount(0);
        post.setCommentCount(0);

        if (postsDAO.createPost(post)) {
            response.sendRedirect(request.getContextPath() + "/post");
        } else {
            request.setAttribute("error", "Failed to create post");
            request.getRequestDispatcher("/create-post.jsp").forward(request, response);
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Posts existingPost = postsDAO.getPostById(postId);
        
        if (existingPost == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null || userId != existingPost.getUserId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        existingPost.setTitle(request.getParameter("title"));
        existingPost.setContent(request.getParameter("content"));
        existingPost.setStatus(request.getParameter("status"));

        if (postsDAO.updatePost(existingPost)) {
            response.sendRedirect(request.getContextPath() + "/post/view?id=" + postId);
        } else {
            request.setAttribute("error", "Failed to update post");
            request.setAttribute("post", existingPost);
            request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
        }
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Posts post = postsDAO.getPostById(postId);
        
        if (post == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null || userId != post.getUserId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        if (postsDAO.deletePost(postId)) {
            response.sendRedirect(request.getContextPath() + "/post");
        } else {
            request.setAttribute("error", "Failed to delete post");
            request.getRequestDispatcher("/post/view?id=" + postId).forward(request, response);
        }
    }

    @Override
    public void destroy() {
        if (postsDAO != null) {
            postsDAO.closeConnection();
        }
    }
}