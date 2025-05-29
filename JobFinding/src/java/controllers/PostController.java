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

    @Override
    public void init() throws ServletException {
        super.init();
        postsDAO = new PostsDAO();
    }

    private boolean isRecruiter(HttpSession session) {
        String role = (String) session.getAttribute("role");
        return "recruiter".equals(role);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please login first");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || userType == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid user session");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List user's posts with pagination
                int page = parsePageNumber(request.getParameter("page"));
                int pageSize = 10;
                
                List<Posts> posts = postsDAO.getUserPosts(userId, userType, page, pageSize);
                request.setAttribute("posts", posts);
                request.getRequestDispatcher("/posts.jsp").forward(request, response);
            } 
            else if (pathInfo.matches("/\\d+")) {
                // View single post
                int postId = Integer.parseInt(pathInfo.substring(1));
                Posts post = postsDAO.getPostDetail(postId);
                
                if (post == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found");
                    return;
                }
                
                // Increment view count
                postsDAO.incrementViewCount(postId);
                
                // Get comments
                List<Posts> comments = postsDAO.getPostComments(postId);
                
                request.setAttribute("post", post);
                request.setAttribute("comments", comments);
                request.getRequestDispatcher("/post_detail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            handleDatabaseError(e, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID format");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please login first");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || userType == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid user session");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
            return;
        }
        
        try {
            switch (action.toLowerCase()) {
                case "create":
                    createPost(request, response, session, userId, userType);
                    break;
                case "update":
                    updatePost(request, response, userId);
                    break;
                case "delete":
                    deletePost(request, response, userId);
                    break;
                case "comment":
                    createComment(request, response, userId, userType);
                    break;
                case "like":
                    toggleLike(request, response, userId, userType);
                    break;
                case "reject":
                    rejectPost(request, response, userId, userType);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                    break;
            }
        } catch (SQLException e) {
            handleDatabaseError(e, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid numeric parameter");
        }
    }

    private void createPost(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, int userId, String userType) 
            throws ServletException, IOException, SQLException {
        if (!isRecruiter(session)) {
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"success\":false,\"message\":\"Only recruiters can create posts\"}");
                return;
            } else {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only recruiters can create posts");
                return;
            }
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String category = request.getParameter("category");
        
        if (title == null || title.trim().isEmpty() || 
            content == null || content.trim().isEmpty()) {
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\":false,\"message\":\"Title and content are required\"}");
                return;
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Title and content are required");
                return;
            }
        }

        Posts post = new Posts();
        post.setUserId(userId);
        post.setUserType(userType);
        post.setTitle(title);
        post.setContent(content);
        post.setPostType("post");
        post.setStatus("active");

        boolean created = postsDAO.createPost(post);
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            response.setContentType("application/json");
            if (created) {
                response.getWriter().write("{\"success\":true,\"message\":\"Post published successfully!\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\":false,\"message\":\"Failed to create post\"}");
            }
            return;
        }

        if (created) {
            session.setAttribute("successMessage", "Post published successfully!");
            session.setAttribute("lastCreatedPost", post);
            String destination = request.getParameter("destination");
            if ("my_posts".equals(destination)) {
                response.sendRedirect(request.getContextPath() + "/my_posts.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/home.jsp");
            }
        } else {
            request.setAttribute("error", "Failed to create post");
            request.getRequestDispatcher("/create_post.jsp").forward(request, response);
        }
    }

    private void createComment(HttpServletRequest request, HttpServletResponse response, 
            int userId, String userType) 
            throws ServletException, IOException, SQLException {
        
        String content = request.getParameter("content");
        String parentIdParam = request.getParameter("parentId");
        
        if (content == null || content.trim().isEmpty() || parentIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Content and parent ID are required");
            return;
        }

        int parentId = Integer.parseInt(parentIdParam);
        Posts comment = new Posts();
        comment.setUserId(userId);
        comment.setUserType(userType);
        comment.setParentId(parentId);
        comment.setContent(content);
        comment.setPostType("comment");
        comment.setStatus("active");

        if (postsDAO.createPost(comment)) {
            response.sendRedirect(request.getContextPath() + "/post/" + parentId);
        } else {
            request.setAttribute("error", "Failed to create comment");
            response.sendRedirect(request.getContextPath() + "/post/" + parentId);
        }
    }

    private void toggleLike(HttpServletRequest request, HttpServletResponse response, 
            int userId, String userType) 
            throws ServletException, IOException, SQLException {
        
        String postIdParam = request.getParameter("postId");
        if (postIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Post ID is required");
            return;
        }

        int postId = Integer.parseInt(postIdParam);
        
        if (postsDAO.toggleLike(postId, userId, userType)) {
            response.sendRedirect(request.getContextPath() + "/post/" + postId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to toggle like");
        }
    }

    private void rejectPost(HttpServletRequest request, HttpServletResponse response, 
            int userId, String userType) 
            throws ServletException, IOException, SQLException {
        
        if (!isRecruiter(request.getSession(false))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only recruiters can reject posts");
            return;
        }

        String rejectReason = request.getParameter("rejectReason");
        if (rejectReason == null || rejectReason.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reject reason is required");
            return;
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        if (title == null || title.trim().isEmpty() || 
            content == null || content.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Title and content are required");
            return;
        }

        Posts post = new Posts();
        post.setUserId(userId);
        post.setUserType(userType);
        post.setTitle(title);
        post.setContent(content);
        post.setPostType("post");
        post.setStatus("rejected");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        if (postsDAO.createPost(post)) {
            out.write("{\"success\":true,\"message\":\"Post has been rejected successfully\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"success\":false,\"message\":\"Failed to reject post\"}");
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException, SQLException {
        
        String postIdParam = request.getParameter("postId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        if (postIdParam == null || title == null || content == null || 
            title.trim().isEmpty() || content.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Post ID, title and content are required");
            return;
        }

        int postId = Integer.parseInt(postIdParam);
        Posts post = new Posts();
        post.setId(postId);
        post.setUserId(userId);
        post.setTitle(title);
        post.setContent(content);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        if (postsDAO.updatePost(post)) {
            out.write("{\"success\":true,\"message\":\"Post updated successfully\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"success\":false,\"message\":\"Failed to update post\"}");
        }
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response, int userId)
            throws IOException, SQLException {
        String postIdParam = request.getParameter("postId");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (postIdParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"success\":false,\"message\":\"Post ID is required\"}");
            return;
        }
        int postId = Integer.parseInt(postIdParam);
        if (postsDAO.deletePost(postId, userId)) {
            out.write("{\"success\":true,\"message\":\"Post deleted successfully\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"success\":false,\"message\":\"Failed to delete post\"}");
        }
    }

    private int parsePageNumber(String pageParam) {
        try {
            int page = Integer.parseInt(pageParam);
            return page > 0 ? page : 1;
        } catch (NumberFormatException e) {
            return 1;
        }
    }

    private void handleDatabaseError(SQLException e, HttpServletResponse response) throws IOException {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
            "Database error occurred: " + e.getMessage());
    }

    @Override
    public String getServletInfo() {
        return "Post Controller handles post, comment, and like management";
    }
}