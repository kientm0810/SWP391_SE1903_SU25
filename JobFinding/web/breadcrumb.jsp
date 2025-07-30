<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!-- Breadcrumb Component -->
        <nav aria-label="breadcrumb" class="breadcrumb-nav">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="admin_dashboard.jsp">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                </li>

                <c:choose>
                    <c:when test="${pageContext.request.servletPath == '/admin_post_types.jsp'}">
                        <li class="breadcrumb-item active" aria-current="page">
                            <i class="fas fa-tags"></i> Post Types
                        </li>
                    </c:when>
                    <c:when test="${pageContext.request.servletPath == '/admin_create_post_type.jsp'}">
                        <li class="breadcrumb-item">
                            <a href="admin_post_types.jsp">
                                <i class="fas fa-tags"></i> Post Types
                            </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <i class="fas fa-plus"></i> Create Post Type
                        </li>
                    </c:when>
                    <c:when test="${pageContext.request.servletPath == '/admin_edit_post_type.jsp'}">
                        <li class="breadcrumb-item">
                            <a href="admin_post_types.jsp">
                                <i class="fas fa-tags"></i> Post Types
                            </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <i class="fas fa-edit"></i> Edit Post Type
                        </li>
                    </c:when>
                    <c:when test="${pageContext.request.servletPath == '/admin_blog_types.jsp'}">
                        <li class="breadcrumb-item active" aria-current="page">
                            <i class="fas fa-layer-group"></i> Blog Types
                        </li>
                    </c:when>
                    <c:when test="${pageContext.request.servletPath == '/admin_create_blog_type.jsp'}">
                        <li class="breadcrumb-item">
                            <a href="admin_blog_types.jsp">
                                <i class="fas fa-layer-group"></i> Blog Types
                            </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <i class="fas fa-plus"></i> Create Blog Type
                        </li>
                    </c:when>
                    <c:when test="${pageContext.request.servletPath == '/admin_edit_blog_type.jsp'}">
                        <li class="breadcrumb-item">
                            <a href="admin_blog_types.jsp">
                                <i class="fas fa-layer-group"></i> Blog Types
                            </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <i class="fas fa-edit"></i> Edit Blog Type
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="breadcrumb-item active" aria-current="page">
                            <i class="fas fa-cog"></i> Admin Panel
                        </li>
                    </c:otherwise>
                </c:choose>
            </ol>
        </nav>

        <style>
            .breadcrumb-nav {
                background: white;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .breadcrumb {
                background: transparent;
                padding: 0;
                margin: 0;
            }

            .breadcrumb-item {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .breadcrumb-item a {
                color: #007bff;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 5px;
                transition: color 0.3s ease;
            }

            .breadcrumb-item a:hover {
                color: #0056b3;
                text-decoration: underline;
            }

            .breadcrumb-item.active {
                color: #6c757d;
                font-weight: 500;
            }

            .breadcrumb-item.active i {
                color: #6c757d;
            }

            .breadcrumb-item+.breadcrumb-item::before {
                content: ">";
                color: #6c757d;
                margin: 0 10px;
                font-weight: bold;
            }

            .breadcrumb-item i {
                font-size: 14px;
            }
        </style>