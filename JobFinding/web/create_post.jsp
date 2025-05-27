<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${param.parentId != null ? 'Thêm bình luận' : 'Tạo bài viết mới'} - JobFinding</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
            <style>
                :root {
                    --primary-color: #00b14f;
                    --primary-hover: #009245;
                    --secondary-color: #2d3846;
                    --border-color: #e9ecef;
                    --text-color: #333;
                    --light-bg: #f8f9fa;
                    --danger-color: #ff4d4f;
                    --warning-color: #faad14;
                    --white: #fff;
                    --gray-light: #f5f5f5;
                    --gray-medium: #d9d9d9;
                    --box-shadow: 0 2px 4px rgba(0, 0, 0, .1);
                }

                body {
                    background-color: var(--light-bg);
                    color: var(--text-color);
                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                    line-height: 1.5;
                    padding-top: 76px;
                }

                .topcv-container {
                    max-width: 1140px;
                    margin: 0 auto;
                    padding: 0 20px;
                }

                .page-header {
                    background: var(--white);
                    padding: 24px 0;
                    margin-bottom: 24px;
                    border-bottom: 1px solid var(--border-color);
                    box-shadow: var(--box-shadow);
                }

                .page-title {
                    font-size: 24px;
                    font-weight: 700;
                    color: var(--secondary-color);
                    margin: 0;
                    display: flex;
                    align-items: center;
                }

                .page-title i {
                    color: var(--primary-color);
                    margin-right: 12px;
                    font-size: 28px;
                }

                .form-container {
                    background: var(--white);
                    border-radius: 12px;
                    box-shadow: var(--box-shadow);
                    margin-bottom: 32px;
                }

                .form-header {
                    padding: 20px 24px;
                    border-bottom: 1px solid var(--border-color);
                }

                .form-header h2 {
                    font-size: 18px;
                    font-weight: 600;
                    color: var(--secondary-color);
                    margin: 0;
                }

                .form-main {
                    padding: 24px;
                }

                .form-section {
                    margin-bottom: 32px;
                }

                .form-section-title {
                    font-size: 16px;
                    font-weight: 600;
                    color: var(--secondary-color);
                    margin-bottom: 20px;
                    display: flex;
                    align-items: center;
                }

                .form-section-title i {
                    margin-right: 8px;
                    color: var(--primary-color);
                }

                .form-group {
                    margin-bottom: 24px;
                }

                .form-label {
                    font-weight: 500;
                    font-size: 14px;
                    color: var(--secondary-color);
                    margin-bottom: 8px;
                    display: block;
                }

                .form-control {
                    height: 44px;
                    padding: 10px 16px;
                    font-size: 14px;
                    border: 1px solid var(--border-color);
                    border-radius: 8px;
                    transition: all 0.2s;
                }

                .form-control:focus {
                    border-color: var(--primary-color);
                    box-shadow: 0 0 0 3px rgba(0, 177, 79, 0.1);
                }

                textarea.form-control {
                    min-height: 120px;
                    height: auto;
                }

                .form-select {
                    height: 44px;
                    font-size: 14px;
                    border-radius: 8px;
                    padding: 10px 16px;
                }

                .btn {
                    height: 44px;
                    padding: 0 24px;
                    font-size: 14px;
                    font-weight: 600;
                    border-radius: 8px;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    transition: all 0.2s;
                }

                .btn i {
                    margin-right: 8px;
                    font-size: 16px;
                }

                .btn-primary {
                    background: var(--primary-color);
                    border-color: var(--primary-color);
                    color: var(--white);
                }

                .btn-primary:hover {
                    background: var(--primary-hover);
                    border-color: var(--primary-hover);
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(0, 177, 79, 0.2);
                }

                .btn-outline-primary {
                    color: var(--primary-color);
                    border-color: var(--primary-color);
                    background: transparent;
                }

                .btn-outline-primary:hover {
                    background: var(--primary-color);
                    color: var(--white);
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(0, 177, 79, 0.1);
                }

                .btn-light {
                    background: var(--gray-light);
                    border-color: var(--gray-medium);
                    color: var(--text-color);
                }

                .btn-light:hover {
                    background: var(--gray-medium);
                    transform: translateY(-1px);
                }

                .form-text {
                    font-size: 13px;
                    color: #666;
                    margin-top: 6px;
                }

                .character-count {
                    font-size: 13px;
                    color: #666;
                    margin-top: 6px;
                    text-align: right;
                }

                .character-count.warning {
                    color: var(--warning-color);
                }

                .character-count.danger {
                    color: var(--danger-color);
                }

                .select2-container .select2-selection--multiple {
                    min-height: 44px;
                    border: 1px solid var(--border-color) !important;
                    border-radius: 8px;
                    padding: 4px 8px;
                }

                .select2-container--default .select2-selection--multiple .select2-selection__choice {
                    background: var(--primary-color);
                    border: none;
                    color: var(--white);
                    padding: 4px 10px;
                    font-size: 13px;
                    border-radius: 4px;
                    margin: 4px;
                }

                .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
                    color: var(--white);
                    margin-right: 6px;
                    font-size: 16px;
                }

                .tox-tinymce {
                    border-radius: 8px !important;
                    border: 1px solid var(--border-color) !important;
                }

                .alert {
                    padding: 16px 20px;
                    border-radius: 8px;
                    font-size: 14px;
                    margin-bottom: 24px;
                    display: flex;
                    align-items: center;
                }

                .alert i {
                    margin-right: 12px;
                    font-size: 18px;
                }

                .alert-danger {
                    background: #fff1f0;
                    border-color: #ffccc7;
                    color: var(--danger-color);
                }

                .invalid-feedback {
                    font-size: 13px;
                    color: var(--danger-color);
                    margin-top: 6px;
                }

                .required-field::after {
                    content: "*";
                    color: var(--danger-color);
                    margin-left: 4px;
                }

                .action-buttons {
                    padding-top: 24px;
                    margin-top: 24px;
                    border-top: 1px solid var(--border-color);
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .button-group {
                    display: flex;
                    gap: 12px;
                }

                .draft-status {
                    font-size: 13px;
                    color: #666;
                    display: flex;
                    align-items: center;
                }

                .draft-status i {
                    margin-right: 6px;
                    color: var(--primary-color);
                }

                .terms-section {
                    background: var(--light-bg);
                    padding: 16px;
                    border-radius: 8px;
                    margin-top: 24px;
                }

                .terms-title {
                    font-size: 14px;
                    font-weight: 600;
                    color: var(--secondary-color);
                    margin-bottom: 12px;
                }

                .terms-content {
                    font-size: 13px;
                    color: #666;
                    margin-bottom: 0;
                }

                @media (max-width: 768px) {
                    .topcv-container {
                        padding: 0 16px;
                    }

                    .page-header {
                        padding: 16px 0;
                    }

                    .page-title {
                        font-size: 20px;
                    }

                    .form-container {
                        border-radius: 8px;
                    }

                    .form-main {
                        padding: 16px;
                    }

                    .form-section {
                        margin-bottom: 24px;
                    }

                    .button-group {
                        flex-direction: column;
                        width: 100%;
                    }

                    .button-group .btn {
                        width: 100%;
                        margin-bottom: 8px;
                    }

                    .action-buttons {
                        flex-direction: column;
                        gap: 16px;
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <div class="page-header">
                <div class="topcv-container">
                    <h1 class="page-title">
                        <i class="fas fa-edit"></i>
                        ${param.parentId != null ? 'Thêm bình luận' : 'Tạo bài viết mới'}
                    </h1>
                </div>
            </div>

            <div class="topcv-container">
                <div class="form-container">
                    <div class="form-header">
                        <h2>
                            <i class="fas fa-file-alt me-2"></i>
                            ${param.parentId != null ? 'Thông tin bình luận' : 'Thông tin bài viết'}
                        </h2>
                    </div>

                    <div class="form-main">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle"></i>
                                ${error}
                            </div>
                        </c:if>

                        <form action="post" method="POST" class="needs-validation" id="postForm" novalidate>
                            <input type="hidden" name="action" value="${param.parentId != null ? 'comment' : 'create'}">
                            <input type="hidden" name="draft_id" id="draftId">

                            <c:if test="${not empty param.parentId}">
                                <input type="hidden" name="parentId" value="${param.parentId}">
                            </c:if>

                            <c:if test="${empty param.parentId}">
                                <!-- Basic Information Section -->
                                <div class="form-section">
                                    <h3 class="form-section-title">
                                        <i class="fas fa-info-circle"></i>
                                        Thông tin cơ bản
                                    </h3>

                                    <div class="form-group">
                                        <label for="title" class="form-label required-field">Tiêu đề bài viết</label>
                                        <input type="text" class="form-control" id="title" name="title"
                                            placeholder="Nhập tiêu đề mô tả ngắn gọn nội dung bài viết" required
                                            maxlength="200">
                                        <div class="invalid-feedback">
                                            Vui lòng nhập tiêu đề bài viết
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <div class="form-text">
                                                Tiêu đề tốt giúp người đọc nắm bắt nội dung nhanh chóng
                                            </div>
                                            <div class="character-count" id="titleCount">0/200</div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="category" class="form-label required-field">Chuyên mục</label>
                                        <select class="form-select" id="category" name="category" required>
                                            <option value="">Chọn chuyên mục</option>
                                            <option value="job_search">Tìm việc làm</option>
                                            <option value="career_advice">Tư vấn nghề nghiệp</option>
                                            <option value="interview_tips">Kỹ năng phỏng vấn</option>
                                            <option value="resume_cv">Hồ sơ & CV</option>
                                            <option value="salary_negotiation">Đàm phán lương</option>
                                            <option value="workplace">Môi trường làm việc</option>
                                            <option value="skill_development">Phát triển kỹ năng</option>
                                            <option value="job_market">Thị trường lao động</option>
                                            <option value="other">Chuyên mục khác</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Vui lòng chọn chuyên mục cho bài viết
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label d-flex justify-content-between">
                                            <span>Thẻ tag</span>
                                            <small class="text-muted">Tối đa 5 thẻ</small>
                                        </label>
                                        <select class="form-control" id="tags" name="tags[]" multiple="multiple">
                                            <c:forEach items="${commonTags}" var="tag">
                                                <option value="${tag}">${tag}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">
                                            Thêm các thẻ tag liên quan để bài viết dễ dàng được tìm thấy
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Content Section -->
                            <div class="form-section">
                                <h3 class="form-section-title">
                                    <i class="fas fa-pen-fancy"></i>
                                    Nội dung
                                </h3>

                                <div class="form-group">
                                    <label for="content" class="form-label required-field">Nội dung bài viết</label>
                                    <textarea class="form-control" id="content" name="content" rows="10"
                                        required></textarea>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập nội dung bài viết
                                    </div>
                                    <div class="character-count" id="contentCount">0/50000</div>
                                </div>
                            </div>

                            <!-- Terms Section -->
                            <div class="terms-section">
                                <h4 class="terms-title">
                                    <i class="fas fa-shield-alt me-2"></i>
                                    Điều khoản đăng bài
                                </h4>
                                <p class="terms-content">
                                    Bằng cách đăng bài, bạn đồng ý với các điều khoản sau:
                                    <br>- Nội dung phải phù hợp với chuyên mục đã chọn
                                    <br>- Không vi phạm bản quyền và các quy định pháp luật
                                    <br>- Không chứa thông tin quảng cáo, spam hoặc nội dung không lành mạnh
                                    <br>- JobFinding có quyền chỉnh sửa hoặc gỡ bỏ nội dung vi phạm
                                </p>
                            </div>

                            <!-- Action Buttons -->
                            <div class="action-buttons">
                                <div class="button-group">
                                    <button type="submit" class="btn btn-primary" id="publishBtn">
                                        <i class="fas fa-paper-plane"></i>
                                        ${param.parentId != null ? 'Đăng bình luận' : 'Đăng bài'}
                                    </button>
                                    <button type="button" class="btn btn-outline-primary" id="saveDraftBtn">
                                        <i class="fas fa-save"></i>
                                        Lưu nháp
                                    </button>
                                    <a href="javascript:history.back()" class="btn btn-light">
                                        <i class="fas fa-times"></i>
                                        Hủy bỏ
                                    </a>
                                </div>
                                <span class="draft-status" id="draftStatus"></span>
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
                    // Initialize Select2 for tags with improved styling
                    $('#tags').select2({
                        tags: true,
                        tokenSeparators: [','],
                        maximumSelectionLength: 5,
                        placeholder: 'Thêm thẻ tag cho bài viết',
                        allowClear: true,
                        width: '100%',
                        theme: 'classic',
                        language: {
                            maximumSelected: function (e) {
                                return 'Bạn chỉ có thể chọn tối đa ' + e.maximum + ' thẻ tag';
                            },
                            noResults: function () {
                                return 'Không tìm thấy kết quả';
                            },
                            searching: function () {
                                return 'Đang tìm kiếm...';
                            }
                        }
                    });

                    // Character count for title with improved UI feedback
                    $('#title').on('input', function () {
                        const maxLength = 200;
                        const currentLength = $(this).val().length;
                        const $counter = $('#titleCount');
                        const percentage = currentLength / maxLength;

                        $counter.text(`${currentLength}/${maxLength}`);

                        if (percentage >= 0.9) {
                            $counter.removeClass('warning').addClass('danger');
                        } else if (percentage >= 0.8) {
                            $counter.removeClass('danger').addClass('warning');
                        } else {
                            $counter.removeClass('warning danger');
                        }
                    });

                    // Initialize TinyMCE with improved configuration
                    tinymce.init({
                        selector: '#content',
                        height: 500,
                        menubar: true,
                        plugins: [
                            'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                            'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                            'insertdatetime', 'media', 'table', 'help', 'wordcount', 'emoticons'
                        ],
                        toolbar: 'undo redo | formatselect | ' +
                            'bold italic forecolor backcolor | alignleft aligncenter ' +
                            'alignright alignjustify | bullist numlist outdent indent | ' +
                            'removeformat | link image media | emoticons | help',
                        content_style: 'body { font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; font-size: 14px; line-height: 1.6; }',
                        placeholder: 'Chia sẻ kiến thức, kinh nghiệm của bạn...',
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

                                    cb(blobInfo.blobUri(), { title: file.name });
                                };
                                reader.readAsDataURL(file);
                            };
                            input.click();
                        },
                        setup: function (editor) {
                            editor.on('KeyUp', function (e) {
                                const content = editor.getContent({ format: 'text' });
                                const maxLength = 50000;
                                const currentLength = content.length;
                                const $counter = $('#contentCount');
                                const percentage = currentLength / maxLength;

                                $counter.text(`${currentLength}/${maxLength}`);

                                if (percentage >= 0.9) {
                                    $counter.removeClass('warning').addClass('danger');
                                } else if (percentage >= 0.8) {
                                    $counter.removeClass('danger').addClass('warning');
                                } else {
                                    $counter.removeClass('warning danger');
                                }
                            });

                            // Auto-save draft with improved feedback
                            let autoSaveInterval = setInterval(function () {
                                saveDraft(true);
                            }, 30000);

                            editor.on('remove', function () {
                                clearInterval(autoSaveInterval);
                            });
                        }
                    });

                    // Enhanced form validation
                    const form = document.getElementById('postForm');
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();

                            // Scroll to first invalid field
                            const firstInvalid = form.querySelector(':invalid');
                            if (firstInvalid) {
                                firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }
                        }
                        form.classList.add('was-validated');
                    });

                    // Improved draft saving functionality
                    function saveDraft(isAuto = false) {
                        const formData = {
                            title: $('#title').val(),
                            category: $('#category').val(),
                            tags: $('#tags').val(),
                            content: tinymce.get('content').getContent(),
                            draftId: $('#draftId').val()
                        };

                        const $status = $('#draftStatus');

                        // Show saving indicator
                        $status.html('<i class="fas fa-spinner fa-spin"></i> Đang lưu...');

                        $.ajax({
                            url: 'save-draft',
                            type: 'POST',
                            data: JSON.stringify(formData),
                            contentType: 'application/json',
                            success: function (response) {
                                $('#draftId').val(response.draftId);
                                const now = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                                $status.html(
                                    '<i class="fas fa-check-circle"></i> ' +
                                    (isAuto ? `Tự động lưu lúc ${now}` : `Đã lưu nháp lúc ${now}`)
                                );

                                if (!isAuto) {
                                    setTimeout(() => $status.text(''), 3000);
                                }
                            },
                            error: function () {
                                $status.html('<i class="fas fa-exclamation-circle"></i> Lưu nháp thất bại')
                                    .addClass('text-danger');
                                setTimeout(() => {
                                    $status.text('').removeClass('text-danger');
                                }, 3000);
                            }
                        });
                    }

                    // Manual draft save with improved feedback
                    $('#saveDraftBtn').click(function () {
                        saveDraft();
                    });

                    // Load existing draft with loading indicator
                    const draftId = new URLSearchParams(window.location.search).get('draft_id');
                    if (draftId) {
                        const $form = $('#postForm');
                        $form.append('<div class="loading-overlay"><i class="fas fa-spinner fa-spin"></i> Đang tải bản nháp...</div>');

                        $.get(`get-draft?id=${draftId}`, function (draft) {
                            $('#draftId').val(draft.id);
                            $('#title').val(draft.title);
                            $('#category').val(draft.category);
                            $('#tags').val(draft.tags).trigger('change');
                            tinymce.get('content').setContent(draft.content);

                            $('.loading-overlay').remove();
                        });
                    }
                });
            </script>
        </body>

        </html>