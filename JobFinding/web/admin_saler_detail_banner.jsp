<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Banner"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Banner Detail</title>
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
    <a href="AdminSalerController?target=banner" class="btn btn-outline-success mb-3">← Back to List Banners</a>

    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">${banner.title}</h4>
        </div>
        <div class="card-body">
            <div class="mb-3">
                <h6 class="text-muted">Redirect URL:</h6>
                <p><a href="${banner.redirect_url}" target="_blank">${banner.redirect_url}</a></p>
            </div>

            <div class="mb-3">
                <h6 class="text-muted">Image Preview:</h6>
                <img src="${banner.image_url}" alt="Banner Image" class="img-fluid rounded shadow-sm" style="max-height: 250px;">
            </div>

            <div class="mb-3">
                <h6 class="text-muted">Position:</h6>
                <p>${banner.position}</p>
            </div>

            <div class="mb-3">
                <h6 class="text-muted">Active:</h6>
                <p>${banner.is_active ? "Yes" : "No"}</p>
            </div>

            <div class="mb-3">
                <h6 class="text-muted">Created At:</h6>
                <p>${banner.created_at}</p>
            </div>

            <div class="d-flex gap-3">
                <form action="AdminSalerController" method="post">
                    <input type="hidden" name="target" value="banner" />
                    <input type="hidden" name="service" value="Update" />
                    <input type="hidden" name="bannerId" value="${banner.id}" />
                    <button type="submit" class="btn btn-green">✏️ Update Banner</button>
                </form>

                <form action="AdminSalerController" method="post" onsubmit="return confirm('Are you sure you want to delete this banner?');">
                    <input type="hidden" name="target" value="banner" />
                    <input type="hidden" name="service" value="Delete" />
                    <input type="hidden" name="bannerId" value="${banner.id}" />
                    <button type="submit" class="btn btn-danger">🗑️ Delete Banner</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
