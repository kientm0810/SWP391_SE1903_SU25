<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!-- Admin Header Component -->
        <header class="admin-header">
            <div class="header-container">
                <div class="header-left">
                    <div class="logo-section">
                        <img src="assets/img/logo/logoweb.png" alt="JobFinding Logo" height="40" class="logo">
                        <div class="logo-text">
                            <h3 class="mb-0">Admin Panel</h3>
                            <small class="text-muted">Recruitment System</small>
                        </div>
                    </div>
                </div>

                <div class="header-center">
                    <nav class="header-nav">
                        <a href="admin_dashboard.jsp"
                            class="nav-link ${pageContext.request.servletPath == '/admin_dashboard.jsp' ? 'active' : ''}">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>

                        <c:if test="${sessionScope.adminRole == 'admin'}">
                            <div class="nav-dropdown">
                                <button class="nav-link dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-tags"></i>
                                    <span>Content Types</span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="admin_post_types.jsp">
                                            <i class="fas fa-tags"></i> Post Types
                                        </a></li>
                                    <li><a class="dropdown-item" href="admin_blog_types.jsp">
                                            <i class="fas fa-layer-group"></i> Blog Types
                                        </a></li>
                                </ul>
                            </div>
                        </c:if>

                        <c:if test="${sessionScope.adminRole == 'manager' || sessionScope.adminRole == 'admin'}">
                            <a href="AdminController?target=Recruiter"
                                class="nav-link ${param.target == 'Recruiter' ? 'active' : ''}">
                                <i class="fas fa-building"></i>
                                <span>Recruiters</span>
                            </a>

                            <a href="AdminController?target=Staff"
                                class="nav-link ${param.target == 'Staff' ? 'active' : ''}">
                                <i class="fas fa-user-tie"></i>
                                <span>Staff</span>
                            </a>
                        </c:if>

                        <c:if test="${sessionScope.adminRole == 'saler' || sessionScope.adminRole == 'admin'}">
                            <a href="AdminSalerController?target=blog"
                                class="nav-link ${param.target == 'blog' ? 'active' : ''}">
                                <i class="fas fa-blog"></i>
                                <span>Blogs</span>
                            </a>

                            <a href="AdminSalerController?target=banner"
                                class="nav-link ${param.target == 'banner' ? 'active' : ''}">
                                <i class="fas fa-image"></i>
                                <span>Banners</span>
                            </a>
                        </c:if>

                        <c:if test="${sessionScope.adminRole == 'manager' || sessionScope.adminRole == 'admin'}">
                            <a href="reports.jsp"
                                class="nav-link ${pageContext.request.servletPath == '/reports.jsp' ? 'active' : ''}">
                                <i class="fas fa-chart-bar"></i>
                                <span>Reports</span>
                            </a>
                        </c:if>
                    </nav>
                </div>

                <div class="header-right">
                    <div class="user-menu">
                        <div class="user-info">
                            <img src="https://via.placeholder.com/35" alt="Admin Avatar" class="user-avatar">
                            <div class="user-details">
                                <span class="user-name">Admin</span>
                                <small class="user-role">${sessionScope.adminRole}</small>
                            </div>
                        </div>

                        <div class="dropdown">
                            <button class="btn btn-link dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="profile.jsp">
                                        <i class="fas fa-user-circle"></i> My Profile
                                    </a></li>
                                <li><a class="dropdown-item" href="settings.jsp">
                                        <i class="fas fa-cog"></i> Settings
                                    </a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="home">
                                        <i class="fas fa-home"></i> Go to Home
                                    </a></li>
                                <li><a class="dropdown-item" href="logout">
                                        <i class="fas fa-sign-out-alt"></i> Logout
                                    </a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <style>
            .admin-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 0;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .header-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 20px;
                height: 70px;
            }

            .header-left .logo-section {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .logo {
                border-radius: 8px;
            }

            .logo-text h3 {
                font-size: 18px;
                margin: 0;
                color: white;
            }

            .logo-text small {
                color: rgba(255, 255, 255, 0.8);
            }

            .header-center {
                flex: 1;
                display: flex;
                justify-content: center;
            }

            .header-nav {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .nav-link {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 10px 15px;
                color: rgba(255, 255, 255, 0.9);
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-size: 14px;
                font-weight: 500;
            }

            .nav-link:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                transform: translateY(-1px);
            }

            .nav-link.active {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .nav-link i {
                font-size: 16px;
            }

            .nav-dropdown .dropdown-toggle::after {
                margin-left: 5px;
            }

            .dropdown-menu {
                border: none;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
                border-radius: 10px;
                padding: 8px 0;
            }

            .dropdown-item {
                padding: 10px 20px;
                display: flex;
                align-items: center;
                gap: 10px;
                color: #333;
                transition: all 0.3s ease;
            }

            .dropdown-item:hover {
                background-color: #f8f9fa;
                color: #007bff;
            }

            .dropdown-item i {
                width: 16px;
                text-align: center;
            }

            .header-right .user-menu {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .user-avatar {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid rgba(255, 255, 255, 0.3);
            }

            .user-details {
                display: flex;
                flex-direction: column;
            }

            .user-name {
                font-weight: 600;
                font-size: 14px;
                color: white;
            }

            .user-role {
                color: rgba(255, 255, 255, 0.8);
                font-size: 12px;
                text-transform: capitalize;
            }

            .btn-link {
                color: rgba(255, 255, 255, 0.8);
                padding: 8px;
                border-radius: 50%;
                transition: all 0.3s ease;
            }

            .btn-link:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .header-container {
                    padding: 0 15px;
                }

                .header-center {
                    display: none;
                }

                .logo-text {
                    display: none;
                }

                .user-details {
                    display: none;
                }
            }

            @media (max-width: 576px) {
                .header-container {
                    padding: 0 10px;
                }

                .logo-section {
                    gap: 10px;
                }
            }
        </style>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>