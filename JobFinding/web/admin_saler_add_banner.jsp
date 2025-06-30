<!-- admin_saler_add_banner.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Banner - Admin Panel</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Create New Banner</h1>
                <div class="header-actions">
                    <a href="AdminSalerController?target=banner" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Back to List
                    </a>
                </div>
            </div>
            
            <div class="form-container">
                <form action="AdminSalerController" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>Title</label>
                        <input name="title" type="text" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Image Upload</label>
                        <input type="file" name="file" accept="image/*" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Redirect URL</label>
                        <input name="redirect_url" type="url" class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Position</label>
                        <input name="position" type="number" class="form-control" min="1" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="is_active" checked>
                            <span>Active</span>
                        </label>
                    </div>
                    
                    <input type="hidden" name="target" value="banner">
                    <input type="hidden" name="service" value="Add">
                    
                    <div class="form-actions">
                        <button type="submit" name="submit" value="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Create Banner
                        </button>
                        <a href="AdminSalerController?target=banner" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <style>
        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
    </style>
</body>
</html>