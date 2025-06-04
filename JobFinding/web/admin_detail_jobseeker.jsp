<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.JobSeeker" %>
<!DOCTYPE html>
<html>
<% JobSeeker p = (JobSeeker) request.getAttribute("JobSeeker"); %>
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Profile</title>
    <link rel="stylesheet" href="assets/css/admin_detail_jobseeker.css">
</head>
<body>
    <div class="container">
        <a class="back-link" href="AdminController?target=JobSeeker">← Back to List JobSeekers</a>

        <div class="profile-header">
            <img class="avatar" src="<%= p.getProfilePicture() != null && !p.getProfilePicture().isEmpty() ? p.getProfilePicture() : "images/default-avatar.png" %>" alt="Avatar">
            <div class="basic-info">
                <h1><%= p.getFullName() %></h1>
                <h2><%= p.getDesiredJobTitle() %></h2>
                <p class="status <%= p.isActive() ? "active" : "banned" %>">
                    <%= p.isActive() ? "🟢 Active" : "🔴 Banned" %>
                </p>
            </div>
        </div>

        <div class="profile-body">
            <div class="left-column">
                <h3>Thông tin liên hệ</h3>
                <ul>
                    <li><strong>Email:</strong> <%= p.getEmail() %></li>
                    <li><strong>Điện thoại:</strong> <%= p.getPhone() %></li>
                    <li><strong>Địa chỉ:</strong> <%= p.getAddress() %></li>
                    <li><strong>Ngày sinh:</strong> <%= p.getDateOfBirth() %></li>
                    <li><strong>Giới tính:</strong> <%= p.getGender() %></li>
                </ul>

                <h3>Tài liệu</h3>
                <ul>
                    <li><strong>CV:</strong> <a href="<%= p.getCvFile() %>" target="_blank">Xem CV 📄</a></li>
                    <li><strong>Portfolio:</strong> <a href="<%= p.getPortfolioUrl() %>" target="_blank">Xem Portfolio 🌐</a></li>
                </ul>
            </div>

            <div class="right-column">
                <h3>Thông tin nghề nghiệp</h3>
                <ul>
                    <li><strong>Kinh nghiệm:</strong> <%= p.getExperienceYears() %> năm</li>
                    <li><strong>Học vấn:</strong> <%= p.getEducation() %></li>
                    <li><strong>Kỹ năng:</strong> <%= p.getSkills() %></li>
                    <li><strong>Mức lương mong muốn:</strong> <%= p.getDesiredSalary() %></li>
                    <li><strong>Ngành nghề:</strong> <%= p.getJobCategory() %></li>
                    <li><strong>Khu vực:</strong> <%= p.getPreferredLocation() %></li>
                    <li><strong>Cấp bậc:</strong> <%= p.getCareerLevel() %></li>
                    <li><strong>Hình thức:</strong> <%= p.getWorkType() %></li>
                    <li><strong>Ngôn ngữ:</strong> <%= p.getLanguages() %></li>
                </ul>

                <h3>Giới thiệu bản thân</h3>
                <p><%= p.getProfileSummary() %></p>

                <div class="meta">
                    <small>Created at: <%= p.getCreatedAt() %></small><br>
                    <small>Updated at: <%= p.getUpdatedAt() %></small>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
