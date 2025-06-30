<!-- admin_detail_recruiter.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Recruiter"%>
<!DOCTYPE html>
<html>
<%
    Recruiter p = (Recruiter) request.getAttribute("Recruiter");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Profile - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .profile-section {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .section-header {
            color: #2e7d32;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e8f5e9;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
            font-size: 14px;
        }
        
        .info-value {
            color: #333;
            font-size: 16px;
        }
        
        .image-preview {
            max-width: 150px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .company-logo {
            width: 100px;
            height: 100px;
            object-fit: contain;
            border-radius: 8px;
            background-color: #f5f5f5;
            padding: 10px;
        }
        
        .verification-badge {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        
        .verification-pending {
            background-color: #fff3e0;
            color: #ef6c00;
        }
        
        .verification-verified {
            background-color: #e3f2fd;
            color: #1565c0;
        }
        
        .verification-rejected {
            background-color: #ffebee;
            color: #c62828;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Recruiter Profile</h1>
                <div class="header-actions">
                    <a href="AdminController?target=Recruiter" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="profile-section">
                <h2 class="section-header">
                    <i class="fas fa-user"></i>
                    Personal Information
                </h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">ID</span>
                        <span class="info-value">#<%= p.getId() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Username</span>
                        <span class="info-value"><%= p.getUsername() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Email</span>
                        <span class="info-value"><%= p.getEmail() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Full Name</span>
                        <span class="info-value"><%= p.getFullName() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Phone</span>
                        <span class="info-value"><%= p.getPhone() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Date of Birth</span>
                        <span class="info-value"><%= p.getDateOfBirth() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Gender</span>
                        <span class="info-value"><%= p.getGender() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Address</span>
                        <span class="info-value"><%= p.getAddress() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Profile Picture</span>
                        <img src="<%= p.getProfilePicture() %>" alt="Profile Picture" class="image-preview">
                    </div>
                    <div class="info-item">
                        <span class="info-label">Account Status</span>
                        <span class="status-badge <%= p.isActive() ? "status-active" : "status-inactive" %>">
                            <%= p.isActive() ? "Active" : "Inactive" %>
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="profile-section">
                <h2 class="section-header">
                    <i class="fas fa-building"></i>
                    Company Information
                </h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Company Name</span>
                        <span class="info-value"><%= p.getCompanyName() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Tax Code</span>
                        <span class="info-value"><%= p.getTaxCode() %></span>
                    </div>
                    <div class="info-item" style="grid-column: 1/-1;">
                        <span class="info-label">Description</span>
                        <span class="info-value"><%= p.getCompanyDescription() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Logo</span>
                        <img src="<%= p.getLogo() %>" alt="Company Logo" class="company-logo">
                    </div>
                    <div class="info-item">
                        <span class="info-label">Website</span>
                        <span class="info-value">
                            <a href="<%= p.getWebsite() %>" target="_blank" style="color: #4caf50;">
                                <%= p.getWebsite() %>
                            </a>
                        </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Company Address</span>
                        <span class="info-value"><%= p.getCompanyAddress() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Company Size</span>
                        <span class="info-value"><%= p.getCompanySize() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Industry</span>
                        <span class="info-value"><%= p.getIndustry() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Loyalty Score</span>
                        <span class="info-value"><%= p.getLoyaltyScore() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Verification Status</span>
                        <span class="verification-badge verification-<%= p.getVerificationStatus() %>">
                            <%= p.getVerificationStatus() %>
                        </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Created At</span>
                        <span class="info-value"><%= p.getCreatedAt() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Updated At</span>
                        <span class="info-value"><%= p.getUpdatedAt() %></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>