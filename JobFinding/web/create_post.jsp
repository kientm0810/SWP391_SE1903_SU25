<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${param.parentId != null ? 'Add Comment' : 'Create New Post'}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <style>
            body {
                background-color: #f8f9fa;
                padding-top: 76px;
            }

            .form-container {
                max-width: 800px;
                margin: 2rem auto;
                background: #fff;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            .form-header {
                background: #f8f9fa;
                padding: 1.5rem;
                border-bottom: 1px solid #e9ecef;
                border-radius: 8px 8px 0 0;
            }

            .form-title {
                color: #2d3846;
                margin: 0;
                font-size: 1.5rem;
                font-weight: 600;
            }

            .form-body {
                padding: 2rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                font-weight: 500;
                color: #2d3846;
                margin-bottom: 0.5rem;
            }

            .form-control {
                border: 1px solid #dce0e3;
                padding: 0.75rem;
                border-radius: 4px;
                transition: all 0.3s;
            }

            .form-control:focus {
                border-color: #00b14f;
                box-shadow: 0 0 0 0.2rem rgba(0, 177, 79, 0.25);
            }

            .btn-primary {
                background-color: #00b14f;
                border-color: #00b14f;
                padding: 0.75rem 1.5rem;
                font-weight: 500;
            }

            .btn-primary:hover {
                background-color: #009443;
                border-color: #009443;
            }

            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
                padding: 0.75rem 1.5rem;
                font-weight: 500;
            }

            .tag-input {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                padding: 0.5rem;
                border: 1px solid #dce0e3;
                border-radius: 4px;
                min-height: 46px;
            }

            .tag {
                background: #e9ecef;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.875rem;
            }

            .tag-remove {
                cursor: pointer;
                color: #6c757d;
            }

            .tag-remove:hover {
                color: #dc3545;
            }

            .tox-tinymce {
                border: 1px solid #dce0e3 !important;
                border-radius: 4px !important;
            }

            .page-breadcrumb {
                background: #fff;
                padding: 1rem 0;
                border-bottom: 1px solid #e9ecef;
                margin-bottom: 2rem;
            }

            .breadcrumb-item a {
                color: #6c757d;
                text-decoration: none;
            }

            .breadcrumb-item.active {
                color: #00b14f;
            }

            .form-text {
                font-size: 0.875rem;
                color: #6c757d;
            }

            .required-field::after {
                content: "*";
                color: #dc3545;
                margin-left: 4px;
            }

            .character-count {
                font-size: 0.875rem;
                color: #6c757d;
                text-align: right;
                margin-top: 0.25rem;
            }

            .character-count.warning {
                color: #ffc107;
            }

            .character-count.danger {
                color: #dc3545;
            }

            .image-preview {
                max-width: 200px;
                max-height: 200px;
                margin-top: 1rem;
                border-radius: 4px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .select2-container--default .select2-selection--multiple {
                border: 1px solid #dce0e3;
                border-radius: 4px;
                min-height: 46px;
            }

            .select2-container--default.select2-container--focus .select2-selection--multiple {
                border-color: #00b14f;
                box-shadow: 0 0 0 0.2rem rgba(0, 177, 79, 0.25);
            }

            .draft-status {
                font-size: 0.875rem;
                color: #6c757d;
                margin-left: 1rem;
            }

            @media (max-width: 768px) {
                .form-container {
                    margin: 1rem;
                }

                .form-body {
                    padding: 1rem;
                }

                .btn-group {
                    flex-direction: column;
                    width: 100%;
                }

                .btn-group .btn {
                    margin-bottom: 0.5rem;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <!-- Breadcrumb -->
        <div class="page-breadcrumb">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="home"><i class="fas fa-home"></i></a></li>
                        <!--                            <li class="breadcrumb-item"><a href="posts">Community</a></li>-->
                        <li class="breadcrumb-item active" aria-current="page">
                            ${param.parentId != null ? 'Add Comment' : 'Create Post'}
                        </li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container">
            <div class="form-container">
                <div class="form-header">
                    <h1 class="form-title">
                        <i class="fas fa-edit me-2"></i>
                        ${param.parentId != null ? 'Add Comment' : 'Create New Post'}
                    </h1>
                </div>

                <div class="form-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
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
                            <div class="form-group">
                                <label for="title" class="form-label required-field">Title</label>
                                <input type="text" class="form-control" id="title" name="title"
                                       placeholder="Enter a descriptive title for your post" required maxlength="200">
                                <div class="invalid-feedback">
                                    Please provide a title for your post.
                                </div>
                                <div class="d-flex justify-content-between">
                                    <div class="form-text">
                                        A good title helps others understand your post at a glance
                                    </div>
                                    <div class="character-count" id="titleCount">0/200</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="category" class="form-label required-field">Category</label>
                                <select class="form-select" id="category" name="category" required>
                                    <option value="">Select a category</option>
                                    <option value="job_search">Job Search</option>
                                    <option value="career_advice">Career Advice</option>
                                    <option value="interview_tips">Interview Tips</option>
                                    <option value="resume_cv">Resume/CV</option>
                                    <option value="salary_negotiation">Salary Negotiation</option>
                                    <option value="workplace">Workplace</option>
                                    <option value="skill_development">Skill Development</option>
                                    <option value="job_market">Job Market</option>
                                    <option value="other">Other</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a category for your post.
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label d-flex justify-content-between">
                                    <span>Tags</span>
                                    <small class="text-muted">Select up to 5 tags</small>
                                </label>
                                <select class="form-control" id="tags" name="tags[]" multiple="multiple">
                                    <c:forEach items="${commonTags}" var="tag">
                                        <option value="${tag}">${tag}</option>
                                    </c:forEach>
                                </select>
                                <div class="form-text">
                                    Add relevant tags to help others find your post
                                </div>
                            </div>
                        </c:if>

                        <div class="form-group">
                            <label for="content" class="form-label required-field">Content</label>
                            <textarea class="form-control" id="content" name="content" rows="10"
                                      required></textarea>
                            <div class="invalid-feedback">
                                Please provide content for your post.
                            </div>
                            <div class="character-count" id="contentCount">0/50000</div>
                        </div>

                        <div class="form-group d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <button type="submit" class="btn btn-primary" id="publishBtn">
                                    <i class="fas fa-paper-plane me-2"></i>
                                    ${param.parentId != null ? 'Post Comment' : 'Publish Post'}
                                </button>
                                <button type="button" class="btn btn-outline-primary" id="saveDraftBtn">
                                    <i class="fas fa-save me-2"></i>
                                    Save Draft
                                </button>
                                <a href="javascript:history.back()" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
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
                // Initialize Select2 for tags
                $('#tags').select2({
                    tags: true,
                    tokenSeparators: [','],
                    maximumSelectionLength: 5,
                    placeholder: 'Add relevant tags',
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
                                menubar: true,
                                plugins: [
                                    'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                                    'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                                    'insertdatetime', 'media', 'table', 'help', 'wordcount', 'emoticons'
                                ],
                                toolbar: 'undo redo | formatselect | ' +
                                        'bold italic forecolor backcolor | alignleft aligncenter ' +
                                        'alignright alignjustify | bullist numlist outdent indent | ' +
                                        'removeformat | image media link emoticons | help',
                                content_style: 'body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial; font-size: 14px; }',
                                placeholder: 'Share your thoughts, questions, or insights...',
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

                                                        // Auto-save draft every 30 seconds
                                                        let autoSaveInterval = setInterval(function () {
                                                            saveDraft(true);
                                                        }, 30000);

                                                        editor.on('remove', function () {
                                                            clearInterval(autoSaveInterval);
                                                        });
                                                    }
                                                });

                                                // Form validation
                                                const form = document.getElementById('postForm');
                                                form.addEventListener('submit', function (event) {
                                                    if (!form.checkValidity()) {
                                                        event.preventDefault();
                                                        event.stopPropagation();
                                                    }
                                                    form.classList.add('was-validated');
                                                });

                                                // Save draft functionality
                                                function saveDraft(isAuto = false) {
                                                    const formData = {
                                                        title: $('#title').val(),
                                                        category: $('#category').val(),
                                                        tags: $('#tags').val(),
                                                        content: tinymce.get('content').getContent(),
                                                        draftId: $('#draftId').val()
                                                    };

                                                    $.ajax({
                                                        url: 'save-draft',
                                                        type: 'POST',
                                                        data: JSON.stringify(formData),
                                                        contentType: 'application/json',
                                                        success: function (response) {
                                                            $('#draftId').val(response.draftId);
                                                            const now = new Date().toLocaleTimeString();
                                                            $('#draftStatus').text(isAuto ? `Auto-saved at ${now}` : `Draft saved at ${now}`);
                                                            setTimeout(() => $('#draftStatus').text(''), 3000);
                                                        },
                                                        error: function () {
                                                            $('#draftStatus').text('Failed to save draft').addClass('text-danger');
                                                            setTimeout(() => {
                                                                $('#draftStatus').text('').removeClass('text-danger');
                                                            }, 3000);
                                                        }
                                                    });
                                                }

                                                // Manual draft save
                                                $('#saveDraftBtn').click(function () {
                                                    saveDraft();
                                                });

                                                // Load existing draft if available
                                                const draftId = new URLSearchParams(window.location.search).get('draft_id');
                                                if (draftId) {
                                                    $.get(`get-draft?id=${draftId}`, function (draft) {
                                                        $('#draftId').val(draft.id);
                                                        $('#title').val(draft.title);
                                                        $('#category').val(draft.category);
                                                        $('#tags').val(draft.tags).trigger('change');
                                                        tinymce.get('content').setContent(draft.content);
                                                    });
                                                }
                                            });
        </script>
    </body>

</html>