<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #ffe6f0;
            font-family: 'Segoe UI', sans-serif;
        }
        .form-container {
            background: #fff0f5;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 0 20px rgba(255, 105, 180, 0.2);
        }
        h3 {
            color: #d63384;
        }
        .form-control, .form-select, textarea {
            border-radius: 12px;
            border: 1px solid #f5c2d7;
        }
        .form-control:focus, .form-select:focus, textarea:focus {
            box-shadow: 0 0 5px #ff99cc;
            border-color: #ff66b2;
        }
        .btn-primary {
            background-color: #ff69b4;
            border-color: #ff69b4;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #ff1493;
            border-color: #ff1493;
        }
        .alert {
            border-radius: 12px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="mx-auto form-container" style="max-width: 600px;">
        <h3 class="mb-4 text-center">Đăng ký tài khoản</h3>
        <form method="post" action="register">
            <div class="mb-3">
                <input class="form-control" name="username" placeholder="Tên đăng nhập" required>
            </div>
            <div class="mb-3">
                <input class="form-control" type="password" name="password" placeholder="Mật khẩu" required>
            </div>
            <div class="mb-3">
                <input class="form-control" name="email" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input class="form-control" name="fullName" placeholder="Họ tên" required>
            </div>
            <div class="mb-3">
                <input class="form-control" name="phone" placeholder="Số điện thoại">
            </div>
            <div class="mb-3">
                <input class="form-control" name="dob" type="date" required>
            </div>
            <div class="mb-3">
                <select class="form-select" name="gender">
                    <option value="Nam">Nam</option>
                    <option value="Nữ">Nữ</option>
                    <option value="Khác">Khác</option>
                </select>
            </div>
            <div class="mb-3">
                <textarea class="form-control" name="address" placeholder="Địa chỉ"></textarea>
            </div>
            <div class="mb-3">
                <select class="form-select" name="role" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="job_seeker">Người tìm việc</option>
                    <option value="employer">Nhà tuyển dụng</option>
                </select>
            </div>

            <button class="btn btn-primary w-100">Đăng ký</button>

            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success mt-3">${message}</div>
            </c:if>
        </form>
    </div>
</div>
</body>
</html>