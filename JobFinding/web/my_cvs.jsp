<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>CV của tôi | JobFinding</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <div class="container py-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1>CV của tôi</h1>
                        <a href="create_cv.jsp" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Tạo CV mới
                        </a>
                    </div>

                    <!-- CV List -->
                    <div class="row g-4">
                        <c:choose>
                            <c:when test="${not empty cvList}">
                                <c:forEach items="${cvList}" var="cv">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card h-100">
                                            <div class="position-relative">
                                                <img src="${cv.thumbnail}" class="card-img-top" alt="${cv.title}">
                                                <c:if test="${cv.isDefault}">
                                                    <span class="position-absolute top-0 start-0 badge bg-primary m-2">
                                                        Mặc định
                                                    </span>
                                                </c:if>
                                            </div>
                                            <div class="card-body">
                                                <h5 class="card-title">${cv.title}</h5>
                                                <p class="text-muted mb-3">
                                                    <small>
                                                        <i class="fas fa-clock me-1"></i>
                                                        Cập nhật:
                                                        <fmt:formatDate value="${cv.updatedAt}" pattern="dd/MM/yyyy" />
                                                    </small>
                                                </p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="btn-group">
                                                        <a href="edit_cv.jsp?id=${cv.id}"
                                                            class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="preview_cv.jsp?id=${cv.id}"
                                                            class="btn btn-sm btn-outline-secondary">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <button type="button"
                                                            class="btn btn-sm btn-outline-success download-cv"
                                                            data-cv-id="${cv.id}">
                                                            <i class="fas fa-download"></i>
                                                        </button>
                                                        <c:if test="${!cv.isDefault}">
                                                            <button type="button"
                                                                class="btn btn-sm btn-outline-info set-default"
                                                                data-cv-id="${cv.id}">
                                                                <i class="fas fa-star"></i>
                                                            </button>
                                                        </c:if>
                                                        <button type="button"
                                                            class="btn btn-sm btn-outline-danger delete-cv"
                                                            data-cv-id="${cv.id}">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                    <span class="badge bg-${cv.language == 'vi' ? 'info' : 'warning'}">
                                                        ${cv.language == 'vi' ? 'Tiếng Việt' : 'English'}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <div class="text-center py-5">
                                        <img src="assets/images/empty-cv.png" alt="No CVs" class="mb-4"
                                            style="width: 200px;">
                                        <h5>Bạn chưa có CV nào</h5>
                                        <p class="text-muted">Hãy tạo CV đầu tiên của bạn để bắt đầu ứng tuyển!</p>
                                        <a href="cv_templates.jsp" class="btn btn-primary mt-3">
                                            <i class="fas fa-plus me-2"></i>Tạo CV từ mẫu
                                        </a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Xác nhận xóa</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa CV này không?</p>
                                <p class="text-danger"><small>Hành động này không thể hoàn tác.</small></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-danger" id="confirmDelete">Xóa</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Success Toast -->
                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                    <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header">
                            <i class="fas fa-check-circle text-success me-2"></i>
                            <strong class="me-auto">Thành công</strong>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body"></div>
                    </div>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
                        const successToast = new bootstrap.Toast(document.getElementById('successToast'));
                        let cvToDelete = null;

                        // Delete CV
                        document.querySelectorAll('.delete-cv').forEach(button => {
                            button.addEventListener('click', function () {
                                cvToDelete = this.dataset.cvId;
                                deleteModal.show();
                            });
                        });

                        document.getElementById('confirmDelete').addEventListener('click', function () {
                            if (cvToDelete) {
                                fetch('delete_cv', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/x-www-form-urlencoded',
                                    },
                                    body: `cvId=${cvToDelete}`
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            location.reload();
                                        } else {
                                            throw new Error(data.message);
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                        alert('Có lỗi xảy ra. Vui lòng thử lại!');
                                    });
                            }
                            deleteModal.hide();
                        });

                        // Set Default CV
                        document.querySelectorAll('.set-default').forEach(button => {
                            button.addEventListener('click', function () {
                                const cvId = this.dataset.cvId;
                                fetch('set_default_cv', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/x-www-form-urlencoded',
                                    },
                                    body: `cvId=${cvId}`
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            location.reload();
                                        } else {
                                            throw new Error(data.message);
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                        alert('Có lỗi xảy ra. Vui lòng thử lại!');
                                    });
                            });
                        });

                        // Download CV
                        document.querySelectorAll('.download-cv').forEach(button => {
                            button.addEventListener('click', function () {
                                const cvId = this.dataset.cvId;
                                window.location.href = `download_cv?id=${cvId}`;
                            });
                        });
                    });
                </script>
            </body>

            </html>