<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Sidebar Component -->
<div class="sidebar">
    <div class="sidebar-header">
        <h2>Admin Panel</h2>
        <p>Recruitment System</p>
    </div>

    <nav class="sidebar-menu">
        <a href="admin_dashboard.jsp" class="menu-item ${pageContext.request.servletPath == '/admin_dashboard.jsp' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>

        <a href="AdminController?target=JobSeeker" class="menu-item ${param.target == 'JobSeeker' ? 'active' : ''}">
            <i class="fas fa-users"></i>
            <span>Manage Job Seekers</span>
        </a>

        <a href="AdminController?target=Recruiter" class="menu-item ${param.target == 'Recruiter' ? 'active' : ''}">
            <i class="fas fa-building"></i>
            <span>Manage Recruiters</span>
        </a>

        <a href="AdminController?target=Manager" class="menu-item ${param.target == 'Manager' ? 'active' : ''}">
            <i class="fas fa-user-tie"></i>
            <span>Manage Managers</span>
        </a>

        <a href="AdminController?target=Saler" class="menu-item ${param.target == 'Saler' ? 'active' : ''}">
            <i class="fas fa-user-tag"></i>
            <span>Manage Salers</span>
        </a>

        <a href="AdminSalerController?target=blog" class="menu-item ${param.target == 'blog' ? 'active' : ''}">
            <i class="fas fa-blog"></i>
            <span>Manage Blogs</span>
        </a>

        <a href="AdminSalerController?target=banner" class="menu-item ${param.target == 'banner' ? 'active' : ''}">
            <i class="fas fa-image"></i>
            <span>Manage Banners</span>
        </a>

        <a href="reports.jsp" class="menu-item ${pageContext.request.servletPath == '/reports.jsp' ? 'active' : ''}">
            <i class="fas fa-chart-bar"></i>
            <span>Reports</span>
        </a>

        <hr style="margin: 20px 25px; opacity: 0.2;">

        <a href="profile.jsp" class="menu-item">
            <i class="fas fa-user-circle"></i>
            <span>My Profile</span>
        </a>

        <a href="settings.jsp" class="menu-item">
            <i class="fas fa-cog"></i>
            <span>Settings</span>
        </a>

        <a href="logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </nav>
</div>

<style>
/* Sidebar với nền trắng và chữ đen */
.sidebar {
    width: 250px;
    background-color: whitesmoke;
    color: black;
    padding: 0;
    position: fixed;
    height: 100vh;
    overflow-y: auto;
    box-shadow: 2px 0 8px rgba(0,0,0,0.1);
    z-index: 1000;
}

.sidebar-header {
    padding: 20px;
    background-color: #ffffff;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.sidebar-header h2 {
    font-size: 22px;
    margin-bottom: 5px;
    color: #222;
}

.sidebar-header p {
    font-size: 13px;
    color: #777;
}

.sidebar-menu {
    padding: 15px 0;
}

.menu-item {
    display: flex;
    align-items: center;
    padding: 14px 24px;
    color: #333;
    text-decoration: none;
    font-size: 15px;
    transition: background 0.3s, padding-left 0.3s;
    border-left: 3px solid transparent;
}

.menu-item:hover {
    background-color: #e0e0e0;
    padding-left: 28px;
    color: #000;
}

.menu-item.active {
    background-color: #c8e6c9;
    color: #1b5e20;
    font-weight: bold;
    border-left: 3px solid #2e7d32;
}

.menu-item i {
    margin-right: 12px;
    width: 20px;
    text-align: center;
    color: inherit;
}

/* Responsive Sidebar */
@media (max-width: 768px) {
    .sidebar {
        width: 70px;
    }

    .sidebar-header h2,
    .sidebar-header p,
    .menu-item span {
        display: none;
    }

    .menu-item {
        justify-content: center;
        padding: 14px;
    }

    .menu-item i {
        margin: 0;
        font-size: 20px;
    }
}
</style>
