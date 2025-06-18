<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Blog</title>
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
            <h4 class="mb-0">📝 Create New Blog</h4>
        </div>
        <div class="card-body">
            <form action="AdminSalerController" method="post">
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input name="title" type="text" class="form-control" id="title" required>
                </div>

                <div class="mb-3">
                    <label for="thumbnail" class="form-label">Thumbnail URL</label>
                    <textarea name="thumbnail" class="form-control" id="thumbnail"></textarea>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea name="description" id="default" class="form-control" rows="6"></textarea>
                </div>

                <input type="hidden" name="target" value="blog">
                <input type="hidden" name="service" value="Add">

                <button type="submit" name="submit" value="submit" class="btn btn-green">Submit</button>
            </form>
        </div>
    </div>
</div>

<!-- TinyMCE -->
<script src="./tinymce/tinymce.min.js"></script>
<script src="./assets/js/tinymceConfig.js"></script>
<script src="./assets/js/tinymceConfigThumbnailBlog.js"></script>

</body>
</html>
