<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Promotion Programs - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .promotion-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .promotion-card {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .promotion-card:hover {
            border-color: #4caf50;
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(76,175,80,0.2);
        }
        
        .promotion-card.featured {
            border-color: #4caf50;
            background: linear-gradient(135deg, #f1f8e9 0%, #ffffff 100%);
        }
        
        .promotion-card.featured::before {
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
            font-weight: bold;
        }
        
        .promotion-name {
            font-size: 24px;
            font-weight: bold;
            color: #2e7d32;
            margin-bottom: 15px;
        }
        
        .promotion-price {
            font-size: 28px;
            font-weight: bold;
            color: #1b5e20;
            margin: 15px 0;
        }
        
        .promotion-duration {
            color: #666;
            margin-bottom: 15px;
            font-size: 14px;
        }
        
        .promotion-description {
            color: #666;
            margin-bottom: 25px;
            min-height: 50px;
            font-size: 14px;
            line-height: 1.5;
        }
        
        .promotion-stats {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .stat-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .stat-item:last-child {
            margin-bottom: 0;
        }
        
        .stat-label {
            color: #666;
        }
        
        .stat-value {
            font-weight: bold;
            color: #2e7d32;
        }
        
        .promotion-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .btn-view-posts {
            background: #4caf50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-view-posts:hover {
            background: #45a049;
            color: white;
            text-decoration: none;
        }
        
        .btn-edit {
            background: #2196f3;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-edit:hover {
            background: #1976d2;
            color: white;
            text-decoration: none;
        }
        
        .page-stats {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .overall-stat {
            text-align: center;
            padding: 15px;
            border-radius: 8px;
            background: #f8f9fa;
        }
        
        .overall-stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #2e7d32;
        }
        
        .overall-stat-label {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Quản lý chương trình khuyến mãi</h1>
<!--                <div class="header-actions">
                    <a href="AdminController?target=program&service=add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm chương trình mới
                    </a>
                </div>-->
            </div>
            
            <!-- Hiển thị thông báo thành công -->
            <c:if test="${not empty successMessage}">
                <div style="background: #e8f5e8; border: 1px solid #4caf50; color: #2e7d32; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                    <i class="fas fa-check-circle"></i>
                    ${successMessage}
                </div>
            </c:if>
            
            <!-- Tổng quan thống kê -->
            <div class="page-stats">
                <h3 style="margin-bottom: 20px; color: #2e7d32;">Tổng quan</h3>
                <div class="stats-grid">
                    <div class="overall-stat">
                        <div class="overall-stat-value">${totalActivePosts}</div>
                        <div class="overall-stat-label">Tổng bài đăng đang hoạt động</div>
                    </div>
                    <div class="overall-stat">
                        <div class="overall-stat-value">
                            <fmt:formatNumber value="${totalMonthlyRevenue}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="overall-stat-label">
                            Doanh thu tháng này
                            <br><small style="opacity: 0.8;">
                                (<fmt:formatNumber value="${totalAllTimeRevenue}" pattern="#,###" /> VNĐ tổng cộng)
                            </small>
                        </div>
                    </div>
                    <div class="overall-stat">
                        <div class="overall-stat-value">${totalActiveRecruiters}</div>
                        <div class="overall-stat-label">Nhà tuyển dụng đang hoạt động</div>
                    </div>
                    <div class="overall-stat">
                        <div class="overall-stat-value">${promotionPrograms.size()}</div>
                        <div class="overall-stat-label">Chương trình khuyến mãi</div>
                    </div>
                </div>
            </div>
            
            <!-- Danh sách promotion programs -->
            <div class="promotion-grid">
                <c:forEach var="program" items="${promotionPrograms}" varStatus="status">
                    <div class="promotion-card ${program.positionType == 'featured' ? 'featured' : ''}">
                        <div class="promotion-name">${program.name}</div>
                        <div class="promotion-price">
                            <fmt:formatNumber value="${program.cost}" pattern="#,###" /> VNĐ
                        </div>
                        <div class="promotion-duration">${program.durationDays} ngày</div>
                        <div class="promotion-description">${program.description}</div>
                        
                        <!-- Thống kê cho từng program -->
                        <div class="promotion-stats">
                            <div class="stat-item">
                                <span class="stat-label">Số bài đăng:</span>
                                <span class="stat-value">${postCounts[program.id]}</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Doanh thu tháng này:</span>
                                <span class="stat-value">
                                    <fmt:formatNumber value="${monthlyRevenues[program.id]}" pattern="#,###" /> VNĐ
                                </span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Tổng doanh thu:</span>
                                <span class="stat-value">
                                    <fmt:formatNumber value="${allTimeRevenues[program.id]}" pattern="#,###" /> VNĐ
                                </span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Số lượng còn lại:</span>
                                <span class="stat-value">
                                    <c:choose>
                                        <c:when test="${program.quantity == -1}">
                                            <span style="color: #4caf50;">Không giới hạn</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: ${program.quantity > 10 ? '#4caf50' : '#ff9800'};">
                                                ${program.quantity}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Trạng thái:</span>
                                <span class="stat-value">
                                    <c:choose>
                                        <c:when test="${program.active}">
                                            <span style="color: #4caf50;">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #f44336;">Tạm dừng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                        
                        <div class="promotion-actions">
                            <a href="AdminPromotionController?target=program&service=viewPosts&programId=${program.id}" 
                               class="btn-view-posts">
                                <i class="fas fa-list"></i>
                                Xem bài đăng
                            </a>
                            <a href="AdminPromotionController?target=program&service=update&id=${program.id}" 
                               class="btn-edit">
                                <i class="fas fa-edit"></i>
                                Chỉnh sửa
                            </a>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty promotionPrograms}">
                    <div style="grid-column: 1 / -1; text-align: center; padding: 50px; color: #666;">
                        <i class="fas fa-inbox" style="font-size: 48px; margin-bottom: 20px; opacity: 0.5;"></i>
                        <p>Chưa có chương trình khuyến mãi nào.</p>
                        <a href="AdminController?target=program&service=add" class="btn btn-primary">
                            Tạo chương trình đầu tiên
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>