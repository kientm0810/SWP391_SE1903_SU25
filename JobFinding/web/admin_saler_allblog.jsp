<!-- admin_saler_allblog.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blogs - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .blog-thumbnail {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .blog-title {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .blog-description {
            max-width: 400px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Manage Blogs</h1>
                <div class="header-actions">
                    <a href="AdminSalerController?target=blog&service=Add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Create New Blog
                    </a>
                </div>
            </div>
            
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Thumbnail</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Created Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="blog" items="${blogs}">
                            <tr>
                                <td>#${blog.id}</td>
                                <td>
                                    <img src="${blog.thumbnail}" alt="Blog thumbnail" class="blog-thumbnail">
                                </td>
                                <td>
                                    <div class="blog-title" title="${blog.title}">
                                        ${blog.title}
                                    </div>
                                </td>
                                <td>Admin #${blog.admin_id}</td>
                                <td>${blog.created_at}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${blog.status == 'published'}">
                                            <span class="status-badge status-published">Published</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-draft">Draft</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="AdminSalerController?target=blog&service=Detail&blogId=${blog.id}" 
                                           class="action-btn view-btn">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="AdminSalerController?target=blog&service=Update&blogId=${blog.id}" 
                                           class="action-btn edit-btn">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="AdminSalerController?target=blog&service=Delete&blogId=${blog.id}" 
                                           class="action-btn delete-btn"
                                           onclick="return confirm('Are you sure you want to delete this blog?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty blogs}">
                            <tr>
                                <td colspan="7" class="text-center">No blogs found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>