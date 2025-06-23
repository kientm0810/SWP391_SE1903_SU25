<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Create New Post</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

            <link rel="stylesheet" href="assets/css/stylePosts.css" />
           
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
                                        <textarea class="form-control" id="jobDescription"
                                            name="jobDescription"></textarea>
                                        <div class="invalid-feedback">Vui lòng nhập mô tả công việc</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="requirements" class="form-label required-field">Yêu cầu ứng
                                            viên</label>
                                        <textarea class="form-control" id="requirements" name="requirements"></textarea>
                                        <div class="invalid-feedback">Vui lòng nhập yêu cầu ứng viên</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="benefits" class="form-label required-field">Quyền lợi</label>
                                        <textarea class="form-control" id="benefits" name="benefits"></textarea>
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

                                <!-- Thông tin bổ sung -->
                                <div class="mb-4">
                                    <h4>Thông tin bổ sung</h4>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="rank" class="form-label">Cấp bậc</label>
                                            <input type="text" class="form-control" id="rank" name="rank"
                                                maxlength="100">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="industry" class="form-label">Ngành nghề</label>
                                            <input type="text" class="form-control" id="industry" name="industry"
                                                maxlength="100">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="contactPerson" class="form-label">Người liên hệ</label>
                                            <input type="text" class="form-control" id="contactPerson"
                                                name="contactPerson" maxlength="100">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="companySize" class="form-label">Quy mô công ty</label>
                                            <input type="text" class="form-control" id="companySize" name="companySize"
                                                maxlength="100">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="companyWebsite" class="form-label">Website công ty</label>
                                            <input type="text" class="form-control" id="companyWebsite"
                                                name="companyWebsite" maxlength="255">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="keywords" class="form-label">Từ khóa</label>
                                            <input type="text" class="form-control" id="keywords" name="keywords"
                                                maxlength="255" placeholder="Nhập các từ khóa, cách nhau bởi dấu phẩy">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="companyDescription" class="form-label">Mô tả công ty</label>
                                        <textarea class="form-control" id="companyDescription" name="companyDescription"
                                            rows="3" maxlength="1000"></textarea>
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

            <!--API CKEditor 5 -->
            <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
            <script>
                // Lưu các instance CKEditor
                window.CKEDITOR_INSTANCES = {};
                ClassicEditor.create(document.querySelector('#jobDescription')).then(editor => {
                    window.CKEDITOR_INSTANCES['jobDescription'] = editor;
                });
                ClassicEditor.create(document.querySelector('#requirements')).then(editor => {
                    window.CKEDITOR_INSTANCES['requirements'] = editor;
                });
                ClassicEditor.create(document.querySelector('#benefits')).then(editor => {
                    window.CKEDITOR_INSTANCES['benefits'] = editor;
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
                        };
                        reader.readAsDataURL(file);
                    } else {
                        preview.style.display = 'none';
                    }
                }

                // Form submission handling
                document.getElementById('createPostForm').addEventListener('submit', async function (e) {
                    e.preventDefault();

                    try {
                        // Đồng bộ nội dung CKEditor vào textarea
                        for (const [id, editor] of Object.entries(window.CKEDITOR_INSTANCES)) {
                            const textarea = document.getElementById(id);
                            if (textarea) {
                                const content = await editor.getData();
                                textarea.value = content;
                                console.log(`Updated ${id} with content:`, content);
                            }
                        }

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
                            const value = input.value.trim();

                            if (!value) {
                                isValid = false;
                                input.classList.add('is-invalid');
                                // Scroll to the first invalid field
                                if (isValid === false) {
                                    input.scrollIntoView({ behavior: 'smooth', block: 'center' });
                                    input.focus();
                                }
                            } else {
                                input.classList.remove('is-invalid');
                            }
                        }

                        if (!isValid) {
                            alert('Vui lòng điền đầy đủ các trường bắt buộc');
                            return;
                        }

                        // Log form data before submission
                        console.log('Form data before submission:');
                        for (let [key, value] of formData.entries()) {
                            console.log(key + ':', value);
                        }

                        // Submit form using fetch API
                        const response = await fetch(form.action, {
                            method: 'POST',
                            body: formData
                        });

                        const data = await response.json();
                        console.log('Server response:', data);

                        if (data.success) {
                            alert('Bài đăng đã được tạo thành công!');
                            // Redirect đến trang My Posts
                            window.location.href = data.redirectUrl || '${pageContext.request.contextPath}/post?view=my-post';
                        } else {
                            alert(data.message || 'Có lỗi xảy ra khi tạo bài đăng. Vui lòng thử lại.');
                        }
                    } catch (error) {
                        console.error('Error during form submission:', error);
                        alert('Có lỗi xảy ra khi tạo bài đăng: ' + error.message);
                    }
                });
            </script>
        </body>

        </html>