<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard - TopCV</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --admin-primary: #dc3545;
            --admin-secondary: #6c757d;
            --admin-success: #198754;
            --admin-warning: #ffc107;
            --admin-info: #0dcaf0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .admin-navbar {
            background: linear-gradient(135deg, var(--admin-primary), #b02a37);
            box-shadow: 0 2px 15px rgba(220, 53, 69, 0.2);
        }
        .sidebar {
            min-height: calc(100vh - 76px);
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        .dashboard-card {
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }
        .stats-card {
            background: linear-gradient(135deg, #fff, #f8f9fa);
            border-left: 4px solid var(--admin-primary);
        }
        .stats-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
        .activity-item {
            border-left: 3px solid #e9ecef;
            padding-left: 15px;
            margin-bottom: 15px;
            position: relative;
        }
        .activity-item:before {
            content: '';
            position: absolute;
            left: -6px;
            top: 10px;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background: var(--admin-primary);
        }
        .nav-link.active {
            background-color: var(--admin-primary) !important;
            color: white !important;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(220, 53, 69, 0.05);
        }
        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8em;
        }
        .chart-container {
            position: relative;
            height: 300px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg admin-navbar">
        <div class="container-fluid">
            <a class="navbar-brand text-white fw-bold" href="#">
                <i class="fas fa-shield-alt me-2"></i>TopCV Admin
            </a>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" 
                       id="dropdownAdmin" data-bs-toggle="dropdown">
                        <img src="${admin.profile_picture != null ? admin.profile_picture : 'https://cdn.topcv.vn/images/default-user-avatar.png'}" 
                             alt="Admin" class="rounded-circle me-2" width="40" height="40">
                        <span>${admin.full_name}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i>Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-2 sidebar">
                <div class="p-3">
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item mb-2">
                            <a class="nav-link active" href="#dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#users">
                                <i class="fas fa-users me-2"></i>User Management
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#recruiters">
                                <i class="fas fa-building me-2"></i>Recruiters
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#jobseekers">
                                <i class="fas fa-user-tie me-2"></i>Job Seekers
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#jobs">
                                <i class="fas fa-briefcase me-2"></i>Job Listings
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#transactions">
                                <i class="fas fa-credit-card me-2"></i>Financial Transactions
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#promotions">
                                <i class="fas fa-bullhorn me-2"></i>Promotion Programs
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#reports">
                                <i class="fas fa-chart-bar me-2"></i>Reports
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link" href="#notifications">
                                <i class="fas fa-bell me-2"></i>Notifications
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-10 p-4">
                <!-- Welcome Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="h3 mb-1">Welcome back, ${admin.full_name}!</h2>
                        <p class="text-muted">Here's what's happening with TopCV today</p>
                    </div>
                    <div>
                        <button class="btn btn-primary me-2">
                            <i class="fas fa-download me-1"></i>Export Report
                        </button>
                        <button class="btn btn-outline-primary">
                            <i class="fas fa-plus me-1"></i>Quick Action
                        </button>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <div class="card dashboard-card stats-card">
                            <div class="card-body d-flex align-items-center">
                                <div class="stats-icon bg-primary text-white me-3">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">1,247</h3>
                                    <small class="text-muted">Total Job Seekers</small>
                                    <div class="text-success small">
                                        <i class="fas fa-arrow-up"></i> +12% this month
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card dashboard-card stats-card">
                            <div class="card-body d-flex align-items-center">
                                <div class="stats-icon bg-success text-white me-3">
                                    <i class="fas fa-building"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">342</h3>
                                    <small class="text-muted">Active Recruiters</small>
                                    <div class="text-success small">
                                        <i class="fas fa-arrow-up"></i> +8% this month
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card dashboard-card stats-card">
                            <div class="card-body d-flex align-items-center">
                                <div class="stats-icon bg-warning text-white me-3">
                                    <i class="fas fa-briefcase"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">2,156</h3>
                                    <small class="text-muted">Active Job Listings</small>
                                    <div class="text-success small">
                                        <i class="fas fa-arrow-up"></i> +15% this month
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card dashboard-card stats-card">
                            <div class="card-body d-flex align-items-center">
                                <div class="stats-icon bg-info text-white me-3">
                                    <i class="fas fa-dollar-sign"></i>
                                </div>
                                <div>
                                    <h3 class="mb-0">$45,892</h3>
                                    <small class="text-muted">Monthly Revenue</small>
                                    <div class="text-success small">
                                        <i class="fas fa-arrow-up"></i> +23% this month
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row mb-4">
                    <div class="col-md-8">
                        <div class="card dashboard-card">
                            <div class="card-header bg-transparent">
                                <h5 class="card-title mb-0">Revenue Analytics</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-transparent">
                                <h5 class="card-title mb-0">User Distribution</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="userChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tables Row -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-header bg-transparent d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0">Recent Recruiter Verifications</h5>
                                <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Company</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <strong>FPT Software</strong><br>
                                                    <small class="text-muted">Technology</small>
                                                </td>
                                                <td><span class="badge badge-status bg-warning">Pending</span></td>
                                                <td>Today</td>
                                                <td>
                                                    <button class="btn btn-sm btn-success me-1">Approve</button>
                                                    <button class="btn btn-sm btn-danger">Reject</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>Viettel Solutions</strong><br>
                                                    <small class="text-muted">Telecommunications</small>
                                                </td>
                                                <td><span class="badge badge-status bg-success">Verified</span></td>
                                                <td>Yesterday</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary">View</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>Tiki Corporation</strong><br>
                                                    <small class="text-muted">E-commerce</small>
                                                </td>
                                                <td><span class="badge badge-status bg-warning">Pending</span></td>
                                                <td>2 days ago</td>
                                                <td>
                                                    <button class="btn btn-sm btn-success me-1">Approve</button>
                                                    <button class="btn btn-sm btn-danger">Reject</button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card dashboard-card">
                            <div class="card-header bg-transparent d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0">Recent Financial Transactions</h5>
                                <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Type</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <strong>Featured Job</strong><br>
                                                    <small class="text-muted">FPT Software</small>
                                                </td>
                                                <td class="text-success">+$299</td>
                                                <td><span class="badge badge-status bg-success">Completed</span></td>
                                                <td>Today</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>Subscription</strong><br>
                                                    <small class="text-muted">Viettel Solutions</small>
                                                </td>
                                                <td class="text-success">+$499</td>
                                                <td><span class="badge badge-status bg-success">Completed</span></td>
                                                <td>Yesterday</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>CV Service</strong><br>
                                                    <small class="text-muted">Job Seeker Premium</small>
                                                </td>
                                                <td class="text-success">+$49</td>
                                                <td><span class="badge badge-status bg-warning">Pending</span></td>
                                                <td>2 days ago</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Activity Feed -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="card dashboard-card">
                            <div class="card-header bg-transparent">
                                <h5 class="card-title mb-0">System Activity Feed</h5>
                            </div>
                            <div class="card-body">
                                <div class="activity-item">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <strong>New recruiter registration</strong>
                                            <p class="mb-1 text-muted">Tech Innovations Ltd. submitted verification documents</p>
                                        </div>
                                        <small class="text-muted">5 min ago</small>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <strong>Job listing reported</strong>
                                            <p class="mb-1 text-muted">Job "Senior Developer" flagged for suspicious content</p>
                                        </div>
                                        <small class="text-muted">15 min ago</small>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <strong>Payment processed</strong>
                                            <p class="mb-1 text-muted">$299 received for featured job posting</p>
                                        </div>
                                        <small class="text-muted">1 hour ago</small>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <strong>Mass email sent</strong>
                                            <p class="mb-1 text-muted">Newsletter sent to 1,247 job seekers</p>
                                        </div>
                                        <small class="text-muted">2 hours ago</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card dashboard-card">
                            <div class="card-header bg-transparent">
                                <h5 class="card-title mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <button class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>Create Promotion Program
                                    </button>
                                    <button class="btn btn-outline-primary">
                                        <i class="fas fa-envelope me-2"></i>Send Notification
                                    </button>
                                    <button class="btn btn-outline-primary">
                                        <i class="fas fa-chart-bar me-2"></i>Generate Report
                                    </button>
                                    <button class="btn btn-outline-primary">
                                        <i class="fas fa-users me-2"></i>Manage Users
                                    </button>
                                    <button class="btn btn-outline-primary">
                                        <i class="fas fa-cog me-2"></i>System Settings
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <script>
        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Revenue ($)',
                    data: [32000, 38000, 35000, 42000, 39000, 45892],
                    borderColor: '#dc3545',
                    backgroundColor: 'rgba(220, 53, 69, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        // User Distribution Chart
        const userCtx = document.getElementById('userChart').getContext('2d');
        new Chart(userCtx, {
            type: 'doughnut',
            data: {
                labels: ['Job Seekers', 'Recruiters', 'Admin'],
                datasets: [{
                    data: [1247, 342, 8],
                    backgroundColor: ['#0dcaf0', '#198754', '#dc3545']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

        // Navigation handling
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function(e) {
                document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Real-time updates simulation
        setInterval(() => {
            const stats = document.querySelectorAll('.stats-card h3');
            if (Math.random() > 0.8) {
                const randomStat = stats[Math.floor(Math.random() * stats.length)];
                const currentValue = parseInt(randomStat.textContent.replace(/[^0-9]/g, ''));
                randomStat.textContent = (currentValue + Math.floor(Math.random() * 5) + 1).toLocaleString();
                randomStat.style.animation = 'pulse 1s';
                setTimeout(() => randomStat.style.animation = '', 1000);
            }
        }, 10000);
    </script>
</body>
</html>