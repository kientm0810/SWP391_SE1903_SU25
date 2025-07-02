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

    private static final String FROM = "kientthe180644@fpt.edu.vn";
    private static String PASSWORD = "svlt vfbk eeri cflk";

    public static boolean sendNotification(String to) {
        final String from = FROM;
        final String host = Constants.SMTP_HOST;
        final int port = Constants.SMTP_PORT;
        final String username = FROM; // Should be moved to Constants
        final String password = PASSWORD; // Should be moved to Constants

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "" + port);

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
            System.out.println("herre");
            return false;
        }
    }

    public static boolean sendEmail(String to, String title, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };

        Session session = Session.getInstance(props);
        MimeMessage msg = new MimeMessage(session);

        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject(title, "UTF-8");

            msg.setContent(content, "text/html; charset=UTF-8");
            System.out.println("van do thang transport!");
            Transport.send(msg);
            System.out.println("Send successfully!");
            return true;
        } catch (Exception e) {
            return false;
        }

    }

    public static void main(String[] args) {
        System.out.println(sendNotification("kienkute0810@gmail.com"));
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
        System.out.println(sendEmail("kienkute0810@gmail.com", "[Notification - Job Finding] ACCOUNT_APPROVED", htmlContent));
    }
}
