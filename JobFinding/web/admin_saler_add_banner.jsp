<!-- admin_saler_add_banner.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:choose>
        <c:when test="${not empty banner.id}">Update Banner</c:when>
        <c:otherwise>Create New Banner</c:otherwise>
    </c:choose> - Admin Panel</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <c:choose>
                    <c:when test="${not empty banner.id}">
                        <h1>Update Banner</h1>
                    </c:when>
                    <c:otherwise>
                        <h1>Create New Banner</h1>
                    </c:otherwise>
                </c:choose>

                <div class="header-actions">
                    <a href="AdminSalerController?target=banner" class="btn btn-secondary">
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
                            <c:when test="${not empty banner.id}">
                                <input name="title" type="text" class="form-control" value="${banner.title}" required>
                            </c:when>
                            <c:otherwise>
                                <input name="title" type="text" class="form-control" required>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="form-group">
                        <label>Image Upload</label>
                        <c:choose>
                            <c:when test="${not empty banner.id}">
                                <input type="file" name="file" accept="image/*" class="form-control">
                            </c:when>
                            <c:otherwise>
                                <input type="file" name="file" accept="image/*" class="form-control" required>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty mustbeImg}">
                            ${mustbeImg}
                        </c:if>
                    </div>
                    
                    <div class="form-group">
                        <label>Redirect URL</label>
                        <c:choose>
                            <c:when test="${not empty banner.id}">
                                <input name="redirect_url" type="url" value="${banner.redirect_url}" class="form-control">
                            </c:when>
                            <c:otherwise>
                                <input name="redirect_url" type="url" class="form-control">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="form-group">
                        <label>Position</label>
                        <c:choose>
                            <c:when test="${not empty banner.id}">
                                <input name="position" type="number" class="form-control" min="1" value="${banner.position}" required>
                            </c:when>
                            <c:otherwise>
                                <input name="position" type="number" class="form-control" min="1" required>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <c:choose>
                            <c:when test="${not empty banner.id}">
                                <c:choose>
                                <c:when test="${banner.is_active}">
                                    <input type="checkbox" name="is_active" checked>
                                </c:when>
                                <c:otherwise>
                                        <input type="checkbox" name="is_active">
                                </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <input type="checkbox" name="is_active" checked>
                            </c:otherwise>
                        </c:choose>
                            <span>Active</span>
                        </label>
                    </div>
                    
                    <input type="hidden" name="target" value="banner">
                    <c:choose>
                        <c:when test="${not empty banner.id}">
                            <input type="hidden" name="bannerId" value="${banner.id}">
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
                        <a href="AdminSalerController?target=banner" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <style>
        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
    </style>
</body>
</html>