package controllers;

import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import daos.SavedJobDAO;
import models.SavedJob;

@WebServlet(name="SaveJobController", urlPatterns={"/save-job"})
public class SaveJobController extends HttpServlet {
    
    private SavedJobDAO savedJobDAO;
    
    @Override
    public void init() throws ServletException {
        savedJobDAO = new SavedJobDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = request.getSession();
            Integer jobSeekerId = (Integer) session.getAttribute("userId");
            
            if (jobSeekerId == null) {
                response.getWriter().write("{\"success\":false,\"message\":\"Vui lòng đăng nhập để lưu việc làm\"}");
                return;
            }
            
            String jobIdStr = request.getParameter("jobId");
            if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"Thiếu thông tin việc làm\"}");
                return;
            }
            
            int jobId = Integer.parseInt(jobIdStr);
            
            // Check if job is already saved
            if (savedJobDAO.isJobSaved(jobSeekerId, jobId)) {
                response.getWriter().write("{\"success\":false,\"message\":\"Việc làm đã được lưu trước đó\"}");
                return;
            }
            
            // Save the job
            SavedJob savedJob = new SavedJob();
            savedJob.setJobSeekerId(jobSeekerId);
            savedJob.setPostId(jobId);
            savedJob.setSavedAt(new Timestamp(System.currentTimeMillis()));
            
            boolean success = savedJobDAO.saveJob(savedJob);
            
            if (success) {
                response.getWriter().write("{\"success\":true,\"message\":\"Đã lưu việc làm thành công\"}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"Có lỗi xảy ra khi lưu việc làm\"}");
            }
            
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\":false,\"message\":\"ID việc làm không hợp lệ\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false,\"message\":\"Có lỗi xảy ra\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
} 