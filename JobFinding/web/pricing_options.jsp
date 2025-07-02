<!-- pricing_options.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chọn gói đăng tin</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 900px;
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
            .pricing-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
            }
            .pricing-card {
                border: 2px solid #e0e0e0;
                border-radius: 10px;
                padding: 25px;
                text-align: center;
                transition: all 0.3s;
                position: relative;
            }
            .pricing-card:hover {
                border-color: #4caf50;
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(76,175,80,0.2);
            }
            .featured {
                border-color: #4caf50;
                background: linear-gradient(135deg, #f1f8e9 0%, #ffffff 100%);
            }
            .featured::before {
                content: "Phổ biến";
                position: absolute;
                top: -10px;
                left: 50%;
                transform: translateX(-50%);
                background: #4caf50;
                color: white;
                padding: 5px 15px;
                border-radius: 15px;
                font-size: 12px;
            }
            .plan-name {
                font-size: 24px;
                font-weight: bold;
                color: #2e7d32;
                margin-bottom: 10px;
            }
            .plan-price {
                font-size: 32px;
                font-weight: bold;
                color: #1b5e20;
                margin: 15px 0;
            }
            .plan-duration {
                color: #666;
                margin-bottom: 20px;
            }
            .plan-description {
                color: #666;
                margin-bottom: 25px;
                min-height: 50px;
            }
            .btn-select {
                background: #4caf50;
                color: white;
                padding: 12px 25px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }
            .btn-select:hover {
                background: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h2>Chọn gói đăng tin tuyển dụng</h2>
                <p>Chọn gói phù hợp để tăng hiệu quả tuyển dụng</p>
            </div>

            <div class="pricing-grid">
                <c:forEach var="pricing" items="${pricingOptions}" varStatus="status">
                    <div class="pricing-card ${pricing.positionCode == 'featured' ? 'featured' : ''}">
                        <div class="plan-name">${pricing.positionName}</div>
                        <div class="plan-price">
                            <fmt:formatNumber value="${pricing.price}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="plan-duration">${pricing.durationDays} ngày</div>
                        <div class="plan-description">${pricing.description}</div>
                        <form action="checkout" method="post">
                            <input type="hidden" name="action" value="jobPost">
                            <input type="hidden" name="jobId" value="${jobId}">
                            <input type="hidden" name="positionCode" value="${pricing.positionCode}">
                            <button type="submit" class="btn-select">Chọn gói này</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
