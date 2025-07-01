<!-- admin_saler_add_blog.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:choose>
        <c:when test="${not empty blog.id}">Update Blog</c:when>
        <c:otherwise>Create New Blog</c:otherwise>
    </c:choose> - Admin Panel</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <c:choose>
                    <c:when test="${not empty blog.id}">
                        <h1>Update Blog</h1>
                    </c:when>
                    <c:otherwise>
                        <h1>Create New Blog</h1>
                    </c:otherwise>
                </c:choose>
                <div class="header-actions">
                    <a href="AdminSalerController?target=blog" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="form-container">
                <form action="AdminSalerController" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>Title</label>
                        <c:choose>
                            <c:when test="${not empty blog.id}">
                                <input name="title" type="text" class="form-control" value="${blog.title}" required>
                            </c:when>
                            <c:otherwise>
                                <input name="title" type="text" class="form-control" required>
                            </c:otherwise>
                        </c:choose>
                        <span>${message}</span>
                    </div>

                    <div class="form-group">
                        <label>Thumbnail</label>
                        <c:choose>
                            <c:when test="${not empty blog.id}">
                                <input type="file" name="thumbnail" accept="image/*" class="form-control" />
                            </c:when>
                            <c:otherwise>
                                <input type="file" name="thumbnail" accept="image/*" class="form-control" required />
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty mustbeImg}">
                            ${mustbeImg}
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <c:choose>
                            <c:when test="${not empty blog.id}">
                                <textarea name="description" id="default" class="form-control" rows="6">${blog.description}</textarea>
                            </c:when>
                            <c:otherwise>
                                <textarea name="description" id="default" class="form-control" rows="6"></textarea>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <input type="hidden" name="target" value="blog">
                    <c:choose>
                        <c:when test="${not empty blog.id}">
                            <input type="hidden" name="blogId" value="${blog.id}">
                            <input type="hidden" name="service" value="Update">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="service" value="Add">
                        </c:otherwise>
                    </c:choose>

                    <div class="form-actions">
                        <button type="submit" name="submit" value="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Confirm
                        </button>
                        <a href="AdminSalerController?target=blog" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- TinyMCE -->
    <script src="./tinymce/tinymce.min.js"></script>
    <script src="./assets/js/tinymceConfig.js"></script>
    <script src="./assets/js/tinymceConfigThumbnailBlog.js"></script>
    
    <style>
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
    </style>
</body>
</html>