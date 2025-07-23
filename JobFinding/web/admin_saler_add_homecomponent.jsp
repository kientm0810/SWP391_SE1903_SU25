<!-- admin_saler_add_homecomponent.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:choose>
        <c:when test="${not empty component.id}">Update Homepage Component</c:when>
        <c:otherwise>Create New Homepage Component</c:otherwise>
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
                    <c:when test="${not empty component.id}">
                        <h1>Update Homepage Component</h1>
                    </c:when>
                    <c:otherwise>
                        <h1>Create New Homepage Component</h1>
                    </c:otherwise>
                </c:choose>
                <div class="header-actions">
                    <a href="AdminSalerController?target=homecomponent" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="form-container">
                <form action="AdminSalerController" method="post" onsubmit="tinymce.triggerSave();">
                    <div class="form-group">
                        <label>Component Type</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <select name="componentType" class="form-control" required>
                                    <option value="">Select Component Type</option>
                                    <option value="testimonial" ${component.componentType == 'testimonial' ? 'selected' : ''}>Testimonial</option>
                                    <option value="apply_process" ${component.componentType == 'apply_process' ? 'selected' : ''}>Apply Process</option>
                                </select>
                            </c:when>
                            <c:otherwise>
                                <select name="componentType" class="form-control" required>
                                    <option value="">Select Component Type</option>
                                    <option value="testimonial">Testimonial</option>
                                    <option value="apply_process">Apply Process</option>
                                </select>
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Choose the type of homepage component you want to manage</small>
                    </div>

                    <div class="form-group">
                        <label>Title</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <input name="title" type="text" class="form-control" value="${component.title}" required>
                            </c:when>
                            <c:otherwise>
                                <input name="title" type="text" class="form-control" required>
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Main title for the component section</small>
                        <span class="error-message">${message}</span>
                    </div>

                    <div class="form-group">
                        <label>Subtitle</label>
                        <c:choose>
                            <c:when test="${not empty component.id}">
                                <input name="subtitle" type="text" class="form-control" value="${component.subtitle}">
                            </c:when>
                            <c:otherwise>
                                <input name="subtitle" type="text" class="form-control">
                            </c:otherwise>
                        </c:choose>
                        <small class="form-text text-muted">Optional subtitle for additional context</small>
                    </div>

                    <div class="form