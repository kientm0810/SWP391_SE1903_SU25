<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa bài viết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-color: #4d96ff;
            --primary-hover: #3a7bd5;
            --secondary-color: #f8f9fa;
            --text-color: #2d3846;
            --light-gray: #e9ecef;
            --border-color: #dce0e3;
            --danger-color: #ff6b6b;
            --warning-color: #ffd166;
        }
        
        body {
            background-color: #f5f7fa;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #2d3846;
        }
        
        .container {
            max-width: 1140px;
        }
        
        .form-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin: 20px auto;
            overflow: hidden;
        }
        
        .form-header {
            padding: 20px 30px;
            border-bottom: 1px solid var(--light-gray);
            background-color: #fff;
        }
        
        .form-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--text-color);
            margin: 0;
        }
        
        .form-body {
            padding: 30px;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--text-color);
        }
        
        .form-control, .form-select {
            border-radius: 4px;
            border: 1px solid var(--border-color);
            padding: 10px 12px;
            font-size: 14px;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(77, 150, 255, 0.25);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 4px;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }
        
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        
        .required-field::after {
            content: "*";
            color: var(--danger-color);
            margin-left: 4px;
        }
        
        .character-count {
            font-size: 12px;
            color: #6c757d;
            text-align: right;
        }
        
        .character-count.warning {
            color: var(--warning-color);
        }
        
        .character-count.danger {
            color: var(--danger-color);
        }
        
        .select2-container--default .select2-selection--multiple {
            border: 1px solid var(--border-color);
            border-radius: 4px;
            min-height: 42px;
        }
        
        .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #e9f2ff;
            border-color: #c7d9ff;
            color: var(--primary-hover);
            border-radius: 4px;
        }
        
        .draft-status {
            font-size: 13px;
            color: #6c757d;
        }
        
        .nav-breadcrumb {
            background-color: #fff;
            padding: 15px 0;
            border-bottom: 1px solid var(--light-gray);
        }
        
        .breadcrumb-item a {
            color: #6c757d;
            text-decoration: none;
        }
        
        .breadcrumb-item.active {
            color: var(--primary-color);
        }
        
        .tox-tinymce {
            border-radius: 4px !important;
            border: 1px solid var(--border-color) !important;
        }
        
        .form-text {
            font-size: 13px;
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .form-body {
                padding: 20px;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn-group .btn {
                margin-bottom: 10px;
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <!-- Breadcrumb -->
    <div class="nav-breadcrumb">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="home"><i class="fas fa-home"></i></a></li>
             
                    <li class="breadcrumb-item"><a href="posts.jsp${post.id}">Bài viết</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa bài viết</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h1 class="form-title">
                    <i class="fas fa-edit me-2"></i>
                    Chỉnh sửa bài viết
                </h1>
            </div>

            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        ${error}
                    </div>
                </c:if>

                <form action="post" method="POST" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="postId" value="${post.id}">

                    <div class="mb-4">
                        <label for="title" class="form-label required-field">Tiêu đề</label>
                        <input type="text" class="form-control" id="title" name="title" value="${post.title}"
                            placeholder="Nhập tiêu đề bài viết" required maxlength="200">
                        <div class="invalid-feedback">
                            Vui lòng nhập tiêu đề bài viết.
                        </div>
                        <div class="d-flex justify-content-between">
                            <div class="form-text">
                                Tiêu đề rõ ràng sẽ giúp mọi người hiểu nội dung bài viết của bạn
                            </div>
                            <div class="character-count" id="titleCount">${post.title.length()}/200</div>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label for="category" class="form-label required-field">Chuyên mục</label>
                            <select class="form-select" id="category" name="category" required>
                                <option value="">Chọn chuyên mục</option>
                                <option value="job_search" ${post.category == 'job_search' ? 'selected' : ''}>Tìm việc</option>
                                <option value="career_advice" ${post.category == 'career_advice' ? 'selected' : ''}>Tư vấn nghề nghiệp</option>
                                <option value="interview_tips" ${post.category == 'interview_tips' ? 'selected' : ''}>Kinh nghiệm phỏng vấn</option>
                                <option value="resume_cv" ${post.category == 'resume_cv' ? 'selected' : ''}>CV/Resume</option>
                                <option value="salary_negotiation" ${post.category == 'salary_negotiation' ? 'selected' : ''}>Đàm phán lương</option>
                                <option value="workplace" ${post.category == 'workplace' ? 'selected' : ''}>Môi trường làm việc</option>
                                <option value="skill_development" ${post.category == 'skill_development' ? 'selected' : ''}>Phát triển kỹ năng</option>
                                <option value="job_market" ${post.category == 'job_market' ? 'selected' : ''}>Thị trường việc làm</option>
                                <option value="other" ${post.category == 'other' ? 'selected' : ''}>Chủ đề khác</option>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn chuyên mục.
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label d-flex justify-content-between">
                                <span>Tags</span>
                                <small class="text-muted">Tối đa 5 tags</small>
                            </label>
                            <select class="form-control" id="tags" name="tags[]" multiple="multiple">
                                <c:forEach items="${commonTags}" var="tag">
                                    <option value="${tag}" ${post.tags.contains(tag) ? 'selected' : ''}>${tag}</option>
                                </c:forEach>
                            </select>
                            <div class="form-text">
                                Thêm tags liên quan để bài viết dễ được tìm thấy
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="content" class="form-label required-field">Nội dung</label>
                        <textarea class="form-control" id="content" name="content" rows="10"
                            required>${post.content}</textarea>
                        <div class="invalid-feedback">
                            Vui lòng nhập nội dung bài viết.
                        </div>
                        <div class="character-count" id="contentCount">${post.content.length()}/50000</div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>
                                Lưu thay đổi
                            </button>
                            <a href="post/${post.id}" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i>
                                Hủy bỏ
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script
        src="https://cdn.tiny.cloud/1/ainjahbwyamlr1ureczw2mbfmr73mgpn7f6ceaaxu1h8ccv8/tinymce/6/tinymce.min.js"
        referrerpolicy="origin"></script>

    <script>
        $(document).ready(function () {
            // Initialize Select2 for tags
            $('#tags').select2({
                tags: true,
                tokenSeparators: [','],
                maximumSelectionLength: 5,
                placeholder: 'Thêm tags',
                allowClear: true
            });

            // Character count for title
            $('#title').on('input', function () {
                const maxLength = 200;
                const currentLength = $(this).val().length;
                const $counter = $('#titleCount');

                $counter.text(`${currentLength}/${maxLength}`);

                if (currentLength >= maxLength * 0.9) {
                    $counter.addClass('danger');
                } else if (currentLength >= maxLength * 0.8) {
                    $counter.addClass('warning').removeClass('danger');
                } else {
                    $counter.removeClass('warning danger');
                }
            });

            // Initialize TinyMCE
            tinymce.init({
                selector: '#content',
                height: 500,
                menubar: false,
                plugins: [
                    'advlist autolink lists link image charmap preview anchor',
                    'searchreplace visualblocks code fullscreen',
                    'insertdatetime media table paste code help wordcount emoticons'
                ],
                toolbar: 'undo redo | formatselect | bold italic forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | image media link emoticons | help',
                content_style: 'body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial; font-size: 14px; }',
                placeholder: 'Viết nội dung bài viết của bạn...',
                skin: 'oxide',
                content_css: 'default',
                images_upload_url: 'upload-image',
                automatic_uploads: true,
                file_picker_types: 'image',
                file_picker_callback: function (cb, value, meta) {
                    const input = document.createElement('input');
                    input.setAttribute('type', 'file');
                    input.setAttribute('accept', 'image/*');

                    input.onchange = function () {
                        const file = this.files[0];
                        const reader = new FileReader();

                        reader.onload = function () {
                            const id = 'blobid' + (new Date()).getTime();
                            const blobCache = tinymce.activeEditor.editorUpload.blobCache;
                            const base64 = reader.result.split(',')[1];
                            const blobInfo = blobCache.create(id, file, base64);
                            blobCache.add(blobInfo);

                            cb(blobInfo.blobUri(), {title: file.name});
                        };
                        reader.readAsDataURL(file);
                    };
                    input.click();
                },
                setup: function (editor) {
                    editor.on('KeyUp', function (e) {
                        const content = editor.getContent({format: 'text'});
                        const maxLength = 50000;
                        const currentLength = content.length;
                        const $counter = $('#contentCount');

                        $counter.text(`${currentLength}/${maxLength}`);

                        if (currentLength >= maxLength * 0.9) {
                            $counter.addClass('danger');
                        } else if (currentLength >= maxLength * 0.8) {
                            $counter.addClass('warning').removeClass('danger');
                        } else {
                            $counter.removeClass('warning danger');
                        }
                    });
                }
            });

            // Form validation
            (function () {
                'use strict';
                var forms = document.querySelectorAll('.needs-validation')
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }
                            form.classList.add('was-validated')
                        }, false);
                    });
            })();
        });
    </script>
</body>
</html>