<!-- registration_checkout.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán phí đăng ký</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .header {
                text-align: center;
                color: #2e7d32;
                margin-bottom: 30px;
            }
            .amount-box {
                background: #e8f5e8;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
                margin: 20px 0;
            }
            .amount {
                font-size: 28px;
                font-weight: bold;
                color: #1b5e20;
            }
            .btn-pay {
                background: #4caf50;
                color: white;
                padding: 15px 30px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }
            .btn-pay:hover {
                background: #45a049;
            }
            .note {
                background: #fff3e0;
                padding: 15px;
                border-radius: 5px;
                border-left: 4px solid #ff9800;
            }
            
        </style>
    </head>
    <body>
        <main>
            <div class="container">
                <div class="header">
                    <h2>Thanh toán phí đăng ký Recruiter</h2>
                </div>

                <c:if test="${not empty paymentError}">
                    <div style="background: #ffebee; color: #c62828; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
                        ${paymentError}
                    </div>
                </c:if>

                <div class="amount-box">
                    <p><strong>Phí đăng ký tài khoản</strong></p>
                    <div class="amount">50.000 VNĐ</div>
                    <p>Thanh toán một lần để xác thực tài khoản</p>
                </div>

                <form action="checkout" method="post">
                    <input type="hidden" name="action" value="registration">
                    <input type="hidden" name="recruiterId" value="${recruiterId}">
                    <button type="submit" class="btn-pay">Thanh toán qua VNPay</button>
                </form>

                <div class="note">
                    <strong>Lưu ý:</strong> Sau khi thanh toán thành công, tài khoản sẽ được xác thực và bạn có thể đăng tin tuyển dụng.
                </div>
            </div>
        </main>
    </body>
</html>
