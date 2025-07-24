<!-- admin_saler_detail_homecomponent.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Homepage Component Details - Admin Panel</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <jsp:include page="admin-common-styles.jsp" />
        <style>
            .detail-container {
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .detail-header {
                border-bottom: 2px solid #28a745;
                padding-bottom: 20px;
                margin-bottom: 30px;
            }

            .detail-header h2 {
                color: #28a745;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .detail-row {
                display: flex;
                margin-bottom: 20px;
                padding: 15px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .detail-row:last-child {
                border-bottom: none;
            }

            .detail-label {
                font-weight: bold;
                color: #333;
                min-width: 150px;
                flex-shrink: 0;
            }

            .detail-value {
                flex: 1;
                color: #666;
            }

            .component-type-badge {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: bold;
                text-transform: uppercase;
            }

            .type-testimonial {
                background-color: #e3f2fd;
                color: #1565c0;
            }

            .type-apply_process {
                background-color: #f3e5f5;
                color: #7b1fa2;
            }

            .position-badge {
                background-color: #28a745;
                color: white;
                padding: 4px 12px;
                border-radius: 12px;
                font-size: 14px;
                font-weight: bold;
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: bold;
                text-transform: uppercase;
            }

            .status-active {
                background-color: #d4edda;
                color: #155724;
            }

            .status-inactive {
                background-color: #f8d7da;
                color: #721c24;
            }

            .content-preview {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                border-left: 4px solid #28a745;
                line-height: 1.6;
            }

            .icon-preview {
                font-size: 24px;
                color: #28a745;
                margin-right: 10px;
            }

            .action-buttons {
                margin-top: 30px;
                display: flex;
                gap: 15px;
            }

            .btn-back {
                background-color: #6c757d;
                color: white;
            }

            .btn-edit {
                background-color: #28a745;
                color: white;
            }

            .btn-delete {
                background-color: #dc3545;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <jsp:include page="sidebar.jsp" />

            <div class="main-content">
                <div class="page-header">
                    <h1>Homepage Component Details</h1>
                    <div class="header-actions">
                        <a href="AdminSalerController?target=homecomponent" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            Back to List
                        </a>
                    </div>
                </div>

                <div class="detail-container">
                    <div class="detail-header">
                        <h2>
                            <i class="fas fa-info-circle"></i>
                            Component Information
                        </h2>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">ID:</div>
                        <div class="detail-value">#${component.id}</div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">Component Type:</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${component.typeName == 'testimonial'}">
                                    <span class="component-type-badge type-testimonial">Testimonial</span>
                                </c:when>
                                <c:when test="${component.typeName == 'apply_process'}">
                                    <span class="component-type-badge type-apply_process">Apply Process</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="component-type-badge">${component.typeName}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Image:</span>
                        <span class="detail-value">
                            <img style="
                                 width: 130px;
                                 height: 130px;
                                 border-radius: 50%;
                                 object-fit: cover;
                                 box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                                 " 
                                 src="/JobFinding/${component.img}" alt="Thumbnail">
                        </span>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">Position:</div>
                        <div class="detail-value">
                            <span class="position-badge">${component.position}</span>
                        </div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">Name:</div>
                        <div class="detail-value">${component.name}</div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">Title:</div>
                        <div class="detail-value"><strong>${component.title}</strong></div>
                    </div>

                    <c:if test="${not empty component.iconClass}">
                        <div class="detail-row">
                            <div class="detail-label">Icon:</div>
                            <div class="detail-value">
                                <i class="${component.iconClass} icon-preview"></i>
                                <code>${component.iconClass}</code>
                            </div>
                        </div>
                    </c:if>

                    <div class="detail-row">
                        <div class="detail-label">Status:</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${component.status == 'active'}">
                                    <span class="status-badge status-active">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive">Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">Created Date:</div>
                        <div class="detail-value">${component.createdAt}</div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">Last Updated:</div>
                        <div class="detail-value">${component.updatedAt}</div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">Content:</div>
                        <div class="detail-value">
                            <div class="content-preview">
                                ${component.content}
                            </div>
                        </div>
                    </div>

                    <div class="action-buttons">
<!--                        <a href="AdminSalerController?target=homecomponent" class="btn btn-back">
                            <i class="fas fa-arrow-left"></i>
                            Back to List
                        </a>-->

                        <a href="AdminSalerController?target=homecomponent&service=Update&componentId=${component.id}" class="btn btn-edit">
                            <i class="fas fa-edit"></i>
                            Edit Component
                        </a>

                        <a href="AdminSalerController?target=homecomponent&service=Delete&componentId=${component.id}" 
                           class="btn btn-delete"
                           onclick="return confirm('Are you sure you want to delete this homepage component?')">
                            <i class="fas fa-trash"></i>
                            Delete Component
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>