/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import daos.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;
import models.Notification;

/**
 *
 * @author andin
 */
public class NotificationController extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);

        String role = (String) session.getAttribute("role");
        if (role != null) {
//            int id = (int) session.getAttribute("userId");
//            if (role.equals("recruiter")) {
//                processRecruiter(request, response);
//            } else if (role.equals("job-seeker")){
//                processJobSeeker(request, response);
//            }

            processQuery(request, response);
        } else {
            response.sendRedirect("home");
//            request.getRequestDispatcher("notification.jsp").forward(request, response);
        }
    }

    private void processQuery(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        if (service == null) {
            service = "list";
        }

        if (service.equals("list")){
            listNotice(request, response);
        } else if (service.equals("detail")){
            detailNotice(request, response);
        } else if (service.equals("deleteAll")){
            deleteAllNotice(request, response);
        } else if (service.equals("deleteReaded")){
            deleteAllNoticeReaded(request, response);
        } else if (service.equals("markAsUnread")){
            markAsUnread(request, response);
        } else if (service.equals("deleteSpecific")){
            deleteSpecificNotice(request, response);
        }
    }

    private void listNotice(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = (String) session.getAttribute("role");
        int id = (int) session.getAttribute("userId");
        NotificationDAO dao = new NotificationDAO();
        
        int topk = -1;
        Vector<Notification> list = new Vector<>();
        
        String type = request.getParameter("type");
        if (type == null){
            type = "all";
        }
        
        if (type.equals("all")){
            list = dao.getNotice(id, topk, role);
        } else if (type.equals("unread")){
            list = dao.getUnreadNotice(id, topk, role);
        }
        
        request.setAttribute("notice", list);
        request.setAttribute("type", "all");
        
        request.getRequestDispatcher("notification.jsp").forward(request, response);
    }
    
    private void detailNotice(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = (String) session.getAttribute("role");
        int id = Integer.parseInt(request.getParameter("id"));
        int recId = (int) session.getAttribute("userId");
        
        NotificationDAO dao = new NotificationDAO();

        Notification p = dao.getSpecificNotification(id);
        
        int topk = -1;
        Vector<Notification> list = new Vector<>();
        
        String type = request.getParameter("type");
        if (type == null){
            type = "all";
        }
        
        if (type.equals("")){
            type = "all";
        }
        
        if (type.equals("all")){
            list = dao.getNotice(recId, topk, role);
        } else if (type.equals("unread")){
            list = dao.getUnreadNotice(recId, topk, role);
        }

        dao.readSpecificNotification(id);
        
        log("size: " + list.size() + " " + id + " " + type);
        
        request.setAttribute("specific", p);
        request.setAttribute("notice", list);
        request.setAttribute("type", type);
        
        request.getRequestDispatcher("notification.jsp").forward(request, response);
    }
    
    private void deleteAllNotice(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = (String) session.getAttribute("role");
        int id = (int) session.getAttribute("userId");
        
        NotificationDAO dao = new NotificationDAO();
        dao.deleteAll(id, role);
        
        response.sendRedirect("notification");
    }
    
    private void deleteAllNoticeReaded(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = (String) session.getAttribute("role");
        int id = (int) session.getAttribute("userId");
        
        NotificationDAO dao = new NotificationDAO();
        dao.deleteAllReaded(id, role);
        
        response.sendRedirect("notification");
    }
    
    private void markAsUnread(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        NotificationDAO dao = new NotificationDAO();
        dao.markAsUnread(id);
        
        response.sendRedirect("notification");
    }
    
    private void deleteSpecificNotice(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        NotificationDAO dao = new NotificationDAO();
        dao.deleteSpecificNotice(id);
        
        response.sendRedirect("notification");
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
