<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>

<%-- Authentication check --%>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="login"/>
</c:if>

<%-- Set locale for formatting --%>
<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Trang chủ ứng viên - JobFinding">
        <title>Trang chủ | JobFinding</title>

        <!-- Preload critical resources -->
        <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" as="style">
        <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" as="style">

        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" 
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" 
              integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous">

        <link rel="stylesheet" href="assets/css/dashboard.css">

        <style>
            :root {
                --primary-color: #00b14f;
                --secondary-color: #f8f9fa;
                --dark-color: #212f3f;
                --blue-color: #2f7cba;
                --gray-color: #6c757d;
                --light-gray: #f5f7fa;
                --border-color: #e9ecef;
                --success-color: #28a745;
                --warning-color: #ffc107;
                --danger-color: #dc3545;
                --info-color: #17a2b8;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                background-color: var(--light-gray);
                color: var(--dark-color);
                line-height: 1.6;
            }

            /* Navigation Styles */
            .navbar {
                background-color: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 0.75rem 0;
                position: sticky;
                top: 0;
                z-index: 1020;
            }

            .navbar-brand img {
                height: 40px;
                width: auto;
            }

            .nav-link {
                color: var(--dark-color);
                font-weight: 500;
                padding: 0.75rem 1rem;
                transition: all 0.3s ease;
                position: relative;
            }

            .nav-link:hover {
                color: var(--primary-color);
                transform: translateY(-1px);
            }

            /* Dashboard Container */
            .dashboard-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1rem;
            }

            /* Card Styles */
            .profile-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin-bottom: 1.5rem;
                border: 1px solid var(--border-color);
                transition: box-shadow 0.3s ease;
            }

            .profile-card:hover {
                box-shadow: 0 4px 16px rgba(0,0,0,0.12);
            }

            /* Profile Header */
            .profile-header {
                padding: 2rem;
                border-bottom: 1px solid var(--border-color);
                display: flex;
                align-items: center;
                gap: 1.5rem;
            }

            .profile-avatar {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid var(--primary-color);
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .profile-info h4 {
                margin: 0 0 0.5rem 0;
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--dark-color);
            }

            .profile-info p {
                margin: 0;
                color: var(--gray-color);
                font-size: 1rem;
            }

            /* Progress Bar */
            .profile-completion {
                padding: 2rem;
                border-bottom: 1px solid var(--border-color);
            }

            .progress {
                height: 10px;
                background-color: var(--light-gray);
                border-radius: 6px;
                margin: 1rem 0;
                overflow: hidden;
            }

            .progress-bar {
                background: linear-gradient(90deg, var(--primary-color) 0%, #00d460 100%);
                border-radius: 6px;
                transition: width 0.8s ease;
            }

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 1rem;
                padding: 2rem;
            }

            .stat-item {
                text-align: center;
                padding: 1.5rem;
                background: linear-gradient(135deg, var(--light-gray) 0%, #ffffff 100%);
                border-radius: 12px;
                border: 1px solid var(--border-color);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .stat-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .stat-item i {
                font-size: 2rem;
                color: var(--primary-color);
                margin-bottom: 1rem;
                display: block;
            }

            .stat-item h5 {
                font-size: 2rem;
                margin: 0 0 0.5rem 0;
                color: var(--dark-color);
                font-weight: 700;
            }

            .stat-item p {
                margin: 0;
                color: var(--gray-color);
                font-size: 0.9rem;
                font-weight: 500;
            }

            /* Section Titles */
            .section-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1.5rem 2rem;
                border-bottom: 1px solid var(--border-color);
                background: linear-gradient(90deg, #f8f9fa 0%, #ffffff 100%);
            }

            .section-title h5 {
                margin: 0;
                font-size: 1.2rem;
                font-weight: 600;
                color: var(--dark-color);
            }

            /* Buttons */
            .btn-primary {
                background: linear-gradient(135deg, var(--primary-color) 0%, #00d460 100%);
                border: none;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #009a43 0%, #00b350 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,177,79,0.3);
            }

            .btn-outline-primary {
                color: var(--primary-color);
                border: 2px solid var(--primary-color);
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background-color: var(--primary-color);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,177,79,0.3);
            }

            /* Job Cards */
            .job-card {
                padding: 2rem;
                border-bottom: 1px solid var(--border-color);
                transition: all 0.3s ease;
            }

            .job-card:hover {
                background: linear-gradient(135deg, var(--light-gray) 0%, #ffffff 100%);
                transform: translateX(5px);
            }

            .job-card:last-child {
                border-bottom: none;
            }

            .job-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 0.5rem;
                line-height: 1.4;
            }

            .job-company {
                color: var(--blue-color);
                font-size: 1rem;
                margin-bottom: 1rem;
                font-weight: 500;
            }

            .job-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 1.5rem;
                color: var(--gray-color);
                font-size: 0.9rem;
                margin-bottom: 1rem;
            }

            .job-meta span {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .job-meta i {
                width: 16px;
                text-align: center;
                color: var(--primary-color);
            }

            /* Status Badges */
            .badge-status {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-new, .status-mới {
                background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
                color: #1976d2;
                border: 1px solid #90caf9;
            }

            .status-reviewed, .status-đã_xem {
                background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
                color: #f57c00;
                border: 1px solid #ffcc02;
            }

            .status-interviewed, .status-phỏng_vấn {
                background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c8 100%);
                color: var(--success-color);
                border: 1px solid #81c784;
            }

            .status-rejected, .status-từ_chối {
                background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
                color: var(--danger-color);
                border: 1px solid #ef5350;
            }

            /* Empty State */
            .empty-state {
                padding: 4rem 2rem;
                text-align: center;
            }

            .empty-state img {
                width: 120px;
                margin-bottom: 2rem;
                opacity: 0.6;
                filter: grayscale(20%);
            }

            .empty-state h6 {
                color: var(--gray-color);
                margin-bottom: 1rem;
                font-size: 1.1rem;
            }

            .empty-state p {
                color: var(--gray-color);
                margin: 0;
                font-size: 0.95rem;
            }

            /* Notification Dropdown */
            .notification-dropdown {
                max-height: 400px;
                overflow-y: auto;
            }

            .notification-item {
                border-bottom: 1px solid var(--border-color);
                transition: background-color 0.2s ease;
            }

            .notification-item:hover {
                background-color: var(--light-gray);
            }

            .notification-item:last-child {
                border-bottom: none;
            }

            /* Loading Animation */
            .loading {
                opacity: 0.6;
                pointer-events: none;
            }

            .loading::after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 20px;
                height: 20px;
                margin: -10px 0 0 -10px;
                border: 2px solid var(--primary-color);
                border-radius: 50%;
                border-top-color: transparent;
                animation: spin 0.8s linear infinite;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            /* Responsive Design */
            @media (max-width: 992px) {
                .dashboard-container {
                    margin: 1rem auto;
                }

                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                    padding: 1.5rem;
                }
            }

            @media (max-width: 768px) {
                .profile-header {
                    flex-direction: column;
                    text-align: center;
                    padding: 1.5rem;
                }

                .profile-avatar {
                    margin-bottom: 1rem;
                }

                .job-meta {
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .section-title {
                    padding: 1rem 1.5rem;
                }

                .job-card {
                    padding: 1.5rem;
                }
            }

            @media (max-width: 576px) {
                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .navbar-nav {
                    text-align: center;
                }

                .profile-header {
                    padding: 1rem;
                }

                .profile-completion,
                .stats-grid {
                    padding: 1rem;
                }
            }

            /* Accessibility Improvements */
            .btn:focus,
            .nav-link:focus {
                outline: 2px solid var(--primary-color);
                outline-offset: 2px;
            }

            /* Print Styles */
            @media print {
                .navbar,
                .dropdown,
                .btn {
                    display: none !important;
                }

                .profile-card {
                    box-shadow: none;
                    border: 1px solid #000;
                }
            }

            /* Job Categories */
            .category-card {
                background: white;
                border: 1px solid var(--border-color);
                border-radius: 12px;
                padding: 1rem 1.25rem;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }
            .category-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                text-decoration: none;
            }
            .category-card i {
                font-size: 1.75rem;
                color: var(--primary-color);
            }
        </style>
    </head>

    <body>
        <!-- Skip to main content for accessibility -->
        <a href="#main-content" class="visually-hidden-focusable">Chuyển đến nội dung chính</a>

        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg" role="navigation" aria-label="Main navigation">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home.jsp" aria-label="JobFinding Homepage">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="JobFinding Logo">
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                        data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" 
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/job_search.jsp">
                                <i class="fas fa-search me-2" aria-hidden="true"></i>Tìm việc làm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/cv_templates.jsp">
                                <i class="fas fa-file-alt me-2" aria-hidden="true"></i>Mẫu CV
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/companies.jsp">
                                <i class="fas fa-building me-2" aria-hidden="true"></i>Công ty
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/blog.jsp">
                                <i class="fas fa-newspaper me-2" aria-hidden="true"></i>Blog
                            </a>
                        </li>
                    </ul>

                    <div class="d-flex align-items-center gap-3">
                        <!-- Notifications -->
                        <div class="dropdown">
                            <button class="btn btn-light position-relative" type="button" 
                                    data-bs-toggle="dropdown" aria-expanded="false" 
                                    aria-label="Notifications">
                                <i class="fas fa-bell" aria-hidden="true"></i>
                                <c:if test="${not empty notifications and fn:length(notifications) > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                                          aria-label="${fn:length(notifications)} thông báo mới">
                                        ${fn:length(notifications)}
                                    </span>
                                </c:if>
                            </button>
                            <div class="dropdown-menu dropdown-menu-end notification-dropdown" style="width: 350px;">
                                <h6 class="dropdown-header d-flex justify-content-between align-items-center">
                                    <span>Thông báo</span>
                                    <small class="text-muted">${fn:length(notifications)} mới</small>
                                </h6>
                                <div class="dropdown-divider"></div>

                                <c:choose>
                                    <c:when test="${not empty notifications}">
                                        <c:forEach items="${notifications}" var="notification" varStatus="status">
                                            <div class="notification-item">
                                                <a class="dropdown-item py-3" href="#" role="menuitem">
                                                    <div class="d-flex">
                                                        <div class="flex-shrink-0 me-3">
                                                            <i class="fas fa-bell text-primary" aria-hidden="true"></i>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <p class="mb-1 fw-medium">
                                                                <c:out value="${notification.content}" escapeXml="true"/>
                                                            </p>
                                                            <small class="text-muted">
                                                                <i class="fas fa-clock me-1" aria-hidden="true"></i>
                                                                <fmt:formatDate value="${notification.createdAt}" 
                                                                                pattern="dd/MM/yyyy HH:mm" />
                                                            </small>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-bell-slash text-muted mb-2" style="font-size: 2rem;" aria-hidden="true"></i>
                                            <p class="text-muted mb-0">Không có thông báo mới</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-center fw-medium" href="${pageContext.request.contextPath}/notifications.jsp">
                                    <i class="fas fa-external-link-alt me-1" aria-hidden="true"></i>Xem tất cả thông báo
                                </a>
                            </div>
                        </div>

                        <!-- User Menu -->
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle d-flex align-items-center" 
                                    type="button" data-bs-toggle="dropdown" aria-expanded="false"
                                    aria-label="User menu">
                                <img src="<c:choose><c:when test='${not empty sessionScope.user.profilePicture}'><c:out value='${sessionScope.user.profilePicture}'/></c:when><c:otherwise>${pageContext.request.contextPath}/assets/images/default-avatar.png</c:otherwise></c:choose>"
                                     class="rounded-circle me-2" width="32" height="32" 
                                         alt="Avatar của <c:out value='${sessionScope.user.fullName}'/>">
                                <span class="d-none d-sm-inline">
                                    <c:out value="${sessionScope.user.fullName}" escapeXml="true"/>
                                </span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/profile.jsp">
                                        <i class="fas fa-user me-2" aria-hidden="true"></i>Hồ sơ cá nhân
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/my_cvs.jsp">
                                        <i class="fas fa-file-alt me-2" aria-hidden="true"></i>CV của tôi
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/applications.jsp">
                                        <i class="fas fa-paper-plane me-2" aria-hidden="true"></i>Việc làm đã ứng tuyển
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/saved_jobs.jsp">
                                        <i class="fas fa-heart me-2" aria-hidden="true"></i>Việc làm đã lưu
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/settings.jsp">
                                        <i class="fas fa-cog me-2" aria-hidden="true"></i>Cài đặt
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2" aria-hidden="true"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <main id="main-content" class="dashboard-container">
            <div class="row">
                <!-- Left Column -->
                <div class="col-lg-4">
                    <!-- Profile Summary -->
                    <section class="profile-card" aria-labelledby="profile-summary">
                        <div class="profile-header">
                            <img src="<c:choose><c:when test='${not empty sessionScope.user.profilePicture}'><c:out value='${sessionScope.user.profilePicture}'/></c:when><c:otherwise>${pageContext.request.contextPath}/assets/images/default-avatar.png</c:otherwise></c:choose>"
                                 class="profile-avatar" alt="Ảnh đại diện của <c:out value='${sessionScope.user.fullName}'/>">
                            <div class="profile-info">
                                <h4 id="profile-summary">
                                    <c:out value="${sessionScope.user.fullName}" escapeXml="true"/>
                                </h4>
                                <p>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user.desiredJobTitle}">
                                            <c:out value="${sessionScope.user.desiredJobTitle}" escapeXml="true"/>
                                        </c:when>
                                        <c:otherwise>Chưa cập nhật vị trí mong muốn</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>

                        <div class="profile-completion">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0">Mức độ hoàn thiện hồ sơ</h6>
                                <span class="text-primary fw-bold">${profileCompleteness}%</span>
                            </div>
                            <div class="progress" role="progressbar" aria-label="Profile completion" 
                                 aria-valuenow="${profileCompleteness}" aria-valuemin="0" aria-valuemax="100">
                                <div class="progress-bar" style="width: ${profileCompleteness}%"></div>
                            </div>
                            <small class="text-muted">
                                <c:choose>
                                    <c:when test="${profileCompleteness >= 80}">
                                        <i class="fas fa-check-circle text-success me-1" aria-hidden="true"></i>
                                        Hồ sơ đã hoàn thiện tốt!
                                    </c:when>
                                    <c:when test="${profileCompleteness >= 50}">
                                        <i class="fas fa-info-circle text-warning me-1" aria-hidden="true"></i>
                                        Hoàn thiện thêm để tăng cơ hội việc làm
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-exclamation-circle text-danger me-1" aria-hidden="true"></i>
                                        Cần hoàn thiện hồ sơ để nhận được nhiều cơ hội hơn
                                    </c:otherwise>
                                </c:choose>
                            </small>
                        </div>

                        <div class="p-3">
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/edit_profile.jsp" 
                                   class="btn btn-primary">
                                    <i class="fas fa-edit me-2" aria-hidden="true"></i>Chỉnh sửa hồ sơ
                                </a>
                                <a href="${pageContext.request.contextPath}/create_cv.jsp" 
                                   class="btn btn-outline-primary">
                                    <i class="fas fa-plus me-2" aria-hidden="true"></i>Tạo CV mới
                                </a>
                            </div>
                        </div>
                    </section>

                    <!-- Profile Stats -->
                    <section class="profile-card" aria-labelledby="profile-stats">
                        <h5 id="profile-stats" class="visually-hidden">Thống kê hoạt động</h5>
                        <div class="stats-grid">
                            <div class="stat-item">
                                <i class="fas fa-paper-plane" aria-hidden="true"></i>
                                <h5>${requestScope.applicationCount != null ? requestScope.applicationCount : 0}</h5>
                                <p>Đã ứng tuyển</p>
                            </div>
                            <div class="stat-item">
                                <i class="fas fa-heart" aria-hidden="true"></i>
                                <h5>${requestScope.savedJobsCount != null ? requestScope.savedJobsCount : 0}</h5>
                                <p>Đã lưu</p>
                            </div>
                            <div class="stat-item">
                                <i class="fas fa-eye" aria-hidden="true"></i>
                                <h5>${sessionScope.user.profileViews != null ? sessionScope.user.profileViews : 0}</h5>
                                <p>Lượt xem</p>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Right Column -->
                <div class="col-lg-8">
                    <!-- Recent Applications -->
                    <section class="profile-card" aria-labelledby="recent-applications">
                        <div class="section-title">
                            <h5 id="recent-applications">Việc làm đã ứng tuyển gần đây</h5>
                            <a href="${pageContext.request.contextPath}/applications.jsp" 
                               class="btn btn-link text-decoration-none">
                                Xem tất cả <i class="fas fa-arrow-right ms-1" aria-hidden="true"></i>
                            </a>
                        </div>

                        <c:choose>
                            <c:when test="${not empty recentApplications}">
                                <c:forEach items="${recentApplications}" var="app" varStatus="status">
                                    <article class="job-card">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div class="flex-grow-1">
                                                <h6 class="job-title">
                                                    <a href="${pageContext.request.contextPath}/job_details.jsp?id=${app.jobListing.id}" 
                                                       class="text-decoration-none text-dark">
                                                        <c:out value="${app.jobListing.title}" escapeXml="true"/>
                                                    </a>
                                                </h6>
                                                <p class="job-company">
                                                    <c:out value="${app.jobListing.recruiter.companyName}" escapeXml="true"/>
                                                </p>
                                                <div class="job-meta">
                                                    <span>
                                                        <i class="fas fa-calendar" aria-hidden="true"></i>
                                                        Ứng tuyển: <fmt:formatDate value="${app.appliedAt}" pattern="dd/MM/yyyy" />
                                                    </span>
                                                    <c:if test="${not empty app.jobListing.location}">
                                                        <span>
                                                            <i class="fas fa-map-marker-alt" aria-hidden="true"></i>
                                                            <c:out value="${app.jobListing.location}" escapeXml="true"/>
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="flex-shrink-0 ms-3">
                                                <span class="badge-status status-${fn:toLowerCase(fn:replace(app.status, ' ', '_'))}"
                                                      role="status" aria-label="Trạng thái: ${app.status}">
                                                    <c:out value="${app.status}" escapeXml="true"/>
                                                </span>
                                            </div>
                                        </div>
                                    </article>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <img src="${pageContext.request.contextPath}/assets/images/empty-application.png" 
                                         alt="Chưa có ứng tuyển nào">
                                    <h6>Chưa có ứng tuyển nào</h6>
                                    <p>Bạn chưa ứng tuyển vào vị trí nào. Hãy tìm kiếm và ứng tuyển công việc phù hợp!</p>
                                    <a href="${pageContext.request.contextPath}/job_search.jsp" 
                                       class="btn btn-primary mt-3">
                                        <i class="fas fa-search me-2" aria-hidden="true"></i>Tìm việc làm ngay
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </section>

                    <!-- Recommended Jobs -->
                    <section class="profile-card mt-4" aria-labelledby="recommended-jobs">
                        <div class="section-title">
                            <h5 id="recommended-jobs">Việc làm phù hợp với bạn</h5>
                            <a href="${pageContext.request.contextPath}/job_search.jsp" 
                               class="btn btn-link text-decoration-none">
                                Xem tất cả <i class="fas fa-arrow-right ms-1" aria-hidden="true"></i>
                            </a>
                        </div>

                        <c:choose>
                            <c:when test="${not empty recommendedJobs}">
                                <c:forEach items="${recommendedJobs}" var="job" varStatus="status">
                                    <article class="job-card">
                                        <div class="row align-items-center">
                                            <div class="col-md-9">
                                                <h6 class="job-title">
                                                    <a href="${pageContext.request.contextPath}/job_details.jsp?id=${job.id}" 
                                                       class="text-decoration-none text-dark">
                                                        <c:out value="${job.title}" escapeXml="true"/>
                                                    </a>
                                                </h6>
                                                <p class="job-company">
                                                    <c:out value="${job.recruiterName}" escapeXml="true"/>
                                                </p>
                                                <div class="job-meta">
                                                    <c:if test="${not empty job.salaryMin and not empty job.salaryMax}">
                                                        <span>
                                                            <i class="fas fa-money-bill-wave" aria-hidden="true"></i>
                                                            <fmt:formatNumber value="${job.salaryMin}" type="number" /> - 
                                                            <fmt:formatNumber value="${job.salaryMax}" type="number" /> triệu VNĐ
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${not empty job.location}">
                                                        <span>
                                                            <i class="fas fa-map-marker-alt" aria-hidden="true"></i>
                                                            <c:out value="${job.location}" escapeXml="true"/>
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${not empty job.timeAgo}">
                                                        <span>
                                                            <i class="fas fa-clock" aria-hidden="true"></i>
                                                            <c:out value="${job.timeAgo}" escapeXml="true"/>
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-3 text-end">
                                                <div class="d-flex flex-column gap-2">
                                                    <a href="${pageContext.request.contextPath}/job_detail.jsp?id=${job.id}" 
                                                       class="btn btn-primary btn-sm">
                                                        <i class="fas fa-paper-plane me-1" aria-hidden="true"></i>
                                                        Ứng tuyển ngay
                                                    </a>
                                                    <button class="btn btn-outline-primary btn-sm btn-save-job" 
                                                            data-job-id="${job.id}"
                                                            data-bs-toggle="tooltip" 
                                                            title="Lưu việc làm"
                                                            aria-label="Lưu việc làm ${job.title}">
                                                        <i class="far fa-heart" aria-hidden="true"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </article>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <img src="${pageContext.request.contextPath}/assets/images/empty-job.png" 
                                         alt="Chưa có việc làm phù hợp">
                                    <h6>Chưa có việc làm phù hợp</h6>
                                    <p>Hệ thống chưa tìm thấy việc làm phù hợp với hồ sơ của bạn. Hãy cập nhật thông tin để nhận được gợi ý tốt hơn!</p>
                                    <div class="d-flex gap-2 justify-content-center mt-3">
                                        <a href="${pageContext.request.contextPath}/edit_profile.jsp" 
                                           class="btn btn-primary">
                                            <i class="fas fa-user-edit me-2" aria-hidden="true"></i>Cập nhật hồ sơ
                                        </a>
                                        <a href="${pageContext.request.contextPath}/job_search.jsp" 
                                           class="btn btn-outline-primary">
                                            <i class="fas fa-search me-2" aria-hidden="true"></i>Tìm việc làm
                                        </a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </section>

                    <!-- Top Job Categories -->
                    <section class="profile-card mt-4" aria-labelledby="top-categories">
                        <div class="section-title">
                            <h5 id="top-categories">Ngành nghề phổ biến</h5>
                        </div>
                        <div class="p-4">
                            <c:choose>
                                <c:when test="${not empty jobCategories}">
                                    <div class="row g-3">
                                        <c:forEach items="${jobCategories}" var="cat">
                                            <div class="col-12 col-md-6 col-lg-4">
                                                <a href="${pageContext.request.contextPath}/home?jobType=${cat.jobType}" class="category-card" aria-label="${cat.jobType} (${cat.count}) việc làm">
                                                    <i class="fas fa-briefcase" aria-hidden="true"></i>
                                                    <div>
                                                        <h6 class="mb-0">
                                                            <c:choose>
                                                                <c:when test="${cat.jobType == 'full_time'}">Full-time</c:when>
                                                                <c:when test="${cat.jobType == 'part_time'}">Part-time</c:when>
                                                                <c:when test="${cat.jobType == 'internship'}">Internship</c:when>
                                                                <c:when test="${cat.jobType == 'freelance'}">Freelance</c:when>
                                                                <c:when test="${cat.jobType == 'contract'}">Contract</c:when>
                                                                <c:otherwise>${cat.jobType}</c:otherwise>
                                                            </c:choose>
                                                        </h6>
                                                        <small class="text-muted">(${cat.count}) việc làm</small>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p>Không có dữ liệu ngành nghề.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>

                    <!-- Quick Actions -->
                    <section class="profile-card mt-4" aria-labelledby="quick-actions">
                        <div class="section-title">
                            <h5 id="quick-actions">Thao tác nhanh</h5>
                        </div>
                        <div class="p-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/cv_templates.jsp" 
                                           class="btn btn-outline-primary">
                                            <i class="fas fa-file-alt me-2" aria-hidden="true"></i>
                                            Tạo CV từ mẫu
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/companies.jsp" 
                                           class="btn btn-outline-primary">
                                            <i class="fas fa-building me-2" aria-hidden="true"></i>
                                            Khám phá công ty
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/blog.jsp" 
                                           class="btn btn-outline-primary">
                                            <i class="fas fa-newspaper me-2" aria-hidden="true"></i>
                                            Mẹo tìm việc
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/settings.jsp" 
                                           class="btn btn-outline-primary">
                                            <i class="fas fa-cog me-2" aria-hidden="true"></i>
                                            Cài đặt tài khoản
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </main>

        <!-- Success/Error Toast -->
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div id="actionToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <i class="fas fa-info-circle text-primary me-2" aria-hidden="true"></i>
                    <strong class="me-auto">Thông báo</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body"></div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Initialize tooltips
                const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });

                // Toast functionality
                const toastElement = document.getElementById('actionToast');
                const toast = new bootstrap.Toast(toastElement);

                function showToast(message, type = 'info') {
                    const toastBody = toastElement.querySelector('.toast-body');
                    const toastIcon = toastElement.querySelector('.toast-header i');

                    toastBody.textContent = message;

                    // Update icon and color based on type
                    toastIcon.className = 'fas me-2';
                    switch (type) {
                        case 'success':
                            toastIcon.classList.add('fa-check-circle', 'text-success');
                            break;
                        case 'error':
                            toastIcon.classList.add('fa-exclamation-circle', 'text-danger');
                            break;
                        case 'warning':
                            toastIcon.classList.add('fa-exclamation-triangle', 'text-warning');
                            break;
                        default:
                            toastIcon.classList.add('fa-info-circle', 'text-primary');
                    }

                    toast.show();
                }

                // Save job functionality with improved error handling
                document.querySelectorAll('.btn-save-job').forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();

                        const jobId = this.getAttribute('data-job-id');
                        const icon = this.querySelector('i');
                        const isSaved = icon.classList.contains('fas');

                        // Show loading state
                        this.disabled = true;
                        this.classList.add('loading');

                        const originalTitle = this.getAttribute('title');
                        this.setAttribute('title', 'Đang xử lý...');

                        fetch('${pageContext.request.contextPath}/save_job', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                                'X-Requested-With': 'XMLHttpRequest'
                            },
                            body: `jobId=${encodeURIComponent(jobId)}&action=${isSaved ? 'unsave' : 'save'}`
                        })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error(`HTTP error! status: ${response.status}`);
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    if (data.success) {
                                        if (data.action === 'saved') {
                                            icon.classList.remove('far');
                                            icon.classList.add('fas');
                                            this.classList.add('text-danger');
                                            this.setAttribute('title', 'Đã lưu - Click để bỏ lưu');
                                            showToast('Đã lưu việc làm thành công!', 'success');
                                        } else {
                                            icon.classList.remove('fas');
                                            icon.classList.add('far');
                                            this.classList.remove('text-danger');
                                            this.setAttribute('title', 'Lưu việc làm');
                                            showToast('Đã bỏ lưu việc làm!', 'info');
                                        }

                                        // Update tooltip
                                        const tooltipInstance = bootstrap.Tooltip.getInstance(this);
                                        if (tooltipInstance) {
                                            tooltipInstance.dispose();
                                            new bootstrap.Tooltip(this);
                                        }
                                    } else {
                                        throw new Error(data.message || 'Có lỗi xảy ra');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'error');
                                    this.setAttribute('title', originalTitle);
                                })
                                .finally(() => {
                                    // Remove loading state
                                    this.disabled = false;
                                    this.classList.remove('loading');
                                });
                    });
                });

                // Profile completion animation
                const progressBar = document.querySelector('.progress-bar');
                if (progressBar) {
                    const targetWidth = progressBar.style.width;
                    progressBar.style.width = '0%';
                    setTimeout(() => {
                        progressBar.style.width = targetWidth;
                    }, 500);
                }

                // Smooth scroll for anchor links
                document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                    anchor.addEventListener('click', function (e) {
                        e.preventDefault();
                        const target = document.querySelector(this.getAttribute('href'));
                        if (target) {
                            target.scrollIntoView({
                                behavior: 'smooth',
                                block: 'start'
                            });
                        }
                    });
                });

                // Add keyboard navigation for dropdown menus
                document.querySelectorAll('.dropdown-menu').forEach(menu => {
                    menu.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape') {
                            const toggle = this.previousElementSibling;
                            bootstrap.Dropdown.getInstance(toggle).hide();
                            toggle.focus();
                        }
                    });
                });

                // Auto-refresh notifications every 5 minutes
                setInterval(function () {
                    if (document.visibilityState === 'visible') {
                        // Only refresh if page is visible
                        fetch('${pageContext.request.contextPath}/api/notifications/count', {
                            method: 'GET',
                            headers: {
                                'X-Requested-With': 'XMLHttpRequest'
                            }
                        })
                                .then(response => response.json())
                                .then(data => {
                                    const badge = document.querySelector('.navbar .badge');
                                    if (data.count > 0) {
                                        if (badge) {
                                            badge.textContent = data.count;
                                        }
                                    } else {
                                        if (badge) {
                                            badge.style.display = 'none';
                                        }
                                    }
                                })
                                .catch(error => console.error('Error refreshing notifications:', error));
                    }
                }, 300000); // 5 minutes

                // Performance monitoring
                if ('performance' in window) {
                    window.addEventListener('load', function () {
                        setTimeout(function () {
                            const perfData = performance.getEntriesByType('navigation')[0];
                            if (perfData && perfData.loadEventEnd - perfData.loadEventStart > 3000) {
                                console.warn('Page load time exceeded 3 seconds');
                            }
                        }, 0);
                    });
                }
            });
        </script>

        <!-- Schema.org structured data for SEO -->
        <script type="application/ld+json">
            {
            "@context": "https://schema.org",
            "@type": "WebApplication",
            "name": "JobFinding Dashboard",
            "description": "Trang chủ ứng viên tìm việc làm",
            "url": "${pageContext.request.contextPath}/dashboard.jsp",
            "applicationCategory": "BusinessApplication",
            "operatingSystem": "Web"
            }
        </script>
    </body>
</html>