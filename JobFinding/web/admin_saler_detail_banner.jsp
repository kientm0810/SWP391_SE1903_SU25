<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Banner"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Banner Detail - Admin Panel</title>
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
        
        .banner-image {
            max-width: 100%;
            max-height: 400px;
            object-fit: contain;
            border-radius: 8px;
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
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Banner Details</h1>
                <div class="header-actions">
                    <a href="AdminSalerController?target=banner" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                    <a href="AdminSalerController?target=banner&service=Update&bannerId=${banner.id}" class="btn btn-primary">
                        <i class="fas fa-edit"></i>
                        Edit Banner
                    </a>
                </div>
            </div>
            
            <div class="detail-section">
                <h2 class="mb-3" style="color: #2e7d32;">${banner.title}</h2>
                
                <div class="text-center mb-4">
                    <img src="/JobFinding/${banner.image_url}" alt="Banner Image" class="banner-image">
                </div>
                
                <div class="detail-info">
                    <div class="detail-row">
                        <span class="detail-label">Redirect URL:</span>
                        <span class="detail-value">
                            <a href="${banner.redirect_url}" target="_blank" style="color: #4caf50;">
                                ${banner.redirect_url}
                            </a>
                        </span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Position:</span>
                        <span class="detail-value">${banner.position}</span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Status:</span>
                        <span class="detail-value">${banner.is_active}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>