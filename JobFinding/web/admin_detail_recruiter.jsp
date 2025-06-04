<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Recruiter"%>
<!DOCTYPE html>
<html>
<%
    Recruiter p = (Recruiter) request.getAttribute("Recruiter");
%>
<head>
    <meta charset="UTF-8">
    <title>Recruiter Profile</title>
    <link rel="stylesheet" href="assets/css/admin_detail_recruiter.css">
</head>
<body>
    <div class="container">
        <a class="back-link" href="AdminController?target=Recruiter">← Back to List Recruiters</a>
        <h1>Recruiter Profile</h1>

        <!-- Thông tin cá nhân -->
        <section class="section">
            <h2>Personal Information</h2>
            <table class="detail-table">
                <tr><th>ID</th><td><%= p.getId() %></td></tr>
                <tr><th>Username</th><td><%= p.getUsername() %></td></tr>
                <tr><th>Password</th><td><%= p.getPassword() %></td></tr>
                <tr><th>Email</th><td><%= p.getEmail() %></td></tr>
                <tr><th>Full Name</th><td><%= p.getFullName() %></td></tr>
                <tr><th>Phone</th><td><%= p.getPhone() %></td></tr>
                <tr><th>Date of Birth</th><td><%= p.getDateOfBirth() %></td></tr>
                <tr><th>Gender</th><td><%= p.getGender() %></td></tr>
                <tr><th>Address</th><td><%= p.getAddress() %></td></tr>
                <tr>
                    <th>Profile Picture</th>
                    <td><img src="<%= p.getProfilePicture() %>" alt="Profile Picture" class="profile-img"></td>
                </tr>
            </table>
        </section>

        <!-- Thông tin công ty -->
        <section class="section">
            <h2>Company Information</h2>
            <table class="detail-table">
                <tr><th>Company Name</th><td><%= p.getCompanyName() %></td></tr>
                <tr><th>Description</th><td><%= p.getCompanyDescription() %></td></tr>
                <tr>
                    <th>Logo</th>
                    <td><img src="<%= p.getLogo() %>" alt="Company Logo" class="logo-img"></td>
                </tr>
                <tr><th>Website</th><td><a href="<%= p.getWebsite() %>" target="_blank"><%= p.getWebsite() %></a></td></tr>
                <tr><th>Address</th><td><%= p.getCompanyAddress() %></td></tr>
                <tr><th>Size</th><td><%= p.getCompanySize() %></td></tr>
                <tr><th>Industry</th><td><%= p.getIndustry() %></td></tr>
                <tr><th>Tax Code</th><td><%= p.getTaxCode() %></td></tr>
                <tr><th>Loyalty Score</th><td><%= p.getLoyaltyScore() %></td></tr>
                <tr><th>Verification</th><td><%= p.getVerificationStatus() %></td></tr>
                <tr><th>Created At</th><td><%= p.getCreatedAt() %></td></tr>
                <tr><th>Updated At</th><td><%= p.getUpdatedAt() %></td></tr>
                <tr><th>Status</th><td><%= p.isActive() ? "Active" : "Banned" %></td></tr>
            </table>
        </section>
    </div>
</body>
</html>
