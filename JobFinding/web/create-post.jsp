<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Post</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <script
            src="https://cdn.tiny.cloud/1/ainjahbwyamlr1ureczw2mbfmr73mgpn7f6ceaaxu1h8ccv8/tinymce/7/tinymce.min.js"
        referrerpolicy="origin"></script>
        <style>
            .form-container {
                max-width: 800px;
                margin: 0 auto;
            }

            .tox-tinymce {
                min-height: 400px;
            }

            .required-field::after {
                content: " *";
                color: red;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container mt-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/post">Posts</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Create New Post</li>
                </ol>
            </nav>

            <div class="form-container">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title mb-4">Đăng Tin Tuyển Dụng</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/post/create" method="POST"
                              id="createPostForm" enctype="multipart/form-data">
                            <input type="hidden" name="postType" value="job">
                            <input type="hidden" name="status" value="active">
                            <input type="hidden" name="parentId" value="">
                            <!-- Thông tin cơ bản -->
                            <div class="mb-4">
                                <h4>Thông tin cơ bản</h4>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="title" class="form-label required-field">Tiêu đề tin tuyển
                                            dụng</label>
                                        <input type="text" class="form-control" id="title" name="title" required
                                               maxlength="255">
                                        <div class="invalid-feedback">Vui lòng nhập tiêu đề tin tuyển dụng</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="companyName" class="form-label required-field">Tên công
                                            ty</label>
                                        <input type="text" class="form-control" id="companyName" name="companyName"
                                               required maxlength="255">
                                        <div class="invalid-feedback">Vui lòng nhập tên công ty</div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="companyLogo" class="form-label required-field">Logo công
                                            ty</label>
                                        <input type="file" class="form-control" id="companyLogo" name="companyLogo"
                                               accept="image/*" onchange="previewLogo(event)" required>
                                        <div id="logoPreview" class="mt-2" style="display: none;">
                                            <img id="previewImage" src="#" alt="Logo Preview"
                                                 style="max-width: 200px; max-height: 200px;">
                                        </div>
                                        <div class="invalid-feedback">Vui lòng chọn logo công ty</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="salary" class="form-label required-field">Mức lương</label>
                                        <input type="text" class="form-control" id="salary" name="salary" required
                                               maxlength="100">
                                        <div class="invalid-feedback">Vui lòng nhập mức lương</div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="location" class="form-label required-field">Địa điểm</label>
                                        <input type="text" class="form-control" id="location" name="location"
                                               required maxlength="255">
                                        <div class="invalid-feedback">Vui lòng nhập địa điểm</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="jobType" class="form-label required-field">Loại hình công
                                            việc</label>
                                        <select class="form-select" id="jobType" name="jobType" required>
                                            <option value="">Chọn loại hình công việc</option>
                                            <option value="Full-time">Full-time</option>
                                            <option value="Part-time">Part-time</option>
                                            <option value="Contract">Contract</option>
                                            <option value="Internship">Internship</option>
                                        </select>
                                        <div class="invalid-feedback">Vui lòng chọn loại hình công việc</div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="experience" class="form-label required-field">Kinh
                                            nghiệm</label>
                                        <input type="text" class="form-control" id="experience" name="experience"
                                               required maxlength="100">
                                        <div class="invalid-feedback">Vui lòng nhập kinh nghiệm</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="deadline" class="form-label required-field">Hạn nộp hồ
                                            sơ</label>
                                        <input type="date" class="form-control" id="deadline" name="deadline"
                                               required>
                                        <div class="invalid-feedback">Vui lòng chọn hạn nộp hồ sơ</div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="workingTime" class="form-label required-field">Thời gian làm
                                            việc</label>
                                        <input type="text" class="form-control" id="workingTime" name="workingTime"
                                               required maxlength="200">
                                        <div class="invalid-feedback">Vui lòng nhập thời gian làm việc</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Chi tiết công việc -->
                            <div class="mb-4">
                                <h4>Chi tiết công việc</h4>
                                <div class="mb-3">
                                    <label for="jobDescription" class="form-label required-field">Mô tả công
                                        việc</label>
                                    <textarea class="form-control" id="jobDescription" name="jobDescription"
                                              required></textarea>
                                    <div class="invalid-feedback">Vui lòng nhập mô tả công việc</div>
                                </div>
                                <div class="mb-3">
                                    <label for="requirements" class="form-label required-field">Yêu cầu ứng
                                        viên</label>
                                    <textarea class="form-control" id="requirements" name="requirements"
                                              required></textarea>
                                    <div class="invalid-feedback">Vui lòng nhập yêu cầu ứng viên</div>
                                </div>
                                <div class="mb-3">
                                    <label for="benefits" class="form-label required-field">Quyền lợi</label>
                                    <textarea class="form-control" id="benefits" name="benefits"
                                              required></textarea>
                                    <div class="invalid-feedback">Vui lòng nhập quyền lợi</div>
                                </div>
                            </div>

                            <!-- Thông tin liên hệ -->
                            <div class="mb-4">
                                <h4>Thông tin liên hệ</h4>
                                <div class="mb-3">
                                    <label for="contactAddress" class="form-label required-field">Địa chỉ làm
                                        việc</label>
                                    <input type="text" class="form-control" id="contactAddress"
                                           name="contactAddress" required maxlength="500">
                                    <div class="invalid-feedback">Vui lòng nhập địa chỉ làm việc</div>
                                </div>
                                <div class="mb-3">
                                    <label for="applicationMethod" class="form-label required-field">Cách thức ứng
                                        tuyển</label>
                                    <textarea class="form-control" id="applicationMethod" name="applicationMethod"
                                              required></textarea>
                                    <div class="invalid-feedback">Vui lòng nhập cách thức ứng tuyển</div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/post" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Đăng tin
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- API TinyMCE-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                   // Initialize TinyMCE for rich text editors
                                                   tinymce.init({
                                                       selector: '#jobDescription, #requirements, #benefits, #applicationMethod',
                                                       plugins: 'lists link image table code help wordcount',
                                                       toolbar: 'undo redo | blocks | bold italic | alignleft aligncenter alignright | indent outdent | bullist numlist | link image | removeformat help',
                                                       height: 300,
                                                       menubar: false,
                                                       content_style: 'body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; font-size: 14px; }',
                                                       setup: function (editor) {
                                                           editor.on('change', function () {
                                                               editor.save();
                                                               validateField(editor.getElement());
                                                           });
                                                       }
                                                   });

                                                   // Logo preview function
                                                   function previewLogo(event) {
                                                       const preview = document.getElementById('logoPreview');
                                                       const previewImage = document.getElementById('previewImage');
                                                       const file = event.target.files[0];

                                                       if (file) {
                                                           const reader = new FileReader();
                                                           reader.onload = function (e) {
                                                               previewImage.src = e.target.result;
                                                               preview.style.display = 'block';
                                                           }
                                                           reader.readAsDataURL(file);
                                                       } else {
                                                           preview.style.display = 'none';
                                                       }
                                                   }

                                                   // Validate individual field
                                                   function validateField(element) {
                                                       const value = element.value.trim();
                                                       if (!value) {
                                                           element.classList.add('is-invalid');
                                                           return false;
                                                       }
                                                       element.classList.remove('is-invalid');
                                                       return true;
                                                   }

                                                   // Form submission handling
                                                   document.getElementById('createPostForm').addEventListener('submit', function (e) {
                                                       e.preventDefault();

                                                       // Save TinyMCE content
                                                       tinymce.triggerSave();

                                                       // Validate form
                                                       const form = this;
                                                       const formData = new FormData(form);
                                                       let isValid = true;

                                                       // Check required fields
                                                       const requiredFields = [
                                                           'title', 'companyName', 'salary', 'location', 'jobType',
                                                           'experience', 'deadline', 'workingTime', 'jobDescription',
                                                           'requirements', 'benefits', 'contactAddress', 'applicationMethod',
                                                           'companyLogo'
                                                       ];

                                                       for (let field of requiredFields) {
                                                           const input = document.getElementById(field);
                                                           if (!validateField(input)) {
                                                               isValid = false;
                                                               // Scroll to the first invalid field
                                                               if (isValid === false) {
                                                                   input.scrollIntoView({behavior: 'smooth', block: 'center'});
                                                                   input.focus();
                                                               }
                                                           }
                                                       }

                                                       if (!isValid) {
                                                           alert('Vui lòng điền đầy đủ các trường bắt buộc');
                                                           return;
                                                       }

                                                       // Submit form using fetch API
                                                       fetch(form.action, {
                                                           method: 'POST',
                                                           body: formData
                                                       })
                                                               .then(response => response.json())
                                                               .then(data => {
                                                                   if (data.success) {
                                                                       alert('Bài đăng đã được tạo thành công!');
                                                                       window.location.href = '${pageContext.request.contextPath}/';
                                                                   } else {
                                                                       alert(data.message || 'Có lỗi xảy ra khi tạo bài đăng. Vui lòng thử lại.');
                                                                   }
                                                               })
                                                               .catch(error => {
                                                                   console.error('Error:', error);
                                                                   alert('Có lỗi xảy ra khi tạo bài đăng. Vui lòng thử lại.');
                                                               });
                                                   });

                                                   // Remove invalid class when user starts typing
                                                   document.querySelectorAll('input, textarea, select').forEach(input => {
                                                       input.addEventListener('input', function () {
                                                           validateField(this);
                                                       });
                                                   });
        </script>
    </body>

</html>