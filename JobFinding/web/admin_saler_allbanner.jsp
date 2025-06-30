<!-- admin_saler_allbanner.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Banners - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .banner-preview {
            width: 120px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        
        .banner-preview:hover {
            transform: scale(1.1);
        }
        
        .position-badge {
            background-color: #e3f2fd;
            color: #1565c0;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .redirect-url {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #666;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Manage Banners</h1>
                <div class="header-actions">
                    <a href="AdminSalerController?target=banner&service=Add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Create New Banner
                    </a>
                </div>
            </div>
            
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Preview</th>
                            <th>Title</th>
                            <th>Redirect URL</th>
                            <th>Position</th>
                            <th>Created By</th>
                            <th>Created Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="banner" items="${banners}">
                            <tr>
                                <td>#${banner.id}</td>
                                <td>
                                    <img src="${banner.image_url}" alt="${banner.title}" 
                                         class="banner-preview" 
                                         onclick="window.open('${banner.image_url}', '_blank')">
                                </td>
                                <td>${banner.title}</td>
                                <td>
                                    <div class="redirect-url" title="${banner.redirect_url}">
                                        ${banner.redirect_url}
                                    </div>
                                </td>
                                <td>
                                    <span class="position-badge">Position ${banner.position}</span>
                                </td>
                                <td>Admin #${banner.admin_id}</td>
                                <td>${banner.created_at}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${banner.is_active}">
                                            <span class="status-badge status-active">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="AdminSalerController?target=banner&service=Detail&bannerId=${banner.id}" 
                                           class="action-btn view-btn">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="AdminSalerController?target=banner&service=Update&bannerId=${banner.id}" 
                                           class="action-btn edit-btn">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="AdminSalerController?target=banner&service=Delete&bannerId=${banner.id}" 
                                           class="action-btn delete-btn"
                                           onclick="return confirm('Are you sure you want to delete this banner?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty banners}">
                            <tr>
                                <td colspan="9" class="text-center">No banners found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>