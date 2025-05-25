<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${post.title}</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="header.jsp"/>
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>
                
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h1 class="card-title">${post.title}</h1>
                            <c:if test="${post.isOwner}">
                                <div class="btn-group">
                                    <a href="update-post?id=${post.id}" class="btn btn-outline-primary">Edit</a>
                                    <button type="button" class="btn btn-outline-danger" 
                                            onclick="deletePost(${post.id})">Delete</button>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="text-muted mb-3">
                            Posted by ${post.userType} on 
                            <fmt:formatDate value="${post.createdAt}" pattern="MMM d, yyyy 'at' h:mm a"/>
                            <c:if test="${post.updatedAt != post.createdAt}">
                                (Edited <fmt:formatDate value="${post.updatedAt}" pattern="MMM d, yyyy 'at' h:mm a"/>)
                            </c:if>
                        </div>
                        
                        <div class="post-content mb-4">
                            ${post.content}
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <button class="btn btn-link text-decoration-none" onclick="toggleLike(${post.id})">
                                    <i class="fas fa-heart${post.hasLiked ? ' text-danger' : ''}"></i>
                                    <span id="likeCount">${post.likeCount}</span> Likes
                                </button>
                                <span class="ms-3">
                                    <i class="fas fa-eye"></i> ${post.viewCount} Views
                                </span>
                            </div>
                            <button class="btn btn-primary" onclick="focusCommentBox()">
                                Add Comment
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Comments Section -->
                <div class="card">
                    <div class="card-header">
                        <h4>Comments (${post.commentCount})</h4>
                    </div>
                    <div class="card-body">
                        <!-- Comment Form -->
                        <form action="create-post" method="POST" class="mb-4">
                            <input type="hidden" name="parentId" value="${post.id}">
                            <div class="form-group">
                                <textarea class="form-control" id="commentContent" name="content" 
                                          rows="3" placeholder="Write a comment..." required></textarea>
                            </div>
                            <div class="mt-2">
                                <button type="submit" class="btn btn-primary">Post Comment</button>
                            </div>
                        </form>
                        
                        <!-- Comments List -->
                        <div class="comments-list">
                            <c:forEach items="${comments}" var="comment">
                                <div class="comment mb-3">
                                    <div class="d-flex justify-content-between">
                                        <div class="comment-header">
                                            <strong>${comment.userType}</strong> - 
                                            <small class="text-muted">
                                                <fmt:formatDate value="${comment.createdAt}" 
                                                              pattern="MMM d, yyyy 'at' h:mm a"/>
                                            </small>
                                        </div>
                                        <c:if test="${comment.isOwner}">
                                            <button class="btn btn-sm btn-outline-danger" 
                                                    onclick="deleteComment(${comment.id})">
                                                Delete
                                            </button>
                                        </c:if>
                                    </div>
                                    <div class="comment-content mt-2">
                                        ${comment.content}
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script>
        function deletePost(postId) {
            if (confirm('Are you sure you want to delete this post?')) {
                fetch('delete-post', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: `id=${postId}`
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.href = 'posts';
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the post');
                });
            }
        }
        
        function deleteComment(commentId) {
            if (confirm('Are you sure you want to delete this comment?')) {
                fetch('delete-post', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: `id=${commentId}`
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the comment');
                });
            }
        }
        
        function toggleLike(postId) {
            fetch('toggle-like', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: `postId=${postId}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const likeButton = document.querySelector('.fa-heart');
                    const likeCount = document.getElementById('likeCount');
                    if (data.liked) {
                        likeButton.classList.add('text-danger');
                        likeCount.textContent = parseInt(likeCount.textContent) + 1;
                    } else {
                        likeButton.classList.remove('text-danger');
                        likeCount.textContent = parseInt(likeCount.textContent) - 1;
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while processing your like');
            });
        }
        
        function focusCommentBox() {
            document.getElementById('commentContent').focus();
        }
    </script>
</body>
</html>