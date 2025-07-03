/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import daos.FeaturedJobDAO;
import daos.PromotionProgramDAO;
import daos.PostsDAO;
import daos.RecruiterDAO;
import models.PromotionProgram;
import models.Posts;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import utils.InputSanitizer;

/**
 *
 * @author andin
 */
@WebServlet(name = "AdminPromotionController", urlPatterns = {"/AdminPromotionController"})
public class AdminPromotionController extends HttpServlet {

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
        
        HttpSession session = request.getSession(true);
        if (session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
            response.sendRedirect("home");
            return;
        }

        String service = request.getParameter("service");
        if (service == null) {
            service = "list";
        }

        switch (service) {
            case "list":
                listPromotionPrograms(request, response);
                break;
            case "viewPosts":
                viewPostsByProgram(request, response);
                break;
            case "edit":
                editPromotionProgram(request, response);
                break;
            case "add":
                addPromotionProgram(request, response);
                break;
            case "update":
                updatePromotionProgram(request, response);
                break;
            case "delete":
                deletePromotionProgram(request, response);
                break;
            default:
                listPromotionPrograms(request, response);
                break;
        }
    }

    private void listPromotionPrograms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PromotionProgramDAO programDAO = new PromotionProgramDAO();
        FeaturedJobDAO featuredJobDAO = new FeaturedJobDAO();
        PostsDAO postsDAO = new PostsDAO();

        // Lấy danh sách promotion programs
        List<PromotionProgram> promotionPrograms = programDAO.getAllPromotionPrograms();

        // Tạo map để lưu thống kê cho từng program
        Map<Integer, Integer> postCounts = new HashMap<>();
        Map<Integer, Double> monthlyRevenues = new HashMap<>();
        Map<Integer, Double> allTimeRevenues = new HashMap<>();

        double totalMonthlyRevenue = 0;
        double totalAllTimeRevenue = 0;
        
        // Tính toán thống kê cho từng program
        for (PromotionProgram program : promotionPrograms) {
            int postCount = featuredJobDAO.countUniquePostsByPromotionId(program.getId());
            double monthlyRevenue = featuredJobDAO.getTotalRevenueByPromotionId(program.getId());
            double allTimeRevenue = featuredJobDAO.getTotalAllTimeRevenueByPromotionId(program.getId());
            
            totalMonthlyRevenue += monthlyRevenue;
            totalAllTimeRevenue += allTimeRevenue;
            
            postCounts.put(program.getId(), postCount);
            monthlyRevenues.put(program.getId(), monthlyRevenue);
            allTimeRevenues.put(program.getId(), allTimeRevenue);
        }

        log("month: " + totalMonthlyRevenue);
        log("all: " + totalAllTimeRevenue);
        
        // Tính tổng quan
        int totalActivePosts = postsDAO.getTotalPosts();
//        double totalMonthlyRevenue = monthlyRevenues.values().stream().mapToDouble(Double::doubleValue).sum();
//        double totalAllTimeRevenue = allTimeRevenues.values().stream().mapToDouble(Double::doubleValue).sum();
        int totalActiveRecruiters = programDAO.countActiveRecruiters();

        // Set attributes
        request.setAttribute("promotionPrograms", promotionPrograms);
        request.setAttribute("postCounts", postCounts);
        request.setAttribute("monthlyRevenues", monthlyRevenues);
        request.setAttribute("allTimeRevenues", allTimeRevenues);
        request.setAttribute("totalActivePosts", totalActivePosts);
        request.setAttribute("totalMonthlyRevenue", totalMonthlyRevenue);
        request.setAttribute("totalAllTimeRevenue", totalAllTimeRevenue);
        request.setAttribute("totalActiveRecruiters", totalActiveRecruiters);
        
        // Handle success message từ redirect
        String successMessage = request.getParameter("success");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
        }

        request.getRequestDispatcher("admin_manage_promotion_programs.jsp").forward(request, response);
    }

    private void viewPostsByProgram(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String programIdStr = request.getParameter("programId");
        String pageStr = request.getParameter("page");
        String recordsPerPageStr = request.getParameter("recordsPerPage");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");
        String submit = request.getParameter("submit");

        if (programIdStr == null || programIdStr.isEmpty()) {
            response.sendRedirect("AdminPromotionController?target=program");
            return;
        }

        int programId = Integer.parseInt(programIdStr);
        int page = 1;
        int pageSize = 10;

        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }
        if (recordsPerPageStr != null && !recordsPerPageStr.isEmpty()) {
            pageSize = Integer.parseInt(recordsPerPageStr);
        }
        if (sortField == null || sortField.isEmpty()) {
            sortField = "created_at";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "DESC";
        }

        PromotionProgramDAO programDAO = new PromotionProgramDAO();
        FeaturedJobDAO featuredJobDAO = new FeaturedJobDAO();

        PromotionProgram promotionProgram = programDAO.getPromotionProgramById(programId);
        if (promotionProgram == null) {
            response.sendRedirect("AdminPromotionController?target=program");
            return;
        }

        List<FeaturedJobDAO.PostPromotionInfo> posts;
        int totalPosts;

        if (submit != null && submit.equals("Search")) {
            // Chỉ search theo title
            String title = InputSanitizer.cleanSearchQuery(request.getParameter("title"));

            if (title != null && !title.isEmpty()) {
                posts = featuredJobDAO.searchPostsByPromotionIdWithPaging(programId, title, page, pageSize, sortField, sortOrder);
                totalPosts = featuredJobDAO.countSearchPostsByPromotionId(programId, title);
                request.setAttribute("searchTitle", title);
            } else {
                posts = featuredJobDAO.getPostsByPromotionIdWithPaging(programId, page, pageSize, sortField, sortOrder);
                totalPosts = featuredJobDAO.countUniquePostsByPromotionId(programId);
            }
        } else {
            // Lấy tất cả posts với pagination và sorting
            posts = featuredJobDAO.getPostsByPromotionIdWithPaging(programId, page, pageSize, sortField, sortOrder);
            totalPosts = featuredJobDAO.countUniquePostsByPromotionId(programId);
        }

        double monthlyRevenue = featuredJobDAO.getTotalRevenueByPromotionId(programId);
        double allTimeRevenue = featuredJobDAO.getTotalAllTimeRevenueByPromotionId(programId);
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        // Set attributes
        request.setAttribute("promotionProgram", promotionProgram);
        request.setAttribute("posts", posts);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("allTimeRevenue", allTimeRevenue);
        request.setAttribute("currentPage", page);
        request.setAttribute("recordsPerPage", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalPosts);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("admin_promotion_posts_list.jsp").forward(request, response);
    }

    private void editPromotionProgram(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("AdminPromotionController?target=program");
            return;
        }

        int id = Integer.parseInt(idStr);
        PromotionProgramDAO programDAO = new PromotionProgramDAO();
        PromotionProgram program = programDAO.getPromotionProgramById(id);

        if (program == null) {
            response.sendRedirect("AdminPromotionController?target=program");
            return;
        }

        request.setAttribute("program", program);
        request.setAttribute("action", "edit");
        request.getRequestDispatcher("admin_add_edit_promotion.jsp").forward(request, response);
    }

    private void addPromotionProgram(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("admin_add_edit_promotion.jsp").forward(request, response);
    }

    private void updatePromotionProgram(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submit = request.getParameter("submit");
        if (submit == null){
            submit = "";
        }
        
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);
        
        if (submit.equals("submit")){
//            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String costStr = request.getParameter("cost");
            String durationDaysStr = request.getParameter("durationDays");
            String description = request.getParameter("description");
            String positionType = request.getParameter("positionType");
            String quantityStr = request.getParameter("quantity");
            String isActiveStr = request.getParameter("isActive");

            try {
//                int id = Integer.parseInt(idStr);
                double cost = Double.parseDouble(costStr);
                int durationDays = Integer.parseInt(durationDaysStr);
                int quantity = Integer.parseInt(quantityStr);
                boolean isActive = Boolean.parseBoolean(isActiveStr);

                PromotionProgramDAO programDAO = new PromotionProgramDAO();
                
                PromotionProgram program = programDAO.getPromotionProgramById(id);
//                program.setId(id);
//                program.setName(name);
                program.setCost(cost);
                program.setDurationDays(durationDays);
//                program.setDescription(description);
//                program.setPositionType(positionType);
                program.setQuantity(quantity);
//                program.setActive(isActive);

//                PromotionProgramDAO programDAO = new PromotionProgramDAO();
                boolean success = programDAO.updatePromotionProgram(program);

                if (success) {
                    request.setAttribute("successMessage", "Cập nhật chương trình thành công!");
                } else {
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật chương trình.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Dữ liệu không hợp lệ.");
            }

            response.sendRedirect("AdminPromotionController?target=program");
        } else {
            PromotionProgramDAO dao = new PromotionProgramDAO();
            request.setAttribute("program", dao.getPromotionProgramById(id));
            request.getRequestDispatcher("admin_edit_promotion_program.jsp").forward(request, response);
        }
    }

    private void deletePromotionProgram(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                
                PromotionProgramDAO programDAO = new PromotionProgramDAO();
                PromotionProgram program = programDAO.getPromotionProgramById(id);
                
                if (program != null) {
                    program.setActive(false);
                    boolean success = programDAO.updatePromotionProgram(program);
                    
                    if (success) {
                        request.setAttribute("successMessage", "Vô hiệu hóa chương trình thành công!");
                    } else {
                        request.setAttribute("errorMessage", "Có lỗi xảy ra khi vô hiệu hóa chương trình.");
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID không hợp lệ.");
            }
        }

        response.sendRedirect("AdminPromotionController?target=program");
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
        return "Admin Promotion Controller";
    }// </editor-fold>
}