<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Post</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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

            .btn-secondary:hover {
                background-color: #5a6268;
                border-color: #5a6268;
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
                        <li class="breadcrumb-item"><a href="posts">Community</a></li>
                        <li class="breadcrumb-item"><a href="post/${post.id}">Post</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Edit Post</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container">
            <div class="form-container">
                <div class="form-header">
                    <h1 class="form-title">
                        <i class="fas fa-edit me-2"></i>
                        Edit Post
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

                        <div class="form-group">
                            <label for="title" class="form-label required-field">Title</label>
                            <input type="text" class="form-control" id="title" name="title" value="${post.title}"
                                   placeholder="Enter a descriptive title for your post" required>
                            <div class="invalid-feedback">
                                Please provide a title for your post.
                            </div>
                            <div class="form-text">
                                A good title helps others understand your post at a glance
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label d-flex justify-content-between">
                                <span>Tags</span>
                                <small class="text-muted">Press Enter to add a tag</small>
                            </label>
                            <div class="tag-input" id="tagContainer">
                                <c:forEach items="${post.tags}" var="tag">
                                    <span class="tag">
                                        ${tag}
                                        <i class="fas fa-times tag-remove"></i>
                                        <input type="hidden" name="tags[]" value="${tag}">
                                    </span>
                                </c:forEach>
                                <input type="text" class="form-control form-control-sm border-0" id="tagInput"
                                       placeholder="Add relevant tags">
                            </div>
                            <div class="form-text">
                                Add up to 5 tags to help others find your post
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="content" class="form-label required-field">Content</label>
                            <textarea class="form-control" id="content" name="content" rows="10"
                                      required>${post.content}</textarea>
                            <div class="invalid-feedback">
                                Please provide content for your post.
                            </div>
                        </div>

                        <div class="form-group d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>
                                Save Changes
                            </button>
                            <a href="post/${post.id}" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i>
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- API TinyMCE -->
        <script
            src="https://cdn.tiny.cloud/1/ainjahbwyamlr1ureczw2mbfmr73mgpn7f6ceaaxu1h8ccv8/tinymce/6/tinymce.min.js"
        referrerpolicy="origin"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Initialize TinyMCE with enhanced configuration
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

                            cb(blobInfo.blobUri(), {title: file.name});
                        };
                        reader.readAsDataURL(file);
                    };
                    input.click();
                },
                setup: function (editor) {
                    editor.on('change', function () {
                        editor.save();
                    });
                },
                image_title: true,
                image_caption: true,
                image_dimensions: false,
                paste_data_images: true,
                browser_spellcheck: true,
                contextmenu: 'link image table',
                draggable_modal: true
            });

            // Form validation
            (function () {
                'use strict'
                var forms = document.querySelectorAll('.needs-validation')
                Array.prototype.slice.call(forms)
                        .forEach(function (form) {
                            form.addEventListener('submit', function (event) {
                                if (!form.checkValidity()) {
                                    event.preventDefault()
                                    event.stopPropagation()
                                }
                                form.classList.add('was-validated')
                            }, false)
                        })
            })()

            // Tags functionality
            const tagInput = document.getElementById('tagInput');
            const tagContainer = document.getElementById('tagContainer');
            let tags = Array.from(document.querySelectorAll('.tag')).map(tag =>
                tag.textContent.trim().replace(/×$/, '').trim()
            );

            if (tagInput) {
                tagInput.addEventListener('keydown', function (e) {
                    if (e.key === 'Enter' && this.value.trim()) {
                        e.preventDefault();
                        const tag = this.value.trim();
                        if (!tags.includes(tag) && tags.length < 5) {
                            tags.push(tag);
                            const tagElement = document.createElement('span');
                            tagElement.className = 'tag';
                            tagElement.innerHTML = `
            ${tag}
                        <i class="fas fa-times tag-remove"></i>
                        <input type="hidden" name="tags[]" value="${tag}">
                    `;
                            tagContainer.insertBefore(tagElement, this);

                            // Add remove event
                            tagElement.querySelector('.tag-remove').addEventListener('click', function () {
                                tagElement.remove();
                                tags = tags.filter(t => t !== tag);
                            });
                        }
                        this.value = '';
                    }
                });

                // Add remove event to existing tags
                document.querySelectorAll('.tag-remove').forEach(removeBtn => {
                    removeBtn.addEventListener('click', function () {
                        const tagElement = this.parentElement;
                        const tagText = tagElement.textContent.trim().replace(/×$/, '').trim();
                        tagElement.remove();
                        tags = tags.filter(t => t !== tagText);
                    });
                });
            }
        </script>
    </body>

</html>