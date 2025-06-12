<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, models.Admin" %>
<%
    Vector<Admin> vec = (Vector<Admin>)request.getAttribute("vec");
    if (vec == null){
        vec = new Vector<>();
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Managers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <!-- Back button -->
        <div class="mb-4">
            <a href="admin_dashboard.jsp" class="btn btn-success">&larr; Back to Dashboard</a>
        </div>

        <h1 class="text-success mb-4">Quản lý Managers</h1>

        <!-- Search form -->
        <form action="AdminController" method="post" class="row g-3 mb-4">
            <div class="col-md-3">
                <label class="form-label">ID</label>
                <input type="number" name="id" class="form-control" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Email</label>
                <input type="text" name="email" class="form-control" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullName" class="form-control" value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Phone</label>
                <input type="text" name="phone" class="form-control" value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Gender</label>
                <select name="gender" class="form-select">
                    <option value="">--Select--</option>
                    <option value="male" <%= "male".equals(request.getParameter("gender")) ? "selected" : "" %>>Male</option>
                    <option value="female" <%= "female".equals(request.getParameter("gender")) ? "selected" : "" %>>Female</option>
                    <option value="other" <%= "other".equals(request.getParameter("gender")) ? "selected" : "" %>>Other</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Address</label>
                <input type="text" name="address" class="form-control" value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
            </div>
            <div class="col-md-3">
                <label class="form-label">Active</label>
                <select name="isActive" class="form-select">
                    <option value="">--Select--</option>
                    <option value="true" <%= "true".equals(request.getParameter("isActive")) ? "selected" : "" %>>Active</option>
                    <option value="false" <%= "false".equals(request.getParameter("isActive")) ? "selected" : "" %>>Banned</option>
                </select>
            </div>
            <div class="col-12 d-flex justify-content-end gap-2">
                <input type="submit" name="submit" value="Search" class="btn btn-success">
                <input type="reset" value="Reset" class="btn btn-secondary">
                <input type="hidden" name="service" value="list">
                <input type="hidden" name="target" value="Manager">
            </div>
        </form>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered align-middle text-center">
                <thead class="table-success">
                    <tr>
                        <th>ID</th>
                        <th>Profile Picture</th>
                        <th>Full Name</th>
                        <th>View</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Admin a : vec) { %>
                        <tr>
                            <td><%= a.getId() %></td>
                            <td><img src="<%= a.getProfilePicture() %>" alt="Profile" class="rounded-circle" width="40" height="40"></td>
                            <td><%= a.getFullName() %></td>
                            <td>
                                <a class="btn btn-outline-primary btn-sm" href="AdminController?target=Manager&service=Detail&ID=<%= a.getId() %>">View</a>
                            </td>
                            <td>
                                <a class="btn btn-sm <%= a.isActive() ? "btn-danger" : "btn-success" %>" 
                                   href="AdminController?target=Manager&service=Ban&ID=<%= a.getId() %>&status=<%= a.isActive() %>">
                                    <%= a.isActive() ? "Ban" : "Reassign" %>
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Add button -->
        <div class="mt-3">
            <a href="AdminController?target=Manager&service=Add" class="btn btn-outline-success">+ Add New Manager</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
