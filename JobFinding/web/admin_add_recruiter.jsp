<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Recruiter</title>
    <link rel="stylesheet" href="assets/css/admin_add_recruiter.css">
</head>
<body>
    <div class="form-container">
        <a class="back-link" href="AdminController?target=Recruiter">← Back to List Recruiters</a>
        <h1>Add New Recruiter</h1>
        <form action="AdminController" method="POST">
            <div class="form-section">
                <h2>Personal Info</h2>
                <div class="form-group"><label>Username</label><input type="text" name="username"></div>
                <div class="form-group"><label>Password</label><input type="text" name="password"></div>
                <div class="form-group"><label>Email</label><input type="text" name="email"></div>
                <div class="form-group"><label>Full Name</label><input type="text" name="fullName"></div>
                <div class="form-group"><label>Phone</label><input type="text" name="phone"></div>
                <div class="form-group"><label>Date of Birth</label><input type="date" name="dateOfBirth"></div>
                <div class="form-group">
                    <label>Gender</label>
                    <select name="gender">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </div>
                <div class="form-group"><label>Address</label><input type="text" name="address"></div>
                <div class="form-group"><label>Profile Picture (URL)</label><input type="text" name="profilePicture"></div>
            </div>

            <div class="form-section">
                <h2>Company Info</h2>
                <div class="form-group"><label>Company Name</label><input type="text" name="companyName"></div>
                <div class="form-group"><label>Company Description</label><input type="text" name="companyDescription"></div>
                <div class="form-group"><label>Logo (URL)</label><input type="text" name="logo"></div>
                <div class="form-group"><label>Website</label><input type="text" name="website"></div>
                <div class="form-group"><label>Company Address</label><input type="text" name="companyAddress"></div>
                <div class="form-group"><label>Company Size</label><input type="text" name="companySize"></div>
                <div class="form-group"><label>Industry</label><input type="text" name="industry"></div>
                <div class="form-group"><label>Tax Code</label><input type="text" name="taxCode"></div>
                <div class="form-group"><label>Loyalty Score</label><input type="text" name="loyaltyScore"></div>
                <div class="form-group"><label>Verification Status</label><input type="text" name="verificationStatus"></div>
            </div>

            <div class="form-section">
                <h2>System Info</h2>
                <div class="form-group"><label>Created At</label><input type="date" name="createdAt"></div>
                <div class="form-group"><label>Updated At</label><input type="date" name="updatedAt"></div>
                <div class="form-group">
                    <label>Status</label>
                    <label><input type="radio" name="isActive" value="true" checked> Active</label>
                    <label><input type="radio" name="isActive" value="false"> DeActive</label>
                </div>
            </div>

            <div class="form-actions">
                <input type="submit" value="Add Recruiter" class="btn-green">
                <input type="reset" value="Reset" class="btn-gray">
                <input type="hidden" name="service" value="Add">
                <input type="hidden" name="target" value="Recruiter">
            </div>
        </form>
    </div>
</body>
</html>
