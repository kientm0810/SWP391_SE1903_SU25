<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Banner</title>
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
    <a href="AdminSalerController?target=banner&service=List" class="btn btn-outline-success mb-3">← Back to List Banners</a>

    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">📸 Create New Banner</h4>
        </div>
        <div class="card-body">
            <form action="AdminSalerController" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input name="title" type="text" class="form-control" id="title" required>
                </div>

                <div class="mb-3">
                    <label for="image_url" class="form-label">Image URL</label> <br/>
                    <input type="file" name="file" accept="image/*" required />
                </div>

                <div class="mb-3">
                    <label for="redirect_url" class="form-label">Redirect URL</label>
                    <input name="redirect_url" type="url" class="form-control" id="redirect_url">
                </div>

                <div class="mb-3">
                    <label for="position" class="form-label">Position</label>
                    <input name="position" type="number" class="form-control" id="position" min="1" required>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="is_active" id="is_active" checked>
                    <label class="form-check-label" for="is_active">
                        Active
                    </label>
                </div>

                <input type="hidden" name="target" value="banner">
                <input type="hidden" name="service" value="Add">

                <button type="submit" name="submit" value="submit" class="btn btn-green">Submit</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
