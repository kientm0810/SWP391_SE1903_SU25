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
                    <li class="nav-item">
                        <a class="nav-link" href="blog.jsp">
                            <i class="fas fa-blog"></i> Blog
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
                            <c:if test="${sessionScope.role == 'recruiter'}">
                                <div class="dropdown" data-bs-auto-close="outside">
                                    <button class="btn btn-light dropdown-toggle" type="button" id="notiDropdown"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-bell"></i>
                                    </button>

                                    <ul class="dropdown-menu dropdown-menu-end notifications" aria-labelledby="notiDropdown">

                                        <!-- Notification filter tabs -->
                                        <div class="d-flex justify-content-center px-3 pt-2">
                                            <button type="button" class="btn btn-sm btn-outline-primary me-1 tab-btn active" 
                                                    data-target="all">
                                                All
                                            </button>
                                            <button type="button" class="btn btn-sm btn-outline-primary me-1 tab-btn" 
                                                    data-target="unread">
                                                Unread
                                            </button>
                                        </div>
                                        <hr class="my-2" />

                                        <!-- All notifications -->
                                        <div class="tab-content all">
                                            <c:forEach var="noti" items="${notice}">
                                                <a href="notification?service=detail&type=all&id=${noti.id}" class="text-decoration-none text-dark">
                                                    <li class="notification-item ${noti.is_read ? '' : 'unread'}">
                                                        <div class="notification-title">${noti.title}</div>
                                                        <div class="notification-content">${noti.content}</div>
                                                        <span class="notification-time">${noti.created_at}</span>
                                                    </li>
                                                </a>
                                            </c:forEach>
                                        </div>

                                        <!-- Unread notifications only -->
                                        <div class="tab-content unread d-none">
                                            <c:forEach var="noti" items="${unread}">
                                                <c:if test="${!noti.is_read}">
                                                    <a href="notification?service=detail&type=all&id=${noti.id}" class="text-decoration-none text-dark">
                                                        <li class="notification-item unread">
                                                            <div class="notification-title">${noti.title}</div>
                                                            <div class="notification-content">${noti.content}</div>
                                                            <span class="notification-time">${noti.created_at}</span>
                                                        </li>
                                                    </a>
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <li class="view-all text-center mt-2">
                                            <a href="notification" class="text-primary text-decoration-none">View all</a>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>
                            <div>&nbsp;</div>
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
                                            <a class="dropdown-item" href="post">
                                                <i class="fas fa-file-alt"></i> My Posts
                                            </a>
                                        </li>
                                    </c:if>
                                    <li>
                                        <a class="dropdown-item" href="list_cv">
                                            <i class="fas fa-user"></i> My CV
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="my-posts">
                                            <i class="fas fa-file-alt"></i> My Posts
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
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

<!-- Bootstrap and Font Awesome -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="assets/css/header.css">

<script src="assets/js/header.js"></script>
