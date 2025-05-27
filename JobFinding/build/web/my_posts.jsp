<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý bài đăng - JobFinding</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4d96ff;
                --primary-hover: #3a7bd5;
                --secondary-color: #f8f9fa;
                --text-color: #2d3846;
                --light-gray: #e9ecef;
                --border-color: #dce0e3;
                --danger-color: #ff6b6b;
                --warning-color: #ffd166;
            }

            body {
                background-color: #f5f7fa;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                color: #2d3846;
                padding-top: 76px;
            }

            .nav-breadcrumb {
                background-color: #fff;
                padding: 15px 0;
                border-bottom: 1px solid var(--light-gray);
            }

            .breadcrumb-item a {
                color: #6c757d;
                text-decoration: none;
            }

            .breadcrumb-item.active {
                color: var(--primary-color);
            }

            .stats-card {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                text-align: center;
                transition: transform 0.2s;
            }

            .stats-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .stats-number {
                font-size: 2rem;
                font-weight: 600;
                color: var(--primary-color);
                margin-bottom: 0.5rem;
            }

            .stats-label {
                color: #6c757d;
                font-size: 0.875rem;
            }

            .post-card {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                margin-bottom: 1.5rem;
                transition: transform 0.2s;
            }

            .post-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .post-header {
                padding: 1.5rem;
                border-bottom: 1px solid var(--light-gray);
            }

            .post-title {
                color: var(--text-color);
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

            .post-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                margin-bottom: 1rem;
            }

            .post-tag {
                background: #e9f2ff;
                color: var(--primary-color);
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.875rem;
                text-decoration: none;
                transition: all 0.2s;
            }

            .post-tag:hover {
                background: var(--primary-color);
                color: #fff;
            }

            .post-footer {
                padding: 1rem 1.5rem;
                background: var(--secondary-color);
                border-top: 1px solid var(--light-gray);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .post-status {
                font-size: 0.875rem;
            }

            .status-active {
                color: #00b14f;
            }

            .status-draft {
                color: #ffc107;
            }

            .status-hidden {
                color: #6c757d;
            }

            .btn-group .btn {
                padding: 0.375rem 0.75rem;
                font-size: 0.875rem;
            }

            .btn-group .btn i {
                margin-right: 0.25rem;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 1.5rem;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }

            .empty-state i {
                font-size: 4rem;
                color: var(--primary-color);
                margin-bottom: 1.5rem;
            }

            .empty-state h3 {
                color: var(--text-color);
                margin-bottom: 1rem;
            }

            .empty-state p {
                color: #6c757d;
                margin-bottom: 1.5rem;
            }

            .pagination {
                margin-top: 2rem;
                justify-content: center;
            }

            .page-link {
                color: var(--primary-color);
                border-color: var(--border-color);
                padding: 0.5rem 1rem;
            }

            .page-link:hover {
                color: var(--primary-hover);
                background-color: #e9f2ff;
            }

            .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            @media (max-width: 768px) {
                .stats-card {
                    margin-bottom: 1rem;
                }

                .post-meta {
                    flex-wrap: wrap;
                    gap: 0.5rem;
                }

                .post-footer {
                    flex-direction: column;
                    gap: 1rem;
                    text-align: center;
                }

                .btn-group {
                    flex-direction: column;
                    width: 100%;
                }

                .btn-group .btn {
                    margin-bottom: 0.5rem;
                    width: 100%;
                }
            }

            .status-inactive {
                color: #dc3545;
            }

            .status-deleted {
                color: #6c757d;
            }

            .post-type {
                display: inline-block;
                padding: 0.25rem 0.5rem;
                border-radius: 4px;
                font-size: 0.875rem;
                font-weight: 500;
                margin-right: 0.5rem;
            }

            .post-type-post {
                background-color: #e3f2fd;
                color: #1976d2;
            }

            .post-type-comment {
                background-color: #f3e5f5;
                color: #7b1fa2;
            }

            .post-type-like {
                background-color: #fff3e0;
                color: #f57c00;
            }

            .parent-post {
                font-size: 0.875rem;
                color: #6c757d;
                margin-bottom: 0.5rem;
            }

            .parent-post a {
                color: var(--primary-color);
                text-decoration: none;
            }

            .parent-post a:hover {
                text-decoration: underline;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: #fff;
                border-radius: 8px;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s;
            }

            .stat-card:hover {
                transform: translateY(-2px);
            }

            .stat-icon {
                font-size: 2rem;
                color: var(--primary-color);
                margin-bottom: 1rem;
            }

            .stat-value {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 0.5rem;
            }

            .stat-label {
                color: #6c757d;
                font-size: 0.875rem;
            }

            .filters-bar {
                background: #fff;
                padding: 1rem;
                border-radius: 8px;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .sort-select {
                min-width: 200px;
            }

            .post-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .post-card {
                display: flex;
                flex-direction: column;
                height: 100%;
            }

            .post-header {
                flex: 1;
            }

            .post-actions {
                margin-top: auto;
                padding: 1rem;
                border-top: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .status-badge {
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .status-active {
                background-color: #e8f5e9;
                color: #2e7d32;
            }

            .status-inactive {
                background-color: #fff3e0;
                color: #f57c00;
            }

            .status-deleted {
                background-color: #ffebee;
                color: #c62828;
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
                        <li class="breadcrumb-item active" aria-current="page">Quản lý bài đăng</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container">
            <!-- Success Message -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>

            <!-- Error Message -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>

            <div class="row">
                <!-- Stats Cards -->
                <div class="col-12 mb-4">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stats-number">${totalPosts}</div>
                                <div class="stats-label">Tổng bài đăng</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stats-number">${totalViews}</div>
                                <div class="stats-label">Lượt xem</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stats-number">${totalLikes}</div>
                                <div class="stats-label">Lượt thích</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="stats-number">${totalComments}</div>
                                <div class="stats-label">Bình luận</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Filter Controls -->
                <div class="col-12 mb-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex gap-3">
                            <c:if test="${sessionScope.userType != 'job_seeker'}">
                                <a href="${pageContext.request.contextPath}/create_post.jsp"
                                   class="btn btn-primary">
                                    <i class="fas fa-plus-circle me-2"></i>Tạo bài đăng mới
                                </a>
                            </c:if>
                            <select class="form-select" id="statusFilter" style="width: auto;">
                                <option value="">Tất cả trạng thái</option>
                                <option value="active" ${param.status=='active' ? 'selected' : '' }>Đang hiển
                                    thị</option>
                                <option value="inactive" ${param.status=='inactive' ? 'selected' : '' }>Đã ẩn
                                </option>
                                <option value="deleted" ${param.status=='deleted' ? 'selected' : '' }>Đã xóa
                                </option>
                            </select>
                            <select class="form-select" id="typeFilter" style="width: auto;">
                                <option value="">Tất cả loại</option>
                                <option value="post" ${param.type=='post' ? 'selected' : '' }>Bài đăng</option>
                                <option value="comment" ${param.type=='comment' ? 'selected' : '' }>Bình luận
                                </option>
                                <option value="like" ${param.type=='like' ? 'selected' : '' }>Lượt thích
                                </option>
                            </select>
                        </div>
                        <div class="input-group" style="width: 300px;">
                            <input type="text" class="form-control" id="searchInput"
                                   placeholder="Tìm kiếm bài đăng..." value="${param.search}">
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="updateQueryParams()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Posts List -->
                <div class="col-12">
                    <c:choose>
                        <c:when test="${not empty posts}">
                            <c:forEach items="${posts}" var="post">
                                <div class="post-card">
                                    <div class="post-header">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div>
                                                <span class="post-type post-type-${post.postType}">
                                                    <c:choose>
                                                        <c:when test="${post.postType == 'post'}">Bài đăng
                                                        </c:when>
                                                        <c:when test="${post.postType == 'comment'}">Bình luận
                                                        </c:when>
                                                        <c:when test="${post.postType == 'like'}">Lượt thích
                                                        </c:when>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <div class="post-status">
                                                <c:choose>
                                                    <c:when test="${post.status == 'active'}">
                                                        <i class="fas fa-circle status-active"></i> Đang hiển
                                                        thị
                                                    </c:when>
                                                    <c:when test="${post.status == 'inactive'}">
                                                        <i class="fas fa-circle status-inactive"></i> Đã ẩn
                                                    </c:when>
                                                    <c:when test="${post.status == 'deleted'}">
                                                        <i class="fas fa-circle status-deleted"></i> Đã xóa
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/post/${post.id}"
                                           class="post-title">
                                            ${post.title}
                                        </a>

                                        <div class="post-meta">
                                            <span><i class="far fa-calendar"></i> Ngày tạo:
                                                <fmt:formatDate value="${post.createdAt}"
                                                                pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                            <c:if
                                                test="${post.updatedAt != null && post.updatedAt != post.createdAt}">
                                                <span><i class="far fa-edit"></i> Cập nhật:
                                                    <fmt:formatDate value="${post.updatedAt}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                </span>
                                            </c:if>
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
                                    </div>

                                    <div class="post-footer">
                                        <div class="btn-group">
                                            <c:if
                                                test="${post.status != 'deleted' && (sessionScope.userType == 'admin' || post.userId == sessionScope.userId)}">
                                                <a href="${pageContext.request.contextPath}/post/edit/${post.id}"
                                                   class="btn btn-outline-primary">
                                                    <i class="fas fa-edit"></i> Chỉnh sửa
                                                </a>

                                                <c:if test="${post.status == 'inactive'}">
                                                    <button type="button" class="btn btn-success"
                                                            onclick="updatePostStatus('${post.id}', 'active')">
                                                        <i class="fas fa-check"></i> Hiển thị
                                                    </button>
                                                </c:if>

                                                <c:if test="${post.status == 'active'}">
                                                    <button type="button" class="btn btn-warning"
                                                            onclick="updatePostStatus('${post.id}', 'inactive')">
                                                        <i class="fas fa-eye-slash"></i> Ẩn bài
                                                    </button>
                                                </c:if>

                                                <button type="button" class="btn btn-danger"
                                                        onclick="updatePostStatus('${post.id}', 'deleted')">
                                                    <i class="fas fa-trash-alt"></i> Xóa
                                                </button>
                                            </c:if>

                                            <c:if
                                                test="${post.status == 'deleted' && (sessionScope.userType == 'admin' || post.userId == sessionScope.userId)}">
                                                <button type="button" class="btn btn-success"
                                                        onclick="updatePostStatus('${post.id}', 'active')">
                                                    <i class="fas fa-undo"></i> Khôi phục
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
                                                   href="${pageContext.request.contextPath}/post?page=${currentPage - 1}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.type ? '&type='.concat(param.type) : ''}${not empty param.search ? '&search='.concat(param.search) : ''}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="${pageContext.request.contextPath}/post?page=${i}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.type ? '&type='.concat(param.type) : ''}${not empty param.search ? '&search='.concat(param.search) : ''}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="${pageContext.request.contextPath}/post?page=${currentPage + 1}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.type ? '&type='.concat(param.type) : ''}${not empty param.search ? '&search='.concat(param.search) : ''}"
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
                                <h3>Chưa có bài đăng nào</h3>
                                <p>Bạn chưa tạo bài đăng nào. Hãy bắt đầu chia sẻ thông tin!</p>
                                <c:if test="${sessionScope.userType != 'job_seeker'}">
                                    <a href="${pageContext.request.contextPath}/create_post.jsp"
                                       class="btn btn-primary">
                                        <i class="fas fa-plus-circle me-2"></i>Tạo bài đăng đầu tiên
                                    </a>
                                </c:if>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                        function updateQueryParams() {
                                                            const status = $('#statusFilter').val();
                                                            const type = $('#typeFilter').val();
                                                            const search = $('#searchInput').val().trim();
                                                            const page = 1; // Reset to first page when filtering

                                                            let url = '${pageContext.request.contextPath}/post?page=' + page;
                                                            if (status)
                                                                url += '&status=' + status;
                                                            if (type)
                                                                url += '&type=' + type;
                                                            if (search)
                                                                url += '&search=' + encodeURIComponent(search);

                                                            window.location.href = url;
                                                        }

                                                        // Handle filter changes
                                                        $('#statusFilter, #typeFilter').change(function () {
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

                                                        function updatePostStatus(postId, status) {
                                                            const confirmMessages = {
                                                                'active': 'Bạn có chắc chắn muốn hiển thị bài viết này?',
                                                                'inactive': 'Bạn có chắc chắn muốn ẩn bài viết này?',
                                                                'deleted': 'Bạn có chắc chắn muốn xóa bài viết này? Hành động này có thể hoàn tác.'
                                                            };

                                                            if (confirm(confirmMessages[status])) {
                                                                $.ajax({
                                                                    url: '${pageContext.request.contextPath}/post',
                                                                    type: 'POST',
                                                                    data: {
                                                                        action: 'updateStatus',
                                                                        postId: postId,
                                                                        status: status
                                                                    },
                                                                    success: function (response) {
                                                                        if (response.success) {
                                                                            location.reload();
                                                                        } else {
                                                                            alert('Có lỗi xảy ra: ' + response.message);
                                                                        }
                                                                    },
                                                                    error: function (xhr) {
                                                                        alert('Có lỗi xảy ra: ' + (xhr.responseJSON?.message || 'Không thể kết nối đến server'));
                                                                    }
                                                                });
                                                            }
                                                        }
        </script>
    </body>

</html>