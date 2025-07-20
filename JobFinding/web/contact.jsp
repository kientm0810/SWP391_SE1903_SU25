<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên Hệ - JobFinding</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f8f9fa;
        }

        .header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 3rem 0;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .main-content {
            padding: 3rem 0;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .contact-form, .contact-info {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .contact-form h2, .contact-info h2 {
            color: #28a745;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 2px solid #e9ecef;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #28a745;
        }

        .submit-btn {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            width: 100%;
            transition: transform 0.3s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
        }

        .info-item {
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #28a745;
        }

        .info-item h3 {
            color: #28a745;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-item p {
            color: #666;
            margin: 0;
        }

        .info-item a {
            color: #28a745;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            .main-content {
                grid-template-columns: 1fr;
            }
            .header h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main class="container">
        <div class="main-content">
            <div class="contact-form">
                <h2><i class="fas fa-paper-plane"></i> Gửi Tin Nhắn</h2>
                
                <form action="${pageContext.request.contextPath}/contact" method="post">
                    <div class="form-group">
                        <label for="fullName">Họ và Tên *</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Số Điện Thoại</label>
                        <input type="tel" id="phone" name="phone">
                    </div>

                    <div class="form-group">
                        <label for="subject">Chủ Đề *</label>
                        <select id="subject" name="subject" required>
                            <option value="">Chọn chủ đề</option>
                            <option value="job_search">Hỗ trợ tìm việc</option>
                            <option value="employer">Dành cho nhà tuyển dụng</option>
                            <option value="technical">Hỗ trợ kỹ thuật</option>
                            <option value="other">Khác</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="message">Nội Dung *</label>
                        <textarea id="message" name="message" rows="4" required></textarea>
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="fas fa-paper-plane"></i> Gửi Tin Nhắn
                    </button>
                </form>
            </div>

            <div class="contact-info">
                <h2><i class="fas fa-info-circle"></i> Thông Tin Liên Hệ</h2>
                
                <div class="info-item">
                    <h3><i class="fas fa-map-marker-alt"></i> Địa Chỉ</h3>
                    <p>123 Đường Láng, Đống Đa, Hà Nội</p>
                </div>

                <div class="info-item">
                    <h3><i class="fas fa-phone"></i> Điện Thoại</h3>
                    <p><a href="tel:+84243456789">024 3456 7890</a></p>
                    <p><a href="tel:+84987654321">098 765 4321</a></p>
                </div>

                <div class="info-item">
                    <h3><i class="fas fa-envelope"></i> Email</h3>
                    <p><a href="mailto:contact@jobfinding.vn">contact@jobfinding.vn</a></p>
                </div>

                <div class="info-item">
                    <h3><i class="fas fa-clock"></i> Giờ Làm Việc</h3>
                    <p>Thứ 2 - Thứ 6: 8:00 - 18:00</p>
                    <p>Thứ 7: 8:00 - 12:00</p>
                </div>

                <div class="info-item">
                    <h3><i class="fab fa-facebook"></i> Mạng Xã Hội</h3>
                    <p><a href="#" target="_blank">Facebook</a> | <a href="#" target="_blank">LinkedIn</a></p>
                </div>
            </div>
        </div>
    </main>
</body>
</html>