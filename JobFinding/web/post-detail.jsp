<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${post.title}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .post-content {
                white-space: pre-wrap;
                line-height: 1.6;
            }

            .post-meta {
                color: #6c757d;
                font-size: 0.9em;
            }

            .post-stats {
                font-size: 1.1em;
            }

            .post-stats i {
                margin-right: 5px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container mt-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/post">Posts</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${post.title}</li>
                </ol>
            </nav>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <h1 class="card-title">${post.title}</h1>

                    <div class="post-meta mb-3">
                        <span><i class="fas fa-user"></i> ${post.userType}</span>
                        <span class="ms-3"><i class="fas fa-calendar"></i>
                            <fmt:formatDate value="${post.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                        </span>
                    </div>

                    <div class="post-stats mb-4">
                        <span class="me-3"><i class="fas fa-eye"></i> ${post.viewCount} views</span>
                        <span class="me-3"><i class="fas fa-heart"></i> ${post.likeCount} likes</span>
                        <span><i class="fas fa-comment"></i> ${post.commentCount} comments</span>
                    </div>

                    <div class="post-content mb-4">
                        ${post.content}
                    </div>

                    <c:if test="${sessionScope.userId == post.userId}">
                        <div class="post-actions">
                            <a href="${pageContext.request.contextPath}/post/edit?id=${post.id}"
                               class="btn btn-outline-primary">
                                <i class="fas fa-edit"></i> Edit Post
                            </a>

                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                    data-bs-target="#deleteModal">
                                <i class="fas fa-trash"></i> Delete Post
                            </button>

                            <!-- Delete Confirmation Modal -->
                            <div class="modal fade" id="deleteModal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Confirm Delete</h5>
                                            <button type="button" class="btn-close"
                                                    data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            Are you sure you want to delete this post?
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Cancel</button>
                                            <form action="${pageContext.request.contextPath}/post/delete"
                                                  method="POST" style="display: inline;">
                                                <input type="hidden" name="id" value="${post.id}">
                                                <button type="submit" class="btn btn-danger">Delete</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Comments Section -->
            <div class="card mt-4">
                <div class="card-body">
                    <h3 class="card-title">Comments</h3>
                    <!-- Add comment form -->
                    <c:if test="${sessionScope.userId != null}">
                        <form action="${pageContext.request.contextPath}/comment/add" method="POST"
                              class="mb-4">
                            <input type="hidden" name="postId" value="${post.id}">
                            <div class="mb-3">
                                <textarea class="form-control" name="content" rows="3"
                                          placeholder="Write a comment..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Post Comment</button>
                        </form>
                    </c:if>

                    <!-- Comments list -->
                    <div class="comments-list">
                        <!-- Add your comments display logic here -->
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>