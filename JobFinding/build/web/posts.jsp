<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bài viết - JobFinding</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #00b14f;
                --primary-hover: #009245;
                --secondary-color: #2d3846;
                --border-color: #e9ecef;
                --text-color: #333;
                --light-bg: #f8f9fa;
                --danger-color: #ff4d4f;
                --warning-color: #faad14;
                --white: #fff;
                --gray-light: #f5f5f5;
                --gray-medium: #d9d9d9;
                --box-shadow: 0 2px 4px rgba(0, 0, 0, .1);
            }

            body {
                background-color: var(--light-bg);
                color: var(--text-color);
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                line-height: 1.5;
                padding-top: 76px;
            }

            .post-card {
                background: var(--white);
                border-radius: 12px;
                box-shadow: var(--box-shadow);
                margin-bottom: 1.5rem;
                transition: transform 0.2s;
                border: 1px solid var(--border-color);
            }

            .post-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .post-header {
                padding: 1.5rem;
                border-bottom: 1px solid var(--border-color);
            }

            .post-title {
                color: var(--secondary-color);
                font-size: 1.25rem;
                font-weight: 600;
                margin: 0;
                text-decoration: none;
                display: block;
            }

            .post-title:hover {
                color: var(--primary-color);
            }

            .post-meta {
                margin-top: 0.75rem;
                color: #6c757d;
                font-size: 0.875rem;
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .post-meta i {
                color: var(--primary-color);
                width: 16px;
                text-align: center;
                margin-right: 4px;
            }

            .post-body {
                padding: 1.5rem;
            }

            .post-excerpt {
                color: #495057;
                margin-bottom: 1rem;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .nav-breadcrumb {
                background-color: var(--white);
                padding: 15px 0;
                border-bottom: 1px solid var(--border-color);
                box-shadow: var(--box-shadow);
            }

            .breadcrumb-item a {
                color: #6c757d;
                text-decoration: none;
            }

            .breadcrumb-item.active {
                color: var(--primary-color);
            }

            .empty-state {
                text-align: center;
                padding: 3rem 1.5rem;
                background: var(--white);
                border-radius: 12px;
                box-shadow: var(--box-shadow);
            }

            .empty-state i {
                font-size: 4rem;
                color: var(--primary-color);
                margin-bottom: 1.5rem;
            }

            .empty-state h3 {
                color: var(--secondary-color);
                margin-bottom: 1rem;
            }

            .empty-state p {
                color: #6c757d;
                margin-bottom: 1.5rem;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: var(--white);
                font-weight: 500;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                transition: all 0.2s;
            }

            .btn-primary:hover {
                background-color: var(--primary-hover);
                border-color: var(--primary-hover);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(0, 177, 79, 0.2);
            }

            .btn-outline-primary {
                color: var(--primary-color);
                border-color: var(--primary-color);
                background: transparent;
                font-weight: 500;
            }

            .btn-outline-primary:hover {
                background-color: var(--primary-color);
                color: var(--white);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(0, 177, 79, 0.1);
            }

            .form-select,
            .form-control {
                height: 44px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 14px;
                padding: 0.5rem 1rem;
            }

            .form-select:focus,
            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 177, 79, 0.1);
            }

            .pagination {
                margin-top: 2rem;
            }

            .page-link {
                color: var(--primary-color);
                border-color: var(--border-color);
                padding: 0.5rem 1rem;
            }

            .page-link:hover {
                color: var(--primary-hover);
                background-color: var(--gray-light);
            }

            .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-outline-secondary {
                color: var(--secondary-color);
                border-color: var(--border-color);
            }

            .btn-outline-secondary:hover {
                background-color: var(--gray-light);
                color: var(--secondary-color);
                border-color: var(--border-color);
            }

            .btn-outline-danger {
                color: var(--danger-color);
                border-color: var(--danger-color);
            }

            .btn-outline-danger:hover {
                background-color: var(--danger-color);
                color: var(--white);
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <!-- Breadcrumb -->
        <div class="nav-breadcrumb">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i
                                    class="fas fa-home"></i></a></li>
                        <li class="breadcrumb-item active" aria-current="page">Bài viết</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container mt-4">
            <!-- Filter Controls -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex gap-3">
                            <c:if test="${sessionScope.userType != 'job_seeker'}">
                                <a href="${pageContext.request.contextPath}/create_post.jsp"
                                   class="btn btn-primary">
                                    <i class="fas fa-plus-circle me-2"></i>Tạo bài đăng mới
                                </a>
                            </c:if>
                            <select class="form-select" id="categoryFilter" style="width: auto;">
                                <option value="">Tất cả chuyên mục</option>
                                <option value="job_search">Tìm việc</option>
                                <option value="career_advice">Tư vấn nghề nghiệp</option>
                                <option value="interview_tips">Kinh nghiệm phỏng vấn</option>
                                <option value="resume_cv">CV/Resume</option>
                                <option value="salary_negotiation">Đàm phán lương</option>
                                <option value="workplace">Môi trường làm việc</option>
                                <option value="skill_development">Phát triển kỹ năng</option>
                                <option value="job_market">Thị trường việc làm</option>
                                <option value="other">Chủ đề khác</option>
                            </select>
                        </div>
                        <div class="input-group" style="width: 300px;">
                            <input type="text" class="form-control" id="searchInput"
                                   placeholder="Tìm kiếm bài viết..." value="${param.search}">
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="updateQueryParams()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Posts List -->
            <div class="row">
                <div class="col-12">
                    <c:choose>
                        <c:when test="${not empty posts}">
                            <c:forEach items="${posts}" var="post">
                                <div class="post-card">
                                    <div class="post-header">
                                        <a href="${pageContext.request.contextPath}/post/${post.id}"
                                           class="post-title">
                                            ${post.title}
                                        </a>
                                        <div class="post-meta">
                                            <span>
                                                <i class="far fa-user"></i>
                                                <c:choose>
                                                    <c:when test="${post.userType == 'admin'}">
                                                        Admin
                                                    </c:when>
                                                    <c:when test="${post.userType == 'recruiter'}">
                                                        Nhà tuyển dụng
                                                    </c:when>
                                                    <c:when test="${post.userType == 'job_seeker'}">
                                                        Người tìm việc
                                                    </c:when>
                                                </c:choose>
                                            </span>
                                            <span><i class="far fa-calendar"></i>
                                                <fmt:formatDate value="${post.createdAt}"
                                                                pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                            <span><i class="far fa-eye"></i> ${post.viewCount} lượt xem</span>
                                            <span><i class="far fa-heart"></i> ${post.likeCount} lượt
                                                thích</span>
                                            <span><i class="far fa-comments"></i> ${post.commentCount} bình
                                                luận</span>
                                        </div>
                                    </div>
                                    <div class="post-body">
                                        <div class="post-excerpt">
                                            ${post.content}
                                        </div>
                                        <div class="mt-3">
                                            <a href="${pageContext.request.contextPath}/post/${post.id}"
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-book-reader me-1"></i> Đọc thêm
                                            </a>
                                            <c:if test="${sessionScope.userId != null}">
                                                <button type="button" class="btn btn-outline-danger btn-sm ms-2"
                                                        onclick="toggleLike(${post.id})">
                                                    <i class="far fa-heart me-1"></i> Thích
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="?page=${currentPage - 1}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.search ? '&search='.concat(param.search) : ''}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="?page=${i}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.search ? '&search='.concat(param.search) : ''}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="?page=${currentPage + 1}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.search ? '&search='.concat(param.search) : ''}"
                                                   aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="far fa-file-alt"></i>
                                <h3>Chưa có bài viết nào</h3>
                                <p>Hiện tại chưa có bài viết nào được đăng tải.</p>
                                <c:if test="${sessionScope.userType != 'job_seeker'}">
                                    <a href="${pageContext.request.contextPath}/create_post.jsp"
                                       class="btn btn-primary">
                                        <i class="fas fa-plus-circle me-2"></i>Tạo bài viết đầu tiên
                                    </a>
                                </c:if>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                                        function updateQueryParams() {
                                                            const category = $('#categoryFilter').val();
                                                            const search = $('#searchInput').val().trim();
                                                            const page = 1; // Reset to first page when filtering

                                                            let url = '?page=' + page;
                                                            if (category)
                                                                url += '&category=' + category;
                                                            if (search)
                                                                url += '&search=' + encodeURIComponent(search);

                                                            window.location.href = url;
                                                        }

                                                        // Handle filter changes
                                                        $('#categoryFilter').change(function () {
                                                            updateQueryParams();
                                                        });

                                                        // Handle search input (with debounce)
                                                        let searchTimeout;
                                                        $('#searchInput').on('input', function () {
                                                            clearTimeout(searchTimeout);
                                                            searchTimeout = setTimeout(updateQueryParams, 500);
                                                        });

                                                        // Handle Enter key in search input
                                                        $('#searchInput').on('keypress', function (e) {
                                                            if (e.which === 13) {
                                                                updateQueryParams();
                                                            }
                                                        });

                                                        function toggleLike(postId) {
                                                            $.ajax({
                                                                url: '${pageContext.request.contextPath}/post',
                                                                type: 'POST',
                                                                data: {
                                                                    action: 'like',
                                                                    postId: postId
                                                                },
                                                                success: function (response) {
                                                                    if (response.success) {
                                                                        location.reload();
                                                                    } else {
                                                                        alert('Có lỗi xảy ra: ' + response.message);
                                                                    }
                                                                },
                                                                error: function (xhr) {
                                                                    if (xhr.status === 401) {
                                                                        window.location.href = '${pageContext.request.contextPath}/login';
                                                                    } else {
                                                                        alert('Có lỗi xảy ra: ' + (xhr.responseJSON?.message || 'Không thể kết nối đến server'));
                                                                    }
                                                                }
                                                            });
                                                        }
        </script>
        
      
    </body>

</html>