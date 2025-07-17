/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author andin
 */
public final class JavaMail {
    
    private static final Logger LOGGER = Logger.getLogger(JavaMail.class.getName());

    private static Session getMailSession() {
        final String username = Constants.EMAIL_USERNAME;
        final String password = Constants.EMAIL_PASSWORD;

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", Constants.SMTP_HOST);
        props.put("mail.smtp.port", Constants.SMTP_PORT);

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
    }

    public static boolean sendPasswordResetEmail(String to, String token) {
        try {
            MimeMessage message = new MimeMessage(getMailSession());
            message.setFrom(new InternetAddress(Constants.EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("[Job Finding] Yêu cầu đặt lại mật khẩu", "UTF-8");

            String resetLink = "http://localhost:9999/JobFinding/reset-password?token=" + token;
            String htmlContent = "<html>"
                    + " <body style='font-family: Arial, sans-serif;'>"
                    + "     <div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px;'>"
                    + "         <h2 style='color: #333;'>Yêu cầu đặt lại mật khẩu</h2>"
                    + "         <p>Xin chào,</p>"
                    + "         <p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Vui lòng nhấp vào nút bên dưới để đặt lại mật khẩu:</p>"
                    + "         <a href='" + resetLink + "' style='display: inline-block; padding: 10px 20px; background-color: #007bff; color: #fff; text-decoration: none; border-radius: 3px;'>Đặt lại mật khẩu</a>"
                    + "         <p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>"
                    + "         <p style='margin-top: 30px;'>Trân trọng,<br>Đội ngũ Job Finding</p>"
                    + "     </div>"
                    + " </body>"
                    + "</html>";
            
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Failed to send password reset email to " + to, e);
            return false;
        }
    }

    public static boolean sendNotification(String to) {
        try {
            MimeMessage message = new MimeMessage(getMailSession());
            message.setFrom(new InternetAddress(Constants.EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("[Notification - Job Finding] TÀI KHOẢN ĐƯỢC PHÊ DUYỆT", "UTF-8");
            
            String htmlContent = "<html>"
                    + " <body style='font-family: Arial, sans-serif;'>"
                    + "     <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>"
                    + "         <h2 style='color: #2e7d32; margin-bottom: 20px;'>Xác thực tài khoản</h2>"
                    + "         <p>Xin chào,</p>"
                    + "         <p>Tài khoản của bạn đã được phê duyệt</p>"
                    + "         <p><strong>Từ giờ bạn có thể:</strong></p>"
                    + "         <ul>"
                    + "             <li>Đăng bài tuyển dụng.</li>"
                    + "             <li>Đăng kí các gói đăng tin của chúng tôi.</li>"
                    + "         </ul>"
                    + "         <p style='margin-top: 30px;'>Trân trọng,<br>Đội ngũ Job Finding</p>"
                    + "     </div>"
                    + " </body>"
                    + "</html>";
            
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Failed to send notification email to " + to, e);
            return false;
        }
    }

    /**
     * Gửi email với subject và content tùy chỉnh
     */
    public static boolean sendEmail(String to, String subject, String htmlContent) {
        try {
            MimeMessage message = new MimeMessage(getMailSession());
            message.setFrom(new InternetAddress(Constants.EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject, "UTF-8");
            
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Failed to send email to " + to, e);
            return false;
        }
    }
}
