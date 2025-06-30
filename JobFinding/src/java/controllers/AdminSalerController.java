/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import daos.BlogDAO;
import models.Blog;
import models.Banner;
import daos.BannerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Map;
import java.util.Vector;
import utils.UploadPicture;

/**
 *
 * @author andin
 */
@MultipartConfig
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
            log("qua day truoc da");
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

        log("di qua day ma");

        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("admin_saler_allblog.jsp").forward(request, response);
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
            
            ///
            String thumbnail = "";
            try {
                Part filePart = request.getPart("thumbnail");

                String contentType = filePart.getContentType();

                if (contentType != null && contentType.startsWith("image/")) {
                } else {
                    // Không phải ảnh
                    request.setAttribute("mustbeImg", "Chỉ cho phép upload file ảnh!");
                    request.getRequestDispatcher("admin_saler_add_blog.jsp").forward(request, response);
                    return;
                }

                thumbnail = UploadPicture.uploadImage(filePart, thumbnail);

            } catch (Exception e) {
                log(e.getMessage());
            }
            ///
            
            String description = request.getParameter("description");
            String status = "draft";
            int admin_id = 1;//Integer.parseInt(1); // can fix

            Blog blog = new Blog(admin_id, title, description, thumbnail, status);

            BlogDAO dao = new BlogDAO();

            boolean flag = dao.insertBlog(blog);
            log("add " + flag);

            response.sendRedirect("AdminSalerController?target=blog");

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
            
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            BlogDAO dao = new BlogDAO();
            
            Blog x = dao.getBlogById(blogId);
            
            //
            String thumbnail = x.getThumbnail();
            
            try {
                Part filePart = request.getPart("thumbnail");
                
                if (filePart != null && filePart.getSize() > 0){
                    String contentType = filePart.getContentType();

                    if (contentType != null && contentType.startsWith("image/")) {
                    } else {
                        // Không phải ảnh
                        request.setAttribute("mustbeImg", "Chỉ cho phép upload file ảnh!");
                        request.setAttribute("blog", x);
                        request.getRequestDispatcher("admin_saler_add_blog.jsp").forward(request, response);
                        return;
                    }
                } else {
                }

                thumbnail = UploadPicture.uploadImage(filePart, thumbnail);

            } catch (Exception e) {
                log(e.getMessage());
            }
            
            //
            
            String description = request.getParameter("description");
            String status = "draft";
            int admin_id = 1;//Integer.parseInt(1); // can fix
            int blogID = Integer.parseInt(request.getParameter("blogId"));
           
            Blog blog = new Blog(blogID, admin_id, title, description, thumbnail, status);

            boolean flag = dao.updateBlogFields(blog);
//            log("update " + flag);

            response.sendRedirect("AdminSalerController?target=blog");

        } else {
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            BlogDAO dao = new BlogDAO();
            Blog blog = dao.getBlogById(blogId);
            
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("admin_saler_add_blog.jsp").forward(request, response);
        }
    }
    
    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogID = Integer.parseInt(request.getParameter("blogId"));
        
        BlogDAO dao = new BlogDAO();
        boolean flag = dao.deleteBlog(blogID);
        
//        log("delete " + flag);
        response.sendRedirect("AdminSalerController?target=blog");
    }
    
    private void processBanner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");

        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            listAllBanner(request, response);
        } else if (service.equals("listMy")) {

        } else if (service.equals("Add")) {
            addBanner(request, response);
        } else if (service.equals("Detail")) {
            detailBanner(request, response);
        } else if (service.equals("Update")){
            updateBanner(request, response);
        } else if (service.equals("Delete")){
            deleteBanner(request, response);
        }
    }
    
    private void listAllBanner(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        BannerDAO bannerDAO = new BannerDAO();
        Vector<Banner> banners = new Vector<>();

        String who = request.getParameter("who");
        if (who == null) {
            who = "";
        }

        if (who.equals("me")) {
            HttpSession session = request.getSession(true);
            int id = (int) session.getAttribute("userId");
            banners = bannerDAO.getBannersByAdminId(id);
        } else {
            banners = bannerDAO.getAllBanners(); // Lấy toàn bộ banner
        }
        
        log("banner " + banners.size());

        request.setAttribute("banners", banners);
        request.getRequestDispatcher("admin_saler_allbanner.jsp").forward(request, response);
    }

    private void addBanner(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String submit = request.getParameter("submit");

        if (submit == null) {
            submit = "";
        }
        
        if (submit.equals("submit")) {
            String title = request.getParameter("title");
            log("da qua day ");
            
            /// xu li check xem co phai la file anh hay khong
            
            String imageUrl = "";
            try {
                Part filePart = request.getPart("file");

                String contentType = filePart.getContentType();

                if (contentType != null && contentType.startsWith("image/")) {
                } else {
                    // Không phải ảnh
                    request.setAttribute("mustbeImg", "Chỉ cho phép upload file ảnh!");
                    request.getRequestDispatcher("admin_saler_add_banner.jsp").forward(request, response);
                    return;
                }

                imageUrl = UploadPicture.uploadImage(filePart, imageUrl);

            } catch (Exception e) {
                log(e.getMessage());
            }
            ///
            
            String redirectUrl = request.getParameter("redirect_url");
            int position = Integer.parseInt(request.getParameter("position"));
            boolean isActive = request.getParameter("is_active") != null;
            int admin_id = 1; // Lấy từ session nếu có, ví dụ: (int) session.getAttribute("userId")

            Banner banner = new Banner(admin_id, title, imageUrl, redirectUrl, position, isActive);

            BannerDAO dao = new BannerDAO();
            boolean flag = dao.insertBanner(banner);
            log("Add banner: " + flag);

            response.sendRedirect("AdminSalerController?target=banner");
        } else {
            request.getRequestDispatcher("admin_saler_add_banner.jsp").forward(request, response);
        }
    }

    private void updateBanner(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String submit = request.getParameter("submit");

        if (submit == null) {
            submit = "";
        }

        if (submit.equals("submit")) {
            String title = request.getParameter("title");
            int bannerId = Integer.parseInt(request.getParameter("bannerId"));
            BannerDAO dao = new BannerDAO();
            Banner x = dao.getBannerById(bannerId);
            
            //
            String imageUrl = x.getImage_url();
            try {
                Part filePart = request.getPart("file");

                if (filePart != null && filePart.getSize() > 0){
                    String contentType = filePart.getContentType();

                    if (contentType != null && contentType.startsWith("image/")) {
                    } else {
                        // Không phải ảnh
                        request.setAttribute("mustbeImg", "Chỉ cho phép upload file ảnh!");
                        request.setAttribute("banner", x);
                        request.getRequestDispatcher("admin_saler_add_banner.jsp").forward(request, response);
                        return;
                    }
                }

                imageUrl = UploadPicture.uploadImage(filePart, imageUrl);

            } catch (Exception e) {
                log(e.getMessage());
            }
            //
            
            String redirectUrl = request.getParameter("redirect_url");
            int position = Integer.parseInt(request.getParameter("position"));
            boolean isActive = request.getParameter("is_active") != null;
            int admin_id = 1; // Lấy từ session nếu cần

            Banner banner = new Banner(bannerId, admin_id, title, imageUrl, redirectUrl, position, isActive, null);
            boolean flag = dao.updateBanner(banner);

            response.sendRedirect("AdminSalerController?target=banner");
        } else {
            int bannerId = Integer.parseInt(request.getParameter("bannerId"));
            BannerDAO dao = new BannerDAO();
            Banner banner = dao.getBannerById(bannerId);

            request.setAttribute("banner", banner);
            request.getRequestDispatcher("admin_saler_add_banner.jsp").forward(request, response);
        }
    }
    
    private void detailBanner(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int bannerId = Integer.parseInt(request.getParameter("bannerId"));

        BannerDAO dao = new BannerDAO();
        Banner banner = dao.getBannerById(bannerId);

        request.setAttribute("banner", banner);
        request.getRequestDispatcher("admin_saler_detail_banner.jsp").forward(request, response);
    }

    private void deleteBanner(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int bannerId = Integer.parseInt(request.getParameter("bannerId"));

        BannerDAO dao = new BannerDAO();
        boolean flag = dao.deleteBanner(bannerId);

        // log("delete banner: " + flag);
        response.sendRedirect("AdminSalerController?target=banner");
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
