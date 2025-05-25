package controllers;

import daos.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;
import models.Admin;
import models.JobSeeker;
import models.Recruiter;
import utils.Constants;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ResetPasswordController.class.getName());
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize UserDAO", e);
            throw new ServletException("Failed to initialize UserDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Constants.RESET_PASSWORD_PAGE).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email.");
            request.getRequestDispatcher(Constants.RESET_PASSWORD_PAGE).forward(request, response);
            return;
        }

        try {
            // Get user type and ID from DAO
            Object[] userInfo = userDAO.getUserInfoByEmail(email);
            if (userInfo != null) {
                int userId = (int) userInfo[0];
                String userType = (String) userInfo[1];
                boolean isActive = (boolean) userInfo[2];

                if (!isActive) {
                    request.setAttribute("error", Constants.ACCOUNT_INACTIVE_MESSAGE);
                } else {
                    String newPassword = generateRandomPassword(12);
                    if (userDAO.updatePassword(userId, newPassword)) {
                        boolean emailSent = sendPasswordResetEmail(email, newPassword);
                        if (emailSent) {
                            request.setAttribute("message", "Mật khẩu mới đã được gửi đến email của bạn.");
                            LOGGER.log(Level.INFO, "Password reset successful for email: {0}", email);
                        } else {
                            request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
                            LOGGER.log(Level.WARNING, "Failed to send password reset email to: {0}", email);
                        }
                    } else {
                        request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại sau.");
                        LOGGER.log(Level.WARNING, "Failed to update password for email: {0}", email);
                    }
                }
            } else {
                request.setAttribute("error", "Email không tồn tại trong hệ thống.");
                LOGGER.log(Level.INFO, "Password reset attempted for non-existent email: {0}", email);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during password reset for email: " + email, e);
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại sau.");
        }

        request.getRequestDispatcher(Constants.RESET_PASSWORD_PAGE).forward(request, response);
    }

    private String generateRandomPassword(int length) {
        String upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerChars = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";
        String specialChars = "!@#$%^&*()";
        String allChars = upperChars + lowerChars + numbers + specialChars;
        
        Random random = new Random();
        StringBuilder password = new StringBuilder();
        
        // Ensure at least one character from each category
        password.append(upperChars.charAt(random.nextInt(upperChars.length())));
        password.append(lowerChars.charAt(random.nextInt(lowerChars.length())));
        password.append(numbers.charAt(random.nextInt(numbers.length())));
        password.append(specialChars.charAt(random.nextInt(specialChars.length())));
        
        // Fill the rest randomly
        for (int i = 4; i < length; i++) {
            password.append(allChars.charAt(random.nextInt(allChars.length())));
        }
        
        // Shuffle the password
        char[] passwordArray = password.toString().toCharArray();
        for (int i = passwordArray.length - 1; i > 0; i--) {
            int j = random.nextInt(i + 1);
            char temp = passwordArray[i];
            passwordArray[i] = passwordArray[j];
            passwordArray[j] = temp;
        }
        
        return new String(passwordArray);
    }

    private boolean sendPasswordResetEmail(String to, String newPassword) {
        final String from = Constants.EMAIL_FROM;
        final String host = Constants.SMTP_HOST;
        final int port = Constants.SMTP_PORT;
        final String username = "fcareinsurance@gmail.com"; // Should be moved to Constants
        final String password = "cifxowsnfwdnywed"; // Should be moved to Constants

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Yêu cầu đặt lại mật khẩu - Job Finding");
            
            String htmlContent = "<html><body style='font-family: Arial, sans-serif;'>"
                    + "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>"
                    + "<h2 style='color: #2e7d32; margin-bottom: 20px;'>Đặt lại mật khẩu</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>Bạn đã yêu cầu đặt lại mật khẩu. Dưới đây là mật khẩu mới của bạn:</p>"
                    + "<div style='background: #f5f5f5; padding: 15px; border-radius: 5px; margin: 20px 0;'>"
                    + "<strong style='font-size: 18px; color: #2e7d32;'>" + newPassword + "</strong>"
                    + "</div>"
                    + "<p><strong>Lưu ý quan trọng:</strong></p>"
                    + "<ul>"
                    + "<li>Vui lòng đăng nhập và thay đổi mật khẩu ngay sau khi nhận được email này.</li>"
                    + "<li>Không chia sẻ mật khẩu này với bất kỳ ai.</li>"
                    + "</ul>"
                    + "<p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng liên hệ với chúng tôi ngay.</p>"
                    + "<p style='margin-top: 30px;'>Trân trọng,<br>Đội ngũ Job Finding</p>"
                    + "</div></body></html>";
            
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Failed to send password reset email to: " + to, e);
            return false;
        }
    }

    @Override
    public String getServletInfo() {
        return "ResetPasswordController handles password reset requests and email notifications";
    }
}