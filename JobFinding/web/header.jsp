<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <header class="header-area">
        <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
            <div class="container">
                <!-- Logo -->
                <a class="navbar-brand" href="home">
                    <img src="assets/img/logo/logo.png" alt="JobFinding Logo" height="40">
                </a>

                <!-- Mobile Toggle -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Main Navigation -->
                <div class="collapse navbar-collapse" id="navbarMain">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="home">
                                <i class="fas fa-home"></i> Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="post?viewAll=true">
                                <i class="fas fa-briefcase"></i> Jobs
                            </a>
                        </li>
                        <c:if test="${sessionScope.role == 'recruiter'}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="communityDropdown" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-users"></i> Community
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="communityDropdown">

                                    <li>
                                        <a class="dropdown-item" href="create-post.jsp">
                                            <i class="fas fa-edit"></i> Create Post
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="post?view=my-post">
                                            <i class="fas fa-user-edit"></i> My Posts
                                        </a>
                                    </li>

                                </ul>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="about">
                                <i class="fas fa-info-circle"></i> About
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact">
                                <i class="fas fa-envelope"></i> Contact
                            </a>
                        </li>
                    </ul>

                    <!-- User Menu -->
                    <div class="d-flex align-items-center">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <div class="dropdown">
                                    <button class="btn btn-light dropdown-toggle" type="button" id="userDropdown"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user-circle"></i>
                                        ${sessionScope.user.fullName}
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                        <li>
                                            <a class="dropdown-item" href="profile">
                                                <i class="fas fa-user"></i> My Profile
                                            </a>
                                        </li>
                                        <c:if test="${sessionScope.role == 'recruiter'}">
                                            <li>
                                                <a class="dropdown-item" href="post?view=my">
                                                    <i class="fas fa-file-alt"></i> My Posts
                                                </a>
                                            </li>
                                        </c:if>
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/saved-jobs">
                                                <i class="fas fa-heart"></i> Saved Jobs
                                            </a>
                                        </li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li>
                                            <a class="dropdown-item text-danger" href="logout">
                                                <i class="fas fa-sign-out-alt"></i> Logout
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="register" class="btn btn-outline-primary me-2">
                                    <i class="fas fa-user-plus"></i> Register
                                </a>
                                <a href="login" class="btn btn-primary">
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <style>
        :root {
            --topcv-primary: #00B14F;
            --topcv-primary-hover: #009443;
            --topcv-secondary: #F5F5F5;
            --topcv-text: #333333;
            --topcv-light-text: #666666;
            --topcv-border: #E5E5E5;
            --topcv-box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            --topcv-success: #00B14F;
            --topcv-warning: #FFB800;
            --topcv-danger: #FF4D4F;
            --topcv-link: #00B14F;
            --topcv-link-hover: #009443;
        }

        .header-area {
            margin-bottom: 70px;
        }

        .navbar {
            padding: 0.75rem 0;
            background-color: #fff !important;
            box-shadow: var(--topcv-box-shadow);
            border-bottom: 1px solid var(--topcv-border);
        }

        .navbar-brand {
            padding: 0;
        }

        .navbar-brand img {
            height: 32px;
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover img {
            transform: scale(1.05);
        }

        .nav-link {
            color: var(--topcv-text) !important;
            padding: 0.5rem 1rem !important;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link:hover {
            color: var(--topcv-primary) !important;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 50%;
            background-color: var(--topcv-primary);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .nav-link i {
            margin-right: 0.5rem;
            font-size: 16px;
            color: var(--topcv-primary);
        }

        /* Dropdown Styles */
        .dropdown-menu {
            border: 1px solid var(--topcv-border);
            box-shadow: var(--topcv-box-shadow);
            border-radius: 8px;
            padding: 0.5rem;
            min-width: 200px;
        }

        .dropdown-item {
            padding: 0.75rem 1rem;
            color: var(--topcv-text);
            font-size: 14px;
            border-radius: 4px;
            transition: all 0.2s ease;
        }

        .dropdown-item:hover {
            background-color: var(--topcv-secondary);
            color: var(--topcv-primary);
            transform: translateX(5px);
        }

        .dropdown-item i {
            margin-right: 0.75rem;
            width: 16px;
            text-align: center;
            color: var(--topcv-primary);
        }

        .dropdown-item:hover i {
            color: var(--topcv-primary-hover);
        }

        .dropdown-divider {
            margin: 0.5rem 0;
            border-color: var(--topcv-border);
        }

        /* Button Styles */
        .btn {
            padding: 0.5rem 1.25rem;
            font-weight: 500;
            font-size: 14px;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--topcv-primary);
            border-color: var(--topcv-primary);
        }

        .btn-primary:hover {
            background-color: var(--topcv-primary-hover);
            border-color: var(--topcv-primary-hover);
            transform: translateY(-1px);
        }

        .btn-outline-primary {
            color: var(--topcv-primary);
            border-color: var(--topcv-primary);
        }

        .btn-outline-primary:hover {
            background-color: var(--topcv-primary);
            border-color: var(--topcv-primary);
            transform: translateY(-1px);
        }

        .btn-light {
            background-color: var(--topcv-secondary);
            border-color: var(--topcv-border);
            color: var(--topcv-text);
        }

        .btn-light:hover {
            background-color: var(--topcv-border);
            border-color: var(--topcv-border);
            color: var(--topcv-primary);
        }

        .dropdown-toggle::after {
            margin-left: 0.5rem;
            vertical-align: middle;
            border-top-color: var(--topcv-primary);
        }

        /* User Menu */
        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: var(--topcv-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--topcv-primary);
            font-size: 16px;
            border: 2px solid var(--topcv-primary);
        }

        /* Active States */
        .nav-link.active {
            color: var(--topcv-primary) !important;
        }

        .nav-link.active::after {
            width: 100%;
        }

        .dropdown-item.active {
            background-color: var(--topcv-primary);
            color: white;
        }

        .dropdown-item.active i {
            color: white;
        }

        /* Mobile Styles */
        @media (max-width: 991.98px) {
            .navbar-collapse {
                padding: 1rem 0;
                background-color: white;
                border-radius: 8px;
                box-shadow: var(--topcv-box-shadow);
                margin-top: 1rem;
            }

            .navbar-nav {
                margin-bottom: 1rem !important;
            }

            .nav-link::after {
                display: none;
            }

            .d-flex {
                display: block !important;
                width: 100%;
            }

            .btn {
                display: block;
                width: 100%;
                margin: 0.5rem 0;
                text-align: center;
            }

            .user-menu {
                flex-direction: column;
                width: 100%;
            }

            .dropdown-menu {
                position: static !important;
                box-shadow: none;
                border: none;
                padding: 0;
            }

            .navbar-toggler {
                border: none;
                padding: 0.5rem;
                color: var(--topcv-primary);
            }

            .navbar-toggler:focus {
                box-shadow: none;
                outline: none;
            }

            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(0, 177, 79, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .dropdown-menu.show {
            animation: fadeIn 0.3s ease;
        }

        /* Notification Badge */
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: var(--topcv-primary);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid white;
        }
    </style>

    <!-- Bootstrap and Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>