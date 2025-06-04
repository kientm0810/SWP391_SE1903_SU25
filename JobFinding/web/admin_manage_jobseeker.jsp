<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, models.JobSeeker" %>
<%
    Vector<JobSeeker> vec = (Vector<JobSeeker>)request.getAttribute("vec");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage JobSeekers</title>
    <link rel="stylesheet" href="assets/css/admin_manage_jobseeker.css">
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <a href="admin_dashboard.jsp" class="btn back-btn">← Back to Dashboard</a>
        </div>

        <h1>Quản lý JobSeekers</h1>

        <form action="AdminController" method="post" class="search-form">
            <div class="form-group">
                <label>ID:</label>
                <input type="number" name="id" value="<%=request.getParameter("id") != null ? request.getParameter("id") : ""%>">
            </div>
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" value="<%=request.getParameter("username") != null ? request.getParameter("username") : ""%>">
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="text" name="email" value="<%=request.getParameter("email") != null ? request.getParameter("email") : ""%>">
            </div>
            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="fullName" value="<%=request.getParameter("fullName") != null ? request.getParameter("fullName") : ""%>">
            </div>
            <div class="form-group">
                <label>Phone:</label>
                <input type="text" name="phone" value="<%=request.getParameter("phone") != null ? request.getParameter("phone") : ""%>">
            </div>
            <div class="form-group">
                <label>Gender:</label>
                <select name="gender">
                    <option value="">--Select--</option>
                    <option value="male" <%= "male".equals(request.getParameter("gender")) ? "selected" : "" %>>Male</option>
                    <option value="female" <%= "female".equals(request.getParameter("gender")) ? "selected" : "" %>>Female</option>
                    <option value="other" <%= "other".equals(request.getParameter("gender")) ? "selected" : "" %>>Other</option>
                </select>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" value="<%=request.getParameter("address") != null ? request.getParameter("address") : ""%>">
            </div>
            <div class="form-group">
                <label>Experience Years:</label>
                <input type="number" name="experienceYears" value="<%=request.getParameter("experienceYears") != null ? request.getParameter("experienceYears") : ""%>">
            </div>
            <div class="form-group">
                <label>Education:</label>
                <input type="text" name="education" value="<%=request.getParameter("education") != null ? request.getParameter("education") : ""%>">
            </div>
            <div class="form-group">
                <label>Desired Salary:</label>
                <input type="number" name="desiredSalary" value="<%=request.getParameter("desiredSalary") != null ? request.getParameter("desiredSalary") : ""%>">
            </div>
            <div class="form-group">
                <label>Job Category:</label>
                <input type="text" name="jobCategory" value="<%=request.getParameter("jobCategory") != null ? request.getParameter("jobCategory") : ""%>">
            </div>
            <div class="form-group">
                <label>Languages:</label>
                <input type="text" name="languages" value="<%=request.getParameter("languages") != null ? request.getParameter("languages") : ""%>">
            </div>
            <div class="form-group">
                <label>Active:</label>
                <select name="isActive">
                    <option value="">--Select--</option>
                    <option value="true" <%= "true".equals(request.getParameter("isActive")) ? "selected" : "" %>>Active</option>
                    <option value="false" <%= "false".equals(request.getParameter("isActive")) ? "selected" : "" %>>Banned</option>
                </select>
            </div>

            <div class="form-actions">
                <input type="submit" name="submit" value="Search">
                <input type="reset" value="Reset">
                <input type="hidden" name="service" value="list">
                <input type="hidden" name="target" value="JobSeeker">
            </div>
        </form>

        <table class="jobseeker-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Profile Picture</th>
                    <th>Full Name</th>
                    <th>View</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (JobSeeker i : vec) { %>
                    <tr>
                        <td><%= i.getId() %></td>
                        <td><img src="<%= i.getProfilePicture() %>" alt="Profile" class="profile-pic"></td>
                        <td><%= i.getFullName() %></td>
                        <td>
                            <a class="btn view" href="AdminController?target=JobSeeker&service=Detail&ID=<%= i.getId() %>">View</a>
                        </td>
                        <td>
                            <a class="btn <%= i.isActive() ? "ban" : "reassign" %>" href="AdminController?target=JobSeeker&service=Ban&ID=<%= i.getId() %>&status=<%= i.isActive() %>">
                                <%= i.isActive() ? "Ban" : "Reassign" %>
                            </a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <div class="add-link">
            <a href="AdminController?target=JobSeeker&service=Add">+ Add New JobSeeker</a>
        </div>
    </div>
</body>
</html>