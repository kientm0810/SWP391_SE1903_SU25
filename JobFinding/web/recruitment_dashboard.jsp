<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Recruitment Dashboard - Quản lý tuyển dụng</title>
    <link rel="stylesheet" href="assets/css/admin-tables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* giữ nguyên toàn bộ phần CSS như cũ */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stage-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border-left: 4px solid #00b894;
        }
        .stage-card h3 {
            color: #00b894;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        .process-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            border-left: 3px solid #00b894;
            transition: all 0.3s ease;
        }
        .process-item:hover {
            transform: translateX(5px);
            box-shadow: 0 3px 10px rgba(0, 184, 148, 0.2);
        }
        .process-item h4 {
            color: #333;
            margin-bottom: 5px;
            font-size: 1rem;
        }
        .process-item p {
            color: #666;
            font-size: 0.9rem;
            margin: 5px 0;
        }
        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        .status-in-progress {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }
        .status-hired {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        .quick-actions {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        .quick-actions h3 {
            color: #00b894;
            margin-bottom: 15px;
        }
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .btn-small {
            padding: 8px 16px;
            font-size: 0.85rem;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border-top: 4px solid #00b894;
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #00b894;
            margin-bottom: 5px;
        }
        .stat-label {
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="page-header">
            <h2><i class="fas fa-users-cog"></i> Recruitment Dashboard</h2>
            <p>Quản lý quy trình tuyển dụng và theo dõi tiến độ ứng viên</p>
        </div>

        <div class="table-container">
            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number">${inProgress.size()}</div>
                    <div class="stat-label">Đang xử lý</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${completed.size()}</div>
                    <div class="stat-label">Hoàn thành</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${rejected.size()}</div>
                    <div class="stat-label">Từ chối</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${hired.size()}</div>
                    <div class="stat-label">Đã tuyển</div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h3><i class="fas fa-bolt"></i> Thao tác nhanh</h3>
                <div class="action-buttons">
                    <a href="recruitment_screening.jsp" class="btn btn-primary btn-small">
                        <i class="fas fa-search"></i> Sàng lọc hồ sơ
                    </a>
                    <a href="recruitment/phone-interview" class="btn btn-success btn-small">
                        <i class="fas fa-phone"></i> Phỏng vấn điện thoại
                    </a>
                    <a href="recruitment/skills-test" class="btn btn-secondary btn-small">
                        <i class="fas fa-clipboard-check"></i> Test kỹ năng
                    </a>
                    <a href="recruitment/final-interview" class="btn btn-primary btn-small">
                        <i class="fas fa-user-tie"></i> Phỏng vấn cuối
                    </a>
                    <a href="recruitment/decision" class="btn btn-success btn-small">
                        <i class="fas fa-gavel"></i> Quyết định
                    </a>
                    <a href="recruitment/offer" class="btn btn-secondary btn-small">
                        <i class="fas fa-file-contract"></i> Gửi offer
                    </a>
                </div>
            </div>

            <!-- Process Stages -->
            <div class="dashboard-grid">
                <!-- In Progress -->
                <div class="stage-card">
                    <h3><i class="fas fa-clock"></i> Đang xử lý (${inProgress.size()})</h3>
                    <c:choose>
                        <c:when test="${empty inProgress}">
                            <p style="color: #999; text-align: center;">Không có quy trình nào đang xử lý</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="process" items="${inProgress}" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <div class="process-item">
                                        <h4>Application #${process.applicationId}</h4>
                                        <p><strong>Stage:</strong> ${process.currentStage}</p>
                                        <p><strong>Updated:</strong> ${process.updatedAt}</p>
                                        <span class="status-badge status-in-progress">In Progress</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <c:if test="${inProgress.size() > 5}">
                                <p style="text-align: center; color: #00b894; font-weight: bold;">
                                    +${inProgress.size() - 5} thêm...
                                </p>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Completed -->
                <div class="stage-card">
                    <h3><i class="fas fa-check-circle"></i> Hoàn thành (${completed.size()})</h3>
                    <c:choose>
                        <c:when test="${empty completed}">
                            <p style="color: #999; text-align: center;">Chưa có quy trình nào hoàn thành</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="process" items="${completed}" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <div class="process-item">
                                        <h4>Application #${process.applicationId}</h4>
                                        <p><strong>Stage:</strong> ${process.currentStage}</p>
                                        <p><strong>Completed:</strong> ${process.updatedAt}</p>
                                        <span class="status-badge status-completed">Completed</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <c:if test="${completed.size() > 5}">
                                <p style="text-align: center; color: #00b894; font-weight: bold;">
                                    +${completed.size() - 5} thêm...
                                </p>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Rejected -->
                <div class="stage-card">
                    <h3><i class="fas fa-times-circle"></i> Từ chối (${rejected.size()})</h3>
                    <c:choose>
                        <c:when test="${empty rejected}">
                            <p style="color: #999; text-align: center;">Chưa có ứng viên nào bị từ chối</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="process" items="${rejected}" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <div class="process-item">
                                        <h4>Application #${process.applicationId}</h4>
                                        <p><strong>Stage:</strong> ${process.currentStage}</p>
                                        <p><strong>Rejected:</strong> ${process.updatedAt}</p>
                                        <span class="status-badge status-rejected">Rejected</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <c:if test="${rejected.size() > 5}">
                                <p style="text-align: center; color: #00b894; font-weight: bold;">
                                    +${rejected.size() - 5} thêm...
                                </p>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Hired -->
                <div class="stage-card">
                    <h3><i class="fas fa-user-check"></i> Đã tuyển (${hired.size()})</h3>
                    <c:choose>
                        <c:when test="${empty hired}">
                            <p style="color: #999; text-align: center;">Chưa có ứng viên nào được tuyển</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="process" items="${hired}" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <div class="process-item">
                                        <h4>Application #${process.applicationId}</h4>
                                        <p><strong>Stage:</strong> ${process.currentStage}</p>
                                        <p><strong>Hired:</strong> ${process.updatedAt}</p>
                                        <span class="status-badge status-hired">Hired</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <c:if test="${hired.size() > 5}">
                                <p style="text-align: center; color: #00b894; font-weight: bold;">
                                    +${hired.size() - 5} thêm...
                                </p>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="action-buttons">
                <a href="home.jsp" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <a href="applications.jsp" class="btn btn-primary">
                    <i class="fas fa-list"></i> Xem tất cả đơn ứng tuyển
                </a>
            </div>
        </div>
    </div>
</body>

</html>
