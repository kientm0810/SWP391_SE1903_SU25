<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Tạo Bài đăng Mới - JobFinding</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                .type-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    padding: 8px 16px;
                    border-radius: 20px;
                    font-size: 14px;
                    font-weight: 500;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    border: 2px solid transparent;
                }

                .type-badge:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                .type-badge.selected {
                    border-color: #007bff;
                    box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
                }

                .type-badge i {
                    font-size: 16px;
                }

                .form-section {
                    background: #f8f9fa;
                    border-radius: 10px;
                    padding: 20px;
                    margin-bottom: 20px;
                }

                .required-field::after {
                    content: " *";
                    color: red;
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
                                    <a class="nav-link text-white" href="dashboard.jsp">
                                        <i class="fas fa-tachometer-alt"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white active" href="create-post-with-type.jsp">
                                        <i class="fas fa-plus"></i> Tạo Bài đăng
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="my-posts.jsp">
                                        <i class="fas fa-list"></i> Bài đăng của tôi
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
                                <i class="fas fa-plus text-primary"></i> Tạo Bài đăng Mới
                            </h1>
                        </div>

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

                        <form action="post/create" method="POST" id="createPostForm" enctype="multipart/form-data">
                            <input type="hidden" name="postType" value="job">
                            <input type="hidden" name="status" value="active">
                            <input type="hidden" name="parentId" value="">

                            <!-- Post Type Selection -->
                            <div class="form-section">
                                <h5 class="mb-3">
                                    <i class="fas fa-tags text-primary"></i> Chọn Loại Bài đăng
                                </h5>
                                <div class="row">
                                    <c:forEach var="postType" items="${postTypes}">
                                        <div class="col-md-4 mb-3">
                                            <div class="type-badge"
                                                onclick="selectPostType(${postType.id}, '${postType.typeCode}')"
                                                data-type-id="${postType.id}" data-type-code="${postType.typeCode}">
                                                <i class="${postType.iconClass}"
                                                    style="color: ${postType.colorCode};"></i>
                                                <span>${postType.typeName}</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <input type="hidden" id="selectedPostTypeId" name="postTypeId" required>
                                <div class="form-text">Chọn loại bài đăng phù hợp để hiển thị đúng cho người tìm việc
                                </div>
                            </div>

                            <!-- Basic Information -->
                            <div class="form-section">
                                <h5 class="mb-3">
                                    <i class="fas fa-info-circle text-primary"></i> Thông tin cơ bản
                                </h5>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="title" class="form-label required-field">Tiêu đề tin tuyển
                                            dụng</label>
                                        <input type="text" class="form-control" id="title" name="title" required
                                            maxlength="255">
                                        <div class="invalid-feedback">Vui lòng nhập tiêu đề tin tuyển dụng</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="companyName" class="form-label required-field">Tên công ty</label>
                                        <input type="text" class="form-control" id="companyName" name="companyName"
                                            required maxlength="255">
                                        <div class="invalid-feedback">Vui lòng nhập tên công ty</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Job Details -->
                            <div class="form-section">
                                <h5 class="mb-3">
                                    <i class="fas fa-briefcase text-warning"></i> Chi tiết công việc
                                </h5>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label for="location" class="form-label required-field">Địa điểm</label>
                                        <input type="text" class="form-control" id="location" name="location" required
                                            maxlength="255">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="salary" class="form-label required-field">Mức lương</label>
                                        <input type="text" class="form-control" id="salary" name="salary" required
                                            maxlength="100">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="jobType" class="form-label required-field">Loại công việc</label>
                                        <select class="form-select" id="jobType" name="jobType" required>
                                            <option value="">Chọn loại công việc</option>
                                            <option value="full_time">Toàn thời gian</option>
                                            <option value="part_time">Bán thời gian</option>
                                            <option value="contract">Hợp đồng</option>
                                            <option value="internship">Thực tập</option>
                                            <option value="freelance">Freelance</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="experience" class="form-label required-field">Kinh nghiệm</label>
                                        <input type="text" class="form-control" id="experience" name="experience"
                                            required maxlength="100">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="deadline" class="form-label required-field">Hạn nộp hồ sơ</label>
                                        <input type="date" class="form-control" id="deadline" name="deadline" required>
                                    </div>
                                </div>
                            </div>

                            <!-- Job Description -->
                            <div class="form-section">
                                <h5 class="mb-3">
                                    <i class="fas fa-file-alt text-info"></i> Mô tả công việc
                                </h5>
                                <div class="mb-3">
                                    <label for="jobDescription" class="form-label required-field">Mô tả công
                                        việc</label>
                                    <textarea class="form-control" id="jobDescription" name="jobDescription" rows="5"
                                        required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="requirements" class="form-label required-field">Yêu cầu</label>
                                    <textarea class="form-control" id="requirements" name="requirements" rows="4"
                                        required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="benefits" class="form-label">Phúc lợi</label>
                                    <textarea class="form-control" id="benefits" name="benefits" rows="3"></textarea>
                                </div>
                            </div>

                            <!-- Contact Information -->
                            <div class="form-section">
                                <h5 class="mb-3">
                                    <i class="fas fa-address-book text-success"></i> Thông tin liên hệ
                                </h5>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="contactAddress" class="form-label required-field">Địa chỉ liên
                                            hệ</label>
                                        <textarea class="form-control" id="contactAddress" name="contactAddress"
                                            rows="2" required></textarea>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="applicationMethod" class="form-label required-field">Phương thức ứng
                                            tuyển</label>
                                        <textarea class="form-control" id="applicationMethod" name="applicationMethod"
                                            rows="2" required></textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="workingTime" class="form-label required-field">Thời gian làm
                                            việc</label>
                                        <input type="text" class="form-control" id="workingTime" name="workingTime"
                                            required maxlength="200">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="quantity" class="form-label">Số lượng tuyển</label>
                                        <input type="number" class="form-control" id="quantity" name="quantity" min="1"
                                            value="1">
                                    </div>
                                </div>
                            </div>

                            <!-- Company Information -->
                            <div class="form-section">
                                <h5 class="mb-3">
                                    <i class="fas fa-building text-secondary"></i> Thông tin công ty
                                </h5>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="companyLogo" class="form-label">Logo công ty</label>
                                        <input type="file" class="form-control" id="companyLogo" name="companyLogo"
                                            accept="image/*">
                                        <div class="form-text">Chọn file ảnh logo công ty (JPG, PNG)</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="companyWebsite" class="form-label">Website công ty</label>
                                        <input type="url" class="form-control" id="companyWebsite" name="companyWebsite"
                                            maxlength="500">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="companyDescription" class="form-label">Mô tả công ty</label>
                                    <textarea class="form-control" id="companyDescription" name="companyDescription"
                                        rows="3"></textarea>
                                </div>
                            </div>

                            <!-- Submit Buttons -->
                            <div class="form-section">
                                <div class="d-flex justify-content-between">
                                    <button type="button" class="btn btn-secondary" onclick="saveDraft()">
                                        <i class="fas fa-save"></i> Lưu nháp
                                    </button>
                                    <div>
                                        <button type="button" class="btn btn-outline-primary me-2"
                                            onclick="previewPost()">
                                            <i class="fas fa-eye"></i> Xem trước
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-paper-plane"></i> Đăng tin
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </main>
                </div>
            </div>

            <!-- Preview Modal -->
            <div class="modal fade" id="previewModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Xem trước bài đăng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body" id="previewContent">
                            <!-- Preview content will be loaded here -->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" onclick="submitForm()">Đăng tin</button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                let selectedPostTypeId = null;

                function selectPostType(typeId, typeCode) {
                    // Remove previous selection
                    document.querySelectorAll('.type-badge').forEach(badge => {
                        badge.classList.remove('selected');
                    });

                    // Add selection to clicked badge
                    event.target.closest('.type-badge').classList.add('selected');

                    // Update hidden input
                    document.getElementById('selectedPostTypeId').value = typeId;
                    selectedPostTypeId = typeId;

                    console.log('Selected post type:', typeId, typeCode);
                }

                function saveDraft() {
                    // Change form action to save as draft
                    document.getElementById('createPostForm').action = 'post/save-draft';
                    document.getElementById('createPostForm').submit();
                }

                function previewPost() {
                    // Validate form first
                    if (!validateForm()) {
                        return;
                    }

                    // Collect form data
                    const formData = new FormData(document.getElementById('createPostForm'));

                    // Send to preview endpoint
                    fetch('post/preview', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.text())
                        .then(html => {
                            document.getElementById('previewContent').innerHTML = html;
                            new bootstrap.Modal(document.getElementById('previewModal')).show();
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra khi tạo xem trước!');
                        });
                }

                function submitForm() {
                    document.getElementById('createPostForm').submit();
                }

                function validateForm() {
                    const form = document.getElementById('createPostForm');

                    // Check if post type is selected
                    if (!selectedPostTypeId) {
                        alert('Vui lòng chọn loại bài đăng!');
                        return false;
                    }

                    // Check required fields
                    const requiredFields = form.querySelectorAll('[required]');
                    for (let field of requiredFields) {
                        if (!field.value.trim()) {
                            field.classList.add('is-invalid');
                            alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                            return false;
                        } else {
                            field.classList.remove('is-invalid');
                        }
                    }

                    return true;
                }

                // Form submission validation
                document.getElementById('createPostForm').addEventListener('submit', function (e) {
                    if (!validateForm()) {
                        e.preventDefault();
                        return false;
                    }
                });

                // Auto-hide alerts after 5 seconds
                setTimeout(function () {
                    const alerts = document.querySelectorAll('.alert');
                    alerts.forEach(function (alert) {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    });
                }, 5000);
            </script>
        </body>

        </html>