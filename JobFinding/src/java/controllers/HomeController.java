/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import daos.RecruiterNotificationDAO;
import models.RecruiterNotification;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;

/**
 *
 * @author andin
 */
public class HomeController extends HttpServlet {

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
        if (role != null) {
//            int id = (int) session.getAttribute("userId");
            if (role.equals("recruiter")) {
                processRecruiter(request, response);
            } else if (role.equals("job-seeker")){
                processJobSeeker(request, response);
            }
        } else {

            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

    private void processRecruiter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        if (service == null) {
            service = "list";
        }

        if (service.equals("list")){
            listNoticeRecruiter(request, response);
        } else if (service.equals("")){
            
        }
    }

    private void listNoticeRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = (String) session.getAttribute("role");
        int id = (int) session.getAttribute("userId");
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();
        
        int topk = 5;
        Vector<RecruiterNotification> list = dao.getNotice(id, topk);
        Vector<RecruiterNotification> unread = dao.getUnreadNotice(id, topk);
        request.setAttribute("notice", list);
        request.setAttribute("unread", unread);

//        String sql = "SELECT " + (topk == -1 ? "*" : "TOP (" + topk + ")")
//                + "  FROM [project_SWP391].[dbo].[RecruiterNotification]\n"
//                + "  WHERE [recruiter_id] = " + id 
//                + " ORDER BY created_at DESC";
//        
//        log(sql);
        
                log("" + list.size());
//                log("" + id);
//                response.sendRedirect("admin_dashboard.jsp");
//                return;
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
    
    private void processJobSeeker(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
