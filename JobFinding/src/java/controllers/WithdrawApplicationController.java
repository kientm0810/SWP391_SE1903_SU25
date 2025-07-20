package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import daos.ApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.JobSeeker;

@WebServlet(name = "WithdrawApplicationController", urlPatterns = {"/withdraw_application"})
public class WithdrawApplicationController extends HttpServlet {
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false); // Không tạo session mới
        if (session == null || session.getAttribute("user") == null || !"job-seeker".equals(session.getAttribute("role"))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\": false, \"message\": \"Unauthorized: Vui lòng đăng nhập với tư cách ứng viên.\"}");
            out.flush();
            return;
        }
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("user");

        String applicationIdStr = request.getParameter("applicationId");
        if (applicationIdStr == null || applicationIdStr.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"Thiếu tham số: applicationId không được rỗng.\"}");
            out.flush();
            return;
        }

        try {
            int applicationId = Integer.parseInt(applicationIdStr.trim());
            boolean success = applicationDAO.updateApplicationStatusByJobSeeker(applicationId, "rejected", jobSeeker.getId());
            if (success) {
                out.print("{\"success\": true, \"message\": \"Đã hủy ứng tuyển thành công.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"success\": false, \"message\": \"Không tìm thấy đơn ứng tuyển hoặc bạn không có quyền.\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"Định dạng applicationId không hợp lệ: '" + applicationIdStr + "' không phải là số.\"}");
        } catch (SQLException e) {
            e.printStackTrace(); // Log lỗi chi tiết ra console server
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Lỗi cơ sở dữ liệu. Vui lòng thử lại sau.\"}");
        } finally {
            if (out != null) {
                out.flush();
            }
        }
    }
} 