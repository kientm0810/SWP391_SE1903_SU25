<!-- admin_saler_add_blog.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Blog - Admin Panel</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Create New Blog Post</h1>
                <div class="header-actions">
                    <a href="AdminSalerController?target=blog" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="form-container">
                <form action="AdminSalerController" method="post">
                    <div class="form-group">
                        <label>Title</label>
                        <input name="title" type="text" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Thumbnail URL</label>
                        <textarea name="thumbnail" class="form-control" rows="2"></textarea>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" id="default" class="form-control" rows="6"></textarea>
                    </div>

                    <input type="hidden" name="target" value="blog">
                    <input type="hidden" name="service" value="Add">

                    <div class="form-actions">
                        <button type="submit" name="submit" value="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Create Blog
                        </button>
                        <a href="AdminSalerController?target=blog" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- TinyMCE -->
    <script src="./tinymce/tinymce.min.js"></script>
    <script src="./assets/js/tinymceConfig.js"></script>
    <script src="./assets/js/tinymceConfigThumbnailBlog.js"></script>
    
    <style>
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
    </style>
</body>
</html>