<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${post.title}</title>
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
                    }

                    body {
                        background-color: var(--light-bg);
                        color: var(--text-color);
                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                        line-height: 1.5;
                        padding-top: 60px;
                    }

                    .post-container {
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                        margin-bottom: 20px;
                        padding: 30px;
                    }

                    .post-header {
                        margin-bottom: 20px;
                    }

                    .post-title {
                        color: var(--secondary-color);
                        font-size: 24px;
                        font-weight: 600;
                        margin-bottom: 15px;
                    }

                    .post-meta {
                        color: #666;
                        font-size: 14px;
                        margin-bottom: 15px;
                    }

                    .post-content {
                        font-size: 16px;
                        line-height: 1.6;
                        margin-bottom: 30px;
                    }

                    .post-stats {
                        display: flex;
                        gap: 20px;
                        color: #666;
                        font-size: 14px;
                        margin-bottom: 20px;
                    }

                    .post-stats i {
                        color: var(--primary-color);
                        margin-right: 5px;
                    }

                    .post-actions {
                        padding-top: 20px;
                        border-top: 1px solid var(--border-color);
                        display: flex;
                        gap: 15px;
                    }

                    .btn-action {
                        background: none;
                        border: 1px solid var(--border-color);
                        border-radius: 4px;
                        color: #666;
                        font-size: 14px;
                        padding: 8px 15px;
                        display: flex;
                        align-items: center;
                        gap: 5px;
                        cursor: pointer;
                        transition: all 0.2s;
                    }

                    .btn-action:hover {
                        border-color: var(--primary-color);
                        color: var(--primary-color);
                    }

                    .btn-action.liked {
                        background: var(--primary-color);
                        border-color: var(--primary-color);
                        color: #fff;
                    }

                    .comments-section {
                        margin-top: 40px;
                    }

                    .comments-header {
                        margin-bottom: 20px;
                    }

                    .comment-form {
                        margin-bottom: 30px;
                    }

                    .comment-card {
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                        margin-bottom: 15px;
                        padding: 20px;
                    }

                    .comment-meta {
                        color: #666;
                        font-size: 13px;
                        margin-bottom: 10px;
                    }

                    .comment-content {
                        font-size: 14px;
                        line-height: 1.5;
                        margin-bottom: 15px;
                    }

                    .comment-actions {
                        display: flex;
                        gap: 15px;
                    }

                    .btn-sm {
                        font-size: 12px;
                        padding: 4px 8px;
                    }

                    @media (max-width: 768px) {
                        .container {
                            padding: 0 16px;
                        }

                        .post-container {
                            border-radius: 0;
                            margin: 0 -16px 20px;
                            padding: 20px;
                        }

                        .post-title {
                            font-size: 20px;
                        }

                        .post-actions {
                            flex-wrap: wrap;
                        }

                        .btn-action {
                            flex: 1;
                            justify-content: center;
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="post-container">
                                <div class="post-header">
                                    <h1 class="post-title">${post.title}</h1>
                                    <div class="post-meta">
                                        Posted by ${post.userType} ·
                                        <fmt:formatDate value="${post.createdAt}" pattern="MMM d, yyyy 'at' h:mm a" />
                                        <c:if test="${post.updatedAt != null}">
                                            · Updated
                                            <fmt:formatDate value="${post.updatedAt}"
                                                pattern="MMM d, yyyy 'at' h:mm a" />
                                        </c:if>
                                    </div>
                                </div>

                                <div class="post-content">
                                    ${post.content}
                                </div>

                                <div class="post-stats">
                                    <span><i class="fas fa-eye"></i> ${post.viewCount} views</span>
                                    <span><i class="fas fa-heart"></i> ${post.likeCount} likes</span>
                                    <span><i class="fas fa-comment"></i> ${post.commentCount} comments</span>
                                </div>

                                <div class="post-actions">
                                    <button onclick="toggleLike(${post.id})"
                                        class="btn-action ${hasLiked ? 'liked' : ''}">
                                        <i class="fas fa-heart"></i>
                                        <span id="likeText">${hasLiked ? 'Liked' : 'Like'}</span>
                                    </button>
                                    <c:if test="${sessionScope.user.id == post.userId}">
                                        <a href="post?action=edit&id=${post.id}" class="btn-action">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <button onclick="deletePost(${post.id})" class="btn-action text-danger">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </c:if>
                                </div>
                            </div>

                            <div class="comments-section">
                                <div class="comments-header">
                                    <h3>Comments (${post.commentCount})</h3>
                                </div>

                                <div class="comment-form">
                                    <form action="post" method="POST" class="needs-validation" novalidate>
                                        <input type="hidden" name="action" value="comment">
                                        <input type="hidden" name="parentId" value="${post.id}">
                                        <div class="form-group mb-3">
                                            <textarea class="form-control" name="content" rows="3"
                                                placeholder="Write your comment..." required></textarea>
                                            <div class="invalid-feedback">
                                                Please write your comment.
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">
                                            Post Comment
                                        </button>
                                    </form>
                                </div>

                                <c:forEach items="${comments}" var="comment">
                                    <div class="comment-card">
                                        <div class="comment-meta">
                                            ${comment.userType} ·
                                            <fmt:formatDate value="${comment.createdAt}"
                                                pattern="MMM d, yyyy 'at' h:mm a" />
                                        </div>
                                        <div class="comment-content">
                                            ${comment.content}
                                        </div>
                                        <c:if test="${sessionScope.user.id == comment.userId}">
                                            <div class="comment-actions">
                                                <button onclick="deleteComment(${comment.id})"
                                                    class="btn-action btn-sm text-danger">
                                                    <i class="fas fa-trash"></i> Delete
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Form validation
                    (function () {
                        'use strict';
                        const forms = document.querySelectorAll('.needs-validation');
                        Array.from(forms).forEach(form => {
                            form.addEventListener('submit', event => {
                                if (!form.checkValidity()) {
                                    event.preventDefault();
                                    event.stopPropagation();
                                }
                                form.classList.add('was-validated');
                            }, false);
                        });
                    })();

                    // Like/Unlike post
                    function toggleLike(postId) {
                        $.post('post?action=like', { id: postId }, function (response) {
                            if (response.success) {
                                const btn = document.querySelector('.btn-action');
                                const likeText = document.getElementById('likeText');
                                const likeCount = parseInt($('.post-stats .fa-heart').parent().text());

                                if (response.liked) {
                                    btn.classList.add('liked');
                                    likeText.textContent = 'Liked';
                                    $('.post-stats .fa-heart').parent().text(` ${likeCount + 1} likes`);
                                } else {
                                    btn.classList.remove('liked');
                                    likeText.textContent = 'Like';
                                    $('.post-stats .fa-heart').parent().text(` ${likeCount - 1} likes`);
                                }
                            }
                        });
                    }

                    // Delete post
                    function deletePost(postId) {
                        if (confirm('Are you sure you want to delete this post? This action cannot be undone.')) {
                            $.post('post?action=delete', { id: postId }, function (response) {
                                if (response.success) {
                                    window.location.href = 'post_list.jsp';
                                } else {
                                    alert('Failed to delete post. Please try again.');
                                }
                            });
                        }
                    }

                    // Delete comment
                    function deleteComment(commentId) {
                        if (confirm('Are you sure you want to delete this comment?')) {
                            $.post('post?action=delete', { id: commentId }, function (response) {
                                if (response.success) {
                                    location.reload();
                                } else {
                                    alert('Failed to delete comment. Please try again.');
                                }
                            });
                        }
                    }
                </script>
            </body>

            </html>