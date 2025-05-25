<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Posts - JobFinding</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #f8f9fa;
                        padding-top: 76px;
                    }

                    .page-breadcrumb {
                        background: #fff;
                        padding: 1rem 0;
                        border-bottom: 1px solid #e9ecef;
                        margin-bottom: 2rem;
                    }

                    .breadcrumb-item a {
                        color: #6c757d;
                        text-decoration: none;
                    }

                    .breadcrumb-item.active {
                        color: #00b14f;
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
                        border-bottom: 1px solid #e9ecef;
                    }

                    .post-title {
                        color: #2d3846;
                        font-size: 1.25rem;
                        font-weight: 600;
                        margin: 0;
                    }

                    .post-title a {
                        color: inherit;
                        text-decoration: none;
                    }

                    .post-title a:hover {
                        color: #00b14f;
                    }

                    .post-meta {
                        margin-top: 0.5rem;
                        color: #6c757d;
                        font-size: 0.875rem;
                    }

                    .post-meta i {
                        margin-right: 0.25rem;
                    }

                    .post-meta span {
                        margin-right: 1rem;
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
                        background: #e9ecef;
                        color: #495057;
                        padding: 0.25rem 0.75rem;
                        border-radius: 20px;
                        font-size: 0.875rem;
                        text-decoration: none;
                    }

                    .post-tag:hover {
                        background: #dee2e6;
                        color: #212529;
                    }

                    .post-footer {
                        padding: 1rem 1.5rem;
                        background: #f8f9fa;
                        border-top: 1px solid #e9ecef;
                        border-radius: 0 0 8px 8px;
                    }

                    .btn-outline-danger {
                        color: #dc3545;
                        border-color: #dc3545;
                    }

                    .btn-outline-danger:hover {
                        background-color: #dc3545;
                        border-color: #dc3545;
                        color: #fff;
                    }

                    .btn-sm {
                        padding: 0.25rem 0.5rem;
                        font-size: 0.875rem;
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
                        color: #adb5bd;
                        margin-bottom: 1.5rem;
                    }

                    .empty-state h3 {
                        color: #2d3846;
                        margin-bottom: 1rem;
                    }

                    .empty-state p {
                        color: #6c757d;
                        margin-bottom: 1.5rem;
                    }

                    .stats-card {
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                        padding: 1.5rem;
                        margin-bottom: 1.5rem;
                        text-align: center;
                    }

                    .stats-number {
                        font-size: 2rem;
                        font-weight: 600;
                        color: #00b14f;
                        margin-bottom: 0.5rem;
                    }

                    .stats-label {
                        color: #6c757d;
                        font-size: 0.875rem;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <!-- Breadcrumb -->
                <div class="page-breadcrumb">
                    <div class="container">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="home"><i class="fas fa-home"></i></a></li>
<!--                                <li class="breadcrumb-item"><a href="posts">Community</a></li>-->
                                <li class="breadcrumb-item active" aria-current="page">My Posts</li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <div class="container">
                    <div class="row">
                        <!-- Stats Cards -->
                        <div class="col-12 mb-4">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="stats-card">
                                        <div class="stats-number">${totalPosts}</div>
                                        <div class="stats-label">Total Posts</div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="stats-card">
                                        <div class="stats-number">${totalViews}</div>
                                        <div class="stats-label">Total Views</div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="stats-card">
                                        <div class="stats-number">${totalLikes}</div>
                                        <div class="stats-label">Total Likes</div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="stats-card">
                                        <div class="stats-number">${totalComments}</div>
                                        <div class="stats-label">Total Comments</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Create Post Button -->
                        <div class="col-12 mb-4">
                            <a href="create_post.jsp" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Create New Post
                            </a>
                        </div>

                        <!-- Posts List -->
                        <div class="col-12">
                            <c:choose>
                                <c:when test="${not empty posts}">
                                    <c:forEach items="${posts}" var="post">
                                        <div class="post-card">
                                            <div class="post-header">
                                                <h2 class="post-title">
                                                    <a href="post/${post.id}">${post.title}</a>
                                                </h2>
                                                <div class="post-meta">
                                                    <span>
                                                        <i class="far fa-calendar"></i>
                                                        <fmt:formatDate value="${post.createdAt}"
                                                            pattern="MMM dd, yyyy" />
                                                    </span>
                                                    <span>
                                                        <i class="far fa-eye"></i>
                                                        ${post.viewCount} views
                                                    </span>
                                                    <span>
                                                        <i class="far fa-heart"></i>
                                                        ${post.likeCount} likes
                                                    </span>
                                                    <span>
                                                        <i class="far fa-comments"></i>
                                                        ${post.commentCount} comments
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="post-body">
                                                <div class="post-excerpt">
                                                    ${post.content}
                                                </div>

                                                <div class="post-tags">
                                                    <c:forEach items="${post.tags}" var="tag">
                                                        <a href="posts?tag=${tag}" class="post-tag">
                                                            <i class="fas fa-tag"></i> ${tag}
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                            </div>

                                            <div class="post-footer">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <span
                                                            class="badge bg-${post.status == 'active' ? 'success' : 'warning'}">
                                                            ${post.status}
                                                        </span>
                                                    </div>
                                                    <div class="btn-group">
                                                        <a href="edit-post?id=${post.id}"
                                                            class="btn btn-outline-primary btn-sm">
                                                            <i class="fas fa-edit"></i> Edit
                                                        </a>
                                                        <button type="button" class="btn btn-outline-danger btn-sm"
                                                            onclick="confirmDelete(${post.id})">
                                                            <i class="fas fa-trash-alt"></i> Delete
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="far fa-file-alt"></i>
                                        <h3>No Posts Yet</h3>
                                        <p>You haven't created any posts yet. Start sharing your thoughts with the
                                            community!</p>
                                        <a href="create-post" class="btn btn-primary">
                                            <i class="fas fa-plus-circle me-2"></i>Create Your First Post
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Confirm Delete</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete this post? This action cannot be undone.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <form id="deleteForm" action="post" method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="postId" id="deletePostId">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function confirmDelete(postId) {
                        document.getElementById('deletePostId').value = postId;
                        new bootstrap.Modal(document.getElementById('deleteModal')).show();
                    }
                </script>
            </body>

            </html>