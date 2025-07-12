package controllers;

import daos.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.JavaMail;
import utils.PasswordUtils;

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
        String token = request.getParameter("token");
        if (token != null && !token.isEmpty()) {
            // Token exists, show the password reset form
            try {
                if (userDAO.isResetTokenValid(token)) {
                    request.setAttribute("token", token);
                    request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error validating reset token", e);
                request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại sau.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            // No token, show the email request form
            request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            if (token != null && !token.isEmpty()) {
                // Handle password update
                if (newPassword == null || !newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "Mật khẩu không khớp.");
                    request.setAttribute("token", token);
                    request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
                    return;
                }

                if (userDAO.isResetTokenValid(token)) {
                    String hashedPassword = PasswordUtils.hashPassword(newPassword);
                    if (userDAO.updatePasswordByToken(token, hashedPassword)) {
                        userDAO.invalidateResetToken(token); // Mark token as used
                        request.setAttribute("message", "Mật khẩu đã được cập nhật thành công.");
                        response.sendRedirect(request.getContextPath() + "/login.jsp");
                    } else {
                        request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại.");
                        request.setAttribute("token", token);
                        request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } else if (email != null && !email.isEmpty()) {
                // Handle password reset request
                if (userDAO.userExistsByEmail(email)) {
                    String resetToken = UUID.randomUUID().toString();
                    if (userDAO.storePasswordResetToken(email, resetToken)) {
                        boolean emailSent = JavaMail.sendPasswordResetEmail(email, resetToken);
                        if (emailSent) {
                            request.setAttribute("message", "Một liên kết đặt lại mật khẩu đã được gửi đến email của bạn.");
                        } else {
                            request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
                        }
                    } else {
                        request.setAttribute("error", "Không thể tạo yêu cầu đặt lại mật khẩu. Vui lòng thử lại sau.");
                    }
                } else {
                    request.setAttribute("error", "Email không tồn tại trong hệ thống.");
                }
                request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
            } else {
                 request.setAttribute("error", "Vui lòng nhập email của bạn.");
                 request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during password reset process", e);
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "ResetPasswordController handles password reset requests and updates.";
    }
}