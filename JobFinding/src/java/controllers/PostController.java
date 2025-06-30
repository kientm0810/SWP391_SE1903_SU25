package controllers;

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
        "image/jpg",
        "image/webp"
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
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            String view = request.getParameter("view");
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            String userType = (String) session.getAttribute("userType");
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
            
            String keyword = request.getParameter("keyword");
            String jobType = request.getParameter("jobType");
            String location = request.getParameter("location");
            boolean isMyPosts = false;
            //recruiter xem bài đăng của mình 
            if (userType != null && userType.equals("recruiter")) {
                if (view != null && view.equals("my-post") && userId != null) {
                    int totalPosts = postsDAO.getTotalPostsByUserId(userId);
                    int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
                    request.setAttribute("posts", postsDAO.getPostsByUserIdWithPaging(userId, page, pageSize));
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("pageSize", pageSize);
                    isMyPosts = true;
                } else {
                    // recruiter xem tất cả bài post
                    int totalPosts = postsDAO.getTotalPostsWithSearch(keyword, jobType, location);
                    int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
                    request.setAttribute("posts", postsDAO.getPostsByPageWithSearch(page, pageSize, keyword, jobType, location));
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("pageSize", pageSize);
                    request.setAttribute("keyword", keyword);
                    request.setAttribute("jobType", jobType);
                    request.setAttribute("location", location);
                }
            } else {
                // user thường hoặc chưa đăng nhập: chỉ xem tất cả bài post
                int totalPosts = postsDAO.getTotalPostsWithSearch(keyword, jobType, location);
                int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
                request.setAttribute("posts", postsDAO.getPostsByPageWithSearch(page, pageSize, keyword, jobType, location));
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("keyword", keyword);
                request.setAttribute("jobType", jobType);
                request.setAttribute("location", location);
            }
            request.setAttribute("isMyPosts", isMyPosts);
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
                response.getWriter().write("{\"success\":false,\"message\":\"Chỉ chấp nhận file hình ảnh (jpg, jpeg, png, gif, webp)\"}");
                return false;
            }
        }
        return true;
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
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

                // Lấy company logo upload
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
                post.setJobDescription(request.getParameter("jobDescription") != null ? request.getParameter("jobDescription").trim() : null);
                post.setRequirements(request.getParameter("requirements") != null ? request.getParameter("requirements").trim() : null);
                post.setBenefits(request.getParameter("benefits") != null ? request.getParameter("benefits").trim() : null);
                post.setContactAddress(request.getParameter("contactAddress") != null ? request.getParameter("contactAddress").trim() : null);
                post.setApplicationMethod(request.getParameter("applicationMethod") != null ? request.getParameter("applicationMethod").trim() : null);
                post.setRank(request.getParameter("rank") != null ? request.getParameter("rank").trim() : null);
                post.setIndustry(request.getParameter("industry") != null ? request.getParameter("industry").trim() : null);
                post.setContactPerson(request.getParameter("contactPerson") != null ? request.getParameter("contactPerson").trim() : null);
                post.setCompanySize(request.getParameter("companySize") != null ? request.getParameter("companySize").trim() : null);
                post.setCompanyWebsite(request.getParameter("companyWebsite") != null ? request.getParameter("companyWebsite").trim() : null);
                post.setCompanyDescription(request.getParameter("companyDescription") != null ? request.getParameter("companyDescription").trim() : null);
                post.setKeywords(request.getParameter("keywords") != null ? request.getParameter("keywords").trim() : null);

                // Validate all required fields
                if (post.getTitle() == null || post.getTitle().trim().isEmpty()
                        || post.getCompanyName() == null || post.getCompanyName().trim().isEmpty()
                        || post.getSalary() == null || post.getSalary().trim().isEmpty()
                        || post.getLocation() == null || post.getLocation().trim().isEmpty()
                        || post.getJobType() == null || post.getJobType().trim().isEmpty()
                        || post.getExperience() == null || post.getExperience().trim().isEmpty()
                        || post.getWorkingTime() == null || post.getWorkingTime().trim().isEmpty()
                        || post.getJobDescription() == null || post.getJobDescription().trim().isEmpty()
                        || post.getRequirements() == null || post.getRequirements().trim().isEmpty()
                        || post.getBenefits() == null || post.getBenefits().trim().isEmpty()
                        || post.getContactAddress() == null || post.getContactAddress().trim().isEmpty()
                        || post.getApplicationMethod() == null || post.getApplicationMethod().trim().isEmpty()) {

                    System.err.println("Missing required fields:");
                    if (post.getTitle() == null || post.getTitle().trim().isEmpty()) System.err.println("- Title is missing");
                    if (post.getCompanyName() == null || post.getCompanyName().trim().isEmpty()) System.err.println("- Company name is missing");
                    if (post.getSalary() == null || post.getSalary().trim().isEmpty()) System.err.println("- Salary is missing");
                    if (post.getLocation() == null || post.getLocation().trim().isEmpty()) System.err.println("- Location is missing");
                    if (post.getJobType() == null || post.getJobType().trim().isEmpty()) System.err.println("- Job type is missing");
                    if (post.getExperience() == null || post.getExperience().trim().isEmpty()) System.err.println("- Experience is missing");
                    if (post.getWorkingTime() == null || post.getWorkingTime().trim().isEmpty()) System.err.println("- Working time is missing");
                    if (post.getJobDescription() == null || post.getJobDescription().trim().isEmpty()) System.err.println("- Job description is missing");
                    if (post.getRequirements() == null || post.getRequirements().trim().isEmpty()) System.err.println("- Requirements is missing");
                    if (post.getBenefits() == null || post.getBenefits().trim().isEmpty()) System.err.println("- Benefits is missing");
                    if (post.getContactAddress() == null || post.getContactAddress().trim().isEmpty()) System.err.println("- Contact address is missing");
                    if (post.getApplicationMethod() == null || post.getApplicationMethod().trim().isEmpty()) System.err.println("- Application method is missing");

                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng điền đầy đủ thông tin\"}");
                    return;
                }

                // Try to create the post
                boolean success = postsDAO.createPost(post);

                if (!success) {
                    System.err.println("Failed to create post. Database connection status: " + (postsDAO != null && postsDAO.getConnection() != null));
                }

                response.setContentType("application/json");
                if (success) {
                    // Trả về URL để redirect đến trang My Posts sau khi tạo thành công
                    response.getWriter().write("{\"success\":true,\"message\":\"Đăng tin thành công\",\"redirectUrl\":\"" + request.getContextPath() + "/post?view=my-post\"}");
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
            // Update post
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

                    // lấy company logo upload
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
                    post.setRank(request.getParameter("rank") != null ? request.getParameter("rank").trim() : null);
                    post.setIndustry(request.getParameter("industry") != null ? request.getParameter("industry").trim() : null);
                    post.setContactPerson(request.getParameter("contactPerson") != null ? request.getParameter("contactPerson").trim() : null);
                    post.setCompanySize(request.getParameter("companySize") != null ? request.getParameter("companySize").trim() : null);
                    post.setCompanyWebsite(request.getParameter("companyWebsite") != null ? request.getParameter("companyWebsite").trim() : null);
                    post.setCompanyDescription(request.getParameter("companyDescription") != null ? request.getParameter("companyDescription").trim() : null);
                    post.setKeywords(request.getParameter("keywords") != null ? request.getParameter("keywords").trim() : null);

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
        } else if (path.equals("/delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Posts post = postsDAO.getPostById(id);

                if (post != null && userId != null && post.getUserId() == userId) {
                    if (postsDAO.deletePost(id)) {
                        response.sendRedirect(request.getContextPath() + "/post?view=my-post&deleteSuccess=true");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/post/view?id=" + id + "&error=deleteFailed");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/post/view?id=" + id + "&error=unauthorized");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/post?error=invalidId");
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

