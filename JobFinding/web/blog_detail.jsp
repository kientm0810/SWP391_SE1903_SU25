<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${blog.title} - JobFinder</title>
    
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
        
        /* Breadcrumb */
        .breadcrumb-section {
            background: #fff;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
        }
        
        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .breadcrumb-item a:hover {
            color: var(--secondary-color);
        }
        
        /* Blog Detail Area */
        .blog-detail-area {
            padding: 80px 0;
        }
        
        .single-post-area {
            background: #fff;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }
        
        .blog-title {
            color: var(--secondary-color);
            font-size: 36px;
            font-weight: 700;
            line-height: 1.3;
            margin-bottom: 20px;
        }
        
        .blog-meta {
            color: #999;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .blog-meta i {
            color: var(--primary-color);
            margin-right: 8px;
        }
        
        .blog-meta span {
            margin-right: 30px;
        }
        
        .blog-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .blog_details p {
            font-size: 16px;
            line-height: 1.8;
            color: var(--text-color);
            margin-bottom: 20px;
            text-align: justify;
        }
        
        /* Social Share */
        .social-share {
            background: #fbf9ff;
            padding: 25px;
            border-radius: 10px;
            margin: 30px 0;
            text-align: center;
        }
        
        .social-share h6 {
            color: var(--secondary-color);
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .social-share .btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            margin: 0 5px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            border: none;
        }
        
        .social-share .btn-facebook {
            background: #3b5998;
            color: white;
        }
        
        .social-share .btn-twitter {
            background: #1da1f2;
            color: white;
        }
        
        .social-share .btn-linkedin {
            background: #0077b5;
            color: white;
        }
        
        .social-share .btn-copy {
            background: var(--primary-color);
            color: white;
        }
        
        .social-share .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        /* Back Button */
        .back-btn {
            background: var(--primary-color);
            color: white;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-block;
            margin-bottom: 30px;
        }
        
        .back-btn:hover {
            background: #e91e63;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        /* Sidebar */
        .sidebar-widgets {
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }
        
        .widget-title {
            color: var(--secondary-color);
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .widget-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 2px;
        }
        
        /* Related Blogs */
        .related-blog-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        
        .related-blog-item:hover {
            background: #fff;
            box-shadow: 0 3px 10px rgba(251, 36, 106, 0.1);
            transform: translateY(-2px);
        }
        
        .related-blog-item h6 {
            color: var(--secondary-color);
            font-weight: 600;
            margin-bottom: 10px;
            line-height: 1.4;
        }
        
        .related-blog-item h6 a {
            color: inherit;
            text-decoration: none;
        }
        
        .related-blog-item h6 a:hover {
            color: var(--primary-color);
        }
        
        .related-blog-meta {
            color: #999;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .related-blog-description {
            color: var(--text-color);
            font-size: 14px;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .view-all-btn {
            background: var(--primary-color);
            color: white;
            padding: 10px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-block;
            margin-top: 20px;
        }
        
        .view-all-btn:hover {
            background: #e91e63;
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <%@ include file="header.jsp" %>
    
    <!-- Breadcrumb Section -->
<!--    <div class="breadcrumb-section">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="home"><i class="fas fa-home"></i> Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="BlogController">Blog</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">${blog.title}</li>
                </ol>
            </nav>
        </div>
    </div>-->

    <!-- Blog Detail Area -->
    <div class="blog-detail-area">
        <div class="container">
            <!-- Back Button -->
            <a href="BlogController" class="back-btn">
                <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách blog
            </a>

            <div class="row">
                <!-- Main Content -->
                <div class="col-lg-8">
                    <div class="single-post-area">
                        <h1 class="blog-title">${blog.title}</h1>
                        
                        <div class="blog-meta">
                            <span>
                                <i class="fas fa-calendar-alt"></i>
                                <fmt:formatDate value="${blog.created_at}" pattern="dd/MM/yyyy" />
                            </span>
                            <span>
                                <i class="fas fa-clock"></i>
                                <fmt:formatDate value="${blog.updated_at}" pattern="HH:mm" />
                            </span>
                        </div>

                        <c:if test="${not empty blog.thumbnail}">
                            <img src="${blog.thumbnail}" class="blog-image" alt="${blog.title}" 
                                 onerror="this.src='https://via.placeholder.com/800x400/fb246a/ffffff?text=Blog+Image'">
                        </c:if>
                        
                        <div class="blog_details">
                            <p>${blog.description}</p>
                        </div>

                        <!-- Social Share -->
                        <div class="social-share">
                            <h6><i class="fas fa-share-alt me-2"></i>Chia sẻ bài viết</h6>
                            <button class="btn btn-facebook" onclick="shareOnFacebook()" title="Chia sẻ lên Facebook">
                                <i class="fab fa-facebook-f"></i>
                            </button>
                            <button class="btn btn-twitter" onclick="shareOnTwitter()" title="Chia sẻ lên Twitter">
                                <i class="fab fa-twitter"></i>
                            </button>
                            <button class="btn btn-linkedin" onclick="shareOnLinkedIn()" title="Chia sẻ lên LinkedIn">
                                <i class="fab fa-linkedin-in"></i>
                            </button>
                            <button class="btn btn-copy" onclick="copyToClipboard()" title="Sao chép liên kết">
                                <i class="fas fa-copy"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <c:if test="${not empty relatedBlogs}">
                        <div class="sidebar-widgets">
                            <h3 class="widget-title">Bài viết liên quan</h3>
                            
                            <c:forEach var="relatedBlog" items="${relatedBlogs}">
                                <div class="related-blog-item">
                                    <h6>
                                        <a href="BlogController?service=detail&id=${relatedBlog.id}">
                                            ${relatedBlog.title}
                                        </a>
                                    </h6>
                                    <div class="related-blog-meta">
                                        <i class="fas fa-calendar-alt me-1"></i>
                                        <fmt:formatDate value="${relatedBlog.created_at}" pattern="dd/MM/yyyy" />
                                    </div>
                                    <!--<p class="related-blog-description">{relatedBlog.description}</p>-->
                                </div>
                            </c:forEach>
                            
                            <a href="BlogController" class="view-all-btn">
                                Xem tất cả bài viết <i class="fas fa-arrow-right ms-2"></i>
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- JS Files -->
    <script src="assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.slicknav.min.js"></script>
    <script src="assets/js/main.js"></script>
    
    <script>
        function shareOnFacebook() {
            const url = encodeURIComponent(window.location.href);
            const title = encodeURIComponent('${blog.title}');
            window.open(`https://www.facebook.com/sharer/sharer.php?u=${url}`, '_blank', 'width=600,height=400');
        }

        function shareOnTwitter() {
            const url = encodeURIComponent(window.location.href);
            const title = encodeURIComponent('${blog.title}');
            window.open(`https://twitter.com/intent/tweet?text=${title}&url=${url}`, '_blank', 'width=600,height=400');
        }

        function shareOnLinkedIn() {
            const url = encodeURIComponent(window.location.href);
            window.open(`https://www.linkedin.com/sharing/share-offsite/?url=${url}`, '_blank', 'width=600,height=400');
        }

        function copyToClipboard() {
            navigator.clipboard.writeText(window.location.href).then(function() {
                // Show success message
                const toast = document.createElement('div');
                toast.className = 'alert alert-success position-fixed';
                toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 250px;';
                toast.innerHTML = '<i class="fas fa-check me-2"></i>Đã sao chép liên kết!';
                document.body.appendChild(toast);
                
                setTimeout(() => {
                    toast.remove();
                }, 3000);
            });
        }
    </script>
</body>
</html>