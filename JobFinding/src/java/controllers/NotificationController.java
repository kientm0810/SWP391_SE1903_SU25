/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import daos.RecruiterNotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;
import models.RecruiterNotification;

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
            if (role.equals("recruiter")) {
                processRecruiter(request, response);
            } else if (role.equals("job-seeker")){
                processJobSeeker(request, response);
            }
        } else {
            response.sendRedirect("home");
//            request.getRequestDispatcher("notification.jsp").forward(request, response);
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
        } else if (service.equals("detail")){
            detailNoticeRecruiter(request, response);
        } else if (service.equals("deleteAll")){
            deleteAllNoticeRecruiter(request, response);
        } else if (service.equals("deleteReaded")){
            deleteAllNoticeReadedRecruiter(request, response);
        } else if (service.equals("markAsUnread")){
            markAsUnreadRecruiter(request, response);
        } else if (service.equals("deleteSpecific")){
            deleteSpecificNoticeRecruiter(request, response);
        }
    }

    private void listNoticeRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = (String) session.getAttribute("role");
        int id = (int) session.getAttribute("userId");
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();
        
        int topk = -1;
        Vector<RecruiterNotification> list = new Vector<>();
        
        String type = request.getParameter("type");
        if (type == null){
            type = "all";
        }
        
        if (type.equals("all")){
            list = dao.getNotice(id, topk);
        } else if (type.equals("unread")){
            list = dao.getUnreadNotice(id, topk);
        }
        
        request.setAttribute("notice", list);
        request.setAttribute("type", "all");
        
        request.getRequestDispatcher("notification.jsp").forward(request, response);
    }
    
    private void detailNoticeRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        int id = Integer.parseInt(request.getParameter("id"));
        int recId = (int) session.getAttribute("userId");
        
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();

        RecruiterNotification p = dao.getSpecificNotification(id);
        
        int topk = -1;
        Vector<RecruiterNotification> list = new Vector<>();
        
        String type = request.getParameter("type");
        if (type == null){
            type = "all";
        }
        
        if (type.equals("")){
            type = "all";
        }
        
        if (type.equals("all")){
            list = dao.getNotice(recId, topk);
        } else if (type.equals("unread")){
            list = dao.getUnreadNotice(recId, topk);
        }

        dao.readSpecificNotification(id);
        
        log("size: " + list.size() + " " + id + " " + type);
        
        request.setAttribute("specific", p);
        request.setAttribute("notice", list);
        request.setAttribute("type", type);
        
        request.getRequestDispatcher("notification.jsp").forward(request, response);
    }
    
    private void deleteAllNoticeRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        int id = (int) session.getAttribute("userId");
        
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();
        dao.deleteAll(id);
        
        response.sendRedirect("notification");
    }
    
    private void deleteAllNoticeReadedRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        int id = (int) session.getAttribute("userId");
        
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();
        dao.deleteAllReaded(id);
        
        response.sendRedirect("notification");
    }
    
    private void markAsUnreadRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();
        dao.markAsUnread(id);
        
        response.sendRedirect("notification");
    }
    
    private void deleteSpecificNoticeRecruiter(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        RecruiterNotificationDAO dao = new RecruiterNotificationDAO();
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
