<%@ page contentType="text/html; charset=UTF-8" errorPage="error.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ page import="models.Post" %>
                    <%@ page import="daos.PostDAO" %>
                        <%@ page import="java.util.*" %>

                            <% // Get current user info from session Integer currentUserId=(Integer)
                                session.getAttribute("userId"); String currentUserType=(String)
                                session.getAttribute("userType"); // Initialize PostDAO PostDAO postDAO=new PostDAO();
                                // Get page parameters int currentPage=request.getParameter("page") !=null ?
                                Integer.parseInt(request.getParameter("page")) : 1; String
                                search=request.getParameter("search"); int pageSize=10; // Get posts and total count
                                List<Post> posts = postDAO.getAllPosts(currentPage, pageSize, search, currentUserId);
                                int totalPosts = postDAO.getTotalPosts(search);
                                int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

                                // Set attributes for JSTL
                                request.setAttribute("posts", posts);
                                request.setAttribute("currentPage", currentPage);
                                request.setAttribute("totalPages", totalPages);
                                request.setAttribute("currentUserId", currentUserId);
                                request.setAttribute("currentUserType", currentUserType);
                                %>

                                <!DOCTYPE html>
                                <html>

                                <head>
                                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>Diễn đàn | JobFinding</title>
                                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                                        rel="stylesheet">
                                    <link
                                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
                                        rel="stylesheet">
                                    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
                                    <link href="assets/css/style.css" rel="stylesheet">
                                    <style>
                                        .post-card {
                                            border-radius: 1rem;
                                            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
                                            margin-bottom: 1.5rem;
                                            border: none;
                                            transition: transform 0.2s;
                                        }

                                        .post-card:hover {
                                            transform: translateY(-2px);
                                        }

                                        .comment-section {
                                            background-color: #f8f9fa;
                                            border-radius: 0 0 1rem 1rem;
                                            padding: 1.5rem;
                                        }

                                        .comment {
                                            border-left: 3px solid #dee2e6;
                                            padding: 1rem;
                                            margin-bottom: 1rem;
                                            background-color: white;
                                            border-radius: 0.5rem;
                                        }

                                        .interaction-btn {
                                            color: #6c757d;
                                            text-decoration: none;
                                            margin-right: 1rem;
                                            cursor: pointer;
                                            transition: all 0.2s;
                                            display: inline-flex;
                                            align-items: center;
                                        }

                                        .interaction-btn:hover {
                                            color: #0d6efd;
                                        }

                                        .interaction-btn.liked {
                                            color: #dc3545;
                                        }

                                        .interaction-btn i {
                                            margin-right: 0.5rem;
                                        }

                                        .post-content {
                                            white-space: pre-line;
                                            font-size: 1rem;
                                            line-height: 1.6;
                                        }

                                        .post-meta {
                                            font-size: 0.875rem;
                                            color: #6c757d;
                                        }

                                        .comment-form {
                                            margin-bottom: 1.5rem;
                                        }

                                        .comment-input {
                                            border-radius: 1.5rem;
                                            padding: 0.75rem 1.25rem;
                                            resize: none;
                                        }

                                        .comment-submit {
                                            border-radius: 1.5rem;
                                            padding: 0.5rem 1.5rem;
                                        }

                                        .search-form {
                                            position: relative;
                                            margin-bottom: 2rem;
                                        }

                                        .search-form .form-control {
                                            border-radius: 1.5rem;
                                            padding-left: 3rem;
                                            padding-right: 1.5rem;
                                            height: 3rem;
                                        }

                                        .search-form .search-icon {
                                            position: absolute;
                                            left: 1rem;
                                            top: 50%;
                                            transform: translateY(-50%);
                                            color: #6c757d;
                                        }

                                        .create-post-btn {
                                            border-radius: 1.5rem;
                                            padding: 0.75rem 2rem;
                                            font-weight: 500;
                                        }

                                        .loading {
                                            opacity: 0.7;
                                            pointer-events: none;
                                        }

                                        .loading::after {
                                            content: "";
                                            display: inline-block;
                                            width: 1rem;
                                            height: 1rem;
                                            border: 2px solid currentColor;
                                            border-right-color: transparent;
                                            border-radius: 50%;
                                            margin-left: 0.5rem;
                                            animation: spin 0.75s linear infinite;
                                        }

                                        @keyframes spin {
                                            to {
                                                transform: rotate(360deg);
                                            }
                                        }

                                        .ql-editor {
                                            min-height: 150px;
                                        }

                                        .pagination {
                                            margin-top: 2rem;
                                        }

                                        .pagination .page-link {
                                            border-radius: 0.5rem;
                                            margin: 0 0.25rem;
                                            border: none;
                                            color: #6c757d;
                                        }

                                        .pagination .page-item.active .page-link {
                                            background-color: #0d6efd;
                                            color: white;
                                        }

                                        .toast {
                                            min-width: 200px;
                                            max-width: 400px;
                                        }

                                        .toast-body {
                                            font-size: 0.9rem;
                                            padding: 0.75rem 1rem;
                                        }

                                        .toast.bg-success {
                                            background-color: #28a745 !important;
                                        }

                                        .toast.bg-danger {
                                            background-color: #dc3545 !important;
                                        }

                                        .toast.bg-info {
                                            background-color: #17a2b8 !important;
                                        }

                                        @media (max-width: 768px) {
                                            .post-card {
                                                margin-bottom: 1rem;
                                            }

                                            .comment-section {
                                                padding: 1rem;
                                            }
                                        }
                                    </style>
                                </head>

                                <body class="bg-light">
                                    <jsp:include page="header.jsp" />

                                    <div class="container py-5">
                                        <div class="row justify-content-center">
                                            <div class="col-lg-8">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h2 class="h3 mb-0">Diễn đàn cộng đồng</h2>
                                                    <c:if test="${not empty currentUserId}">
                                                        <button type="button" class="btn btn-primary create-post-btn"
                                                            data-bs-toggle="modal" data-bs-target="#createPostModal">
                                                            <i class="fas fa-plus me-2"></i>Tạo bài viết mới
                                                        </button>
                                                    </c:if>
                                                </div>

                                                <!-- Search Form -->
                                                <form action="posts.jsp" method="GET" class="search-form">
                                                    <i class="fas fa-search search-icon"></i>
                                                    <input type="text" class="form-control" name="search"
                                                        placeholder="Tìm kiếm bài viết..."
                                                        value="${fn:escapeXml(param.search)}">
                                                </form>

                                                <!-- Posts List -->
                                                <div id="posts-container">
                                                    <c:forEach items="${posts}" var="post">
                                                        <div class="card post-card" id="post-${post.id}">
                                                            <div class="card-body">
                                                                <div
                                                                    class="d-flex justify-content-between align-items-start">
                                                                    <div class="d-flex align-items-center mb-3">
                                                                        <img src="${fn:escapeXml(post.userAvatar)}"
                                                                            alt="${fn:escapeXml(post.userFullName)}"
                                                                            class="rounded-circle me-2" width="40"
                                                                            height="40">
                                                                        <div>
                                                                            <h5 class="card-title mb-0">
                                                                                ${fn:escapeXml(post.title)}</h5>
                                                                            <p class="post-meta mb-0">
                                                                                ${fn:escapeXml(post.userFullName)} ·
                                                                                <span title="<fmt:formatDate value="
                                                                                    ${post.createdAt}"
                                                                                    pattern="MMM d, yyyy 'at' h:mm a" />">
                                                                                <fmt:formatDate
                                                                                    value="${post.createdAt}"
                                                                                    pattern="MMM d, yyyy" />
                                                                                </span>
                                                                                <c:if
                                                                                    test="${post.updatedAt != post.createdAt}">
                                                                                    · Đã chỉnh sửa
                                                                                </c:if>
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <c:if test="${post.isOwner}">
                                                                        <div class="dropdown">
                                                                            <button class="btn btn-link text-muted"
                                                                                type="button" data-bs-toggle="dropdown">
                                                                                <i class="fas fa-ellipsis-v"></i>
                                                                            </button>
                                                                            <ul class="dropdown-menu dropdown-menu-end">
                                                                                <li>
                                                                                    <a class="dropdown-item"
                                                                                        href="edit-post.jsp?id=${post.id}">
                                                                                        <i
                                                                                            class="fas fa-edit me-2"></i>Chỉnh
                                                                                        sửa
                                                                                    </a>
                                                                                </li>
                                                                                <li>
                                                                                    <button
                                                                                        class="dropdown-item text-danger"
                                                                                        onclick="deletePost(${post.id})">
                                                                                        <i
                                                                                            class="fas fa-trash me-2"></i>Xóa
                                                                                    </button>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </c:if>
                                                                </div>

                                                                <div class="post-content mb-3">${post.content}</div>

                                                                <div class="d-flex align-items-center">
                                                                    <c:if test="${not empty currentUserId}">
                                                                        <button onclick="toggleLike(${post.id})"
                                                                            class="interaction-btn ${post.hasUserLiked ? 'liked' : ''}"
                                                                            id="like-btn-${post.id}">
                                                                            <i class="fas fa-heart"></i>
                                                                            <span
                                                                                id="like-count-${post.id}">${post.likeCount}</span>
                                                                        </button>
                                                                    </c:if>
                                                                    <c:if test="${empty currentUserId}">
                                                                        <span class="interaction-btn">
                                                                            <i
                                                                                class="fas fa-heart"></i>${post.likeCount}
                                                                        </span>
                                                                    </c:if>
                                                                    <button class="interaction-btn"
                                                                        onclick="toggleComments(${post.id})">
                                                                        <i
                                                                            class="fas fa-comment"></i>${post.commentCount}
                                                                    </button>
                                                                    <button class="interaction-btn"
                                                                        onclick="sharePost(${post.id})">
                                                                        <i class="fas fa-share"></i>Chia sẻ
                                                                    </button>
                                                                </div>
                                                            </div>

                                                            <!-- Comments Section -->
                                                            <div class="comment-section"
                                                                id="comments-section-${post.id}" style="display: none;">
                                                                <c:if test="${not empty currentUserId}">
                                                                    <form onsubmit="return addComment(${post.id}, this)"
                                                                        class="comment-form">
                                                                        <div class="input-group">
                                                                            <textarea class="form-control comment-input"
                                                                                placeholder="Viết bình luận..."
                                                                                name="content" required></textarea>
                                                                            <button type="submit"
                                                                                class="btn btn-primary comment-submit">
                                                                                <i class="fas fa-paper-plane"></i>
                                                                            </button>
                                                                        </div>
                                                                    </form>
                                                                </c:if>

                                                                <div id="comments-${post.id}"
                                                                    class="comments-container">
                                                                    <% Post post=(Post)pageContext.getAttribute("post");
                                                                        List<Post> comments =
                                                                        postDAO.getComments(post.getId());
                                                                        pageContext.setAttribute("comments", comments);
                                                                        %>
                                                                        <c:forEach items="${comments}" var="comment">
                                                                            <div class="comment"
                                                                                id="comment-${comment.id}">
                                                                                <div
                                                                                    class="d-flex justify-content-between align-items-start">
                                                                                    <div
                                                                                        class="d-flex align-items-center mb-2">
                                                                                        <img src="${fn:escapeXml(comment.userAvatar)}"
                                                                                            alt="${fn:escapeXml(comment.userFullName)}"
                                                                                            class="rounded-circle me-2"
                                                                                            width="32" height="32">
                                                                                        <div>
                                                                                            <h6 class="mb-0">
                                                                                                ${fn:escapeXml(comment.userFullName)}
                                                                                            </h6>
                                                                                            <small class="text-muted">
                                                                                                <fmt:formatDate
                                                                                                    value="${comment.createdAt}"
                                                                                                    pattern="MMM d, yyyy" />
                                                                                            </small>
                                                                                        </div>
                                                                                    </div>
                                                                                    <c:if test="${comment.isOwner}">
                                                                                        <button type="button"
                                                                                            class="btn btn-link text-danger p-0"
                                                                                            onclick="deleteComment(${comment.id}, ${post.id})">
                                                                                            <i class="fas fa-times"></i>
                                                                                        </button>
                                                                                    </c:if>
                                                                                </div>
                                                                                <p class="mb-0">${comment.content}</p>
                                                                            </div>
                                                                        </c:forEach>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>

                                                <!-- Pagination -->
                                                <c:if test="${totalPages > 1}">
                                                    <nav aria-label="Page navigation" class="mt-4">
                                                        <ul class="pagination justify-content-center">
                                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                <a class="page-link"
                                                                    href="?page=${currentPage - 1}&search=${fn:escapeXml(param.search)}">
                                                                    <i class="fas fa-chevron-left"></i>
                                                                </a>
                                                            </li>

                                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                                <li
                                                                    class="page-item ${currentPage == i ? 'active' : ''}">
                                                                    <a class="page-link"
                                                                        href="?page=${i}&search=${fn:escapeXml(param.search)}">
                                                                        ${i}
                                                                    </a>
                                                                </li>
                                                            </c:forEach>

                                                            <li
                                                                class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                <a class="page-link"
                                                                    href="?page=${currentPage + 1}&search=${fn:escapeXml(param.search)}">
                                                                    <i class="fas fa-chevron-right"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </nav>
                                                </c:if>

                                                <!-- No Posts Message -->
                                                <c:if test="${empty posts}">
                                                    <div class="text-center py-5">
                                                        <img src="assets/images/empty-posts.svg" alt="No posts"
                                                            class="mb-4" style="width: 200px;">
                                                        <h4 class="text-muted">Chưa có bài viết nào</h4>
                                                        <p class="text-muted">
                                                            ${not empty param.search ? 'Thử tìm kiếm với từ khóa khác' :
                                                            'Hãy là người đầu tiên chia sẻ!'}
                                                        </p>
                                                        <c:if test="${not empty currentUserId}">
                                                            <button type="button"
                                                                class="btn btn-primary create-post-btn mt-3"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#createPostModal">
                                                                <i class="fas fa-plus me-2"></i>Tạo bài viết mới
                                                            </button>
                                                        </c:if>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Create Post Modal -->
                                    <div class="modal fade" id="createPostModal" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Tạo bài viết mới</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form id="createPostForm" onsubmit="return createPost(this)">
                                                        <div class="mb-3">
                                                            <label for="postTitle" class="form-label">Tiêu đề</label>
                                                            <input type="text" class="form-control" id="postTitle"
                                                                name="title" required>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="postContent" class="form-label">Nội dung</label>
                                                            <div id="editor"></div>
                                                            <input type="hidden" name="content" id="postContent">
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                        data-bs-dismiss="modal">Hủy</button>
                                                    <button type="submit" form="createPostForm" class="btn btn-primary">
                                                        <i class="fas fa-paper-plane me-2"></i>Đăng bài
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Delete Confirmation Modal -->
                                    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Xác nhận xóa</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Bạn có chắc chắn muốn xóa bài viết này?</p>
                                                    <p class="text-danger mb-0"><small>Hành động này không thể hoàn
                                                            tác.</small></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                        data-bs-dismiss="modal">Hủy</button>
                                                    <button type="button" class="btn btn-danger"
                                                        id="confirmDelete">Xóa</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Toast Notifications -->
                                    <div class="toast-container position-fixed bottom-0 end-0 p-3"
                                        style="z-index: 1050;">
                                        <div id="toast" class="toast align-items-center border-0" role="alert"
                                            aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                                            <div class="d-flex">
                                                <div class="toast-body"></div>
                                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                                    data-bs-dismiss="toast" aria-label="Close"></button>
                                            </div>
                                        </div>
                                    </div>

                                    <script
                                        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                                    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
                                    <script>
                                        // Initialize Quill editor
                                        const quill = new Quill('#editor', {
                                            theme: 'snow',
                                            placeholder: 'Viết nội dung bài viết...',
                                            modules: {
                                                toolbar: [
                                                    ['bold', 'italic', 'underline', 'strike'],
                                                    ['blockquote', 'code-block'],
                                                    [{ list: 'ordered' }, { list: 'bullet' }],
                                                    [{ header: [1, 2, 3, 4, 5, 6, false] }],
                                                    [{ color: [] }, { background: [] }],
                                                    ['clean']
                                                ]
                                            }
                                        });

                                        // Toast notification
                                        const toastEl = document.getElementById('toast');
                                        const toast = new bootstrap.Toast(toastEl, {
                                            animation: true,
                                            autohide: true,
                                            delay: 3000
                                        });

                                        function showToast(message, type = 'success') {
                                            if (!toastEl) {
                                                console.error('Toast element not found');
                                                return;
                                            }

                                            // Set message and styling
                                            toastEl.querySelector('.toast-body').textContent = message;
                                            let bgClass = 'bg-info';
                                            if (type === 'success') {
                                                bgClass = 'bg-success';
                                            } else if (type === 'error') {
                                                bgClass = 'bg-danger';
                                            }
                                            toastEl.className = 'toast align-items-center border-0 text-white ' + bgClass;

                                            // Add fade-in animation
                                            toastEl.style.opacity = '0';
                                            toastEl.style.transition = 'opacity 0.3s ease-in-out';

                                            // Show toast
                                            toast.show();

                                            // Force reflow for animation
                                            toastEl.offsetHeight;
                                            toastEl.style.opacity = '1';

                                            // Reset classes when toast hides
                                            toastEl.addEventListener('hidden.bs.toast', () => {
                                                toastEl.className = 'toast align-items-center border-0';
                                                toastEl.style.opacity = '0';
                                            }, { once: true });
                                        }

                                        // Toggle comments section
                                        function toggleComments(postId) {
                                            const commentsSection = document.getElementById(`comments-section-${postId}`);
                                            commentsSection.style.display = commentsSection.style.display === 'none' ? 'block' : 'none';
                                        }

                                        // Like functionality
                                        function toggleLike(postId) {
                                            const isLoggedIn = ${ not empty currentUserId };
                                            if (!isLoggedIn) {
                                                window.location.href = 'login.jsp';
                                                return;
                                            }

                                            const likeBtn = document.getElementById(`like-btn-${postId}`);
                                            likeBtn.classList.add('loading');

                                            fetch('api/posts/toggle-like', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                },
                                                body: `postId=${postId}`
                                            })
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.success) {
                                                        const likeCount = document.getElementById(`like-count-${postId}`);
                                                        likeBtn.classList.toggle('liked');
                                                        likeCount.textContent = data.likeCount;
                                                    } else {
                                                        showToast(data.message || 'Có lỗi xảy ra', 'error');
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    showToast('Có lỗi xảy ra', 'error');
                                                })
                                                .finally(() => {
                                                    likeBtn.classList.remove('loading');
                                                });
                                        }

                                        // Add comment
                                        function addComment(postId, form) {
                                            const isLoggedIn = ${ not empty currentUserId };
                                            if (!isLoggedIn) {
                                                window.location.href = 'login.jsp';
                                                return false;
                                            }

                                            const content = form.content.value.trim();
                                            if (!content) return false;

                                            const submitBtn = form.querySelector('button[type="submit"]');
                                            submitBtn.classList.add('loading');

                                            fetch('api/posts/add-comment', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                },
                                                body: `postId=${postId}&content=${encodeURIComponent(content)}`
                                            })
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.success) {
                                                        const commentsDiv = document.getElementById(`comments-${postId}`);
                                                        const newComment = `
                                                        <div class="comment" id="comment-${data.comment.id}">
                                                            <div class="d-flex justify-content-between align-items-start">
                                                                <div class="d-flex align-items-center mb-2">
                                                                    <img src="${data.comment.userAvatar}" alt="${data.comment.userFullName}" 
                                                                         class="rounded-circle me-2" width="32" height="32">
                                                                    <div>
                                                                        <h6 class="mb-0">${data.comment.userFullName}</h6>
                                                                        <small class="text-muted">${data.comment.createdAt}</small>
                                                                    </div>
                                                                </div>
                                                                <button type="button" class="btn btn-link text-danger p-0"
                                                                        onclick="deleteComment(${data.comment.id}, ${postId})">
                                                                    <i class="fas fa-times"></i>
                                                                </button>
                                                            </div>
                                                            <p class="mb-0">${data.comment.content}</p>
                                                        </div>
                                                    `;
                                                        commentsDiv.insertAdjacentHTML('afterbegin', newComment);
                                                        form.reset();
                                                        showToast('Đã thêm bình luận');
                                                    } else {
                                                        showToast(data.message || 'Có lỗi xảy ra', 'error');
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    showToast('Có lỗi xảy ra', 'error');
                                                })
                                                .finally(() => {
                                                    submitBtn.classList.remove('loading');
                                                });
                                            return false;
                                        }

                                        // Create post
                                        function createPost(form) {
                                            const content = quill.root.innerHTML;
                                            document.getElementById('postContent').value = content;

                                            const submitBtn = form.querySelector('button[type="submit"]');
                                            submitBtn.classList.add('loading');

                                            const formData = new FormData(form);
                                            fetch('api/posts/create', {
                                                method: 'POST',
                                                body: formData
                                            })
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.success) {
                                                        location.reload();
                                                    } else {
                                                        showToast(data.message || 'Có lỗi xảy ra', 'error');
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    showToast('Có lỗi xảy ra', 'error');
                                                })
                                                .finally(() => {
                                                    submitBtn.classList.remove('loading');
                                                });
                                            return false;
                                        }

                                        // Delete post
                                        let postToDelete = null;
                                        const deleteConfirmModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));

                                        function deletePost(postId) {
                                            postToDelete = postId;
                                            deleteConfirmModal.show();
                                        }

                                        document.getElementById('confirmDelete').addEventListener('click', function () {
                                            if (!postToDelete) return;

                                            this.classList.add('loading');

                                            fetch('api/posts/delete', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                },
                                                body: `postId=${postToDelete}`
                                            })
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.success) {
                                                        document.getElementById(`post-${postToDelete}`).remove();
                                                        deleteConfirmModal.hide();
                                                        showToast('Đã xóa bài viết');
                                                    } else {
                                                        showToast(data.message || 'Có lỗi xảy ra', 'error');
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    showToast('Có lỗi xảy ra', 'error');
                                                })
                                                .finally(() => {
                                                    this.classList.remove('loading');
                                                    postToDelete = null;
                                                });
                                        });

                                        // Delete comment
                                        function deleteComment(commentId, postId) {
                                            if (!confirm('Bạn có chắc chắn muốn xóa bình luận này?')) {
                                                return;
                                            }

                                            fetch('api/posts/delete-comment', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                },
                                                body: `commentId=${commentId}`
                                            })
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.success) {
                                                        document.getElementById(`comment-${commentId}`).remove();
                                                        showToast('Đã xóa bình luận');
                                                    } else {
                                                        showToast(data.message || 'Có lỗi xảy ra', 'error');
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error:', error);
                                                    showToast('Có lỗi xảy ra', 'error');
                                                });
                                        }

                                        // Share post
                                        function sharePost(postId) {
                                            const url = `${window.location.origin}/posts.jsp?post=${postId}`;
                                            if (navigator.share) {
                                                navigator.share({
                                                    title: 'Chia sẻ bài viết',
                                                    url: url
                                                })
                                                    .catch(error => console.error('Error sharing:', error));
                                            } else {
                                                navigator.clipboard.writeText(url)
                                                    .then(() => showToast('Đã sao chép liên kết'))
                                                    .catch(() => showToast('Không thể sao chép liên kết', 'error'));
                                            }
                                        }
                                    </script>
                                </body>

                                </html>