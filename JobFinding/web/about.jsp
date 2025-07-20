<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về Chúng Tôi - JobFinding</title>
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
        }

        .intro-section {
            background: white;
            padding: 2.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            text-align: center;
        }

        .intro-section h2 {
            color: #28a745;
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .intro-section p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 1rem;
        }

        .mvv-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .mvv-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }

        .mvv-card:hover {
            transform: translateY(-5px);
        }

        .mvv-card .icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #28a745;
        }

        .mvv-card h3 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
            color: #333;
        }

        .mvv-card p {
            color: #666;
        }

        .stats-section {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 2.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            text-align: center;
        }

        .stats-section h2 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1.5rem;
        }

        .stat-item {
            padding: 1rem;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            display: block;
            margin-bottom: 0.5rem;
        }

        .why-choose-section {
            background: white;
            padding: 2.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .why-choose-section h2 {
            color: #28a745;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .feature-item {
            padding: 1.5rem;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #28a745;
        }

        .feature-item h4 {
            color: #28a745;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .feature-item p {
            color: #666;
            font-size: 0.95rem;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            .mvv-section {
                grid-template-columns: 1fr;
            }
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main class="container">
        <div class="main-content">
            <!-- Giới thiệu -->
            <div class="intro-section">
                <h2><i class="fas fa-building"></i> JobFinding - Nền tảng tuyển dụng hàng đầu</h2>
                <p>JobFinding là nền tảng kết nối việc làm trực tuyến, giúp ứng viên tìm kiếm cơ hội nghề nghiệp lý tưởng và hỗ trợ nhà tuyển dụng tìm được nhân tài phù hợp.</p>
                <p>Với hơn 5 năm kinh nghiệm trong lĩnh vực tuyển dụng, chúng tôi tự hào là cầu nối tin cậy giữa ứng viên và doanh nghiệp.</p>
            </div>

            <!-- Sứ mệnh, Tầm nhìn, Giá trị -->
            <div class="mvv-section">
                <div class="mvv-card">
                    <i class="fas fa-eye icon"></i>
                    <h3>Tầm Nhìn</h3>
                    <p>Trở thành nền tảng tuyển dụng hàng đầu Việt Nam, kết nối hiệu quả giữa ứng viên và nhà tuyển dụng.</p>
                </div>

                <div class="mvv-card">
                    <i class="fas fa-heart icon"></i>
                    <h3>Sứ Mệnh</h3>
                    <p>Mang đến giải pháp tuyển dụng toàn diện, giúp mọi người tìm được công việc phù hợp và phát triển sự nghiệp.</p>
                </div>

                <div class="mvv-card">
                    <i class="fas fa-gem icon"></i>
                    <h3>Giá Trị</h3>
                    <p>Minh bạch, uy tín, hiệu quả và luôn đặt lợi ích của người dùng lên hàng đầu trong mọi hoạt động.</p>
                </div>
            </div>

            <!-- Thống kê -->
            <div class="stats-section">
                <h2><i class="fas fa-chart-line"></i> Thành Tựu Của Chúng Tôi</h2>
                <div class="stats-grid">
                    <div class="stat-item">
                        <span class="stat-number">50,000+</span>
                        <span class="stat-label">Ứng viên</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">5,000+</span>
                        <span class="stat-label">Nhà tuyển dụng</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">20,000+</span>
                        <span class="stat-label">Việc làm đã kết nối</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">95%</span>
                        <span class="stat-label">Độ hài lòng</span>
                    </div>
                </div>
            </div>

            <!-- Tại sao chọn chúng tôi -->
            <div class="why-choose-section">
                <h2><i class="fas fa-star"></i> Tại Sao Chọn JobFinding?</h2>
                <div class="features-grid">
                    <div class="feature-item">
                        <h4><i class="fas fa-search"></i> Tìm kiếm thông minh</h4>
                        <p>Hệ thống lọc và tìm kiếm công việc thông minh, giúp bạn tìm được vị trí phù hợp nhanh chóng.</p>
                    </div>

                    <div class="feature-item">
                        <h4><i class="fas fa-shield-alt"></i> Bảo mật thông tin</h4>
                        <p>Cam kết bảo vệ thông tin cá nhân của người dùng với các tiêu chuẩn bảo mật cao nhất.</p>
                    </div>

                    <div class="feature-item">
                        <h4><i class="fas fa-headset"></i> Hỗ trợ 24/7</h4>
                        <p>Đội ngũ chăm sóc khách hàng chuyên nghiệp, sẵn sàng hỗ trợ bạn mọi lúc mọi nơi.</p>
                    </div>

                    <div class="feature-item">
                        <h4><i class="fas fa-mobile-alt"></i> Đa nền tảng</h4>
                        <p>Truy cập dễ dàng trên mọi thiết bị: máy tính, tablet, điện thoại với giao diện thân thiện.</p>
                    </div>

                    <div class="feature-item">
                        <h4><i class="fas fa-chart-bar"></i> Phân tích chi tiết</h4>
                        <p>Cung cấp báo cáo và thống kê chi tiết về hiệu quả tuyển dụng cho nhà tuyển dụng.</p>
                    </div>

                    <div class="feature-item">
                        <h4><i class="fas fa-users-cog"></i> Cộng đồng chuyên nghiệp</h4>
                        <p>Kết nối với cộng đồng chuyên gia và chia sẻ kinh nghiệm nghề nghiệp trong các lĩnh vực.</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>