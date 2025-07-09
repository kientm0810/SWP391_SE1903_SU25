package controllers;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import daos.ApplicationDAO;
import daos.InterviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Interview;
import utils.JavaMail;

@WebServlet(name = "ScheduleInterviewController", urlPatterns = {"/schedule-interview"})
public class ScheduleInterviewController extends HttpServlet {
    private InterviewDAO interviewDAO;
    private ApplicationDAO applicationDAO;
    @Override
    public void init() throws ServletException {
        interviewDAO = new InterviewDAO();
        applicationDAO = new ApplicationDAO();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        HttpSession session = request.getSession();
        int interviewerId = (int) session.getAttribute("userId"); // Giả sử recruiter đã đăng nhập
        String timeStr = request.getParameter("time");
        String location = request.getParameter("location");
        String round = request.getParameter("round");
        String status = request.getParameter("status");
        String result = request.getParameter("result");
        String note = request.getParameter("note");
        LocalDateTime time = LocalDateTime.parse(timeStr, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
        Interview interview = new Interview();
        interview.setApplicationId(applicationId);
        interview.setInterviewerId(interviewerId);
        interview.setTime(time);
        interview.setLocation(location);
        interview.setRound(round);
        interview.setStatus(status);
        interview.setResult(result);
        interview.setNote(note);
        boolean ok = interviewDAO.insertInterview(interview);
        // Gửi email cho ứng viên
        try {
            var app = applicationDAO.getApplicationById(applicationId, interviewerId);
            String email = "";
            String name = "Ứng viên";
            try {
                java.lang.reflect.Method getEmail = app.getClass().getMethod("getEmail");
                email = (String) getEmail.invoke(app);
            } catch(Exception e) {}
            try {
                java.lang.reflect.Method getFullName = app.getClass().getMethod("getFullName");
                name = (String) getFullName.invoke(app);
            } catch(Exception e) {}
            if (email != null && !email.isEmpty()) {
                String subject = "Thư mời phỏng vấn từ JobFinding";
                String body = "Xin chào " + name + ",\n\n" +
                    "Bạn đã được mời tham gia phỏng vấn vòng: " + round + " vào lúc " + time.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) + ".\n" +
                    "Địa điểm: " + location + "\n" +
                    "Ghi chú: " + note + "\n\n" +
                    "Vui lòng kiểm tra tài khoản để biết thêm chi tiết.\n\n" +
                    "Trân trọng,\nHệ thống JobFinding";
                JavaMail.sendMail(email, subject, body);
            }
        } catch(Exception e) {}
        response.sendRedirect("applications.jsp?interview=success");
    }
} 