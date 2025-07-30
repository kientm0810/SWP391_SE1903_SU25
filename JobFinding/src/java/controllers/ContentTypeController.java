package controllers;

import java.io.IOException;
import java.util.Vector;

import daos.BlogTypeDAO;
import daos.PostTypeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.BlogType;
import models.PostType;

/**
 * Controller quản lý các loại nội dung (PostType và BlogType)
 */
@WebServlet(name = "ContentTypeController", urlPatterns = {"/content-type/*"})
public class ContentTypeController extends HttpServlet {

    private PostTypeDAO postTypeDAO;
    private BlogTypeDAO blogTypeDAO;

    @Override
    public void init() throws ServletException {
        postTypeDAO = new PostTypeDAO();
        blogTypeDAO = new BlogTypeDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (pathInfo) {
                case "/post-types":
                    handlePostTypes(request, response, action);
                    break;
                case "/blog-types":
                    handleBlogTypes(request, response, action);
                    break;
                case "/api/post-types":
                    handlePostTypesAPI(request, response, action);
                    break;
                case "/api/blog-types":
                    handleBlogTypesAPI(request, response, action);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void handlePostTypes(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        switch (action) {
            case "list":
                listPostTypes(request, response);
                break;
            case "create":
                createPostType(request, response);
                break;
            case "edit":
                editPostType(request, response);
                break;
            case "update":
                updatePostType(request, response);
                break;
            case "delete":
                deletePostType(request, response);
                break;
            default:
                listPostTypes(request, response);
                break;
        }
    }

    private void handleBlogTypes(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        switch (action) {
            case "list":
                listBlogTypes(request, response);
                break;
            case "create":
                createBlogType(request, response);
                break;
            case "edit":
                editBlogType(request, response);
                break;
            case "update":
                updateBlogType(request, response);
                break;
            case "delete":
                deleteBlogType(request, response);
                break;
            default:
                listBlogTypes(request, response);
                break;
        }
    }

    private void handlePostTypesAPI(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
        switch (action) {
            case "get-all":
                getAllPostTypesAPI(request, response);
                break;
            case "get-by-category":
                getPostTypesByCategoryAPI(request, response);
                break;
            case "get-job-posting-types":
                getJobPostingTypesAPI(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                break;
        }
    }

    private void handleBlogTypesAPI(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
        switch (action) {
            case "get-all":
                getAllBlogTypesAPI(request, response);
                break;
            case "get-by-category":
                getBlogTypesByCategoryAPI(request, response);
                break;
            case "get-by-audience":
                getBlogTypesByAudienceAPI(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                break;
        }
    }

    // PostType Management Methods
    private void listPostTypes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Vector<PostType> postTypes = postTypeDAO.getAllPostTypes();
        Vector<Object[]> stats = postTypeDAO.getPostTypeStats();
        
        request.setAttribute("postTypes", postTypes);
        request.setAttribute("stats", stats);
        
        // Handle messages from redirect
        String message = request.getParameter("message");
        if ("created".equals(message)) {
            request.setAttribute("message", "Tạo loại bài đăng thành công!");
        } else if ("updated".equals(message)) {
            request.setAttribute("message", "Cập nhật loại bài đăng thành công!");
        } else if ("deleted".equals(message)) {
            request.setAttribute("message", "Xóa loại bài đăng thành công!");
        }
        
        request.getRequestDispatcher("/admin_post_types.jsp").forward(request, response);
    }

    private void createPostType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String submit = request.getParameter("submit");
        
        if ("submit".equals(submit)) {
            try {
                // Validate required fields
                String typeCode = request.getParameter("typeCode");
                String typeName = request.getParameter("typeName");
                String category = request.getParameter("category");
                String priorityLevelStr = request.getParameter("priorityLevel");
                
                if (typeCode == null || typeCode.trim().isEmpty() ||
                    typeName == null || typeName.trim().isEmpty() ||
                    category == null || category.trim().isEmpty() ||
                    priorityLevelStr == null || priorityLevelStr.trim().isEmpty()) {
                    request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                    request.getRequestDispatcher("/admin_create_post_type.jsp").forward(request, response);
                    return;
                }
                
                // Check if typeCode already exists
                if (postTypeDAO.isTypeCodeExists(typeCode.trim())) {
                    request.setAttribute("error", "Mã code '" + typeCode + "' đã tồn tại! Vui lòng chọn mã khác.");
                    request.getRequestDispatcher("/admin_create_post_type.jsp").forward(request, response);
                    return;
                }
                
                PostType postType = new PostType();
                postType.setTypeCode(typeCode.trim());
                postType.setTypeName(typeName.trim());
                postType.setDescription(request.getParameter("description") != null ? request.getParameter("description").trim() : "");
                postType.setCategory(category.trim());
                postType.setPriorityLevel(Integer.parseInt(priorityLevelStr.trim()));
                postType.setActive(true);
                postType.setIconClass(request.getParameter("iconClass") != null ? request.getParameter("iconClass").trim() : "");
                postType.setColorCode(request.getParameter("colorCode") != null ? request.getParameter("colorCode").trim() : "#007bff");
                
                if (postTypeDAO.createPostType(postType)) {
                    request.setAttribute("message", "Tạo loại bài đăng thành công!");
                    // Redirect to list page after successful creation
                    response.sendRedirect(request.getContextPath() + "/content-type/post-types?action=list&message=created");
                    return;
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi tạo loại bài đăng! Vui lòng thử lại.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Mức ưu tiên không hợp lệ! Vui lòng nhập số.");
            } catch (Exception e) {
                request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        request.getRequestDispatcher("/admin_create_post_type.jsp").forward(request, response);
    }

    private void editPostType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        PostType postType = postTypeDAO.getPostTypeById(id);
        
        if (postType != null) {
            request.setAttribute("postType", postType);
            request.getRequestDispatcher("/admin_edit_post_type.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/content-type/post-types?action=list");
        }
    }

    private void updatePostType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        PostType postType = postTypeDAO.getPostTypeById(id);
        
        if (postType != null) {
            postType.setTypeCode(request.getParameter("typeCode"));
            postType.setTypeName(request.getParameter("typeName"));
            postType.setDescription(request.getParameter("description"));
            postType.setCategory(request.getParameter("category"));
            postType.setPriorityLevel(Integer.parseInt(request.getParameter("priorityLevel")));
            postType.setIconClass(request.getParameter("iconClass"));
            postType.setColorCode(request.getParameter("colorCode"));
            
            if (postTypeDAO.updatePostType(postType)) {
                request.setAttribute("message", "Cập nhật loại bài đăng thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật loại bài đăng!");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/content-type/post-types?action=list");
    }

    private void deletePostType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (postTypeDAO.deletePostType(id)) {
            request.setAttribute("message", "Xóa loại bài đăng thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi xóa loại bài đăng!");
        }
        
        response.sendRedirect(request.getContextPath() + "/content-type/post-types?action=list");
    }

    // BlogType Management Methods
    private void listBlogTypes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Vector<BlogType> blogTypes = blogTypeDAO.getAllBlogTypes();
        Vector<Object[]> stats = blogTypeDAO.getBlogTypeStats();
        
        request.setAttribute("blogTypes", blogTypes);
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/admin_blog_types.jsp").forward(request, response);
    }

    private void createBlogType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String submit = request.getParameter("submit");
        
        if ("submit".equals(submit)) {
            BlogType blogType = new BlogType();
            blogType.setTypeCode(request.getParameter("typeCode"));
            blogType.setTypeName(request.getParameter("typeName"));
            blogType.setDescription(request.getParameter("description"));
            blogType.setCategory(request.getParameter("category"));
            blogType.setTargetAudience(request.getParameter("targetAudience"));
            blogType.setContentFormat(request.getParameter("contentFormat"));
            blogType.setActive(true);
            blogType.setIconClass(request.getParameter("iconClass"));
            blogType.setColorCode(request.getParameter("colorCode"));
            blogType.setSeoKeywords(request.getParameter("seoKeywords"));
            
            if (blogTypeDAO.createBlogType(blogType)) {
                request.setAttribute("message", "Tạo loại blog thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi tạo loại blog!");
            }
        }
        
        request.getRequestDispatcher("/admin_create_blog_type.jsp").forward(request, response);
    }

    private void editBlogType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        BlogType blogType = blogTypeDAO.getBlogTypeById(id);
        
        if (blogType != null) {
            request.setAttribute("blogType", blogType);
            request.getRequestDispatcher("/admin_edit_blog_type.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/content-type/blog-types?action=list");
        }
    }

    private void updateBlogType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        BlogType blogType = blogTypeDAO.getBlogTypeById(id);
        
        if (blogType != null) {
            blogType.setTypeCode(request.getParameter("typeCode"));
            blogType.setTypeName(request.getParameter("typeName"));
            blogType.setDescription(request.getParameter("description"));
            blogType.setCategory(request.getParameter("category"));
            blogType.setTargetAudience(request.getParameter("targetAudience"));
            blogType.setContentFormat(request.getParameter("contentFormat"));
            blogType.setIconClass(request.getParameter("iconClass"));
            blogType.setColorCode(request.getParameter("colorCode"));
            blogType.setSeoKeywords(request.getParameter("seoKeywords"));
            
            if (blogTypeDAO.updateBlogType(blogType)) {
                request.setAttribute("message", "Cập nhật loại blog thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật loại blog!");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/content-type/blog-types?action=list");
    }

    private void deleteBlogType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (blogTypeDAO.deleteBlogType(id)) {
            request.setAttribute("message", "Xóa loại blog thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi xóa loại blog!");
        }
        
        response.sendRedirect(request.getContextPath() + "/content-type/blog-types?action=list");
    }

    // API Methods
    private void getAllPostTypesAPI(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Vector<PostType> postTypes = postTypeDAO.getAllPostTypes();
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < postTypes.size(); i++) {
            PostType pt = postTypes.get(i);
            json.append("{");
            json.append("\"id\":").append(pt.getId()).append(",");
            json.append("\"typeCode\":\"").append(pt.getTypeCode()).append("\",");
            json.append("\"typeName\":\"").append(pt.getTypeName()).append("\",");
            json.append("\"category\":\"").append(pt.getCategory()).append("\",");
            json.append("\"iconClass\":\"").append(pt.getIconClass()).append("\",");
            json.append("\"colorCode\":\"").append(pt.getColorCode()).append("\"");
            json.append("}");
            if (i < postTypes.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    private void getPostTypesByCategoryAPI(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        Vector<PostType> postTypes = postTypeDAO.getPostTypesByCategory(category);
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < postTypes.size(); i++) {
            PostType pt = postTypes.get(i);
            json.append("{");
            json.append("\"id\":").append(pt.getId()).append(",");
            json.append("\"typeCode\":\"").append(pt.getTypeCode()).append("\",");
            json.append("\"typeName\":\"").append(pt.getTypeName()).append("\"");
            json.append("}");
            if (i < postTypes.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    private void getJobPostingTypesAPI(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Vector<PostType> postTypes = postTypeDAO.getJobPostingTypes();
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < postTypes.size(); i++) {
            PostType pt = postTypes.get(i);
            json.append("{");
            json.append("\"id\":").append(pt.getId()).append(",");
            json.append("\"typeCode\":\"").append(pt.getTypeCode()).append("\",");
            json.append("\"typeName\":\"").append(pt.getTypeName()).append("\",");
            json.append("\"description\":\"").append(pt.getDescription()).append("\"");
            json.append("}");
            if (i < postTypes.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    private void getAllBlogTypesAPI(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Vector<BlogType> blogTypes = blogTypeDAO.getAllBlogTypes();
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < blogTypes.size(); i++) {
            BlogType bt = blogTypes.get(i);
            json.append("{");
            json.append("\"id\":").append(bt.getId()).append(",");
            json.append("\"typeCode\":\"").append(bt.getTypeCode()).append("\",");
            json.append("\"typeName\":\"").append(bt.getTypeName()).append("\",");
            json.append("\"category\":\"").append(bt.getCategory()).append("\",");
            json.append("\"targetAudience\":\"").append(bt.getTargetAudience()).append("\"");
            json.append("}");
            if (i < blogTypes.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    private void getBlogTypesByCategoryAPI(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        Vector<BlogType> blogTypes = blogTypeDAO.getBlogTypesByCategory(category);
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < blogTypes.size(); i++) {
            BlogType bt = blogTypes.get(i);
            json.append("{");
            json.append("\"id\":").append(bt.getId()).append(",");
            json.append("\"typeCode\":\"").append(bt.getTypeCode()).append("\",");
            json.append("\"typeName\":\"").append(bt.getTypeName()).append("\"");
            json.append("}");
            if (i < blogTypes.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    private void getBlogTypesByAudienceAPI(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String audience = request.getParameter("audience");
        Vector<BlogType> blogTypes = blogTypeDAO.getBlogTypesByTargetAudience(audience);
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < blogTypes.size(); i++) {
            BlogType bt = blogTypes.get(i);
            json.append("{");
            json.append("\"id\":").append(bt.getId()).append(",");
            json.append("\"typeCode\":\"").append(bt.getTypeCode()).append("\",");
            json.append("\"typeName\":\"").append(bt.getTypeName()).append("\",");
            json.append("\"category\":\"").append(bt.getCategory()).append("\"");
            json.append("}");
            if (i < blogTypes.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Content Type Management Controller";
    }
} 