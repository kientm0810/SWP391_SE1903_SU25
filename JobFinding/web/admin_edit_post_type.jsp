<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Chỉnh sửa Loại Bài đăng - Admin Dashboard</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                .form-section {
                    background: #f8f9fa;
                    border-radius: 10px;
                    padding: 20px;
                    margin-bottom: 20px;
                }

                .icon-preview {
                    font-size: 2em;
                    text-align: center;
                    padding: 20px;
                    border: 2px dashed #dee2e6;
                    border-radius: 10px;
                    margin-top: 10px;
                }

                .color-preview {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    border: 3px solid #fff;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                }

                .current-info {
                    background: #e3f2fd;
                    border-left: 4px solid #2196f3;
                    padding: 15px;
                    margin-bottom: 20px;
                    border-radius: 5px;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- Sidebar -->
                    <nav class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                        <div class="position-sticky pt-3">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="admin_dashboard.jsp">
                                        <i class="fas fa-tachometer-alt"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="admin_post_types.jsp">
                                        <i class="fas fa-tags"></i> Loại Bài đăng
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="admin_blog_types.jsp">
                                        <i class="fas fa-blog"></i> Loại Blog
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </nav>

                    <!-- Main content -->
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">
                                <i class="fas fa-edit text-warning"></i> Chỉnh sửa Loại Bài đăng
                            </h1>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <a href="admin_post_types.jsp" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>

                        <!-- Current Information -->
                        <c:if test="${not empty postType}">
                            <div class="current-info">
                                <h6 class="mb-2">
                                    <i class="fas fa-info-circle"></i> Thông tin hiện tại
                                </h6>
                                <div class="row">
                                    <div class="col-md-3">
                                        <strong>Mã Code:</strong> <code>${postType.typeCode}</code>
                                    </div>
                                    <div class="col-md-3">
                                        <strong>Tên:</strong> ${postType.typeName}
                                    </div>
                                    <div class="col-md-3">
                                        <strong>Danh mục:</strong>
                                        <span class="badge bg-secondary">${postType.category}</span>
                                    </div>
                                    <div class="col-md-3">
                                        <strong>Trạng thái:</strong>
                                        <c:choose>
                                            <c:when test="${postType.active}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty postType}">
                            <form action="content-type/post-types?action=update" method="POST" id="editPostTypeForm">
                                <input type="hidden" name="id" value="${postType.id}">

                                <div class="row">
                                    <!-- Basic Information -->
                                    <div class="col-md-8">
                                        <div class="form-section">
                                            <h5 class="mb-3">
                                                <i class="fas fa-info-circle text-primary"></i> Thông tin cơ bản
                                            </h5>

                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label for="typeCode" class="form-label">
                                                        Mã Code <span class="text-danger">*</span>
                                                    </label>
                                                    <input type="text" class="form-control" id="typeCode"
                                                        name="typeCode" value="${postType.typeCode}" required
                                                        maxlength="50">
                                                    <div class="form-text">Mã code duy nhất để định danh loại bài đăng
                                                    </div>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label for="typeName" class="form-label">
                                                        Tên Loại <span class="text-danger">*</span>
                                                    </label>
                                                    <input type="text" class="form-control" id="typeName"
                                                        name="typeName" value="${postType.typeName}" required
                                                        maxlength="100">
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="description" class="form-label">Mô tả</label>
                                                <textarea class="form-control" id="description" name="description"
                                                    rows="3">${postType.description}</textarea>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label for="category" class="form-label">
                                                        Danh mục <span class="text-danger">*</span>
                                                    </label>
                                                    <select class="form-select" id="category" name="category" required>
                                                        <option value="">Chọn danh mục</option>
                                                        <option value="job_posting" ${postType.category=='job_posting'
                                                            ? 'selected' : '' }>Job Posting</option>
                                                        <option value="content" ${postType.category=='content'
                                                            ? 'selected' : '' }>Content</option>
                                                        <option value="announcement" ${postType.category=='announcement'
                                                            ? 'selected' : '' }>Announcement</option>
                                                        <option value="event" ${postType.category=='event' ? 'selected'
                                                            : '' }>Event</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label for="priorityLevel" class="form-label">
                                                        Mức ưu tiên <span class="text-danger">*</span>
                                                    </label>
                                                    <input type="number" class="form-control" id="priorityLevel"
                                                        name="priorityLevel" value="${postType.priorityLevel}" required
                                                        min="1" max="10">
                                                    <div class="form-text">Số càng nhỏ, ưu tiên càng cao</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Visual Settings -->
                                    <div class="col-md-4">
                                        <div class="form-section">
                                            <h5 class="mb-3">
                                                <i class="fas fa-palette text-warning"></i> Cài đặt hiển thị
                                            </h5>

                                            <div class="mb-3">
                                                <label for="iconClass" class="form-label">Icon Class</label>
                                                <input type="text" class="form-control" id="iconClass" name="iconClass"
                                                    value="${postType.iconClass}" placeholder="VD: fas fa-clock">
                                                <div class="form-text">Font Awesome icon class</div>

                                                <div class="icon-preview" id="iconPreview">
                                                    <c:if test="${not empty postType.iconClass}">
                                                        <i class="${postType.iconClass}"></i>
                                                    </c:if>
                                                    <c:if test="${empty postType.iconClass}">
                                                        <i class="fas fa-question"></i>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="colorCode" class="form-label">Màu sắc</label>
                                                <div class="input-group">
                                                    <input type="color" class="form-control form-control-color"
                                                        id="colorCode" name="colorCode" value="${postType.colorCode}">
                                                    <input type="text" class="form-control" id="colorCodeText"
                                                        value="${postType.colorCode}" placeholder="#007bff" readonly>
                                                </div>

                                                <div class="d-flex justify-content-center mt-2">
                                                    <div class="color-preview" id="colorPreview"
                                                        style="background-color: ${postType.colorCode}"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Quick Actions -->
                                        <div class="form-section">
                                            <h5 class="mb-3">
                                                <i class="fas fa-bolt text-info"></i> Thao tác nhanh
                                            </h5>

                                            <div class="d-grid gap-2">
                                                <button type="submit" class="btn btn-warning">
                                                    <i class="fas fa-save"></i> Cập nhật
                                                </button>
                                                <a href="admin_post_types.jsp" class="btn btn-outline-secondary">
                                                    <i class="fas fa-times"></i> Hủy
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </c:if>

                        <c:if test="${empty postType}">
                            <div class="alert alert-warning" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> Không tìm thấy loại bài đăng này!
                            </div>
                            <a href="admin_post_types.jsp" class="btn btn-primary">
                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
                            </a>
                        </c:if>
                    </main>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Icon preview
                document.getElementById('iconClass').addEventListener('input', function () {
                    const iconClass = this.value || 'fas fa-question';
                    document.getElementById('iconPreview').innerHTML = `<i class="${iconClass}"></i>`;
                });

                // Color preview
                document.getElementById('colorCode').addEventListener('input', function () {
                    const color = this.value;
                    document.getElementById('colorCodeText').value = color;
                    document.getElementById('colorPreview').style.backgroundColor = color;
                });

                // Sync color text input
                document.getElementById('colorCodeText').addEventListener('input', function () {
                    const color = this.value;
                    if (/^#[0-9A-F]{6}$/i.test(color)) {
                        document.getElementById('colorCode').value = color;
                        document.getElementById('colorPreview').style.backgroundColor = color;
                    }
                });

                // Form validation
                document.getElementById('editPostTypeForm').addEventListener('submit', function (e) {
                    const typeCode = document.getElementById('typeCode').value.trim();
                    const typeName = document.getElementById('typeName').value.trim();
                    const category = document.getElementById('category').value;

                    if (!typeCode || !typeName || !category) {
                        e.preventDefault();
                        alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                        return false;
                    }

                    // Validate type code format
                    if (!/^[a-z_]+$/.test(typeCode)) {
                        e.preventDefault();
                        alert('Mã code chỉ được chứa chữ thường và dấu gạch dưới!');
                        return false;
                    }
                });

                // Initialize previews
                document.addEventListener('DOMContentLoaded', function () {
                    const color = document.getElementById('colorCode').value;
                    document.getElementById('colorCodeText').value = color;
                    document.getElementById('colorPreview').style.backgroundColor = color;
                });
            </script>
        </body>

        </html>