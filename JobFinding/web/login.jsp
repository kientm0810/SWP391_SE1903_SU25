<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
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
        <h4 class="text-center text-dark mb-3">Đăng nhập</h4>
         
        <form action="login" method="post">
          
            <div class="mb-3">
                <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
            </div>
              <input type="radio" id="job-seeker" name="role" value="job-seeker">
                <label for="job-seeker">Job-seeker</label>
                   <input type="radio" id="employer" name="role" value="employer">
                <label for="employer">Employer</label>
            <button type="submit" class="btn btn-pink w-100 mb-2">Đăng nhập</button>
            <div class="text-center">
                <a href="reset_password.jsp" class="text-decoration-none text-dark">Quên mật khẩu?</a>
            </div>
             
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3" role="alert">${error}</div>
            </c:if>
        </form>
    </div>
</body>
</html>