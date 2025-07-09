/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.Properties;

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
    public static boolean sendNotification(String to) {
        final String from = Constants.EMAIL_FROM;
        final String host = Constants.SMTP_HOST;
        final int port = Constants.SMTP_PORT;
        final String username = Constants.EMAIL_USERNAME; // Should be moved to Constants
        final String password = Constants.EMAIL_PASSWWORD; // Should be moved to Constants

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
            message.setSubject("[Notification - Job Finding] ACCOUNT_APPROVED");
            
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
            e.getStackTrace();
            return false;
        }
    }

    public static boolean sendMail(String to, String subject, String body) {
        final String from = Constants.EMAIL_FROM;
        final String host = Constants.SMTP_HOST;
        final int port = Constants.SMTP_PORT;
        final String username = Constants.EMAIL_USERNAME;
        final String password = Constants.EMAIL_PASSWWORD;

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
            message.setSubject(subject);
            if (body != null && (body.trim().startsWith("<html") || body.trim().startsWith("<HTML"))) {
                message.setContent(body, "text/html; charset=UTF-8");
            } else {
                message.setText(body);
            }
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
