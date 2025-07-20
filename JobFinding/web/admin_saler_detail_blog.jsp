<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="models.Blog"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Blog Detail - Admin Panel</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .detail-section {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .detail-info {
            margin-top: 30px;
        }

        .detail-row {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .detail-label {
            font-weight: 600;
            color: #666;
            width: 150px;
        }

        .detail-value {
            color: #333;
            flex: 1;
        }

        .btn-green {
            background-color: #28a745;
            color: white;
        }

        .btn-green:hover {
            background-color: #218838;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header-actions a {
            margin-left: 10px;
            text-decoration: none;
        }
    </style>
</head>
<body class="bg-light">
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />

        <div class="main-content">
            <div class="container mt-5">
                <div class="page-header">
                    <h1>Blog Details</h1>
                    <div class="header-actions">
                        <a href="AdminSalerController?target=blog" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            Back to List
                        </a>
                        <a href="AdminSalerController?target=blog&service=Update&blogId=${blog.id}" class="btn btn-green">
                            <i class="fas fa-edit"></i>
                            Edit Blog
                        </a>
                    </div>
                </div>

                <div class="detail-section">
                    <h2 class="mb-3" style="color: #2e7d32;">${blog.title}</h2>

                    <div class="detail-info">
                        <div class="detail-row">
                            <span class="detail-label">Description:</span>
                            <span class="detail-value">${blog.description}</span>
                        </div>

                        <div class="detail-row">
                            <span class="detail-label">Thumbnail:</span>
                            <span class="detail-value">
                                <img src="/JobFinding/${blog.thumbnail}" alt="Thumbnail" style="max-width: 300px; max-height: 200px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                            </span>
                        </div>

                        <div class="detail-row">
                            <span class="detail-label">Created At:</span>
                            <span class="detail-value">${blog.created_at}</span>
                        </div>
                    </div>

                    <div class="mt-4 d-flex gap-3">
                        <form action="AdminSalerController" method="post" onsubmit="return confirm('Are you sure you want to delete this blog?');">
                            <input type="hidden" name="target" value="blog" />
                            <input type="hidden" name="service" value="Delete" />
                            <input type="hidden" name="blogId" value="${blog.id}" />
                            <button type="submit" class="btn btn-danger">🗑️ Delete Blog</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
