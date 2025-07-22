<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog - JobFinder</title>
    
    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/slicknav.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        /* Sidebar với nền trắng và chữ đen */
        .sidebar {
            width: 250px;
            background-color: whitesmoke;
            color: black;
            padding: 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 2px 0 8px rgba(0,0,0,0.1);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            background-color: #ffffff;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .sidebar-header h2 {
            font-size: 22px;
            margin-bottom: 5px;
            color: #222;
        }

        .sidebar-header p {
            font-size: 13px;
            color: #777;
        }

        .sidebar-menu {
            padding: 15px 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 14px 24px;
            color: #333;
            text-decoration: none;
            font-size: 15px;
            transition: background 0.3s, padding-left 0.3s;
            border-left: 3px solid transparent;
        }

        .menu-item:hover {
            background-color: #e0e0e0;
            padding-left: 28px;
            color: #000;
        }

        .menu-item.active {
            background-color: #c8e6c9;
            color: #1b5e20;
            font-weight: bold;
            border-left: 3px solid #2e7d32;
        }

        .menu-item i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
            color: inherit;
        }

        /* Responsive Sidebar */
        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-header h2,
            .sidebar-header p,
            .menu-item span {
                display: none;
            }

            .menu-item {
                justify-content: center;
                padding: 14px;
            }

            .menu-item i {
                margin: 0;
                font-size: 20px;
            }
        }

        .anh{
            border-radius: 20px;
        }
        :root {
            --primary-color: #2e7d32;
            --secondary-color: #252b60;
            --dark-color: #1b5e20;
            --light-bg: #f8f9fa;
            --text-color: #777777;
        }
        
        body {
            background-color: var(--light-bg);
            font-family: "Barlow", sans-serif;
            color: var(--text-color);
        }
        
        /* Page Hero Section */
        .hero-area {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 100px 0 50px;
            color: white;
        }
        
        .hero-caption h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #fff;
        }
        
        .hero-caption p {
            font-size: 18px;
            margin-bottom: 0;
            opacity: 0.9;
        }
        
        /* Blog Section */
        .blog-area {
            padding: 80px 0;
        }
        
        .section-tittle {
            margin-bottom: 50px;
        }
        
        .section-tittle h2 {
            color: var(--secondary-color);
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .search-box {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 50px;
        }
        
        .search-btn {
            background: var(--primary-color);
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .search-btn:hover {
            background: #e91e63;
            transform: translateY(-2px);
        }
        
        /* Blog Cards */
        .home-blog-single {
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.4s ease;
            margin-bottom: 30px;
        }
        
        .home-blog-single:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(251, 36, 106, 0.15);
        }
        
        .blog-img {
            height: 220px;
            overflow: hidden;
            position: relative;
        }
        
        .blog-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .home-blog-single:hover .blog-img img {
            transform: scale(1.1);
        }
        
        .blog-cap {
            padding: 30px 25px;
        }
        
        .blog-cap h3 {
            color: var(--secondary-color);
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        
        .blog-cap h3 a {
            color: inherit;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .blog-cap h3 a:hover {
            color: var(--primary-color);
        }
        
        .blog-cap p {
            color: var(--text-color);
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .blog-meta {
            color: #999;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .blog-meta i {
            color: var(--primary-color);
            margin-right: 5px;
        }
        
        .read-more {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .read-more:hover {
            color: #e91e63;
            text-decoration: none;
        }
        
        /* Pagination */
        .pagination-area {
            padding: 50px 0 0;
        }
        
        .pagination .page-link {
            border: 0;
            background: none;
            color: var(--text-color);
            padding: 11px 15px;
            margin: 0 3px;
            border-radius: 5px;
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
        }
        
        .pagination .page-link:hover {
            color: var(--primary-color);
            background: #fff;
            border-color: var(--primary-color);
        }
        
        .pagination .page-item.active .page-link {
            background: var(--secondary-color);
            border-color: var(--secondary-color);
            color: #fff;
        }
        
        /* Search Results Info */
        .results-info {
            margin-bottom: 30px;
            color: var(--text-color);
        }
        
        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-color);
        }
        
        .no-results i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        /* Form Styling */
        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(251, 36, 106, 0.25);
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <%@ include file="header.jsp" %>

    <!-- Hero Area Start -->
<!--    <div class="hero-area">
        <div class="container">
            <div class="hero-caption text-center">
                <h1><i class="fas fa-blog me-3"></i>Blog Tuyển Dụng</h1>
                <p>Khám phá những bài viết hữu ích về nghề nghiệp và cơ hội việc làm</p>
            </div>
        </div>
    </div>-->
    <!-- Hero Area End -->

    <!-- Blog Area Start -->
    <div class="blog-area">
        <div class="container">
            <!-- Search Section -->
            <div class="search-box">
                <form method="GET" action="BlogController">
                    <input type="hidden" name="service" value="list">
                    <div class="row align-items-end">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                <i class="fas fa-search me-2"></i>Tìm kiếm bài viết
                            </label>
                            <input type="text" class="form-control" name="title" 
                                   value="${searchTitle}" placeholder="Nhập tiêu đề bài viết...">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">Hiển thị</label>
                            <select class="form-select" name="recordsPerPage">
                                <option value="6" ${recordsPerPage == 6 ? 'selected' : ''}>6 bài viết</option>
                                <option value="12" ${recordsPerPage == 12 ? 'selected' : ''}>12 bài viết</option>
                                <option value="18" ${recordsPerPage == 18 ? 'selected' : ''}>18 bài viết</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <button type="submit" name="submit" value="Search" class="btn search-btn w-100">
                                <i class="fas fa-search me-2"></i>Tìm kiếm
                            </button>
                        </div>
                    </div>
                    <input type="hidden" name="sortField" value="${sortField}">
                    <input type="hidden" name="sortOrder" value="${sortOrder}">
                </form>
            </div>

            <!-- Results Info -->
            <div class="d-flex justify-content-between align-items-center results-info">
                <div>
                    <c:if test="${not empty searchTitle}">
                        <i class="fas fa-search me-2"></i>
                        Kết quả tìm kiếm cho: <strong>"${searchTitle}"</strong> - 
                    </c:if>
                    Hiển thị ${(currentPage-1)*recordsPerPage + 1} - 
                    ${currentPage*recordsPerPage > totalRecords ? totalRecords : currentPage*recordsPerPage} 
                    trong tổng số ${totalRecords} bài viết
                </div>
                <c:if test="${not empty searchTitle}">
                    <a href="BlogController" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-times me-2"></i>Xóa bộ lọc
                    </a>
                </c:if>
            </div>

            <!-- Blog Posts -->
            <c:choose>
                <c:when test="${not empty blogs}">
                    <div class="row">
                        <c:forEach var="blog" items="${blogs}">
                            <div class="col-xl-4 col-lg-4 col-md-6">
                                <div class="home-blog-single">
                                    <div class="blog-img-cap">
                                        <div class="blog-img">
                                            <c:choose>
                                                <c:when test="${not empty blog.thumbnail}">
                                                    <img src="/JobFinding/${blog.thumbnail}" alt="${blog.title}" 
                                                         >
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/400x220/fb246a/ffffff?text=Blog+Image" 
                                                         alt="Default Blog Image">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="blog-cap">
                                            <div class="blog-meta">
                                                <i class="fas fa-calendar-alt"></i>
                                                <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy" />
                                            </div>
                                            <h3>
                                                <a href="BlogController?service=detail&id=${blog.id}">
                                                    ${blog.title}
                                                </a>
                                            </h3>
                                            <!--<p>{blog.description}</p>-->
                                            <a href="BlogController?service=detail&id=${blog.id}" class="read-more">
                                                Đọc thêm <i class="fas fa-arrow-right ms-1"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <i class="fas fa-search"></i>
                        <h4>Không tìm thấy bài viết nào</h4>
                        <p>
                            <c:choose>
                                <c:when test="${not empty searchTitle}">
                                    Thử tìm kiếm với từ khóa khác hoặc <a href="BlogController">xem tất cả bài viết</a>
                                </c:when>
                                <c:otherwise>
                                    Hiện tại chưa có bài viết nào được đăng tải.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination-area">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <!-- Previous -->
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="BlogController?service=list&page=${currentPage-1}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}<c:if test='${not empty searchTitle}'>&title=${searchTitle}&submit=Search</c:if>">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>

                            <!-- Page numbers -->
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <li class="page-item active">
                                            <span class="page-link">${i}</span>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="BlogController?service=list&page=${i}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}<c:if test='${not empty searchTitle}'>&title=${searchTitle}&submit=Search</c:if>">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- Next -->
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="BlogController?service=list&page=${currentPage+1}&recordsPerPage=${recordsPerPage}&sortField=${sortField}&sortOrder=${sortOrder}<c:if test='${not empty searchTitle}'>&title=${searchTitle}&submit=Search</c:if>">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
    <!-- Blog Area End -->

    <!-- JS Files -->
    <script src="assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.slicknav.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>