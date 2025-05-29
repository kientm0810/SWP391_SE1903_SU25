<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chỉnh sửa bài viết - JobFinding</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
                    rel="stylesheet" />
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

                    .container {
                        max-width: 1140px;
                    }

                    .edit-post-container {
                        max-width: 800px;
                        margin: 2rem auto;
                        background: var(--white);
                        border-radius: 12px;
                        box-shadow: var(--box-shadow);
                        padding: 2rem;
                    }

                    .form-label {
                        font-weight: 500;
                        color: var(--secondary-color);
                    }

                    .form-control,
                    .form-select {
                        border: 1px solid var(--border-color);
                        border-radius: 8px;
                        padding: 0.75rem 1rem;
                        font-size: 1rem;
                    }

                    .form-control:focus,
                    .form-select:focus {
                        border-color: var(--primary-color);
                        box-shadow: 0 0 0 3px rgba(0, 177, 79, 0.1);
                    }

                    textarea.form-control {
                        min-height: 200px;
                        resize: vertical;
                    }

                    .btn-primary {
                        background-color: var(--primary-color);
                        border-color: var(--primary-color);
                        color: var(--white);
                        font-weight: 500;
                        padding: 0.75rem 1.5rem;
                        border-radius: 8px;
                        transition: all 0.2s;
                    }

                    .btn-primary:hover {
                        background-color: var(--primary-hover);
                        border-color: var(--primary-hover);
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(0, 177, 79, 0.2);
                    }

                    .btn-outline-secondary {
                        color: var(--secondary-color);
                        border-color: var(--border-color);
                        font-weight: 500;
                        padding: 0.75rem 1.5rem;
                        border-radius: 8px;
                    }

                    .btn-outline-secondary:hover {
                        background-color: var(--gray-light);
                        color: var(--secondary-color);
                        border-color: var(--border-color);
                    }

                    .nav-breadcrumb {
                        background-color: var(--white);
                        padding: 15px 0;
                        border-bottom: 1px solid var(--border-color);
                        box-shadow: var(--box-shadow);
                    }

                    .breadcrumb-item a {
                        color: #6c757d;
                        text-decoration: none;
                    }

                    .breadcrumb-item.active {
                        color: var(--primary-color);
                    }

                    .alert {
                        border-radius: 8px;
                        margin-bottom: 1.5rem;
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
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i
                                            class="fas fa-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/posts.jsp">Bài
                                        viết</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa bài viết</li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <div class="container">
                    <div class="edit-post-container">
                        <h2 class="mb-4">Chỉnh sửa bài viết</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/post" method="POST" id="editPostForm">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="postId" value="${post.id}">

                            <div class="mb-3">
                                <label for="title" class="form-label">Tiêu đề bài viết</label>
                                <input type="text" class="form-control" id="title" name="title"
                                    value="${fn:escapeXml(post.title)}" required>
                            </div>

                            <div class="mb-3">
                                <label for="content" class="form-label">Nội dung bài viết</label>
                                <textarea class="form-control" id="content" name="content"
                                    required>${fn:escapeXml(post.content)}</textarea>
                            </div>

                            <div class="d-flex gap-2 justify-content-end">
                                <a href="${pageContext.request.contextPath}/post/${post.id}"
                                    class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-2"></i>Hủy
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Lưu thay đổi
                                </button>
                            </div>
                        </form>
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
                        $('#editPostForm').on('submit', function (e) {
                            e.preventDefault();

                            const formData = $(this).serialize();

                            $.ajax({
                                url: '${pageContext.request.contextPath}/post',
                                type: 'POST',
                                data: formData,
                                success: function (response) {
                                    if (response.success) {
                                        window.location.href = '${pageContext.request.contextPath}/post/${post.id}';
                                    } else {
                                        alert('Có lỗi xảy ra khi cập nhật bài viết: ' + response.message);
                                    }
                                },
                                error: function (xhr) {
                                    if (xhr.status === 401) {
                                        window.location.href = '${pageContext.request.contextPath}/login';
                                    } else {
                                        alert('Có lỗi xảy ra: ' + (xhr.responseJSON?.message || 'Không thể kết nối đến server'));
                                    }
                                }
                            });
                        });
                    });
                </script>
            </body>

            </html>