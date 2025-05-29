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
                        <a class="nav-link" href="job-listing">
                            <i class="fas fa-briefcase"></i> Jobs
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="communityDropdown" role="button" 
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-users"></i> Community
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="communityDropdown">
                            <li>
                                <a class="dropdown-item" href="posts">
                                    <i class="fas fa-list-ul"></i> All Posts
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="create_post.jsp">
                                    <i class="fas fa-edit"></i> Create Post
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="my_posts.jsp">
                                    <i class="fas fa-user-edit"></i> My Posts
                                </a>
                            </li>
                        </ul>
                    </li>
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

<style>
    .header-area {
        margin-bottom: 70px;
    }
    .navbar {
        padding: 0.75rem 0;
        background-color: #fff !important;
    }
    .navbar-brand {
        padding: 0;
    }
    .nav-link {
        color: #2d3846 !important;
        padding: 0.5rem 1rem !important;
        font-weight: 500;
    }
    .nav-link:hover {
        color: #00b14f !important;
    }
    .nav-link i {
        margin-right: 0.5rem;
    }
    .dropdown-item {
        padding: 0.5rem 1rem;
        color: #2d3846;
    }
    .dropdown-item:hover {
        background-color: #f8f9fa;
        color: #00b14f;
    }
    .dropdown-item i {
        margin-right: 0.5rem;
        width: 1rem;
        text-align: center;
    }
    .btn-primary {
        background-color: #00b14f;
        border-color: #00b14f;
        padding: 0.5rem 1rem;
        font-weight: 500;
    }
    .btn-primary:hover {
        background-color: #009443;
        border-color: #009443;
    }
    .btn-outline-primary {
        color: #00b14f;
        border-color: #00b14f;
        padding: 0.5rem 1rem;
        font-weight: 500;
    }
    .btn-outline-primary:hover {
        background-color: #00b14f;
        border-color: #00b14f;
    }
    .dropdown-toggle::after {
        margin-left: 0.5rem;
    }
    .navbar-toggler {
        border: none;
        padding: 0.5rem;
    }
    .navbar-toggler:focus {
        box-shadow: none;
    }
    @media (max-width: 991.98px) {
        .navbar-collapse {
            padding: 1rem 0;
        }
        .navbar-nav {
            margin-bottom: 1rem !important;
        }
        .d-flex {
            display: block !important;
            width: 100%;
        }
        .btn {
            display: block;
            width: 100%;
            margin: 0.5rem 0;
        }
    }
</style>

<!-- Bootstrap and Font Awesome -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>