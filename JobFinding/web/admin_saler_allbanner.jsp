<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="models.Banner"%>
<%
    Vector<Banner> banners = (Vector<Banner>) request.getAttribute("banners");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Banner Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-green {
            background-color: #28a745;
            color: white;
        }
        .btn-green:hover {
            background-color: #218838;
        }
        .table thead {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body class="bg-light">

<div class="container py-4">
    <a href="admin_saler_dashboard.jsp" class="btn btn-outline-success mb-3">← Back to Dashboard</a>

    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">🔍 Search Banner</h4>
        </div>
        <div class="card-body">
            <form class="row g-3" action="AdminSalerController" method="post">
                <div class="col-md-4">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" name="title" id="title" class="form-control" />
                </div>
                <div class="col-md-3">
                    <label for="status" class="form-label">Status</label>
                    <select name="status" id="status" class="form-select">
                        <option value="draft">Draft</option>
                        <option value="published">Published</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="admin_id" class="form-label">Admin ID</label>
                    <input type="number" name="admin_id" id="admin_id" class="form-control" min="1"/>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <input type="hidden" name="action" value="searchBlog" />
                    <button type="submit" class="btn btn-green w-100">Search</button>
                </div>
            </form>
        </div>
    </div>
    
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">📸 All Banners</h4>
            <a href="AdminSalerController?target=banner&service=Add" class="btn btn-light">+ Add New Blog</a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Admin ID</th>
                            <th>Title</th>
                            <th>Image</th>
                            <th>Redirect URL</th>
                            <th>Position</th>
                            <th>Active</th>
                            <th>Created At</th>
                            <th colspan="3" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (banners != null && !banners.isEmpty()) {
                                for (Banner banner : banners) {
                        %>
                        <tr>
                            <td><%= banner.getId() %></td>
                            <td><%= banner.getAdmin_id() %></td>
                            <td><%= banner.getTitle() %></td>
                            <td>
                                <img src="<%= banner.getImage_url() %>" alt="Banner" width="100" class="img-thumbnail">
                            </td>
                            <td><a href="<%= banner.getRedirect_url() %>" target="_blank"><%= banner.getRedirect_url() %></a></td>
                            <td><%= banner.getPosition() %></td>
                            <td><%= banner.isIs_active() ? "✔" : "✘" %></td>
                            <td><%= banner.getCreated_at() %></td>
                            <td>
                                <form action="AdminSalerController" method="post">
                                    <input type="hidden" name="target" value="banner" />
                                    <input type="hidden" name="service" value="Detail" />
                                    <input type="hidden" name="bannerId" value="<%= banner.getId() %>" />
                                    <button type="submit" class="btn btn-sm btn-outline-success">View</button>
                                </form>
                            </td>
                            <td>
                                <form action="AdminSalerController" method="post">
                                    <input type="hidden" name="target" value="banner" />
                                    <input type="hidden" name="service" value="Update" />
                                    <input type="hidden" name="bannerId" value="<%= banner.getId() %>" />
                                    <button type="submit" class="btn btn-sm btn-warning text-white">Edit</button>
                                </form>
                            </td>
                            <td>
                                <form action="AdminSalerController" method="post" onsubmit="return confirm('Are you sure you want to delete this banner?');">
                                    <input type="hidden" name="target" value="banner" />
                                    <input type="hidden" name="service" value="Delete" />
                                    <input type="hidden" name="bannerId" value="<%= banner.getId() %>" />
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="11" class="text-center text-muted">No banners found.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
