<!-- payment_success.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán thành công</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 500px;
                margin: 50px auto;
                background: white;
                border-radius: 10px;
                padding: 40px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                text-align: center;
            }
            .success-icon {
                font-size: 64px;
                color: #4caf50;
                margin-bottom: 20px;
            }
            .success-title {
                color: #2e7d32;
                font-size: 24px;
                margin-bottom: 15px;
            }
            .success-message {
                color: #666;
                margin-bottom: 30px;
            }
            .btn {
                padding: 12px 25px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                margin: 10px;
                text-decoration: none;
                display: inline-block;
            }
            .btn-primary {
                background: #4caf50;
                color: white;
            }
            .btn-secondary {
                background: #9e9e9e;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="success-icon">✅</div>
            <h2 class="success-title">Thanh toán thành công!</h2>
            <p class="success-message">Giao dịch của bạn đã được xử lý thành công.</p>

            <div>
                <a href="recruiter_dashboard.jsp" class="btn btn-primary">Về Dashboard</a>
                <a href="my_jobs.jsp" class="btn btn-secondary">Quản lý tin đăng</a>
            </div>
        </div>
    </body>
</html>