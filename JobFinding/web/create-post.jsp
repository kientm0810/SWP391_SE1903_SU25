<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Create New Post</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
            <style>
                .form-container {
                    max-width: 800px;
                    margin: 0 auto;
                }

                .tox-tinymce {
                    min-height: 400px;
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
                            <h2 class="card-title mb-4">Create New Post</h2>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/post" method="POST" id="createPostForm">
                                <div class="mb-3">
                                    <label for="title" class="form-label">Title</label>
                                    <input type="text" class="form-control" id="title" name="title" required
                                        maxlength="200" value="${param.title}">
                                </div>

                                <div class="mb-3">
                                    <label for="content" class="form-label">Content</label>
                                    <textarea class="form-control" id="content" name="content"
                                        required>${param.content}</textarea>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/post" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to Posts
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i> Create Post
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
             <script src="https://cdn.tiny.cloud/1/ainjahbwyamlr1ureczw2mbfmr73mgpn7f6ceaaxu1h8ccv8/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
            <script>
                tinymce.init({
                    selector: '#content',
                    plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount',
                    toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
                    height: 400,
                    menubar: true,
                    images_upload_url: '${pageContext.request.contextPath}/upload/image',
                    automatic_uploads: true,
                    file_picker_types: 'image',
                    images_reuse_filename: true,
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
                    setup: function (editor) {
                        editor.on('change', function () {
                            editor.save(); // Save content to textarea
                        });
                    }
                });

                // Form submission handling
                document.getElementById('createPostForm').addEventListener('submit', function (e) {
                    e.preventDefault();
                    // Ensure TinyMCE content is saved to textarea
                    tinymce.triggerSave();
                    // Submit the form
                    this.submit();
                });
            </script>
        </body>

        </html>