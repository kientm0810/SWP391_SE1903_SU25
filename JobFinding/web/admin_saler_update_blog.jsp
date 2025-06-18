<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Blog"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Blog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-green {
            background-color: #28a745;
            color: white;
        }
        .btn-green:hover {
            background-color: #218838;
        }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5">
    <a href="AdminSalerController?target=blog" class="btn btn-outline-success mb-4">← Back to Blog List</a>

    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Update Blog</h4>
        </div>
        <div class="card-body">
            <form action="AdminSalerController" method="post">
                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <input name="title" type="text" class="form-control" value="${blog.title}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Thumbnail URL</label>
                    <input name="thumbnail" type="text" class="form-control" value="${blog.thumbnail}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea id="default" name="description" class="form-control" rows="6" required>${blog.description}</textarea>
                </div>

                <div class="d-flex justify-content-between">
                    <input type="hidden" name="target" value="blog">
                    <input type="hidden" name="service" value="Update">
                    <input type="hidden" name="blogId" value="${blog.id}">

                    <button type="submit" name="submit" value="submit" class="btn btn-green">✅ Update Blog</button>
                    <a href="AdminSalerController?target=blog" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- TinyMCE + Bootstrap JS (if needed) -->
<script src="./tinymce/tinymce.min.js"></script>
<script src="./assets/js/tinymceConfig.js"></script>
</body>
</html>
