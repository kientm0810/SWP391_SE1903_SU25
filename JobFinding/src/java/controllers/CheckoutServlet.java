package controllers;

import daos.PostPricingDAO;
import daos.FinancialTransactionDAO;
import daos.RecruiterDAO;
import models.PostPricing;
import models.FinancialTransaction;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    
    private PostPricingDAO pricingDAO = new PostPricingDAO();
    private FinancialTransactionDAO transactionDAO = new FinancialTransactionDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null){
            response.sendRedirect("home");
            return;
        }
        
        if ("registration".equals(action)) {
            handleRegistrationCheckout(request, response);
        } else if ("jobPost".equals(action)) {
            handleJobPostCheckout(request, response);
        } else if ("showPricing".equals(action)) {
            showPricingOptions(request, response);
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
    
    private void handleRegistrationCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        Integer recruiterId = Integer.parseInt(request.getParameter("recruiterId"));
        
        // Check if already verified
        if ("verified".equals(recruiterDAO.getVerificationStatus(recruiterId))) {
            response.sendRedirect("home");
            return;
        }
        
        // Get registration pricing
        PostPricing regPricing = pricingDAO.getPricingByCode("registration");
        if (regPricing == null) {
            request.setAttribute("error", "Pricing not found");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        // Create transaction record
        FinancialTransaction transaction = new FinancialTransaction();
        transaction.setRecruiterId(recruiterId);
        transaction.setType("expense");
        transaction.setTransactionType("registration");
        transaction.setAmount(regPricing.getPrice());
        transaction.setDescription("Registration fee payment");
        transaction.setStatus("pending");
        
        int transactionId = transactionDAO.createTransaction(transaction);
        
        if (transactionId > 0) {
            // Store in session for payment callback
            session.setAttribute("pendingTransactionId", transactionId);
            session.setAttribute("checkoutType", "registration");
            
            // Redirect to VNPay payment
            response.sendRedirect("payment?totalBill=" + regPricing.getPrice() + 
                "&transactionType=registration&transactionId=" + transactionId);
        } else {
            request.setAttribute("error", "Failed to create transaction");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void handleJobPostCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer recruiterId = (Integer) session.getAttribute("recruiterId");
        
        if (recruiterId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String positionCode = request.getParameter("positionCode");
        String jobIdStr = request.getParameter("jobId");
        
        if (positionCode == null || jobIdStr == null) {
            response.sendRedirect("recruiter_dashboard.jsp");
            return;
        }
        
        try {
            int jobId = Integer.parseInt(jobIdStr);
            
            // Get pricing info
            PostPricing pricing = pricingDAO.getPricingByCode(positionCode);
            if (pricing == null) {
                request.setAttribute("error", "Invalid position code");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            
            // Create transaction record
            FinancialTransaction transaction = new FinancialTransaction();
            transaction.setRecruiterId(recruiterId);
            transaction.setType("expense");
            transaction.setTransactionType(positionCode); // normal, featured, premium
            transaction.setAmount(pricing.getPrice());
            transaction.setDescription("Job post payment - " + pricing.getPositionName());
            transaction.setStatus("pending");
            
            int transactionId = transactionDAO.createTransaction(transaction);
            
            if (transactionId > 0) {
                // Store in session for payment callback
                session.setAttribute("pendingTransactionId", transactionId);
                session.setAttribute("checkoutType", "jobPost");
                session.setAttribute("jobId", jobId);
                session.setAttribute("positionCode", positionCode);
                session.setAttribute("durationDays", pricing.getDurationDays());
                
                // Redirect to VNPay payment
                response.sendRedirect("payment?totalBill=" + pricing.getPrice() + 
                    "&transactionType=" + positionCode + "&transactionId=" + transactionId);
            } else {
                request.setAttribute("error", "Failed to create transaction");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("recruiter_dashboard.jsp");
        }
    }
    
    private void showPricingOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jobId = request.getParameter("jobId");
        
        request.setAttribute("jobId", jobId);
        request.setAttribute("pricingOptions", pricingDAO.getJobPostPricing());
        request.getRequestDispatcher("pricing_options.jsp").forward(request, response);
    }
}