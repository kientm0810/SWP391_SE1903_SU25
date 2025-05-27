package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import daos.PostsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.PrintWriter;
import models.Posts;

@WebServlet(name = "PostController", urlPatterns = {"/post"})
public class PostController extends HttpServlet {
    private PostsDAO postsDAO;

    /**
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        super.init();
        postsDAO = new PostsDAO();
    }

    private boolean isRecruiter(HttpSession session) {
        String role = (String) session.getAttribute("role");
        return "recruiter".equals(role);
    }

    private void checkRecruiterAccess(HttpSession session, HttpServletResponse response) 
            throws IOException {
        if (!isRecruiter(session)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Recruiter role required.");
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !isRecruiter(session)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
//        if (session == null || !isRecruiter(session)) {
//            response.sendError(HttpServletResponse.SC_FORBIDDEN);
//            return;
//        }

        String pathInfo = request.getPathInfo();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List user's posts with pagination
                int page = 1;
                int pageSize = 10;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    // Use default page 1
                }
                
                if (userId != null && userType != null) {
                    List<Posts> posts = postsDAO.getUserPosts(userId, userType, page, pageSize);
                    request.setAttribute("posts", posts);
                    request.getRequestDispatcher("/posts.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                }
            } 
            else if (pathInfo.matches("/\\d+")) {
                // View single post
                int postId = Integer.parseInt(pathInfo.substring(1));
                Posts post = postsDAO.getPostDetail(postId);
                
                if (post != null) {
                    // Get comments
                    List<Posts> comments = postsDAO.getPostComments(postId);
                    
                    request.setAttribute("post", post);
                    request.setAttribute("comments", comments);
                    request.getRequestDispatcher("/posts_detail.jsp").forward(request, response);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !isRecruiter(session)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "create":
                    createPost(request, response);
                    break;
                case "update":
                    updatePost(request, response);
                    break;
                case "delete":
                    deletePost(request, response);
                    break;
                case "comment":
                    createComment(request, response);
                    break;
                case "like":
                    toggleLike(request, response);
                    break;
                case "reject":
                    rejectPost(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    break;
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
        
        if (userId == null || userType == null || !isRecruiter(session)) {
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
            // Set success message
            session.setAttribute("successMessage", "Post published successfully!");
            
            // Set the post data in session for display
            session.setAttribute("lastCreatedPost", post);
            
            // Redirect based on the requested destination
            String destination = request.getParameter("destination");
            if ("my_posts".equals(destination)) {
                response.sendRedirect("my_posts.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            request.setAttribute("error", "Failed to create post");
            request.getRequestDispatcher("/create_post.jsp").forward(request, response);
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null || !isRecruiter(session)) {
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
            request.getRequestDispatcher("/post_edit.jsp").forward(request, response);
        }
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null || !isRecruiter(session)) {
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
        
        if (userId == null || userType == null || !isRecruiter(session)) {
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

    private void toggleLike(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || userType == null || !isRecruiter(session)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int postId = Integer.parseInt(request.getParameter("postId"));
        
        if (postsDAO.toggleLike(postId, userId, userType)) {
            response.sendRedirect(request.getContextPath() + "/post/" + postId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void rejectPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || userType == null || !isRecruiter(session)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String rejectReason = request.getParameter("rejectReason");
        if (rejectReason == null || rejectReason.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reject reason is required");
            return;
        }

        Posts post = new Posts();
        post.setUserId(userId);
        post.setUserType(userType);
        post.setTitle(request.getParameter("title"));
        post.setContent(request.getParameter("content"));
        post.setPostType("post");
        post.setStatus("rejected");
   

        if (postsDAO.createPost(post)) {
            // Set success message
            session.setAttribute("successMessage", "Post has been rejected successfully");
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":true}");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to reject post");
        }
    }

    @Override
    public String getServletInfo() {
        return "Post Controller handles post, comment, and like management";
    }
}