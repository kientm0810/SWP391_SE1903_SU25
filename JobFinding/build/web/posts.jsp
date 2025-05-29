<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bài viết - JobFinding</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
              rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              rel="stylesheet">
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

            .post-actions {
                display: flex;
                gap: 0.5rem;
            }

            .post-actions .btn {
                transition: all 0.2s;
            }

            .post-actions .btn:hover {
                transform: translateY(-1px);
            }

            .post-actions .edit-post-btn:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .post-actions .delete-post-btn:hover {
                background-color: var(--danger-color);
                color: white;
            }

            .toast {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .toast-header {
                border-bottom: 1px solid var(--border-color);
            }

            .toast-body {
                padding: 1rem;
            }

            .loading {
                position: relative;
                pointer-events: none;
            }

            .loading::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.8);
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .loading::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 24px;
                height: 24px;
                border: 3px solid var(--primary-color);
                border-top-color: transparent;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                z-index: 1;
            }

            @keyframes spin {
                to {
                    transform: translate(-50%, -50%) rotate(360deg);
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

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
                                <option value="" ${empty param.category ? 'selected' : '' }>Tất cả chuyên
                                    mục</option>
                                <option value="job_search" ${param.category=='job_search' ? 'selected' : ''
                                        }>Tìm việc</option>
                                <option value="career_advice" ${param.category=='career_advice' ? 'selected'
                                                                : '' }>Tư vấn nghề nghiệp</option>
                                <option value="interview_tips" ${param.category=='interview_tips'
                                                                 ? 'selected' : '' }>Kinh nghiệm phỏng vấn</option>
                                <option value="resume_cv" ${param.category=='resume_cv' ? 'selected' : '' }>
                                    CV/Resume</option>
                                <option value="salary_negotiation" ${param.category=='salary_negotiation'
                                                                     ? 'selected' : '' }>Đàm phán lương</option>
                                <option value="workplace" ${param.category=='workplace' ? 'selected' : '' }>
                                    Môi trường làm việc</option>
                                <option value="skill_development" ${param.category=='skill_development'
                                                                    ? 'selected' : '' }>Phát triển kỹ năng</option>
                                <option value="job_market" ${param.category=='job_market' ? 'selected' : ''
                                        }>Thị trường việc làm</option>
                                <option value="other" ${param.category=='other' ? 'selected' : '' }>Chủ đề
                                    khác</option>
                            </select>
                        </div>
                        <div class="input-group" style="width: 300px;">
                            <input type="text" class="form-control" id="searchInput"
                                   placeholder="Tìm kiếm bài viết..." value="${fn:escapeXml(param.search)}">
                            <button class="btn btn-outline-secondary" type="button"
                                    onclick="updateQueryParams()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="mt-3" id="bulkDeleteBar" style="display:none;">
                        <button class="btn btn-danger" id="bulkDeleteBtn"><i
                                class="fas fa-trash-alt me-2"></i>Xóa các bài đã chọn (<span
                                id="selectedCount">0</span>)</button>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <c:choose>
                        <c:when test="${not empty posts}">
                            <c:forEach items="${posts}" var="post">
                                <div class="post-card position-relative" id="post-card-${post.id}">
                                    <c:if test="${sessionScope.userId == post.userId}">
                                        <input type="checkbox"
                                               class="form-check-input position-absolute top-0 start-0 m-3 select-post-checkbox"
                                               data-post-id="${post.id}"
                                               style="z-index:2; width:1.2em; height:1.2em;">
                                    </c:if>
                                    <div class="post-header">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/post/${post.id}"
                                                   class="post-title">
                                                    ${fn:escapeXml(post.title)}
                                                </a>
                                                <div class="post-meta">
                                                    <span><i class="far fa-user"></i>
                                                        ${post.userType}</span>
                                                    <span><i class="far fa-calendar"></i>
                                                        <fmt:formatDate value="${post.createdAt}"
                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                    </span>
                                                    <span><i class="far fa-eye"></i> ${post.viewCount} lượt
                                                        xem</span>
                                                    <span><i class="far fa-heart"></i> ${post.likeCount}
                                                        lượt thích</span>
                                                    <span><i class="far fa-comments"></i>
                                                        ${post.commentCount} bình luận</span>
                                                </div>
                                            </div>
                                            <c:if test="${sessionScope.userId == post.userId}">
                                                <div class="post-actions">
                                                    <button type="button"
                                                            class="btn btn-outline-primary btn-sm edit-post-btn"
                                                            data-post-id="${post.id}"
                                                            data-post-title="${fn:escapeXml(post.title)}"
                                                            data-post-content="${fn:escapeXml(post.content)}">
                                                        <i class="far fa-edit"></i> Chỉnh sửa
                                                    </button>
                                                    <button type="button"
                                                            class="btn btn-outline-danger btn-sm delete-post-btn"
                                                            data-post-id="${post.id}"
                                                            data-post-title="${fn:escapeXml(post.title)}">
                                                        <i class="far fa-trash-alt"></i> Xóa
                                                    </button>
                                                </div>
                                            </c:if>
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
                                                <button type="button"
                                                        class="btn btn-outline-danger btn-sm ms-2 like-post-btn"
                                                        data-post-id="${post.id}">
                                                    <i class="far fa-heart me-1"></i> Thích
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="?page=${currentPage - 1}${not empty param.category ? '&category='.concat(fn:escapeXml(param.category)) : ''}${not empty param.search ? '&search='.concat(fn:escapeXml(param.search)) : ''}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="?page=${i}${not empty param.category ? '&category='.concat(fn:escapeXml(param.category)) : ''}${not empty param.search ? '&search='.concat(fn:escapeXml(param.search)) : ''}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="?page=${currentPage + 1}${not empty param.category ? '&category='.concat(fn:escapeXml(param.category)) : ''}${not empty param.search ? '&search='.concat(fn:escapeXml(param.search)) : ''}"
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
    </div>

    <!-- Edit Post Modal -->
    <div class="modal fade" id="editPostModal" tabindex="-1" aria-labelledby="editPostModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editPostModalLabel">Chỉnh sửa bài viết</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <form id="editPostForm">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editTitle" class="form-label">Tiêu đề</label>
                            <input type="text" class="form-control" id="editTitle" name="title"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="editContent" class="form-label">Nội dung</label>
                            <textarea class="form-control" id="editContent" name="content" rows="8"
                                      required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                        <button type="submit" class="btn btn-primary" id="saveEditBtn">
                            <i class="fas fa-save me-2"></i>Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Post Modal -->
    <div class="modal fade" id="deletePostModal" tabindex="-1" aria-labelledby="deletePostModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deletePostModalLabel">Xác nhận xóa bài viết</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong>Lưu ý:</strong> Hành động này không thể hoàn tác.
                    </div>
                    <p>Bạn có chắc chắn muốn xóa bài viết "<span id="deletePostTitle"
                                                                 class="fw-bold"></span>"?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Hủy
                    </button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">
                        <i class="fas fa-trash-alt me-2"></i>Xóa bài viết
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="actionToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-info-circle me-2"></i>
                <strong class="me-auto" id="toastTitle">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"
                        aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage"></div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
                                        // Function to update URL query parameters based on filters and search
                                        function updateQueryParams() {
                                            const category = $('#categoryFilter').val();
                                            const search = $('#searchInput').val().trim();
                                            const page = 1; // Always reset to first page when applying new filters

                                            let url = '${pageContext.request.contextPath}/post?page=' + page;
                                            if (category) {
                                                url += '&category=' + encodeURIComponent(category);
                                            }
                                            if (search) {
                                                url += '&search=' + encodeURIComponent(search);
                                            }

                                            window.location.href = url;
                                        }

                                        // Handle category filter changes
                                        $('#categoryFilter').change(function () {
                                            updateQueryParams();
                                        });

                                        // Handle search input with debounce
                                        let searchTimeout;
                                        $('#searchInput').on('input', function () {
                                            clearTimeout(searchTimeout);
                                            searchTimeout = setTimeout(updateQueryParams, 500);
                                        });

                                        // Delete post(s) with improved error handling
                                        function deletePosts(postIds) {
                                            if (!Array.isArray(postIds)) {
                                                postIds = [postIds];
                                            }

                                            if (postIds.length === 0)
                                                return;

                                            const $btn = $('#confirmDeleteBtn');
                                            const $modal = $('#deletePostModal');
                                            $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Đang xóa...');

                                            // Create FormData to properly send array of IDs
                                            const formData = new FormData();
                                            formData.append('action', 'delete');
                                            postIds.forEach(id => formData.append('postId', id));

                                            $.ajax({
                                                url: '${pageContext.request.contextPath}/post',
                                                type: 'POST',
                                                data: formData,
                                                processData: false,
                                                contentType: false,
                                                success: function (response) {
                                                    if (response.success) {
                                                        // Remove deleted posts with animation
                                                        postIds.forEach(function (id) {
                                                            const $postCard = $(`#post-card-${id}`);
                                                            $postCard.fadeOut(300, function () {
                                                                $(this).remove();
                                                                // Check if there are any posts left
                                                                if ($('.post-card').length === 0) {
                                                                    // Show empty state
                                                                    const emptyState = `
                                        <div class="empty-state">
                                            <i class="far fa-file-alt"></i>
                                            <h3>Chưa có bài viết nào</h3>
                                            <p>Hiện tại chưa có bài viết nào được đăng tải.</p>
        <c:if test="${sessionScope.userType != 'job_seeker'}">
                                                <a href="${pageContext.request.contextPath}/create_post.jsp" class="btn btn-primary">
                                                    <i class="fas fa-plus-circle me-2"></i>Tạo bài viết đầu tiên
                                                </a>
        </c:if>
                                        </div>`;
                                                                    $('.col-12').html(emptyState);
                                                                }
                                                            });
                                                        });

                                                        // Hide bulk delete bar if visible
                                                        $('#bulkDeleteBar').hide();
                                                        $('.select-post-checkbox').prop('checked', false);

                                                        showToast('Thành công', response.message || 'Xóa bài viết thành công', 'success');
                                                        $modal.modal('hide');
                                                    } else {
                                                        showToast('Lỗi', response.message || 'Không thể xóa bài viết', 'error');
                                                    }
                                                },
                                                error: function (xhr) {
                                                    let message = 'Đã xảy ra lỗi khi xóa bài viết';
                                                    if (xhr.responseJSON && xhr.responseJSON.message) {
                                                        message = xhr.responseJSON.message;
                                                    } else if (xhr.status === 401) {
                                                        message = 'Vui lòng đăng nhập để thực hiện thao tác này';
                                                    } else if (xhr.status === 403) {
                                                        message = 'Bạn không có quyền xóa bài viết này';
                                                    }
                                                    showToast('Lỗi', message, 'error');
                                                },
                                                complete: function () {
                                                    $btn.prop('disabled', false)
                                                            .html('<i class="fas fa-trash-alt me-2"></i>Xóa bài viết');
                                                }
                                            });
                                        }

                                        // Single post delete
                                        $(document).on('click', '.delete-post-btn', function (e) {
                                            e.preventDefault();
                                            const postId = $(this).data('post-id');
                                            const postTitle = $(this).data('post-title');

                                            // Update modal content
                                            $('#deletePostTitle').text(postTitle);

                                            // Reset and set up delete handler
                                            $('#confirmDeleteBtn').off('click').on('click', function () {
                                                deletePosts(postId);
                                            });

                                            // Show modal
                                            $('#deletePostModal').modal('show');
                                        });

                                        // Bulk delete
                                        $('#bulkDeleteBtn').click(function () {
                                            const postIds = $('.select-post-checkbox:checked').map(function () {
                                                return $(this).data('post-id');
                                            }).get();

                                            if (postIds.length === 0) {
                                                showToast('Thông báo', 'Vui lòng chọn ít nhất một bài viết để xóa', 'warning');
                                                return;
                                            }

                                            // Update modal content for bulk delete
                                            $('#deletePostTitle').text(`${postIds.length} bài viết đã chọn`);

                                            // Reset and set up delete handler
                                            $('#confirmDeleteBtn').off('click').on('click', function () {
                                                deletePosts(postIds);
                                            });

                                            // Show modal
                                            $('#deletePostModal').modal('show');
                                        });

                                        // Handle checkbox selection for bulk delete
                                        $(document).on('change', '.select-post-checkbox', function () {
                                            const checkedCount = $('.select-post-checkbox:checked').length;
                                            $('#selectedCount').text(checkedCount);
                                            $('#bulkDeleteBar').toggle(checkedCount > 0);
                                        });

                                        // Reset bulk delete bar when modal is hidden
                                        $('#deletePostModal').on('hidden.bs.modal', function () {
                                            const $btn = $('#confirmDeleteBtn');
                                            $btn.prop('disabled', false)
                                                    .html('<i class="fas fa-trash-alt me-2"></i>Xóa bài viết');
                                        });

                                        // Update post with improved error handling
                                        $(document).on('submit', '#editPostForm', function (e) {
                                            e.preventDefault();
                                            const postId = $(this).data('post-id');
                                            const $btn = $('#saveEditBtn');
                                            $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Đang lưu...');

                                            $.ajax({
                                                url: '${pageContext.request.contextPath}/post',
                                                type: 'POST',
                                                data: {
                                                    action: 'update',
                                                    postId: postId,
                                                    title: $('#editTitle').val(),
                                                    content: $('#editContent').val()
                                                },
                                                success: function (response) {
                                                    if (response.success) {
                                                        const $postCard = $(`#post-card-${postId}`);
                                                        $postCard.find('.post-title').text($('#editTitle').val());
                                                        $postCard.find('.post-excerpt').text($('#editContent').val());
                                                        showToast('Thành công', response.message, 'success');
                                                        $('#editPostModal').modal('hide');
                                                    } else {
                                                        showToast('Lỗi', response.message, 'error');
                                                    }
                                                },
                                                error: function (xhr) {
                                                    let message = 'Đã xảy ra lỗi khi cập nhật bài viết.';
                                                    if (xhr.responseJSON && xhr.responseJSON.message) {
                                                        message = xhr.responseJSON.message;
                                                    }
                                                    showToast('Lỗi', message, 'error');
                                                },
                                                complete: function () {
                                                    $btn.prop('disabled', false).html('<i class="fas fa-save me-2"></i>Lưu thay đổi');
                                                }
                                            });
                                        });
    </script>

</body>

</html>