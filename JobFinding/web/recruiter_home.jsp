<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="models.Recruiter" %>
        <%@page import="models.JobListing" %>
            <%@page import="models.Application" %>
                <%@page import="models.JobSeeker" %>
                    <%@page import="daos.JobDAO" %>
                        <%@page import="daos.ApplicationDAO" %>
                            <%@page import="java.util.*" %>

                                <% try { // Get the recruiter from the session Recruiter recruiter=(Recruiter)
                                    session.getAttribute("recruiter"); if (recruiter==null) {
                                    response.sendRedirect("login.jsp"); return; } // Initialize DAOs JobDAO jobDAO=new
                                    JobDAO(); ApplicationDAO applicationDAO=new ApplicationDAO(); // Get job listings
                                    with error handling List<JobListing> activeJobs = new ArrayList<>();
                                        try {
                                        activeJobs = jobDAO.getJobListingsByRecruiter(recruiter.getId());
                                        } catch (Exception e) {
                                        System.out.println("Error getting jobs: " + e.getMessage());
                                        e.printStackTrace();
                                        // Set to empty list if error occurs
                                        activeJobs = new ArrayList<>();
                                            }

                                            // Get recent applications with error handling
                                            List<Application> recentApplications = new ArrayList<>();
                                                    try {
                                                    recentApplications =
                                                    applicationDAO.getRecentApplications(recruiter.getId(), 5);
                                                    } catch (Exception e) {
                                                    System.out.println("Error getting applications: " + e.getMessage());
                                                    e.printStackTrace();
                                                    // Set to empty list if error occurs
                                                    recentApplications = new ArrayList<>();
                                                        }

                                                        // Get application counts
                                                        int totalApplications = 0;
                                                        int newApplications = 0;
                                                        try {
                                                        totalApplications =
                                                        applicationDAO.getTotalApplicationsCount(recruiter.getId());
                                                        newApplications =
                                                        applicationDAO.getNewApplicationsCount(recruiter.getId());
                                                        } catch (Exception e) {
                                                        System.out.println("Error getting application counts: " +
                                                        e.getMessage());
                                                        e.printStackTrace();
                                                        }
                                                        %>

                                                        <!DOCTYPE html>
                                                        <html>

                                                        <head>
                                                            <meta http-equiv="Content-Type"
                                                                content="text/html; charset=UTF-8">
                                                            <title>Recruiter Dashboard - Job Finding</title>
                                                            <link
                                                                href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
                                                                rel="stylesheet">
                                                            <link rel="stylesheet"
                                                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                                                            <style>
                                                                body {
                                                                    background-color: #f8f9fa;
                                                                    font-family: Arial, sans-serif;
                                                                }

                                                                .dashboard-card {
                                                                    border-radius: 8px;
                                                                    border: none;
                                                                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                                                    margin-bottom: 20px;
                                                                }

                                                                .job-card {
                                                                    transition: all 0.2s;
                                                                    border-left: 3px solid #007bff;
                                                                }

                                                                .job-card:hover {
                                                                    transform: translateY(-2px);
                                                                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                                                                }

                                                                .status-badge {
                                                                    padding: 4px 8px;
                                                                    border-radius: 4px;
                                                                    font-size: 0.85em;
                                                                }

                                                                .status-pending {
                                                                    background-color: #ffeeba;
                                                                }

                                                                .status-approved {
                                                                    background-color: #c3e6cb;
                                                                }

                                                                .status-rejected {
                                                                    background-color: #f5c6cb;
                                                                }
                                                            </style>
                                                        </head>

                                                        <body>
                                                            <!-- Navigation -->
                                                            <nav
                                                                class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                                                                <div class="container">
                                                                    <a class="navbar-brand" href="#">Job Finding</a>
                                                                    <button class="navbar-toggler" type="button"
                                                                        data-bs-toggle="collapse"
                                                                        data-bs-target="#navbarNav">
                                                                        <span class="navbar-toggler-icon"></span>
                                                                    </button>
                                                                    <div class="collapse navbar-collapse"
                                                                        id="navbarNav">
                                                                        <ul class="navbar-nav me-auto">
                                                                            <li class="nav-item">
                                                                                <a class="nav-link active"
                                                                                    href="recruiter_home.jsp">Dashboard</a>
                                                                            </li>
                                                                            <li class="nav-item">
                                                                                <a class="nav-link"
                                                                                    href="post_job.jsp">Post Job</a>
                                                                            </li>
                                                                            <li class="nav-item">
                                                                                <a class="nav-link"
                                                                                    href="manage_jobs.jsp">Manage
                                                                                    Jobs</a>
                                                                            </li>
                                                                        </ul>
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="dropdown">
                                                                                <a href="#"
                                                                                    class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle"
                                                                                    id="dropdownUser"
                                                                                    data-bs-toggle="dropdown">
                                                                                    <i
                                                                                        class="fas fa-user-circle fa-2x me-2"></i>
                                                                                    <span>
                                                                                        <%= recruiter.getCompanyName()
                                                                                            %>
                                                                                    </span>
                                                                                </a>
                                                                                <ul
                                                                                    class="dropdown-menu dropdown-menu-end">
                                                                                    <li><a class="dropdown-item"
                                                                                            href="profile.jsp"><i
                                                                                                class="fas fa-user me-2"></i>Profile</a>
                                                                                    </li>
                                                                                    <li>
                                                                                        <hr class="dropdown-divider">
                                                                                    </li>
                                                                                    <li><a class="dropdown-item"
                                                                                            href="logout"><i
                                                                                                class="fas fa-sign-out-alt me-2"></i>Logout</a>
                                                                                    </li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </nav>

                                                            <div class="container py-4">
                                                                <!-- Welcome Section -->
                                                                <div class="row mb-4">
                                                                    <div class="col-12">
                                                                        <h2>Welcome, <%= recruiter.getCompanyName() %>
                                                                        </h2>
                                                                        <p class="text-muted">Manage your job
                                                                            postings and
                                                                            applications</p>
                                                                    </div>
                                                                </div>

                                                                <!-- Quick Stats -->
                                                                <div class="row mb-4">
                                                                    <div class="col-md-4">
                                                                        <div class="card dashboard-card">
                                                                            <div class="card-body">
                                                                                <h5 class="card-title">Active Jobs
                                                                                </h5>
                                                                                <h2 class="mb-0">
                                                                                    <%= activeJobs.size() %>
                                                                                </h2>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <div class="card dashboard-card">
                                                                            <div class="card-body">
                                                                                <h5 class="card-title">Total
                                                                                    Applications</h5>
                                                                                <h2 class="mb-0">
                                                                                    <%= totalApplications %>
                                                                                </h2>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <div class="card dashboard-card">
                                                                            <div class="card-body">
                                                                                <h5 class="card-title">New
                                                                                    Applications</h5>
                                                                                <h2 class="mb-0">
                                                                                    <%= newApplications %>
                                                                                </h2>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Active Jobs -->
                                                                <div class="row mb-4">
                                                                    <div class="col-12">
                                                                        <div class="card dashboard-card">
                                                                            <div class="card-header bg-white">
                                                                                <div
                                                                                    class="d-flex justify-content-between align-items-center">
                                                                                    <h5 class="mb-0">Active Job
                                                                                        Listings</h5>
                                                                                    <a href="post_job.jsp"
                                                                                        class="btn btn-primary btn-sm">
                                                                                        <i
                                                                                            class="fas fa-plus me-1"></i>Post
                                                                                        New Job
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                                                            <div class="card-body">
                                                                                <% if (!activeJobs.isEmpty()) { for
                                                                                    (JobListing job : activeJobs) { %>
                                                                                    <div class="card job-card mb-3">
                                                                                        <div class="card-body">
                                                                                            <div
                                                                                                class="d-flex justify-content-between align-items-center">
                                                                                                <div>
                                                                                                    <h5 class="mb-1">
                                                                                                        <%= job.getTitle()
                                                                                                            %>
                                                                                                    </h5>
                                                                                                    <p
                                                                                                        class="text-muted mb-0">
                                                                                                        <i
                                                                                                            class="fas fa-map-marker-alt me-1"></i>
                                                                                                        <%= job.getLocation()
                                                                                                            %> •
                                                                                                            <i
                                                                                                                class="fas fa-dollar-sign me-1"></i>
                                                                                                            <%= String.format("%.0f",
                                                                                                                job.getSalaryMin())
                                                                                                                %> -
                                                                                                                <%= String.format("%.0f",
                                                                                                                    job.getSalaryMax())
                                                                                                                    %>
                                                                                                    </p>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <a href="view_applications.jsp?jobId=<%= job.getId() %>"
                                                                                                        class="btn btn-outline-primary btn-sm me-2">
                                                                                                        View
                                                                                                        Applications
                                                                                                    </a>
                                                                                                    <a href="edit_job.jsp?jobId=<%= job.getId() %>"
                                                                                                        class="btn btn-outline-secondary btn-sm">
                                                                                                        Edit
                                                                                                    </a>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <% } } else { %>
                                                                                        <div class="text-center py-4">
                                                                                            <p class="text-muted mb-0">
                                                                                                No active job
                                                                                                listings. Post your
                                                                                                first job now!</p>
                                                                                        </div>
                                                                                        <% } %>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Recent Applications -->
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <div class="card dashboard-card">
                                                                            <div class="card-header bg-white">
                                                                                <h5 class="mb-0">Recent Applications
                                                                                </h5>
                                                                            </div>
                                                                            <div class="card-body">
                                                                                <% if (!recentApplications.isEmpty()) {
                                                                                    for (Application app :
                                                                                    recentApplications) { %>
                                                                                    <div
                                                                                        class="d-flex justify-content-between align-items-center mb-3 p-3 border rounded">
                                                                                        <div>
                                                                                            <h6 class="mb-1">
                                                                                                <%= app.getJobseeker().getFullName()
                                                                                                    %>
                                                                                            </h6>
                                                                                            <p class="text-muted mb-0">
                                                                                                Applied for:
                                                                                                <%= app.getJob().getTitle()
                                                                                                    %>
                                                                                            </p>
                                                                                        </div>
                                                                                        <div class="text-end">
                                                                                            <span
                                                                                                class="status-badge status-<%= app.getStatus().toLowerCase() %>">
                                                                                                <%= app.getStatus() %>
                                                                                            </span>
                                                                                            <div class="mt-2">
                                                                                                <a href="view_application.jsp?id=<%= app.getApplicationId() %>"
                                                                                                    class="btn btn-sm btn-primary">Review</a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <% } } else { %>
                                                                                        <div class="text-center py-4">
                                                                                            <p class="text-muted mb-0">
                                                                                                No
                                                                                                applications
                                                                                                received yet.</p>
                                                                                        </div>
                                                                                        <% } %>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <script
                                                                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
                                                        </body>

                                                        </html>
                                                        <% } catch (Exception e) { System.out.println("Error in
                                                            recruiter_home.jsp: " + e.getMessage());
e.printStackTrace();
response.sendRedirect(request.getContextPath() + " /error.jsp"); } %>