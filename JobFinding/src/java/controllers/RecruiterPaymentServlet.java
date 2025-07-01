package controllers;

import daos.RecruiterPaymentDAO;
import daos.RecruiterDAO;
import models.RecruiterPayment;
import models.Recruiter;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RecruiterPaymentServlet")
public class RecruiterPaymentServlet extends HttpServlet {
    
    private RecruiterPaymentDAO paymentDAO = new RecruiterPaymentDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("registration".equals(action)) {
            handleRegistrationPayment(request, response);
        } else if ("homepageFeature".equals(action)) {
            handleHomepageFeaturePayment(request, response);
        } else if ("paymentHistory".equals(action)) {
            viewPaymentHistory(request, response);
        }
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
    
    private void handleRegistrationPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer recruiterId = (Integer) session.getAttribute("recruiterId");
        
        if (recruiterId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Check if recruiter already paid registration fee
        Recruiter recruiter = recruiterDAO.getSpeccificRecruiter(recruiterId);
        if ("verified".equals(recruiter.getVerificationStatus())) {
            response.sendRedirect("recruiter_dashboard.jsp");
            return;
        }
        
        // Create payment record
        RecruiterPayment payment = new RecruiterPayment();
        payment.setRecruiterId(recruiterId);
        payment.setPaymentType("registration");
        payment.setAmount(50000.0); // 50,000 VND registration fee
        payment.setDescription("Registration fee for recruiter verification");
        payment.setStatus("pending");
        
        int paymentId = paymentDAO.createPayment(payment);
        
        if (paymentId > 0) {
            // Store payment ID in session for VNPay callback
            session.setAttribute("pendingPaymentId", paymentId);
            session.setAttribute("paymentType", "registration");
            
            // Redirect to VNPay payment
            response.sendRedirect("payment?totalBill=50000&paymentType=registration&paymentId=" + paymentId);
        } else {
            request.setAttribute("error", "Failed to create payment record");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void handleHomepageFeaturePayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer recruiterId = (Integer) session.getAttribute("recruiterId");
        
        if (recruiterId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String jobIdStr = request.getParameter("jobId");
        String positionIdStr = request.getParameter("positionId");
        String priceStr = request.getParameter("price");
        
        if (jobIdStr == null || positionIdStr == null || priceStr == null) {
            response.sendRedirect("recruiter_dashboard.jsp");
            return;
        }
        
        try {
            int jobId = Integer.parseInt(jobIdStr);
            int positionId = Integer.parseInt(positionIdStr);
            double price = Double.parseDouble(priceStr);
            
            // Create payment record
            RecruiterPayment payment = new RecruiterPayment();
            payment.setRecruiterId(recruiterId);
            payment.setPaymentType("homepage_feature");
            payment.setAmount(price);
            payment.setReferenceId(jobId);
            payment.setDescription("Homepage featured position for job ID: " + jobId);
            payment.setStatus("pending");
            
            int paymentId = paymentDAO.createPayment(payment);
            
            if (paymentId > 0) {
                // Store info in session for VNPay callback
                session.setAttribute("pendingPaymentId", paymentId);
                session.setAttribute("paymentType", "homepage_feature");
                session.setAttribute("jobId", jobId);
                session.setAttribute("positionId", positionId);
                
                // Redirect to VNPay payment
                long amount = (long) (price);
                response.sendRedirect("payment?totalBill=" + amount + "&paymentType=homepage_feature&paymentId=" + paymentId);
            } else {
                request.setAttribute("error", "Failed to create payment record");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("recruiter_dashboard.jsp");
        }
    }
    
    private void viewPaymentHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer recruiterId = (Integer) session.getAttribute("recruiterId");
        
        if (recruiterId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        request.setAttribute("payments", paymentDAO.getPaymentsByRecruiterId(recruiterId));
        request.getRequestDispatcher("recruiter_payment_history.jsp").forward(request, response);
    }
}