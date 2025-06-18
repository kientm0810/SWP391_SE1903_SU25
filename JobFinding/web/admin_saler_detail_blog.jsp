<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="models.Blog"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detail Blog</title>
    <meta charset="UTF-8">
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
    <a href="AdminSalerController?target=blog" class="btn btn-outline-success mb-3">← Back to List Blogs</a>

    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">${blog.title}</h4>
        </div>
        <div class="card-body">
            <div class="mb-4">
                <h6 class="text-muted">Blog Description</h6>
                <p>${blog.description}</p>
            </div>

            <div class="d-flex gap-3">
                <form action="AdminSalerController" method="post">
                    <input type="hidden" name="target" value="blog" />
                    <input type="hidden" name="service" value="Update" />
                    <input type="hidden" name="blogId" value="${blog.id}" />
                    <button type="submit" class="btn btn-green">✏️ Update Blog</button>
                </form>

                <form action="AdminSalerController" method="post" onsubmit="return confirm('Are you sure you want to delete this blog?');">
                    <input type="hidden" name="target" value="blog" />
                    <input type="hidden" name="service" value="Delete" />
                    <input type="hidden" name="blogId" value="${blog.id}" />
                    <button type="submit" class="btn btn-danger">🗑️ Delete Blog</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
