/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import daos.ReportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        String role = (String) session.getAttribute("role");
        
        // Check if user is admin or recruiter
        if (role == null || (!role.equals("admin") && !role.equals("recruiter"))) {
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
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("userId");
        
        if ("admin".equals(role)) {
            // Admin dashboard - tổng quan toàn hệ thống
            List<RevenueData> totalRevenue = reportsDAO.getTotalRevenueByMonth();
            List<RevenueData> promotionRevenue = reportsDAO.getPromotionRevenueByMonth();
            RevenueStats stats = reportsDAO.getOverallStats();
            
            // Set attributes for admin
            request.setAttribute("totalRevenueData", totalRevenue);
            request.setAttribute("promotionRevenueData", promotionRevenue);
            request.setAttribute("stats", stats);
            request.setAttribute("isAdmin", true);
        } else if ("recruiter".equals(role) && userId != null) {
            // Recruiter dashboard - dữ liệu riêng của recruiter
            List<RevenueData> recruiterRevenue = reportsDAO.getRecruiterRevenueByMonth(userId);
            List<RevenueData> recruiterPromotionRevenue = reportsDAO.getRecruiterPromotionRevenueByMonth(userId);
            RevenueStats recruiterStats = reportsDAO.getRecruiterStats(userId);
            
            // Set attributes for recruiter
            request.setAttribute("totalRevenueData", recruiterRevenue);
            request.setAttribute("promotionRevenueData", recruiterPromotionRevenue);
            request.setAttribute("stats", recruiterStats);
            request.setAttribute("isAdmin", false);
        }
        
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
    
    private void getChartData(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        ReportsDAO reportsDAO = new ReportsDAO();
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("userId");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<RevenueData> data = new ArrayList<>();
        
        if ("admin".equals(role)) {
            if ("total".equals(type)) {
                data = reportsDAO.getTotalRevenueByMonth();
            } else if ("promotion".equals(type)) {
                data = reportsDAO.getPromotionRevenueByMonth();
            }
        } else if ("recruiter".equals(role) && userId != null) {
            if ("total".equals(type)) {
                data = reportsDAO.getRecruiterRevenueByMonth(userId);
            } else if ("promotion".equals(type)) {
                data = reportsDAO.getRecruiterPromotionRevenueByMonth(userId);
            }
        }
        
        // Convert to JSON manually
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < data.size(); i++) {
            RevenueData item = data.get(i);
            json.append("{\"month\":\"").append(item.getMonth()).append("\",\"revenue\":").append(item.getRevenue()).append("}");
            if (i < data.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
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