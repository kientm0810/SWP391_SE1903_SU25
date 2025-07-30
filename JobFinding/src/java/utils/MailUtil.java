/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.mail.Message;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.net.ssl.*;

/**
 *
 * @author Admin
 */
public class MailUtil {

    static final String FROM = "kientthe180644@fpt.edu.vn";
    static final String PASSWORD = "svlt vfbk eeri cflk";

    public static void sendCode(String toEmail, String verificationCode) {
        Properties pros = new Properties();
        pros.put("mail.smtp.host", "smtp.gmail.com"); //using SMTP host of gmail
        pros.put("mail.smtp.port", "587"); //using TLS: port 587, if use SSL port: 465
        pros.put("mail.smtp.auth", "true"); // require authentication step
        pros.put("mail.smtp.starttls.enable", "true"); // encode with tls

        // method for logging in email
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };
        // create a java mail session
        Session session = Session.getInstance(pros, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject("Register verification");
            msg.setSentDate(new Date());
            msg.setText("Your verification code is: " + verificationCode);
            Transport.send(msg); //send email with the message
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void sendLink(String toEmail, String link) {
        Properties pros = new Properties();
        pros.put("mail.smtp.host", "smtp.gmail.com"); //using SMTP host of gmail
        pros.put("mail.smtp.port", "587"); //using TLS: port 587, if use SSL port: 465
        pros.put("mail.smtp.auth", "true"); // require authentication step
        pros.put("mail.smtp.starttls.enable", "true"); // encode with tls

        // method for logging in email
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };
        // create a java mail session
        Session session = Session.getInstance(pros, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject("Register verification");
            msg.setSentDate(new Date());
            msg.setText("Your web's link: " + link);
            Transport.send(msg); //send email with the message
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void sendAccountCredentials(String toEmail, String username, String password, String link) {
        Properties pros = new Properties();
        pros.put("mail.smtp.host", "smtp.gmail.com");
        pros.put("mail.smtp.port", "587");
        pros.put("mail.smtp.auth", "true");
        pros.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };

        Session session = Session.getInstance(pros, auth);
        MimeMessage msg = new MimeMessage(session);

        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject("Thông tin tài khoản đăng nhập hệ thống");
            msg.setSentDate(new Date());

            StringBuilder sb = new StringBuilder();
            sb.append("Xin chào bạn,\n\n");
            sb.append("Tài khoản của bạn đã được tạo thành công. Dưới đây là thông tin đăng nhập:\n\n");
            sb.append("Tên đăng nhập: ").append(username).append("\n");
            sb.append("Mật khẩu: ").append(password).append("\n\n");
            sb.append("Hãy đăng nhập và đổi mật khẩu để bảo mật thông tin.\n");
            sb.append("Đăng nhập ở link: ").append(link).append("\n");
            sb.append("Trân trọng,\n");
            sb.append("Phòng Hệ Thống");

            msg.setText(sb.toString());

            Transport.send(msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static void sendRequest(String toEmail,  String content) {
        Properties pros = new Properties();
        pros.put("mail.smtp.host", "smtp.gmail.com"); //using SMTP host of gmail
        pros.put("mail.smtp.port", "587"); //using TLS: port 587, if use SSL port: 465
        pros.put("mail.smtp.auth", "true"); // require authentication step
        pros.put("mail.smtp.starttls.enable", "true"); // encode with tls
        pros.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // method for logging in email
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };
        // create a java mail session
        Session session = Session.getInstance(pros, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject("Request Transfer Receipt");
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg); //send email with the message
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static boolean sendEmail(String toEmail, String title, String content) {
        Properties pros = new Properties();
        pros.put("mail.smtp.host", "smtp.gmail.com"); //using SMTP host of gmail
        pros.put("mail.smtp.port", "587"); //using TLS: port 587, if use SSL port: 465
        pros.put("mail.smtp.auth", "true"); // require authentication step
        pros.put("mail.smtp.starttls.enable", "true"); // encode with tls
        pros.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // method for logging in email
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };
        // create a java mail session
        Session session = Session.getInstance(pros, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject(title);
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg); //send email with the message
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public static boolean sendEmailThanhToan(String toEmail, String title, String type, String jobTitle) {
        Properties pros = new Properties();
        pros.put("mail.smtp.host", "smtp.gmail.com"); //using SMTP host of gmail
        pros.put("mail.smtp.port", "587"); //using TLS: port 587, if use SSL port: 465
        pros.put("mail.smtp.auth", "true"); // require authentication step
        pros.put("mail.smtp.starttls.enable", "true"); // encode with tls
        pros.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // method for logging in email
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };
        // create a java mail session
        Session session = Session.getInstance(pros, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject(title);
            
            String content = "<html>"
                    + " <body style='font-family: Arial, sans-serif;'>"
                    + "     <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>"
                    + "         <h2 style='color: #2e7d32; margin-bottom: 20px;'>Thanh toán thành công</h2>"
                    + "         <p>Xin chào,</p>"
                    + "         <p>Bạn đã thanh toán thành công gói " + type + "cho bài tuyển dụng " + jobTitle + " </p>"
                    + "         <p style='margin-top: 30px;'>Trân trọng,<br>Đội ngũ Job Finding</p>"
                    + "     </div>"
                    + " </body>"
                    + "</html>";
            
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg); //send email with the message
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}