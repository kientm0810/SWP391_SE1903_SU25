package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import daos.PostsDAO;
import java.io.*;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import jakarta.servlet.http.Part;
import models.Posts;

@WebServlet(name = "PostController", urlPatterns = {"/post/*"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class PostController extends HttpServlet {

    private PostsDAO postsDAO;
    private static final String UPLOAD_DIRECTORY = "uploads/company_logos";

    @Override
    public void init() throws ServletException {
        postsDAO = new PostsDAO();
        // Create upload directory if it doesn't exist
        File uploadDir = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            // List all posts
            request.setAttribute("posts", postsDAO.getAllPosts());
            request.getRequestDispatcher("/posts.jsp").forward(request, response);
        } else if (path.equals("/create")) {
            // Show create post form
            request.getRequestDispatcher("/create-post.jsp").forward(request, response);
        } else if (path.equals("/view")) {
            // View single post
            int id = Integer.parseInt(request.getParameter("id"));
            Posts post = postsDAO.getPostById(id);
            if (post != null) {
                postsDAO.incrementViewCount(id); // Increment view count
                request.setAttribute("post", post);
                request.getRequestDispatcher("/view-post.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/post");
            }
        } else if (path.equals("/edit")) {
            // Show edit form
            int id = Integer.parseInt(request.getParameter("id"));
            Posts post = postsDAO.getPostById(id);
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (post != null && userId != null && post.getUserId() == userId) {
                request.setAttribute("post", post);
                request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/post");
            }
        } else if (path.equals("/delete")) {
            // Delete post
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            Posts post = postsDAO.getPostById(id);
            
            if (post != null && userId != null && post.getUserId() == userId) {
                if (postsDAO.deletePost(id)) {
                    response.sendRedirect(request.getContextPath() + "/post");
                } else {
                    request.setAttribute("error", "Failed to delete post");
                    request.getRequestDispatcher("/post").forward(request, response);
                }
                
                // Increment view count
                postsDAO.incrementViewCount(postId);
                
                // Get comments
                List<Posts> comments = postsDAO.getPostComments(postId);
                
                request.setAttribute("post", post);
                request.setAttribute("comments", comments);
                request.getRequestDispatcher("/post_detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/post");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");

        if (userId == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"message\":\"Please login to create a post\"}");
            return;
        }

        if (path == null || path.equals("/")) {
            // List all posts
            request.setAttribute("posts", postsDAO.getAllPosts());
            request.getRequestDispatcher("/posts.jsp").forward(request, response);
        } else if (path.equals("/create")) {
            try {
                // Create new post object
                Posts post = new Posts();
                post.setUserId(userId);
                post.setUserType("recruiter");
                post.setParentId(null);
                post.setPostType("post");
                post.setTitle(request.getParameter("title").trim());
                post.setStatus("active");
                post.setViewCount(0);
                post.setLikeCount(0);
                post.setCommentCount(0);
                post.setCompanyName(request.getParameter("companyName").trim());
                post.setLocation(request.getParameter("location").trim());
                post.setSalary(request.getParameter("salary").trim());
                post.setJobType(request.getParameter("jobType").trim());
                post.setExperience(request.getParameter("experience").trim());
                
                // Handle company logo upload
                try {
                    Part filePart = request.getPart("companyLogo");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = System.currentTimeMillis() + "_" + getSubmittedFileName(filePart);
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        filePart.write(uploadPath + File.separator + fileName);
                        post.setCompanyLogo(UPLOAD_DIRECTORY + "/" + fileName);
                    } else {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng chọn logo công ty\"}");
                        return;
                    }
                } catch (Exception e) {
                    System.err.println("Error handling file upload: " + e.getMessage());
                    e.printStackTrace();
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\":false,\"message\":\"Lỗi khi tải lên logo: " + e.getMessage() + "\"}");
                    return;
                }
                
                // Parse deadline date
                String deadlineStr = request.getParameter("deadline");
                if (deadlineStr != null && !deadlineStr.isEmpty()) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        post.setDeadline(new Date(sdf.parse(deadlineStr).getTime()));
                    } catch (ParseException e) {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\":false,\"message\":\"Định dạng ngày không hợp lệ\"}");
                        return;
                    }
                } else {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng chọn hạn nộp hồ sơ\"}");
                    return;
                }
                
                post.setWorkingTime(request.getParameter("workingTime").trim());
                post.setJobDescription(request.getParameter("jobDescription").trim());
                post.setRequirements(request.getParameter("requirements").trim());
                post.setBenefits(request.getParameter("benefits").trim());
                post.setContactAddress(request.getParameter("contactAddress").trim());
                post.setApplicationMethod(request.getParameter("applicationMethod").trim());

                // Validate all required fields
                if (post.getTitle() == null || post.getTitle().trim().isEmpty() ||
                    post.getCompanyName() == null || post.getCompanyName().trim().isEmpty() ||
                    post.getSalary() == null || post.getSalary().trim().isEmpty() ||
                    post.getLocation() == null || post.getLocation().trim().isEmpty() ||
                    post.getJobType() == null || post.getJobType().trim().isEmpty() ||
                    post.getExperience() == null || post.getExperience().trim().isEmpty() ||
                    post.getWorkingTime() == null || post.getWorkingTime().trim().isEmpty() ||
                    post.getJobDescription() == null || post.getJobDescription().trim().isEmpty() ||
                    post.getRequirements() == null || post.getRequirements().trim().isEmpty() ||
                    post.getBenefits() == null || post.getBenefits().trim().isEmpty() ||
                    post.getContactAddress() == null || post.getContactAddress().trim().isEmpty() ||
                    post.getApplicationMethod() == null || post.getApplicationMethod().trim().isEmpty()) {
                    
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng điền đầy đủ thông tin\"}");
                    return;
                }

                // Try to create the post
                boolean success = postsDAO.createPost(post);
                
                response.setContentType("application/json");
                if (success) {
                    response.getWriter().write("{\"success\":true,\"message\":\"Đăng tin thành công\"}");
                } else {
                    response.getWriter().write("{\"success\":false,\"message\":\"Không thể tạo tin. Vui lòng kiểm tra lại thông tin.\"}");
                }
            } catch (Exception e) {
                System.err.println("Error creating post: " + e.getMessage());
                e.printStackTrace();
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Có lỗi xảy ra khi tạo bài đăng: " + e.getMessage() + "\"}");
            }
        } else if (path.equals("/update")) {
            // Update existing post
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Posts post = postsDAO.getPostById(id);
                
                if (post != null && post.getUserId() == userId) {
                    post.setTitle(request.getParameter("title").trim());
                    post.setStatus(request.getParameter("status"));
                    post.setCompanyName(request.getParameter("companyName").trim());
                    post.setLocation(request.getParameter("location").trim());
                    post.setSalary(request.getParameter("salary").trim());
                    post.setJobType(request.getParameter("jobType").trim());
                    post.setExperience(request.getParameter("experience").trim());
                    
                    // Handle company logo upload
                    Part filePart = request.getPart("companyLogo");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = System.currentTimeMillis() + "_" + getSubmittedFileName(filePart);
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        // Delete old logo if exists
                        if (post.getCompanyLogo() != null) {
                            File oldFile = new File(getServletContext().getRealPath("") + File.separator + post.getCompanyLogo());
                            if (oldFile.exists()) {
                                oldFile.delete();
                            }
                        }
                        
                        filePart.write(uploadPath + File.separator + fileName);
                        post.setCompanyLogo(UPLOAD_DIRECTORY + "/" + fileName);
                    }
                    
                    // Parse deadline date
                    String deadlineStr = request.getParameter("deadline");
                    if (deadlineStr != null && !deadlineStr.isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        post.setDeadline(new Date(sdf.parse(deadlineStr).getTime()));
                    }
                    
                    post.setWorkingTime(request.getParameter("workingTime").trim());
                    post.setJobDescription(request.getParameter("jobDescription").trim());
                    post.setRequirements(request.getParameter("requirements").trim());
                    post.setBenefits(request.getParameter("benefits").trim());
                    post.setContactAddress(request.getParameter("contactAddress").trim());
                    post.setApplicationMethod(request.getParameter("applicationMethod").trim());

                    if (postsDAO.updatePost(post)) {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\":true,\"message\":\"Post updated successfully\"}");
                    } else {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\":false,\"message\":\"Failed to update post\"}");
                    }
                } else {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\":false,\"message\":\"Post not found or unauthorized\"}");
                }
            } catch (ParseException e) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Invalid date format\"}");
            }
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}