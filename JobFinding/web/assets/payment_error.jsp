<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lỗi thanh toán</title>
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
            .error-icon {
                font-size: 64px;
                color: #f44336;
                margin-bottom: 20px;
            }
            .error-title {
                color: #d32f2f;
                font-size: 24px;
                margin-bottom: 15px;
            }
            .error-message {
                color: #666;
                margin-bottom: 30px;
                padding: 15px;
                background: #ffebee;
                border-radius: 5px;
                border-left: 4px solid #f44336;
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
            .btn:hover {
                opacity: 0.9;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="error-icon">❌</div>
            <h2 class="error-title">Có lỗi xảy ra!</h2>

            <div class="error-message">
                <c:choose>
                    <c:when test="${not empty error}">
                        ${error}
                    </c:when>
                    <c:otherwise>
                        Đã xảy ra lỗi trong quá trình xử lý thanh toán. Vui lòng thử lại sau.
                    </c:otherwise>
                </c:choose>
            </div>

            <div>
                <a href="javascript:history.back()" class="btn btn-primary">Quay lại</a>
                <a href="home" class="btn btn-secondary">Về Homepage</a>
            </div>
        </div>
    </body>
</html>