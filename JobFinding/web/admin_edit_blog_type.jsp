<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Chỉnh sửa Loại Blog - Admin Dashboard</title>
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
                                <i class="fas fa-edit text-warning"></i> Chỉnh sửa Loại Blog
                            </h1>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <a href="admin_blog_types.jsp" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>

                        <!-- Current Information -->
                        <c:if test="${not empty blogType}">
                            <div class="current-info">
                                <h6 class="mb-2">
                                    <i class="fas fa-info-circle"></i> Thông tin hiện tại
                                </h6>
                                <div class="row">
                                    <div class="col-md-2">
                                        <strong>Mã Code:</strong> <code>${blogType.typeCode}</code>
                                    </div>
                                    <div class="col-md-2">
                                        <strong>Tên:</strong> ${blogType.typeName}
                                    </div>
                                    <div class="col-md-2">
                                        <strong>Danh mục:</strong>
                                        <span class="badge bg-secondary">${blogType.category}</span>
                                    </div>
                                    <div class="col-md-2">
                                        <strong>Đối tượng:</strong>
                                        <span class="badge bg-info">${blogType.targetAudience}</span>
                                    </div>
                                    <div class="col-md-2">
                                        <strong>Định dạng:</strong>
                                        <span class="badge bg-warning text-dark">${blogType.contentFormat}</span>
                                    </div>
                                    <div class="col-md-2">
                                        <strong>Trạng thái:</strong>
                                        <c:choose>
                                            <c:when test="${blogType.active}">
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

                        <c:if test="${not empty blogType}">
                            <form action="content-type/blog-types?action=update" method="POST" id="editBlogTypeForm">
                                <input type="hidden" name="id" value="${blogType.id}">

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
                                                        name="typeCode" value="${blogType.typeCode}" required
                                                        maxlength="50">
                                                    <div class="form-text">Mã code duy nhất để định danh loại blog</div>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label for="typeName" class="form-label">
                                                        Tên Loại <span class="text-danger">*</span>
                                                    </label>
                                                    <input type="text" class="form-control" id="typeName"
                                                        name="typeName" value="${blogType.typeName}" required
                                                        maxlength="100">
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="description" class="form-label">Mô tả</label>
                                                <textarea class="form-control" id="description" name="description"
                                                    rows="3">${blogType.description}</textarea>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label for="category" class="form-label">
                                                        Danh mục <span class="text-danger">*</span>
                                                    </label>
                                                    <select class="form-select" id="category" name="category" required>
                                                        <option value="">Chọn danh mục</option>
                                                        <option value="career_advice"
                                                            ${blogType.category=='career_advice' ? 'selected' : '' }>
                                                            Career Advice</option>
                                                        <option value="industry_news"
                                                            ${blogType.category=='industry_news' ? 'selected' : '' }>
                                                            Industry News</option>
                                                        <option value="company_culture"
                                                            ${blogType.category=='company_culture' ? 'selected' : '' }>
                                                            Company Culture</option>
                                                        <option value="job_search" ${blogType.category=='job_search'
                                                            ? 'selected' : '' }>Job Search</option>
                                                        <option value="interview_prep"
                                                            ${blogType.category=='interview_prep' ? 'selected' : '' }>
                                                            Interview Prep</option>
                                                        <option value="professional_development"
                                                            ${blogType.category=='professional_development' ? 'selected'
                                                            : '' }>Professional Development</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label for="targetAudience" class="form-label">
                                                        Đối tượng mục tiêu <span class="text-danger">*</span>
                                                    </label>
                                                    <select class="form-select" id="targetAudience"
                                                        name="targetAudience" required>
                                                        <option value="">Chọn đối tượng</option>
                                                        <option value="job_seekers"
                                                            ${blogType.targetAudience=='job_seekers' ? 'selected' : ''
                                                            }>Job Seekers</option>
                                                        <option value="recruiters"
                                                            ${blogType.targetAudience=='recruiters' ? 'selected' : '' }>
                                                            Recruiters</option>
                                                        <option value="students" ${blogType.targetAudience=='students'
                                                            ? 'selected' : '' }>Students</option>
                                                        <option value="professionals"
                                                            ${blogType.targetAudience=='professionals' ? 'selected' : ''
                                                            }>Professionals</option>
                                                        <option value="all" ${blogType.targetAudience=='all'
                                                            ? 'selected' : '' }>All</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-4 mb-3">
                                                    <label for="contentFormat" class="form-label">
                                                        Định dạng nội dung <span class="text-danger">*</span>
                                                    </label>
                                                    <select class="form-select" id="contentFormat" name="contentFormat"
                                                        required>
                                                        <option value="article" ${blogType.contentFormat=='article'
                                                            ? 'selected' : '' }>Article</option>
                                                        <option value="video" ${blogType.contentFormat=='video'
                                                            ? 'selected' : '' }>Video</option>
                                                        <option value="infographic"
                                                            ${blogType.contentFormat=='infographic' ? 'selected' : '' }>
                                                            Infographic</option>
                                                        <option value="case_study"
                                                            ${blogType.contentFormat=='case_study' ? 'selected' : '' }>
                                                            Case Study</option>
                                                        <option value="interview" ${blogType.contentFormat=='interview'
                                                            ? 'selected' : '' }>Interview</option>
                                                        <option value="podcast" ${blogType.contentFormat=='podcast'
                                                            ? 'selected' : '' }>Podcast</option>
                                                    </select>
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
                                                    value="${blogType.iconClass}" placeholder="VD: fas fa-lightbulb">
                                                <div class="form-text">Font Awesome icon class</div>

                                                <div class="icon-preview" id="iconPreview">
                                                    <c:if test="${not empty blogType.iconClass}">
                                                        <i class="${blogType.iconClass}"></i>
                                                    </c:if>
                                                    <c:if test="${empty blogType.iconClass}">
                                                        <i class="fas fa-question"></i>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="colorCode" class="form-label">Màu sắc</label>
                                                <div class="input-group">
                                                    <input type="color" class="form-control form-control-color"
                                                        id="colorCode" name="colorCode" value="${blogType.colorCode}">
                                                    <input type="text" class="form-control" id="colorCodeText"
                                                        value="${blogType.colorCode}" placeholder="#28a745" readonly>
                                                </div>

                                                <div class="d-flex justify-content-center mt-2">
                                                    <div class="color-preview" id="colorPreview"
                                                        style="background-color: ${blogType.colorCode}"></div>
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="seoKeywords" class="form-label">SEO Keywords</label>
                                                <textarea class="form-control" id="seoKeywords" name="seoKeywords"
                                                    rows="3"
                                                    placeholder="Từ khóa SEO, phân cách bằng dấu phẩy...">${blogType.seoKeywords}</textarea>
                                                <div class="form-text">Từ khóa SEO cho loại blog này</div>
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
                                                <a href="admin_blog_types.jsp" class="btn btn-outline-secondary">
                                                    <i class="fas fa-times"></i> Hủy
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </c:if>

                        <c:if test="${empty blogType}">
                            <div class="alert alert-warning" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> Không tìm thấy loại blog này!
                            </div>
                            <a href="admin_blog_types.jsp" class="btn btn-primary">
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
                document.getElementById('editBlogTypeForm').addEventListener('submit', function (e) {
                    const typeCode = document.getElementById('typeCode').value.trim();
                    const typeName = document.getElementById('typeName').value.trim();
                    const category = document.getElementById('category').value;
                    const targetAudience = document.getElementById('targetAudience').value;
                    const contentFormat = document.getElementById('contentFormat').value;

                    if (!typeCode || !typeName || !category || !targetAudience || !contentFormat) {
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