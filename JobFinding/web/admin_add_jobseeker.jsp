<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add JobSeeker</title>
    <link rel="stylesheet" href="assets/css/admin_add_jobseeker.css">
</head>
<body>
    <div class="container">
        <a href="AdminController?target=JobSeeker" class="btn back-btn">← Back to List JobSeekers</a>
        <h1>Add New JobSeeker</h1>
        <form action="AdminController" method="POST" class="jobseeker-form">
            <div class="form-grid">
                <div class="form-group"><label>Username:</label><input type="text" name="username"></div>
                <div class="form-group"><label>Password:</label><input type="text" name="password"></div>
                <div class="form-group"><label>Email:</label><input type="text" name="email"></div>
                <div class="form-group"><label>Full Name:</label><input type="text" name="fullName"></div>
                <div class="form-group"><label>Phone:</label><input type="text" name="phone"></div>
                <div class="form-group"><label>Date of Birth:</label><input type="date" name="dateOfBirth"></div>
                <div class="form-group">
                    <label>Gender:</label>
                    <select name="gender">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </div>
                <div class="form-group"><label>Address:</label><input type="text" name="address"></div>
                <div class="form-group"><label>Profile Picture:</label><input type="text" name="profilePicture"></div>
                <div class="form-group"><label>CV File:</label><input type="text" name="cvFile"></div>
                <div class="form-group"><label>Skills:</label><input type="text" name="skills"></div>
                <div class="form-group"><label>Experience Years:</label><input type="text" name="experienceYears"></div>
                <div class="form-group"><label>Education:</label><input type="text" name="education"></div>
                <div class="form-group"><label>Desired Job Title:</label><input type="text" name="desiredJobTitle"></div>
                <div class="form-group"><label>Desired Salary:</label><input type="text" name="desiredSalary"></div>
                <div class="form-group"><label>Job Category:</label><input type="text" name="jobCategory"></div>
                <div class="form-group"><label>Preferred Location:</label><input type="text" name="preferredLocation"></div>
                <div class="form-group"><label>Career Level:</label><input type="text" name="careerLevel"></div>
                <div class="form-group"><label>Work Type:</label><input type="text" name="workType"></div>
                <div class="form-group"><label>Profile Summary:</label><input type="text" name="profileSummary"></div>
                <div class="form-group"><label>Portfolio URL:</label><input type="text" name="portfolioUrl"></div>
                <div class="form-group"><label>Languages:</label><input type="text" name="languages"></div>
                <div class="form-group"><label>Created At:</label><input type="date" name="createdAt"></div>
                <div class="form-group"><label>Updated At:</label><input type="date" name="updatedAt"></div>
                <div class="form-group">
                    <label>Status:</label>
                    <div class="radio-group">
                        <label><input type="radio" name="isActive" value="true" checked> Active</label>
                        <label><input type="radio" name="isActive" value="false"> DeActive</label>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <input type="submit" name="submit" value="Add JobSeeker" class="btn submit-btn">
                <input type="reset" value="Reset" class="btn reset-btn">
                <input type="hidden" name="service" value="Add">
                <input type="hidden" name="target" value="JobSeeker">
            </div>
        </form>
    </div>
</body>
</html>
