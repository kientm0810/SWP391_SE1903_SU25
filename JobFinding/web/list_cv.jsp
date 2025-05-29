<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>My CVs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card { border: 1px solid #28a745; }
        .btn-primary { background-color: #28a745; border-color: #28a745; }
        .btn-primary:hover { background-color: #218838; border-color: #218838; }
        .search-form { max-width: 400px; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h1>My CVs</h1>
        <div class="d-flex justify-content-between mb-3">
            <div>
                <a href="create_cv" class="btn btn-primary">Create New CV</a>
                <a href="home" class="btn btn-secondary">Back</a>
            </div>
            <form action="list_cv" method="post" class="search-form">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" placeholder="Search by name or position" 
                           value="${searchTerm}" aria-label="Search CVs">
                    <button class="btn btn-primary" type="submit">Search</button>
                </div>
            </form>
        </div>
        <c:if test="${not empty cvs}">
            <div class="row">
                <c:forEach var="cv" items="${cvs}">
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">${cv.fullName}</h5>
                                <p class="card-text"><strong>Position:</strong> ${cv.jobPosition}</p>
                                <a href="update_cv?cvId=${cv.id}" class="btn btn-primary">Edit CV</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty cvs}">
            <p>No CVs found. Create one now!</p>
        </c:if>
    </div>
</body>
</html>