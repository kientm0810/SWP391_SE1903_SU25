<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, models.Recruiter" %>
<%
    Vector<Recruiter> vec = (Vector<Recruiter>) request.getAttribute("vec");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Management</title>
    <link rel="stylesheet" href="assets/css/admin_manage_recruiter.css">
</head>
<body>
    <div class="container">
        <a href="admin_dashboard.jsp" class="back-link">← Back to Dashboard</a>
        <h1>Manage Recruiters</h1>

        <form action="AdminController" method="post" class="search-form">
            <div class="form-group">
                <label>ID:</label>
                <input type="number" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">
            </div>
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="text" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            </div>
            <div class="form-group">
                <label>Phone:</label>
                <input type="text" name="phone" value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
            </div>
            <div class="form-group">
                <label>Company Name:</label>
                <input type="text" name="companyName" value="<%= request.getParameter("companyName") != null ? request.getParameter("companyName") : "" %>">
            </div>
            <div class="form-group">
                <label>Company Address:</label>
                <input type="text" name="companyAddress" value="<%= request.getParameter("companyAddress") != null ? request.getParameter("companyAddress") : "" %>">
            </div>
            <div class="form-group">
                <label>Company Size:</label>
                <input type="text" name="companySize" value="<%= request.getParameter("companySize") != null ? request.getParameter("companySize") : "" %>">
            </div>
            <div class="form-group">
                <label>Industry:</label>
                <input type="text" name="industry" value="<%= request.getParameter("industry") != null ? request.getParameter("industry") : "" %>">
            </div>
            <div class="form-group">
                <label>Loyalty Score:</label>
                <input type="number" step="0.1" name="loyaltyScore" value="<%= request.getParameter("loyaltyScore") != null ? request.getParameter("loyaltyScore") : "" %>">
            </div>
            <div class="form-group">
                <label>Verification Status:</label>
                <select name="verificationStatus">
                    <option value="" <%= request.getParameter("verificationStatus") == null || request.getParameter("verificationStatus").isEmpty() ? "selected" : "" %>>--Select--</option>
                    <option value="pending" <%= "pending".equals(request.getParameter("verificationStatus")) ? "selected" : "" %>>Pending</option>
                    <option value="verified" <%= "verified".equals(request.getParameter("verificationStatus")) ? "selected" : "" %>>Verified</option>
                    <option value="rejected" <%= "rejected".equals(request.getParameter("verificationStatus")) ? "selected" : "" %>>Rejected</option>
                </select>
            </div>
            <div class="form-group">
                <label>Status:</label>
                <select name="isActive">
                    <option value="" <%= request.getParameter("isActive") == null || request.getParameter("isActive").isEmpty() ? "selected" : "" %>>--Select--</option>
                    <option value="true" <%= "true".equals(request.getParameter("isActive")) ? "selected" : "" %>>Active</option>
                    <option value="false" <%= "false".equals(request.getParameter("isActive")) ? "selected" : "" %>>Banned</option>
                </select>
            </div>
            <div class="form-actions">
                <input type="submit" name="submit" value="Search" class="btn">
                <input type="reset" value="Reset" class="btn btn-secondary">
                <input type="hidden" name="service" value="list">
                <input type="hidden" name="target" value="Recruiter">
            </div>
        </form>

        <table class="recruiter-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Logo</th>
                    <th>Company</th>
                    <th>Loyalty</th>
                    <th>Verification</th>
                    <th>Detail</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Recruiter i : vec) { %>
                <tr>
                    <td><%= i.getId() %></td>
                    <td><img src="<%= i.getLogo() %>" alt="Logo" class="logo"></td>
                    <td><%= i.getCompanyName() %></td>
                    <td><%= i.getLoyaltyScore() %></td>
                    <td>
                        <form action="AdminController" method="post">
                            <input type="hidden" name="target" value="Recruiter">
                            <input type="hidden" name="service" value="UpdateVerificationStatus">
                            <input type="hidden" name="id" value="<%= i.getId() %>">
                            <select name="verificationStatus">
                                <option value="pending" <%= "pending".equals(i.getVerificationStatus()) ? "selected" : "" %>>Pending</option>
                                <option value="verified" <%= "verified".equals(i.getVerificationStatus()) ? "selected" : "" %>>Verified</option>
                                <option value="rejected" <%= "rejected".equals(i.getVerificationStatus()) ? "selected" : "" %>>Rejected</option>
                            </select>
                            <input type="submit" value="Update" class="btn-small">
                            <input type="hidden" name="email" value="<%= i.getEmail()%>" class="btn-small">
                        </form>
                    </td>
                    <td>
                        <a href="AdminController?target=Recruiter&service=Detail&ID=<%= i.getId() %>" class="btn-link">View</a>
                    </td>
                    <td>
                        <a href="AdminController?target=Recruiter&service=Ban&ID=<%= i.getId() %>&status=<%= i.isActive() %>" class="btn-link">
                            <%= i.isActive() ? "Ban" : "Reassign" %>
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <p><a href="AdminController?target=Recruiter&service=Add" class="add-link">+ Add Recruiter</a></p>
    </div>
</body>
</html>