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
            background: linear-gradient(to right, #f8bbd0, #f48fb1);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border: none;
            border-radius: 15px;
        }
        .btn-pink {
            background-color: #ec407a;
            color: white;
        }
        .btn-pink:hover {
            background-color: #d81b60;
        }
    </style>
</head>
<body>
    <div class="card shadow p-4" style="width: 100%; max-width: 400px;">
        <h4 class="text-center text-dark mb-3">Đặt lại mật khẩu</h4>
        <form action="reset-password" method="post">
            <div class="mb-3">
                <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>
            </div>
            <button type="submit" class="btn btn-pink w-100 mb-2">Gửi mật khẩu mới</button>

            <a href="login.jsp" class="btn btn-secondary w-100">Quay về đăng nhập</a>

            <c:if test="${not empty message}">
                <div class="alert alert-success mt-3" role="alert">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3" role="alert">${error}</div>
            </c:if>
        </form>
    </div>
</body>
</html>