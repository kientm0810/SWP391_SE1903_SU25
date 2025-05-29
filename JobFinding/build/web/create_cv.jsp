<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Create CV</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container { background-color: #f8f9fa; padding: 20px; border-radius: 8px; border: 1px solid #28a745; }
        .btn-primary { background-color: #28a745; border-color: #28a745; }
        .btn-primary:hover { background-color: #218838; border-color: #218838; }
        label { font-weight: bold; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h1>Create CV</h1>
        <c:if test="${not empty error}">
            <p class="text-danger">${error}</p>
        </c:if>
        <div class="form-container">
            <form action="create_cv" method="post">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                </div>
                <div class="mb-3">
                    <label for="jobPosition" class="form-label">Job Position</label>
                    <input type="text" class="form-control" id="jobPosition" name="jobPosition" required>
                </div>
                <h5>Personal Information</h5>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" class="form-control" id="phone" name="phone">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="address">
                </div>
                <div class="mb-3">
                    <label for="certificates" class="form-label">Certificates</label>
                    <textarea class="form-control" id="certificates" name="certificates" rows="4"></textarea>
                </div>
                <div class="mb-3">
                    <label for="workExperience" class="form-label">Work Experience</label>
                    <textarea class="form-control" id="workExperience" name="workExperience" rows="4"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Save CV</button>
                <a href="list_cv" class="btn btn-secondary">Back</a>
            </form>
        </div>
    </div>
</body>
</html>