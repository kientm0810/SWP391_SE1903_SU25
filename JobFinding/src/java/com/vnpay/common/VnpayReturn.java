package com.vnpay.common;

import daos.FinancialTransactionDAO;
import daos.RecruiterDAO;
import daos.JobListingDAO;
import models.FinancialTransaction;
import utils.JavaMail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.sql.Timestamp;
import java.util.Calendar;

public class VnpayReturn extends HttpServlet {
    
    private FinancialTransactionDAO transactionDAO = new FinancialTransactionDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();
    private JobListingDAO jobDAO = new JobListingDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            
            String signValue = Config.hashAllFields(fields);
            
            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");
                String orderId = request.getParameter("vnp_TxnRef");
                String responseCode = request.getParameter("vnp_ResponseCode");
                
                boolean transSuccess = "00".equals(request.getParameter("vnp_TransactionStatus"));
                
                // Process based on order type
                processPaymentResult(orderId, paymentCode, responseCode, transSuccess, request, response);
                
            } else {
                request.setAttribute("error", "Invalid signature");
                request.getRequestDispatcher("payment_error.jsp").forward(request, response);
            }
        }
    }
    
    private void processPaymentResult(String orderId, String paymentCode, String responseCode, 
            boolean transSuccess, HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            if (orderId.startsWith("REG_")) {
                handleRegistrationPayment(orderId, paymentCode, responseCode, transSuccess, session, request, response);
            } else if (orderId.startsWith("NORMAL_") || orderId.startsWith("PREM_")) {
                handleJobPostPayment(orderId, paymentCode, responseCode, transSuccess, session, request, response);
            } else {
                handleGeneralPayment(orderId, paymentCode, responseCode, transSuccess, request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing payment: " + e.getMessage());
            request.getRequestDispatcher("payment_error.jsp").forward(request, response);
        }
    }
    
    private void handleRegistrationPayment(String orderId, String paymentCode, String responseCode, 
            boolean transSuccess, HttpSession session, HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String transactionIdStr = orderId.substring(4); // Remove "REG_" prefix
        int transactionId = Integer.parseInt(transactionIdStr);
        
        FinancialTransaction transaction = transactionDAO.getTransactionById(transactionId);
        if (transaction != null) {
            transaction.setTransactionCode(paymentCode);
            transaction.setStatus(transSuccess ? "completed" : "failed");
            transactionDAO.updateTransaction(transaction);
            
            if (transSuccess) {
                // Update recruiter verification status
                recruiterDAO.updateVerificationStatus(transaction.getRecruiterId(), "verified");
                
                // Send confirmation email
                String recruiterEmail = recruiterDAO.getRecruiterEmail(transaction.getRecruiterId());
                if (recruiterEmail != null) {
                    JavaMail.sendNotification(recruiterEmail);
                }
                
                session.setAttribute("paymentSuccess", "Registration successful! Your account is now verified.");
                response.sendRedirect("recruiter_dashboard.jsp");
            } else {
                session.setAttribute("paymentError", "Registration payment failed. Please try again.");
                response.sendRedirect("checkout?action=registration");
            }
        }
    }
    
    private void handleJobPostPayment(String orderId, String paymentCode, String responseCode, 
            boolean transSuccess, HttpSession session, HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String transactionIdStr = orderId.substring(orderId.indexOf("_") + 1);
        int transactionId = Integer.parseInt(transactionIdStr);
        
        FinancialTransaction transaction = transactionDAO.getTransactionById(transactionId);
        if (transaction != null) {
            transaction.setTransactionCode(paymentCode);
            transaction.setStatus(transSuccess ? "completed" : "failed");
            transactionDAO.updateTransaction(transaction);
            
            if (transSuccess) {
                Integer jobId = (Integer) session.getAttribute("jobId");
                String positionCode = (String) session.getAttribute("positionCode");
                Integer durationDays = (Integer) session.getAttribute("durationDays");
                
                if (jobId != null && positionCode != null) {
                    // Update job listing with post type and expiry
                    Calendar cal = Calendar.getInstance();
                    cal.add(Calendar.DAY_OF_MONTH, durationDays);
                    Timestamp expiryDate = new Timestamp(cal.getTimeInMillis());
                    
                    jobDAO.updateJobPostType(jobId, positionCode, expiryDate);
                }
                
                // Clean session
                session.removeAttribute("jobId");
                session.removeAttribute("positionCode");
                session.removeAttribute("durationDays");
                session.removeAttribute("pendingTransactionId");
                session.removeAttribute("checkoutType");
                
                session.setAttribute("paymentSuccess", "Job post payment successful!");
                response.sendRedirect("recruiter_dashboard.jsp");
            } else {
                session.setAttribute("paymentError", "Job post payment failed. Please try again.");
                response.sendRedirect("recruiter_dashboard.jsp");
            }
        }
    }
    
    private void handleGeneralPayment(String orderId, String paymentCode, String responseCode, 
            boolean transSuccess, HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("orderId", orderId);
        request.setAttribute("transSuccess", transSuccess);
        request.setAttribute("paymentCode", paymentCode);
        request.getRequestDispatcher("payment_result.jsp").forward(request, response);
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
}