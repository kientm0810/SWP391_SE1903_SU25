<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #c8e6c9, #a5d6a7); /* Xanh lá cây nhạt */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 100%;
            max-width: 420px;
            background-color: #ffffff;
        }

        .card h4 {
            font-weight: bold;
            color: #2e7d32; /* Màu xanh đậm */
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #a5d6a7;
        }

        .btn-green {
            background-color: #66bb6a;
            color: white;
            border-radius: 10px;
            font-weight: bold;
        }

        .btn-green:hover {
            background-color: #388e3c;
        }

        .btn-secondary {
            border-radius: 10px;
        }

        .alert {
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="card">
        <h4 class="text-center mb-4">🔐 Đặt lại mật khẩu</h4>

        <c:if test="${not empty message}">
            <div class="alert alert-success" role="alert">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty token}">
                <!-- Form to set a new password -->
                <form action="reset-password" method="post">
                    <input type="hidden" name="token" value="${token}">
                    <div class="mb-3">
                        <input type="password" name="newPassword" class="form-control" placeholder="Mật khẩu mới" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required>
                    </div>
                    <button type="submit" class="btn btn-green w-100 mb-2">Đặt lại mật khẩu</button>
                    <a href="login.jsp" class="btn btn-secondary w-100">Hủy</a>
                </form>
            </c:when>
            <c:otherwise>
                <!-- Form to request a password reset link -->
                <form action="reset-password" method="post">
                    <div class="mb-3">
                        <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>
                    </div>
                    <button type="submit" class="btn btn-green w-100 mb-2">Gửi liên kết đặt lại</button>
                    <a href="login.jsp" class="btn btn-secondary w-100">Quay về đăng nhập</a>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>