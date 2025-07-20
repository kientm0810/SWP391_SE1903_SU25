/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import daos.ReportsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import com.google.gson.Gson;
import models.RevenueData;
import models.RevenueStats;

/**
 *
 * @author andin
 */
@WebServlet(name = "ReportsController", urlPatterns = {"/ReportsController"})
public class ReportsController extends HttpServlet {

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

        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                showReportsDashboard(request, response);
                break;
            case "data":
                getChartData(request, response);
                break;
            default:
                showReportsDashboard(request, response);
                break;
        }
    }

    private void showReportsDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ReportsDAO reportsDAO = new ReportsDAO();
        
        // Lấy dữ liệu doanh thu
        List<RevenueData> totalRevenue = reportsDAO.getTotalRevenueByMonth();
        List<RevenueData> promotionRevenue = reportsDAO.getPromotionRevenueByMonth();
        RevenueStats stats = reportsDAO.getOverallStats();
        
        // Chuyển đổi dữ liệu thành JSON cho JavaScript
        Gson gson = new Gson();
        String totalRevenueJson = gson.toJson(totalRevenue);
        String promotionRevenueJson = gson.toJson(promotionRevenue);
        
        // Set attributes
        request.setAttribute("totalRevenueData", totalRevenueJson);
        request.setAttribute("promotionRevenueData", promotionRevenueJson);
        request.setAttribute("stats", stats);
        
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
    
    private void getChartData(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        ReportsDAO reportsDAO = new ReportsDAO();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Gson gson = new Gson();
        
        if ("total".equals(type)) {
            List<RevenueData> data = reportsDAO.getTotalRevenueByMonth();
            response.getWriter().write(gson.toJson(data));
        } else if ("promotion".equals(type)) {
            List<RevenueData> data = reportsDAO.getPromotionRevenueByMonth();
            response.getWriter().write(gson.toJson(data));
        } else {
            response.getWriter().write("[]");
        }
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
        return "Reports Controller";
    }// </editor-fold>
}