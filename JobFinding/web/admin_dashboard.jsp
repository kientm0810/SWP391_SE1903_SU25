<!-- admin_dashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Recruitment System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .stat-card-header i {
            font-size: 30px;
            color: #4caf50;
        }
        
        .stat-value {
            font-size: 32px;
            font-weight: bold;
            color: #2e7d32;
        }
        
        .stat-label {
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }
        
        .quick-actions {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .quick-actions h2 {
            color: #2e7d32;
            margin-bottom: 20px;
        }
        
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .action-btn {
            padding: 15px 20px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        
        .action-btn:hover {
            background-color: #45a049;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Dashboard Overview</h1>
                <div class="user-info">
                    <span>Welcome, Admin</span>
                    <img src="https://via.placeholder.com/40" alt="Admin Avatar">
                </div>
            </div>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-value">1,245</div>
                            <div class="stat-label">Total Job Seekers</div>
                        </div>
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-value">387</div>
                            <div class="stat-label">Active Recruiters</div>
                        </div>
                        <i class="fas fa-building"></i>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-value">892</div>
                            <div class="stat-label">Job Postings</div>
                        </div>
                        <i class="fas fa-briefcase"></i>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-value">$12,450</div>
                            <div class="stat-label">Monthly Revenue</div>
                        </div>
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-value">23</div>
                            <div class="stat-label">Active Managers</div>
                        </div>
                        <i class="fas fa-user-tie"></i>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-value">156</div>
                            <div class="stat-label">Published Blogs</div>
                        </div>
                        <i class="fas fa-blog"></i>
                    </div>
                </div>
            </div>
            
            <div class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="action-buttons">
<!--                    <a href="AdminController?target=JobSeeker&service=Add" class="action-btn">
                        <i class="fas fa-user-plus"></i>
                        <span>Add Job Seeker</span>
                    </a>-->
                    <a href="AdminController?target=Recruiter&service=Add" class="action-btn">
                        <i class="fas fa-building"></i>
                        <span>Add Recruiter</span>
                    </a>
                    <a href="AdminSalerController?target=blog&service=Add" class="action-btn">
                        <i class="fas fa-pen"></i>
                        <span>Create Blog Post</span>
                    </a>
                    <a href="AdminSalerController?target=banner&service=Add" class="action-btn">
                        <i class="fas fa-image"></i>
                        <span>Create Banner</span>
                    </a>
                    <a href="AdminController?target=Manager&service=Add" class="action-btn">
                        <i class="fas fa-user-tie"></i>
                        <span>Add Manager</span>
                    </a>
                    <a href="reports.jsp" class="action-btn">
                        <i class="fas fa-chart-line"></i>
                        <span>View Reports</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>