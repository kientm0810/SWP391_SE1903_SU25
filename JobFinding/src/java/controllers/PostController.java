package controllers;

import daos.PostsDAO;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import models.Posts;

@WebServlet(name = "PostController", urlPatterns = {"/post/*"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class PostController extends HttpServlet {

    private PostsDAO postsDAO;
    private static final String UPLOAD_DIRECTORY = "uploads/company_logos";
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; 
    private static final String[] ALLOWED_IMAGE_TYPES = {
        "image/jpeg",
        "image/png",
        "image/gif",
        "image/jpg"
    };

    @Override
    public void init() throws ServletException {
        postsDAO = new PostsDAO();
   
        File uploadDir = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    }

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
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            HttpSession session = request.getSession();
            String userType = (String) session.getAttribute("userType");
            Integer userId = (Integer) session.getAttribute("userId");
            String viewAllParam = request.getParameter("viewAll");
            boolean viewAll = viewAllParam != null && viewAllParam.equals("true");
            
            //Khu phân trang-start
            int page = 1;
            int pageSize = 6; 
            
            try {
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                }
            } catch (NumberFormatException e) {
                page = 1;
            } //end
        
            String keyword = request.getParameter("keyword");
            String jobType = request.getParameter("jobType");
            String location = request.getParameter("location");
            
            // If user is a recruiter and not explicitly requesting to view all posts, only show their own posts
            if (userType != null && userType.equals("recruiter") && userId != null && !viewAll) {
                // Get total number of posts for recruiter and calculate total pages
                int totalPosts = postsDAO.getTotalPostsByRecruiterId(userId);
                int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

                // Get posts for current page for recruiter
                request.setAttribute("posts", postsDAO.getPostsByRecruiterIdWithPagination(userId, page, pageSize));
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("keyword", keyword); // Still pass these even if not used for filtering
                request.setAttribute("jobType", jobType);
                request.setAttribute("location", location);
            } else {
                // Get total number of posts and calculate total pages
                int totalPosts = postsDAO.getTotalPostsWithSearch(keyword, jobType, location);
                int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
                
                // Get posts for current page with search
                request.setAttribute("posts", postsDAO.getPostsByPageWithSearch(page, pageSize, keyword, jobType, location));
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("keyword", keyword);
                request.setAttribute("jobType", jobType);
                request.setAttribute("location", location);
            }
            request.getRequestDispatcher("/posts.jsp").forward(request, response);
        } else if (path.equals("/create")) {
            // Show create post form
            request.getRequestDispatcher("/create-post.jsp").forward(request, response);
        } else if (path.equals("/view")) {
            // View single post
            int id = Integer.parseInt(request.getParameter("id"));
            Posts post = postsDAO.getPostById(id);
            if (post != null) {
                postsDAO.incrementViewCount(id); // tang so luot xem
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
            } else {
                response.sendRedirect(request.getContextPath() + "/post");
            }
        }
    }

    private boolean isImageFile(Part part) {
        String contentType = part.getContentType();
        for (String type : ALLOWED_IMAGE_TYPES) {
            if (type.equals(contentType)) {
                return true;
            }
        }
        return false;
    }

    private boolean validateFileUpload(Part filePart, HttpServletResponse response) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            // Check file size
            if (filePart.getSize() > MAX_FILE_SIZE) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Kích thước file không được vượt quá 5MB\"}");
                return false;
            }

            // Check file type
            if (!isImageFile(filePart)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Chỉ chấp nhận file hình ảnh (jpg, jpeg, png, gif)\"}");
                return false;
            }
        }
        return true;
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
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/create".equals(path)) {
            response.setContentType("application/json");
            try {
                // Validate required fields
                String[] requiredFields = {
                    "title", "companyName", "salary", "location", "jobType",
                    "experience", "deadline", "workingTime", "jobDescription",
                    "requirements", "benefits", "contactAddress", "applicationMethod"
                };

                for (String field : requiredFields) {
                    String value = request.getParameter(field);
                    if (value == null || value.trim().isEmpty()) {
                        response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng điền đầy đủ thông tin " + field + ".\"}");
                        return;
                    }
                }

                // Validate company logo
                Part filePart = request.getPart("companyLogo");
                if (filePart == null || filePart.getSize() == 0) {
                    response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng chọn logo công ty.\"}");
                    return;
                }

                if (!validateFileUpload(filePart, response)) {
                    return; // validation message already sent
                }

                // Create post object
                Posts post = new Posts();
                post.setUserId(userId);
                post.setUserType(userType != null ? userType : "recruiter");
                post.setTitle(request.getParameter("title").trim());
                post.setJobDescription(request.getParameter("jobDescription").trim());
                post.setRequirements(request.getParameter("requirements").trim());
                post.setBenefits(request.getParameter("benefits").trim());
                post.setContactAddress(request.getParameter("contactAddress").trim());
                post.setApplicationMethod(request.getParameter("applicationMethod").trim());
                post.setWorkingTime(request.getParameter("workingTime").trim());
                post.setExperience(request.getParameter("experience").trim());
                post.setCompanyName(request.getParameter("companyName").trim());
                post.setLocation(request.getParameter("location").trim());
                post.setSalary(request.getParameter("salary").trim());
                post.setJobType(request.getParameter("jobType").trim());
                post.setPostType("job");
                post.setStatus("active");
                post.setViewCount(0);
                post.setLikeCount(0);
                post.setCommentCount(0);
                post.setContent(""); // Set empty content as it's not used in the form

                // Handle deadline conversion
                String deadlineStr = request.getParameter("deadline");
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date parsedDate = sdf.parse(deadlineStr);
                    java.util.Date today = new java.util.Date();
                    
                    // Validate if deadline is in the future
                    if (parsedDate.before(today)) {
                        response.getWriter().write("{\"success\":false,\"message\":\"Hạn nộp hồ sơ phải là ngày trong tương lai.\"}");
                        return;
                    }
                    
                    post.setDeadline(new java.sql.Date(parsedDate.getTime()));
                } catch (ParseException e) {
                    response.getWriter().write("{\"success\":false,\"message\":\"Định dạng hạn nộp hồ sơ không hợp lệ.\"}");
                    return;
                }

                // Handle company logo upload
                String fileName = System.currentTimeMillis() + "_" + getSubmittedFileName(filePart);
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File uploadFile = new File(uploadPath, fileName);
                filePart.write(uploadFile.getAbsolutePath());
                post.setCompanyLogo(UPLOAD_DIRECTORY + "/" + fileName);

                // Create post in database
                if (postsDAO.createPost(post)) {
                    response.getWriter().write("{\"success\":true,\"message\":\"Bài đăng đã được tạo thành công!\"}");
                } else {
                    response.getWriter().write("{\"success\":false,\"message\":\"Có lỗi xảy ra khi tạo bài đăng. Vui lòng thử lại.\"}");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("{\"success\":false,\"message\":\"Đã xảy ra lỗi server khi tạo bài đăng.\"}");
            }
        } else if (path.equals("/edit")) {
            // Handle post update
            int id = Integer.parseInt(request.getParameter("id"));
            Posts post = postsDAO.getPostById(id);
            if (post == null || post.getUserId() != userId) {
                response.sendRedirect(request.getContextPath() + "/post");
                return;
            }

            try {
                post.setTitle(request.getParameter("title").trim());
                post.setJobDescription(request.getParameter("jobDescription").trim());
                post.setRequirements(request.getParameter("requirements").trim());
                post.setBenefits(request.getParameter("benefits").trim());
                post.setContactAddress(request.getParameter("contactAddress").trim());
                post.setApplicationMethod(request.getParameter("applicationMethod").trim());
                post.setWorkingTime(request.getParameter("workingTime").trim());
                post.setExperience(request.getParameter("experience").trim());

                // Handle deadline conversion
                String deadlineStr = request.getParameter("deadline");
                if (deadlineStr != null && !deadlineStr.isEmpty()) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date parsedDate = sdf.parse(deadlineStr);
                        post.setDeadline(new java.sql.Date(parsedDate.getTime()));
                    } catch (ParseException e) {
                        e.printStackTrace(); // Log the error
                        request.setAttribute("error", "Invalid deadline format.");
                        request.setAttribute("post", post); 
                        request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
                        return;
                    }
                } else {
                    request.setAttribute("error", "Deadline is required.");
                    request.setAttribute("post", post); 
                    request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
                    return;
                }

                post.setCompanyName(request.getParameter("companyName").trim());
                post.setLocation(request.getParameter("location").trim());
                post.setSalary(request.getParameter("salary").trim());
                post.setJobType(request.getParameter("jobType").trim());

                // Handle company logo upload
                try {
                    Part filePart = request.getPart("companyLogo");
                    if (filePart != null && filePart.getSize() > 0) {
                        // Validate file upload
                        if (!validateFileUpload(filePart, response)) {
                            return;
                        }

                        String fileName = System.currentTimeMillis() + "_" + getSubmittedFileName(filePart);
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        filePart.write(uploadPath + File.separator + fileName);
                        post.setCompanyLogo(UPLOAD_DIRECTORY + "/" + fileName);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error uploading company logo: " + e.getMessage());
                    request.setAttribute("post", post); // Keep post data on form
                    request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
                    return;
                }

                if (postsDAO.updatePost(post)) {
                    response.sendRedirect(request.getContextPath() + "/post/view?id=" + post.getId());
                } else {
                    request.setAttribute("error", "Failed to update post.");
                    request.setAttribute("post", post); // Keep post data on form
                    request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error updating post: " + e.getMessage());
                request.setAttribute("post", post); // Keep post data on form
                request.getRequestDispatcher("/edit-post.jsp").forward(request, response);
            }
        } else if (path.equals("/update")) {
            // Handle post update
            response.setContentType("application/json");
            try {
                int postId = Integer.parseInt(request.getParameter("id"));
                Posts existingPost = postsDAO.getPostById(postId);

                if (existingPost == null || existingPost.getUserId() != userId) {
                    response.getWriter().write("{\"success\":false,\"message\":\"Bạn không có quyền chỉnh sửa bài đăng này.\"}");
                    return;
                }

                existingPost.setTitle(request.getParameter("title").trim());
                existingPost.setCompanyName(request.getParameter("companyName").trim());
                existingPost.setSalary(request.getParameter("salary").trim());
                existingPost.setLocation(request.getParameter("location").trim());
                existingPost.setJobType(request.getParameter("jobType").trim());
                existingPost.setExperience(request.getParameter("experience").trim());
                existingPost.setWorkingTime(request.getParameter("workingTime").trim());
                existingPost.setJobDescription(request.getParameter("jobDescription").trim());
                existingPost.setRequirements(request.getParameter("requirements").trim());
                existingPost.setBenefits(request.getParameter("benefits").trim());
                existingPost.setContactAddress(request.getParameter("contactAddress").trim());
                existingPost.setApplicationMethod(request.getParameter("applicationMethod").trim());
                existingPost.setStatus(request.getParameter("status").trim());

                // Handle deadline conversion
                String deadlineStr = request.getParameter("deadline");
                if (deadlineStr != null && !deadlineStr.isEmpty()) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date parsedDate = sdf.parse(deadlineStr);
                        existingPost.setDeadline(new java.sql.Date(parsedDate.getTime()));
                    } catch (ParseException e) {
                        e.printStackTrace();
                        response.getWriter().write("{\"success\":false,\"message\":\"Định dạng hạn nộp hồ sơ không hợp lệ.\"}");
                        return;
                    }
                } else {
                    response.getWriter().write("{\"success\":false,\"message\":\"Hạn nộp hồ sơ là bắt buộc.\"}");
                    return;
                }

                // Handle company logo upload
                Part filePart = request.getPart("companyLogo");
                if (filePart != null && filePart.getSize() > 0) {
                    if (!validateFileUpload(filePart, response)) {
                        return; // validation message already sent
                    }
                    String fileName = getSubmittedFileName(filePart);
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                    File uploadFile = new File(uploadPath, fileName);
                    filePart.write(uploadFile.getAbsolutePath());
                    existingPost.setCompanyLogo(UPLOAD_DIRECTORY + "/" + fileName);
                }

                if (postsDAO.updatePost(existingPost)) {
                    response.getWriter().write("{\"success\":true,\"message\":\"Cập nhật tin thành công!\"}");
                } else {
                    response.getWriter().write("{\"success\":false,\"message\":\"Có lỗi xảy ra khi cập nhật tin. Vui lòng thử lại.\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("{\"success\":false,\"message\":\"Đã xảy ra lỗi server khi cập nhật tin.\"}");
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

