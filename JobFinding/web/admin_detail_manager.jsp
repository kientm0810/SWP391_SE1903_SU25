<!-- admin_detail_manager.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Admin" %>
<!DOCTYPE html>
<html>
<% Admin m = (Admin) request.getAttribute("Manager"); %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Detail - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .profile-header {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 30px;
        }
        
        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #4caf50;
        }
        
        .profile-info h2 {
            color: #2e7d32;
            margin-bottom: 10px;
        }
        
        .role-badge {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 5px 15px;
            border-radius: 20px;
            display: inline-block;
            font-size: 14px;
            margin-right: 10px;
        }
        
        .detail-card {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .detail-card h3 {
            color: #2e7d32;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e8f5e9;
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .detail-label {
            font-weight: 600;
            color: #666;
            font-size: 14px;
        }
        
        .detail-value {
            color: #333;
            font-size: 16px;
        }
        
        .timestamps {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 14px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Manager Details</h1>
                <div class="header-actions">
                    <a href="AdminController?target=Manager" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                    <a href="AdminController?target=Manager&service=Update&ID=<%= m.getId() %>" class="btn btn-primary">
                        <i class="fas fa-edit"></i>
                        Edit Manager
                    </a>
                </div>
            </div>
            
            <div class="profile-header">
                <img src="<%= m.getProfilePicture() != null && !m.getProfilePicture().isEmpty() ? m.getProfilePicture() : "images/default-avatar.png" %>" 
                     alt="Avatar" class="profile-image">
                <div class="profile-info">
                    <h2><%= m.getFullName() %></h2>
                    <div>
                        <span class="role-badge"><%= m.getRole() %></span>
                        <span class="status-badge <%= m.isIsActive() ? "status-active" : "status-inactive" %>">
                            <%= m.isIsActive() ? "Active" : "Inactive" %>
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="detail-card">
                <h3><i class="fas fa-user"></i> Personal Information</h3>
                <div class="detail-grid">
                    <div class="detail-item">
                        <span class="detail-label">Email</span>
                        <span class="detail-value"><%= m.getEmail() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Phone</span>
                        <span class="detail-value"><%= m.getPhone() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Date of Birth</span>
                        <span class="detail-value"><%= m.getDateOfBirth() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Gender</span>
                        <span class="detail-value"><%= m.getGender() %></span>
                    </div>
                    <div class="detail-item" style="grid-column: 1/-1;">
                        <span class="detail-label">Address</span>
                        <span class="detail-value"><%= m.getAddress() %></span>
                    </div>
                </div>
            </div>
            
            <div class="detail-card">
                <h3><i class="fas fa-cog"></i> Account Information</h3>
                <div class="detail-grid">
                    <div class="detail-item">
                        <span class="detail-label">Username</span>
                        <span class="detail-value"><%= m.getUsername() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Role</span>
                        <span class="detail-value"><%= m.getRole() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Status</span>
                        <span class="detail-value"><%= m.isIsActive() ? "Active" : "Inactive" %></span>
                    </div>
                </div>
                <div class="timestamps">
                    <i class="fas fa-clock"></i> Created at: <%= m.getCreatedAt() %> | Updated at: <%= m.getUpdatedAt() %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>