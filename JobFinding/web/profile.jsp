<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Hồ sơ cá nhân | JobFinding</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <%@ include file="header.jsp" %>
                <div class="container py-5">
                    <!-- Success/Error Messages -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="successMessage" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session" />
                    </c:if>
                    <div class="row">
                        <!-- Profile Information -->
                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-body text-center">
                                                        <form id="avatarForm" method="post" action="avatar-upload" enctype="multipart/form-data">
                                                            <input type="hidden" name="action" value="uploadAvatar">
                                                            <input type="file" name="avatarFile" id="avatarFile" class="d-none" accept="image/png, image/jpeg" onchange="document.getElementById('avatarForm').submit();">
                                                            <img src="${sessionScope.user.profilePicture != null ? sessionScope.user.profilePicture : 'assets/img/elements/user.png'}" alt="Avatar" class="rounded-circle img-fluid" style="width: 150px; cursor:pointer;" onclick="document.getElementById('avatarFile').click();">
                                                            <small class="text-muted d-block mt-2">Nhấp vào ảnh để thay đổi</small>
                                                        </form>
                    <h5 class="my-3">${sessionScope.user.fullName}</h5>
                    <p class="text-muted mb-1">${sessionScope.user.desiredJobTitle != null ? sessionScope.user.desiredJobTitle : 'Tìm việc làm'}</p>
                    <p class="text-muted mb-4">${sessionScope.user.address != null ? sessionScope.user.address : 'Việt Nam'}</p>
                                    <!-- Buttons removed as per new design -->
                                </div>
                            </div>

                            <!-- Contact Information -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="mb-3">Thông tin liên hệ</h5>
                                    <div class="mb-3">
                                        <i class="fas fa-envelope me-2 text-primary"></i>
                                        <span>${sessionScope.user.email}</span>
                                    </div>
                                    <div class="mb-3">
                                        <i class="fas fa-phone me-2 text-primary"></i>
                                        <span>${sessionScope.user.phone != null ? sessionScope.user.phone : 'Chưa cập nhật'}</span>
                                    </div>
                                    <div class="mb-3">
                                        <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                                        <span>${sessionScope.user.address != null ? sessionScope.user.address : 'Chưa cập nhật'}</span>
                                    </div>
                                    <c:if test="${not empty sessionScope.user.portfolioUrl}">
                                        <div class="mb-3">
                                            <i class="fab fa-linkedin me-2 text-primary"></i>
                                            <a href="${sessionScope.user.portfolioUrl}" target="_blank" class="text-decoration-none">
                                                Portfolio/LinkedIn
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="col-lg-8">
                            <!-- CV Management -->
                            <div class="card mb-4">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">
                                        <i class="fas fa-file-alt text-primary me-2"></i>
                                        Quản lý CV 
                                        <span class="badge bg-primary ms-2">${totalCVs != null ? totalCVs : 0}</span>
                                    </h5>
                                    <a href="cv-upload" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus me-2"></i>Tạo CV mới
                                    </a>
                                </div>
                                <div class="card-body">
                                    <!-- Search Box -->
                                    <div class="mb-3">
                                        <form method="get" action="profile" class="position-relative">
                                            <input type="text" 
                                                   class="form-control" 
                                                   name="search" 
                                                   placeholder="Tìm kiếm CV theo tên hoặc vị trí..." 
                                                   value="${searchTerm}">
                                            <input type="hidden" name="page" value="1">
                                        </form>
                                    </div>

                                    <!-- CV List -->
                                    <c:choose>
                                        <c:when test="${empty cvList}">
                                            <div class="text-center py-4">
                                                <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                                                <h6 class="text-muted">Chưa có CV nào</h6>
                                                <p class="text-muted">Hãy tạo CV đầu tiên để bắt đầu tìm việc làm</p>
                                                <a href="cv-upload" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Tạo CV ngay
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="row">
                                                <c:forEach items="${cvList}" var="cv">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="card border">
                                                            <div class="card-body">
                                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                                    <h6 class="card-title mb-0">${cv.jobPosition}</h6>
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-sm btn-outline-secondary" 
                                                                                type="button" 
                                                                                data-bs-toggle="dropdown">
                                                                            <i class="fas fa-ellipsis-v"></i>
                                                                        </button>
                                                                        <ul class="dropdown-menu">
                                                                            <li>
                                                                                <a class="dropdown-item" href="cv-edit?id=${cv.id}">
                                                                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                                                                </a>
                                                                            </li>
                                                                            <c:if test="${not empty cv.pdfFilePath}">
                                                                                <li>
                                                                                    <a class="dropdown-item" href="${cv.pdfFilePath}" target="_blank">
                                                                                        <i class="fas fa-download me-2"></i>Tải xuống
                                                                                    </a>
                                                                                </li>
                                                                            </c:if>
                                                                            <li><hr class="dropdown-divider"></li>
                                                                            <li>
                                                                                <button class="dropdown-item text-danger" 
                                                                                        onclick="confirmDelete(${cv.id}, '${cv.jobPosition}')">
                                                                                    <i class="fas fa-trash me-2"></i>Xóa
                                                                                </button>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <p class="text-muted mb-1">
                                                                    <i class="fas fa-user me-1"></i>${cv.fullName}
                                                                </p>
                                                                <p class="text-muted small mb-2">
                                                                    <i class="fas fa-envelope me-1"></i>${cv.email}
                                                                </p>
                                                                <div class="d-flex justify-content-between text-muted small">
                                                                    <span>
                                                                        <i class="fas fa-calendar me-1"></i>
                                                                        <fmt:formatDate value="${cv.createdAt}" pattern="dd/MM/yyyy" />
                                                                    </span>
                                                                    <c:if test="${not empty cv.pdfFilePath}">
                                                                        <span class="text-success">
                                                                            <i class="fas fa-file-pdf me-1"></i>PDF
                                                                        </span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <div class="card-footer bg-light p-2">
                                                                <div class="d-flex gap-1">
                                                                    <a href="cv-edit?id=${cv.id}" class="btn btn-sm btn-outline-primary flex-fill">
                                                                        <i class="fas fa-edit me-1"></i>Sửa
                                                                    </a>
                                                                    <c:if test="${not empty cv.pdfFilePath}">
                                                                        <a href="${cv.pdfFilePath}" target="_blank" class="btn btn-sm btn-outline-success">
                                                                            <i class="fas fa-download"></i>
                                                                        </a>
                                                                    </c:if>
                                                                    <button class="btn btn-sm btn-outline-danger" 
                                                                            onclick="confirmDelete(${cv.id}, '${cv.jobPosition}')">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <!-- Pagination -->
                                            <c:if test="${totalPages > 1}">
                                                <nav class="d-flex justify-content-center mt-3">
                                                    <ul class="pagination">
                                                        <c:if test="${currentPage > 1}">
                                                            <li class="page-item">
                                                                <a class="page-link" href="profile?page=${currentPage - 1}&search=${searchTerm}">
                                                                    <i class="fas fa-chevron-left"></i>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                        
                                                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                                            <c:choose>
                                                                <c:when test="${pageNum == currentPage}">
                                                                    <li class="page-item active">
                                                                        <span class="page-link">${pageNum}</span>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li class="page-item">
                                                                        <a class="page-link" href="profile?page=${pageNum}&search=${searchTerm}">
                                                                            ${pageNum}
                                                                        </a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        
                                                        <c:if test="${currentPage < totalPages}">
                                                            <li class="page-item">
                                                                <a class="page-link" href="profile?page=${currentPage + 1}&search=${searchTerm}">
                                                                    <i class="fas fa-chevron-right"></i>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </ul>
                                                </nav>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                    Xác nhận xóa CV
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa CV "<span id="cvName"></span>"?</p>
                                <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <form id="deleteForm" method="post" action="profile" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="cvId" id="deleteCvId">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash me-2"></i>Xóa CV
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/main.js"></script>
                
                <script>
                    function confirmDelete(cvId, cvName) {
                        document.getElementById('deleteCvId').value = cvId;
                        document.getElementById('cvName').textContent = cvName;
                        new bootstrap.Modal(document.getElementById('deleteModal')).show();
                    }

                    // Auto-submit search form when typing (with debounce)
                    let searchTimeout;
                    const searchInput = document.querySelector('input[name="search"]');
                    if (searchInput) {
                        searchInput.addEventListener('input', function() {
                            clearTimeout(searchTimeout);
                            searchTimeout = setTimeout(() => {
                                this.form.submit();
                            }, 500);
                        });
                    }

                    // Auto-hide alerts after 5 seconds
                    setTimeout(() => {
                        const alerts = document.querySelectorAll('.alert');
                        alerts.forEach(alert => {
                            if (alert.querySelector('.btn-close')) {
                                const bsAlert = new bootstrap.Alert(alert);
                                bsAlert.close();
                            }
                        });
                    }, 5000);
                </script>
            </body>

            </html>