<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Admin" %>
<!DOCTYPE html>
<html>
<% Admin m = (Admin) request.getAttribute("Manager"); %>
<head>
    <meta charset="UTF-8">
    <title>Manager Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <!-- Back link -->
    <div class="mb-4">
        <a href="AdminController?target=Manager" class="btn btn-outline-success">&larr; Back to List Managers</a>
    </div>

    <!-- Profile header -->
    <div class="card mb-4 shadow-sm border-success">
        <div class="card-body d-flex align-items-center">
            <img src="<%= m.getProfilePicture() != null && !m.getProfilePicture().isEmpty() ? m.getProfilePicture() : "images/default-avatar.png" %>" 
                 class="rounded-circle me-4" alt="Avatar" width="100" height="100">

            <div>
                <h2 class="text-success mb-1"><%= m.getFullName() %></h2>
                <h5 class="text-muted"><%= m.getRole() %></h5>
                <span class="badge <%= m.isIsActive() ? "bg-success" : "bg-danger" %>">
                    <%= m.isIsActive() ? "🟢 Active" : "🔴 Banned" %>
                </span>
            </div>
        </div>
    </div>

    <!-- Profile details -->
    <div class="row g-4">
        <!-- Left column -->
        <div class="col-md-6">
            <div class="card border-success shadow-sm">
                <div class="card-header bg-success text-white">
                    Thông tin cá nhân
                </div>
                <div class="card-body">
                    <ul class="list-unstyled mb-0">
                        <li><strong>Email:</strong> <%= m.getEmail() %></li>
                        <li><strong>Điện thoại:</strong> <%= m.getPhone() %></li>
                        <li><strong>Địa chỉ:</strong> <%= m.getAddress() %></li>
                        <li><strong>Ngày sinh:</strong> <%= m.getDateOfBirth() %></li>
                        <li><strong>Giới tính:</strong> <%= m.getGender() %></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Right column -->
        <div class="col-md-6">
            <div class="card border-success shadow-sm">
                <div class="card-header bg-success text-white">
                    Thông tin tài khoản
                </div>
                <div class="card-body">
                    <ul class="list-unstyled mb-3">
                        <li><strong>Username:</strong> <%= m.getUsername() %></li>
                        <li><strong>Role:</strong> <%= m.getRole() %></li>
                        <li><strong>Trạng thái:</strong> 
                            <%= m.isIsActive() ? "Đang hoạt động" : "Đã khóa" %>
                        </li>
                    </ul>
                    <div class="text-muted small">
                        <div>Created at: <%= m.getCreatedAt() %></div>
                        <div>Updated at: <%= m.getUpdatedAt() %></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
