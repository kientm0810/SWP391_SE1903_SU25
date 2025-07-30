<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Chỉnh sửa tin tuyển dụng</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link rel="stylesheet" href="assets/css/stylePosts.css">
                <style>
                    .form-container {
                        max-width: 800px;
                        margin: 0 auto;
                    }

                    .tox-tinymce {
                        min-height: 400px;
                    }

                    /* Spacing between header and breadcrumb */
                    .container.mt-4 {
                        margin-top: 2rem !important;
                        padding-top: 1rem;
                    }

                    /* Breadcrumb styling */
                    .breadcrumb {
                        background-color: #f8f9fa;
                        padding: 0.75rem 1rem;
                        border-radius: 0.375rem;
                        margin-bottom: 1.5rem;
                        border: 1px solid #e9ecef;
                    }

                    .breadcrumb-item a {
                        color: #0d6efd;
                        text-decoration: none;
                        font-weight: 500;
                    }

                    .breadcrumb-item a:hover {
                        color: #0a58ca;
                        text-decoration: underline;
                    }

                    .breadcrumb-item.active {
                        color: #6c757d;
                        font-weight: 600;
                    }

                    /* Logo preview styling */
                    #logoPreview {
                        border: 2px dashed #dee2e6;
                        border-radius: 0.375rem;
                        padding: 1rem;
                        text-align: center;
                        background-color: #f8f9fa;
                        transition: all 0.3s ease;
                    }

                    #logoPreview:hover {
                        border-color: #0d6efd;
                        background-color: #f0f8ff;
                    }

                    #previewImage {
                        border-radius: 0.375rem;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                        transition: transform 0.3s ease;
                    }

                    #previewImage:hover {
                        transform: scale(1.05);
                    }

                    /* Form section spacing */
                    .card {
                        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
                        border: 1px solid rgba(0, 0, 0, 0.125);
                    }

                    .card-title {
                        color: #2c3e50;
                        border-bottom: 2px solid #0d6efd;
                        padding-bottom: 0.5rem;
                    }
                </style>
                <!--API TinyMCE -->
                <script src="${pageContext.request.contextPath}/tinymce/tinymce.min.js"></script>
                <script src="${pageContext.request.contextPath}/assets/js/tinymceConfig.js"></script>
            </head>

            <body>

                <!-- Preloader Start -->
                <div id="preloader-active">
                    <div class="preloader d-flex align-items-center justify-content-center">
                        <div class="preloader-inner position-relative">
                            <div class="preloader-circle"></div>
                            <div class="preloader-img pere-text">
                                <img src="assets/img/logo/logo.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="header.jsp" />

                <div class="container mt-4">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/post">Danh sách
                                    tin</a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/post/view?id=${post.id}">${post.title}</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa tin</li>
                        </ol>
                    </nav>

                    <div class="form-container">
                        <div class="card">
                            <div class="card-body">
                                <h2 class="card-title mb-4">Chỉnh sửa tin tuyển dụng</h2>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        ${error}
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/post/update" method="POST"
                                    id="editPostForm" enctype="multipart/form-data" onsubmit="tinymce.triggerSave();">
                                    <input type="hidden" name="id" value="${post.id}">
                                    <input type="hidden" name="parentId" value="${post.parentId}">
                                    <input type="hidden" name="postType" value="${post.postType}">

                                    <!-- Thông tin cơ bản -->
                                    <div class="mb-4">
                                        <h4>Thông tin cơ bản</h4>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="title" class="form-label">Tiêu đề tin tuyển dụng</label>
                                                <input type="text" class="form-control" id="title" name="title" required
                                                    maxlength="200" value="${post.title}">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="companyName" class="form-label">Tên công ty</label>
                                                <input type="text" class="form-control" id="companyName"
                                                    name="companyName" required value="${post.companyName}">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="companyLogo" class="form-label">Logo công ty</label>
                                                <input type="file" class="form-control" id="companyLogo"
                                                    name="companyLogo" accept="image/*" onchange="previewLogo(event)">
                                                <div id="logoPreview" class="mt-2"
                                                    style="display: ${not empty post.companyLogo ? 'block' : 'none'};">
                                                    <img id="previewImage" src="${post.companyLogo}" alt="Logo Preview"
                                                        style="max-width: 200px; max-height: 200px;">
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="salary" class="form-label">Mức lương</label>
                                                <input type="text" class="form-control" id="salary" name="salary"
                                                    required value="${post.salary}">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="location" class="form-label">Địa điểm</label>
                                                <input type="text" class="form-control" id="location" name="location"
                                                    required value="${post.location}">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="jobType" class="form-label">Loại hình công việc</label>
                                                <select class="form-select" id="jobType" name="jobType" required>
                                                    <option value="Full-time" ${post.jobType=='Full-time' ? 'selected'
                                                        : '' }>Full-time</option>
                                                    <option value="Part-time" ${post.jobType=='Part-time' ? 'selected'
                                                        : '' }>Part-time</option>
                                                    <option value="Contract" ${post.jobType=='Contract' ? 'selected'
                                                        : '' }>Contract</option>
                                                    <option value="Internship" ${post.jobType=='Internship' ? 'selected'
                                                        : '' }>Internship</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="experience" class="form-label">Kinh nghiệm</label>
                                                <input type="text" class="form-control" id="experience"
                                                    name="experience" required value="${post.experience}">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="deadline" class="form-label">Hạn nộp hồ sơ</label>
                                                <input type="date" class="form-control" id="deadline" name="deadline"
                                                    required
                                                    value="<fmt:formatDate value='${post.deadline}' pattern='yyyy-MM-dd'/>">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="workingTime" class="form-label">Thời gian làm việc</label>
                                                <input type="text" class="form-control" id="workingTime"
                                                    name="workingTime" required value="${post.workingTime}">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Chi tiết công việc -->
                                    <div class="mb-4">
                                        <h4>Chi tiết công việc</h4>
                                        <div class="mb-3">
                                            <label for="jobDescription" class="form-label">Mô tả công việc</label>
                                            <textarea class="form-control" id="default" name="jobDescription"
                                                required>${post.jobDescription}</textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="requirements" class="form-label">Yêu cầu ứng viên</label>
                                            <textarea class="form-control" id="requirements" name="requirements"
                                                required>${post.requirements}</textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="benefits" class="form-label">Quyền lợi</label>
                                            <textarea class="form-control" id="benefits" name="benefits"
                                                required>${post.benefits}</textarea>
                                        </div>
                                    </div>

                                    <!-- Thông tin liên hệ -->
                                    <div class="mb-4">
                                        <h4>Thông tin liên hệ</h4>
                                        <div class="mb-3">
                                            <label for="contactAddress" class="form-label">Địa chỉ làm việc</label>
                                            <input type="text" class="form-control" id="contactAddress"
                                                name="contactAddress" required value="${post.contactAddress}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="applicationMethod" class="form-label">Cách thức ứng
                                                tuyển</label>
                                            <textarea class="form-control" id="applicationMethod"
                                                name="applicationMethod" required>${post.applicationMethod}</textarea>
                                        </div>
                                    </div>

                                    <!-- Thông tin bổ sung -->
                                    <div class="mb-4">
                                        <h4>Thông tin bổ sung</h4>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="rank" class="form-label">Cấp bậc</label>
                                                <input type="text" class="form-control" id="rank" name="rank"
                                                    maxlength="100" value="${post.rank}">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="industry" class="form-label">Ngành nghề</label>
                                                <input type="text" class="form-control" id="industry" name="industry"
                                                    maxlength="100" value="${post.industry}">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="contactPerson" class="form-label">Người liên hệ</label>
                                                <input type="text" class="form-control" id="contactPerson"
                                                    name="contactPerson" maxlength="100" value="${post.contactPerson}">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="companySize" class="form-label">Quy mô công ty</label>
                                                <input type="text" class="form-control" id="companySize"
                                                    name="companySize" maxlength="100" value="${post.companySize}">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="companyWebsite" class="form-label">Website công ty</label>
                                                <input type="text" class="form-control" id="companyWebsite"
                                                    name="companyWebsite" maxlength="255"
                                                    value="${post.companyWebsite}">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="keywords" class="form-label">Từ khóa</label>
                                                <input type="text" class="form-control" id="keywords" name="keywords"
                                                    maxlength="255"
                                                    placeholder="Nhập các từ khóa, cách nhau bởi dấu phẩy"
                                                    value="${post.keywords}">
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="companyDescription" class="form-label">Mô tả công ty</label>
                                            <textarea class="form-control" id="companyDescription"
                                                name="companyDescription" rows="3"
                                                maxlength="1000">${post.companyDescription}</textarea>
                                        </div>
                                    </div>

                                    <!-- Trạng thái -->
                                    <div class="mb-4">
                                        <h4>Trạng thái</h4>
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Trạng thái tin</label>
                                            <select class="form-select" id="status" name="status" required>
                                                <option value="active" ${post.status=='active' ? 'selected' : '' }>Đang
                                                    tuyển</option>
                                                <option value="draft" ${post.status=='draft' ? 'selected' : '' }>Bản
                                                    nháp</option>
                                                <option value="closed" ${post.status=='closed' ? 'selected' : '' }>Đã
                                                    đóng</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/post/view?id=${post.id}"
                                            class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Quay lại
                                        </a>

                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Cập nhật tin
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Khởi tạo TinyMCE cho các textarea cần rich text
                    tinymce.init({
                        selector: '#requirements, #benefits',
                        height: 300,
                        menubar: true,
                        plugins: [
                            'advlist autolink lists link image charmap print preview anchor',
                            'searchreplace visualblocks code fullscreen',
                            'insertdatetime media table paste code help wordcount',
                            'emoticons template paste textpattern imagetools'
                        ],
                        toolbar: 'undo redo | formatselect | bold italic underline strikethrough | \
                                 fontselect fontsizeselect | forecolor backcolor | \
                                 alignleft aligncenter alignright alignjustify | \
                                 bullist numlist outdent indent | link image imageupload media | \
                                 table tabledelete | tableprops tablerowprops tablecellprops | \
                                 tableinsertrowbefore tableinsertrowafter tabledeleterow | \
                                 tableinsertcolbefore tableinsertcolafter tabledeletecol | \
                                 code fullscreen preview | removeformat | help',
                        content_style: 'body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; font-size: 14px; }',
                        branding: false,
                        language: 'vi',
                        paste_data_images: true,
                        image_advtab: true,
                        image_title: true,
                        automatic_uploads: true,
                        file_picker_types: 'image',
                        images_upload_url: '${pageContext.request.contextPath}/upload/image',
                        images_upload_handler: function (blobInfo, success, failure) {
                            var xhr, formData;
                            xhr = new XMLHttpRequest();
                            xhr.withCredentials = false;
                            xhr.open('POST', '${pageContext.request.contextPath}/upload/image');
                            xhr.onload = function () {
                                var json;
                                if (xhr.status != 200) {
                                    failure('HTTP Error: ' + xhr.status);
                                    return;
                                }
                                json = JSON.parse(xhr.responseText);
                                if (!json || typeof json.location != 'string') {
                                    failure('Invalid JSON: ' + xhr.responseText);
                                    return;
                                }
                                success(json.location);
                            };
                            formData = new FormData();
                            formData.append('file', blobInfo.blob(), blobInfo.filename());
                            xhr.send(formData);
                        },
                        file_picker_callback: function (cb, value, meta) {
                            var input = document.createElement('input');
                            input.setAttribute('type', 'file');
                            input.setAttribute('accept', 'image/*');

                            input.onchange = function () {
                                var file = this.files[0];
                                var reader = new FileReader();
                                reader.onload = function () {
                                    var id = 'blobid' + (new Date()).getTime();
                                    var blobCache = tinymce.activeEditor.editorUpload.blobCache;
                                    var base64 = reader.result.split(',')[1];
                                    var blobInfo = blobCache.create(id, file, base64);
                                    blobCache.add(blobInfo);
                                    cb(blobInfo.blobUri(), { title: file.name });
                                };
                                reader.readAsDataURL(file);
                            };
                            input.click();
                        },
                        setup: function (editor) {
                            // Thêm nút upload ảnh tùy chỉnh
                            editor.ui.registry.addButton('imageupload', {
                                text: 'Upload Ảnh',
                                icon: 'image',
                                onAction: function () {
                                    var input = document.createElement('input');
                                    input.setAttribute('type', 'file');
                                    input.setAttribute('accept', 'image/*');
                                    input.onchange = function () {
                                        var file = this.files[0];
                                        if (file) {
                                            var reader = new FileReader();
                                            reader.onload = function (e) {
                                                var id = 'blobid' + (new Date()).getTime();
                                                var blobCache = editor.editorUpload.blobCache;
                                                var base64 = e.target.result.split(',')[1];
                                                var blobInfo = blobCache.create(id, file, base64);
                                                blobCache.add(blobInfo);
                                                editor.insertContent('<img src="' + blobInfo.blobUri() + '" alt="' + file.name + '" />');
                                            };
                                            reader.readAsDataURL(file);
                                        }
                                    };
                                    input.click();
                                }
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
                            };
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
                    document.getElementById('editPostForm').addEventListener('submit', function (e) {
                        e.preventDefault();

                        // Validate form
                        const form = this;
                        const formData = new FormData(form);
                        let isValid = true;

                        // Check required fields
                        const requiredFields = [
                            'title', 'companyName', 'salary', 'location', 'jobType',
                            'experience', 'deadline', 'workingTime', 'default',
                            'requirements', 'benefits', 'contactAddress', 'applicationMethod'
                        ];

                        for (let field of requiredFields) {
                            const input = document.getElementById(field);
                            if (!validateField(input)) {
                                isValid = false;
                                // Scroll to the first invalid field
                                if (isValid === false) {
                                    input.scrollIntoView({ behavior: 'smooth', block: 'center' });
                                    input.focus();
                                }
                            }
                        }

                        if (!isValid) {
                            alert('Vui lòng điền đầy đủ các trường bắt buộc');
                            return;
                        }

                        // Đồng bộ nội dung TinyMCE vào textarea trước khi submit
                        tinymce.triggerSave();

                        // Submit form using fetch API
                        fetch(form.action, {
                            method: 'POST',
                            body: formData
                        })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    alert('Cập nhật tin thành công!');
                                    window.location.href = '${pageContext.request.contextPath}/post/view?id=${post.id}';
                                } else {
                                    alert(data.message || 'Có lỗi xảy ra khi cập nhật tin. Vui lòng thử lại.');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('Có lỗi xảy ra khi cập nhật tin. Vui lòng thử lại.');
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