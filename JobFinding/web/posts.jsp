<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Posts</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .post-card {
                transition: transform 0.2s;
                margin-bottom: 20px;
            }
            .post-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .post-stats {
                font-size: 0.9em;
                color: #6c757d;
            }
            .post-actions {
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Posts</h2>
                <c:if test="${sessionScope.userId != null}">
                    <a href="${pageContext.request.contextPath}/post/create" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Create New Post
                    </a>
                </c:if>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <c:if test="${empty posts}">
                <div class="alert alert-info" role="alert">
                    No posts found.
                </div>
            </c:if>

            <div class="row">
                <c:forEach items="${posts}" var="post">
                    <div class="col-md-6 col-lg-4">
                        <div class="card post-card">
                            <div class="card-body">
                                <h5 class="card-title">${post.title}</h5>
                                <p class="card-text text-truncate">${post.content}</p>

                                <div class="post-stats">
                                    <span><i class="fas fa-eye"></i> ${post.viewCount}</span>
                                    <span class="ms-3"><i class="fas fa-heart"></i> ${post.likeCount}</span>
                                    <span class="ms-3"><i class="fas fa-comment"></i> ${post.commentCount}</span>
                                </div>

                                <div class="post-actions">
                                    <a href="${pageContext.request.contextPath}/post/view?id=${post.id}" 
                                       class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-eye"></i> View
                                    </a>

                                    <c:if test="${sessionScope.userId == post.userId}">
                                        <a href="${pageContext.request.contextPath}/post/edit?id=${post.id}" 
                                           class="btn btn-outline-secondary btn-sm">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>

                                        <button type="button" 
                                                class="btn btn-outline-danger btn-sm" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#deleteModal${post.id}">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>

                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="deleteModal${post.id}" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Confirm Delete</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to delete this post?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <form action="${pageContext.request.contextPath}/post/delete" method="POST" style="display: inline;">
                                                            <input type="hidden" name="id" value="${post.id}">
                                                            <button type="submit" class="btn btn-danger">Delete</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="mt-2 text-muted small">
                                    Posted by ${post.userType} on ${post.createdAt}
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>