<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn ứng tuyển nhận được | JobFinding</title>

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
    <style>
        body {
            background: #f5f7fa;
        }

        .applications-header {
            background: linear-gradient(90deg, #009966 0%, #00c471 100%);
            border-radius: 18px;
            color: #fff;
            padding: 32px 32px 24px 32px;
            margin-bottom: 32px;
        }

        .applications-header h2 {
            font-weight: bold;
        }

        .applications-header .desc {
            font-size: 1.1rem;
            opacity: 0.95;
        }

        .applications-header .count {
            font-size: 1.05rem;
            margin-top: 12px;
        }

        .filter-section {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 12px #e0e0e0;
            padding: 20px;
            margin-bottom: 24px;
        }

        .filter-section .form-select, .filter-section .form-control {
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
        }

        .filter-section .form-select:focus, .filter-section .form-control:focus {
            border-color: #00b14f;
            box-shadow: 0 0 0 0.2rem rgba(0, 177, 79, .15);
        }

        .filter-section .btn-primary {
            background: #00b14f;
            border-color: #00b14f;
            border-radius: 8px;
            padding: 8px 24px;
            font-weight: 600;
        }

        .filter-section .btn-primary:hover {
            background: #009443;
            border-color: #009443;
        }

        .filter-section .btn-outline-secondary {
            border-color: #ddd;
            color: #666;
            border-radius: 8px;
            padding: 8px 20px;
        }

        .application-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 12px #e0e0e0;
            margin-bottom: 24px;
            padding: 24px 20px;
            display: flex;
            align-items: center;
            transition: box-shadow 0.2s;
        }

        .application-card:hover {
            box-shadow: 0 4px 24px #b2f2e5;
        }

        .candidate-avatar {
            width: 64px;
            height: 64px;
            object-fit: cover;
            border-radius: 50%;
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            margin-right: 24px;
        }

        .application-info {
            flex: 1;
        }

        .candidate-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #222;
            margin-bottom: 4px;
        }

        .job-title {
            color: #666;
            font-size: 0.97rem;
            margin-bottom: 2px;
        }

        .application-meta {
            font-size: 0.97rem;
            color: #888;
            margin-bottom: 4px;
        }

        .application-date {
            font-size: 0.93rem;
            color: #888;
        }

        .application-status {
            display: flex;
            flex-direction: column;
            gap: 8px;
            align-items: flex-end;
            min-width: 180px;
        }

        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            text-align: center;
            min-width: 100px;
        }

        .status-new {
            background: #e3f2fd;
            color: #1976d2;
        }

        .status-reviewed {
            background: #fff3e0;
            color: #f57c00;
        }

        .status-interviewed {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .status-offered {
            background: #e8f5e8;
            color: #388e3c;
        }

        .status-rejected {
            background: #ffebee;
            color: #d32f2f;
        }

        .application-actions .btn {
            min-width: 100px;
            font-size: 0.875rem;
            border-radius: 8px;
            padding: 6px 16px;
            margin-bottom: 4px;
        }

        .pagination-section {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 12px #e0e0e0;
            padding: 20px;
            margin-top: 24px;
        }

        .pagination .page-link {
            border: none;
            color: #00b14f;
            padding: 8px 16px;
            margin: 0 2px;
            border-radius: 8px;
        }

        .pagination .page-item.active .page-link {
            background: #00b14f;
            border-color: #00b14f;
        }

        .pagination .page-link:hover {
            background: #f0f9f4;
            color: #00b14f;
        }

        /* Candidate Modal Styles */
        .candidate-modal .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        }

        .candidate-modal .modal-header {
            background: linear-gradient(90deg, #009966 0%, #00c471 100%);
            color: white;
            border-radius: 16px 16px 0 0;
            padding: 20px 24px;
        }

        .candidate-modal .modal-title {
            font-weight: 600;
            font-size: 1.25rem;
        }

        .candidate-modal .btn-close {
            filter: brightness(0) invert(1);
        }

        .candidate-info-section {
            padding: 24px;
        }

        .candidate-avatar-large {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #e9ecef;
            margin-bottom: 16px;
        }

        .candidate-details h5 {
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .candidate-details p {
            color: #666;
            margin-bottom: 12px;
        }

        .cv-preview {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-top: 20px;
        }

        .cv-download-btn {
            background: #00b14f;
            border-color: #00b14f;
            border-radius: 8px;
            padding: 10px 24px;
            font-weight: 600;
        }

        .cv-download-btn:hover {
            background: #009443;
            border-color: #009443;
        }

        @media (max-width: 768px) {
            .application-card {
                flex-direction: column;
                align-items: flex-start;
            }

            .candidate-avatar {
                margin-bottom: 12px;
                margin-right: 0;
            }

            .application-status {
                flex-direction: row;
                width: 100%;
                justify-content: space-between;
                margin-top: 12px;
            }

            .application-actions {
                display: flex;
                flex-direction: row;
                gap: 8px;
            }
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="container py-4">
        <!-- Header -->
        <div class="applications-header">
            <h2><i class="fas fa-users me-2"></i>Đơn ứng tuyển nhận được</h2>
            <div class="desc">Quản lý và xem xét các đơn ứng tuyển từ ứng viên cho các vị trí của bạn.</div>
            <div class="count">Tổng cộng <b>${totalApplications}</b> đơn ứng tuyển</div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <form id="filterForm" method="get" action="applications">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label for="status" class="form-label fw-semibold text-dark">Trạng thái</label>
                        <select class="form-select" id="status" name="status">
                            <option value="">Tất cả trạng thái</option>
                            <option value="new" ${param.status == 'new' ? 'selected' : ''}>Mới</option>
                            <option value="reviewed" ${param.status == 'reviewed' ? 'selected' : ''}>Đã xem</option>
                            <option value="interviewed" ${param.status == 'interviewed' ? 'selected' : ''}>Đã phỏng vấn</option>
                            <option value="offered" ${param.status == 'offered' ? 'selected' : ''}>Đã đề nghị</option>
                            <option value="rejected" ${param.status == 'rejected' ? 'selected' : ''}>Từ chối</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="sortBy" class="form-label fw-semibold text-dark">Sắp xếp</label>
                        <select class="form-select" id="sortBy" name="sortBy">
                            <option value="applied_at" ${param.sortBy == 'applied_at' ? 'selected' : ''}>Ngày ứng tuyển</option>
                            <option value="candidate_name" ${param.sortBy == 'candidate_name' ? 'selected' : ''}>Tên ứng viên</option>
                            <option value="job_title" ${param.sortBy == 'job_title' ? 'selected' : ''}>Vị trí</option>
                            <option value="status" ${param.sortBy == 'status' ? 'selected' : ''}>Trạng thái</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="keyword" class="form-label fw-semibold text-dark">Tìm kiếm</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" 
                               placeholder="Tên ứng viên, vị trí..." value="${param.keyword}">
                    </div>
                    <div class="col-md-2">
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-filter me-1"></i>Lọc
                            </button>
                            <button type="button" class="btn btn-outline-secondary" onclick="resetFilters()">
                                <i class="fas fa-undo me-1"></i>Đặt lại
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${sessionScope.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="success" scope="session" />
        </c:if>
        
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session" />
        </c:if>

        <!-- Applications List -->
        <c:choose>
            <c:when test="${not empty applications}">
                <c:forEach items="${applications}" var="app">
                    <div class="application-card">
                        <img src="${not empty app.jobseeker.profilePicture ? app.jobseeker.profilePicture : 'assets/img/icon/user-default.png'}"
                             class="candidate-avatar" alt="${app.jobseeker.fullName}">
                        
                        <div class="application-info">
                            <div class="candidate-name">${app.jobseeker.fullName}</div>
                            <div class="job-title">Ứng tuyển: ${app.post.title}</div>
                            <div class="application-meta">
                                <span><i class="fas fa-envelope me-1"></i>${app.jobseeker.email}</span>
                                <span class="mx-2">|</span>
                                <span><i class="fas fa-phone me-1"></i>${app.jobseeker.phone}</span>
                            </div>
                            <div class="application-date">
                                Ứng tuyển: <fmt:formatDate value="${app.createdAt}" pattern="HH:mm, dd/MM/yyyy" />
                            </div>
                        </div>

                        <div class="application-status">
                            <span class="status-badge status-${fn:toLowerCase(app.status)}" data-app-id="${app.applicationId}">
                                <c:choose>
                                    <c:when test="${fn:toLowerCase(app.status) == 'new'}">Mới</c:when>
                                    <c:when test="${fn:toLowerCase(app.status) == 'reviewed'}">Đã xem</c:when>
                                    <c:when test="${fn:toLowerCase(app.status) == 'interviewed'}">Phỏng vấn</c:when>
                                    <c:when test="${fn:toLowerCase(app.status) == 'offered'}">Mời nhận việc</c:when>
                                    <c:when test="${fn:toLowerCase(app.status) == 'rejected'}">Từ chối</c:when>
                                    <c:otherwise>${app.status}</c:otherwise>
                                </c:choose>
                            </span>
                            
                            <div class="application-actions">
                                <button type="button" class="btn btn-primary btn-sm view-candidate-btn" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#candidateModal"
                                        data-fullname="${app.jobseeker.fullName}"
                                        data-email="${app.jobseeker.email}"
                                        data-phone="${app.jobseeker.phone}"
                                        data-avatar="${not empty app.jobseeker.profilePicture ? app.jobseeker.profilePicture : 'assets/img/icon/user-default.png'}"
                                        data-cv-url="${pageContext.request.contextPath}/${app.cvFile}"
                                        data-application-id="${app.applicationId}"
                                        data-current-status="${app.status}">
                                    <i class="fas fa-eye me-1"></i>Xem Chi Tiết
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination-section">
                        <div class="d-flex justify-content-center">
                            <nav>
                                <ul class="pagination mb-0">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&status=${param.status}&sortBy=${param.sortBy}&keyword=${param.keyword}">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&status=${param.status}&sortBy=${param.sortBy}&keyword=${param.keyword}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&status=${param.status}&sortBy=${param.sortBy}&keyword=${param.keyword}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <div class="mb-4">
                        <i class="fas fa-inbox fa-4x text-muted"></i>
                    </div>
                    <h5>Chưa có đơn ứng tuyển nào</h5>
                    <p class="text-muted">Khi có ứng viên ứng tuyển vào các vị trí của bạn, chúng sẽ hiển thị ở đây.</p>
                    <a href="create-post.jsp" class="btn btn-primary mt-3">
                        <i class="fas fa-plus me-2"></i>Đăng tin tuyển dụng
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Candidate Details Modal -->
    <div class="modal fade candidate-modal" id="candidateModal" tabindex="-1" aria-labelledby="candidateModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="candidateModalLabel">
                        <i class="fas fa-user-circle me-2"></i>Thông tin ứng viên
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex align-items-center mb-4">
                        <img id="modal-candidate-avatar" src="" class="candidate-avatar-large" alt="Avatar">
                        <div class="ms-4">
                            <h4 id="modal-candidate-name" class="mb-1"></h4>
                            <p class="text-muted mb-1">
                                <i class="fas fa-envelope me-2"></i><span id="modal-candidate-email"></span>
                            </p>
                            <p class="text-muted mb-0">
                                <i class="fas fa-phone me-2"></i><span id="modal-candidate-phone"></span>
                            </p>
                        </div>
                    </div>
                    <hr>
                    <div class="action-section text-center p-3">
                        <a id="modal-download-cv-btn" href="#" class="btn btn-success me-2" target="_blank" style="display: none;">
                            <i class="fas fa-download me-2"></i> Tải CV
                        </a>
                    </div>
                    <div class="update-status-section p-3 bg-light rounded">
                        <h6 class="mb-3">Cập nhật trạng thái</h6>
                        <form id="updateStatusForm" action="update-application-status" method="POST">
                            <input type="hidden" id="modal-application-id" name="applicationId" />
                            <input type="hidden" name="action" value="update" />
                            <select id="statusSelect" name="status" class="form-select mb-2" required>
                                <option value="">-- Chọn trạng thái --</option>
                                <option value="new">Mới</option>
                                <option value="reviewed">Đã xem</option>
                                <option value="interviewed">Phỏng vấn</option>
                                <option value="offered">Mời nhận việc</option>
                                <option value="rejected">Từ chối</option>
                            </select>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-save me-1"></i> Cập nhật trạng thái
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function resetFilters() {
            document.getElementById('status').value = '';
            document.getElementById('sortBy').value = 'applied_at';
            document.getElementById('keyword').value = '';
            document.getElementById('filterForm').submit();
        }

        document.addEventListener("DOMContentLoaded", function () {
            const candidateModal = document.getElementById('candidateModal');
            if (!candidateModal) return;

            const modalInstance = new bootstrap.Modal(candidateModal);
            const modalFullName = document.getElementById('modal-candidate-name');
            const modalEmail = document.getElementById('modal-candidate-email');
            const modalPhone = document.getElementById('modal-candidate-phone');
            const modalAvatar = document.getElementById('modal-candidate-avatar');
            const modalDownloadCvBtn = document.getElementById('modal-download-cv-btn');
            const modalApplicationIdInput = document.getElementById('modal-application-id');
            const statusSelectModal = document.getElementById('statusSelect');
            const updateStatusForm = document.getElementById('updateStatusForm');

            // Handle modal open - populate with candidate data
            document.querySelectorAll('.view-candidate-btn').forEach(button => {
                button.addEventListener('click', function () {
                    // Populate modal with candidate info
                    modalFullName.textContent = this.dataset.fullname || 'N/A';
                    modalEmail.textContent = this.dataset.email || 'N/A';
                    modalPhone.textContent = this.dataset.phone || 'N/A';
                    modalAvatar.src = this.dataset.avatar || 'assets/img/icon/user-default.png';
                    
                    // Set application ID for form submission
                    modalApplicationIdInput.value = this.dataset.applicationId || '';
                    
                    // Set current status as selected
                    const currentStatus = this.dataset.currentStatus || '';
                    statusSelectModal.value = currentStatus.toLowerCase();
                    
                    // Handle CV download
                    const cvUrl = this.dataset.cvUrl;
                    if (cvUrl && cvUrl !== 'null' && cvUrl !== '') {
                        modalDownloadCvBtn.href = cvUrl;
                        modalDownloadCvBtn.style.display = 'inline-block';
                    } else {
                        modalDownloadCvBtn.style.display = 'none';
                    }
                    
                    modalInstance.show();
                });
            });

            // Handle form submission with confirmation
            updateStatusForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const applicationId = modalApplicationIdInput.value;
                const selectedStatus = statusSelectModal.value;
                const selectedText = statusSelectModal.options[statusSelectModal.selectedIndex].text;
                
                // Simple validation
                if (!applicationId) {
                    alert('Lỗi: Không tìm thấy ID ứng tuyển.');
                    return;
                }
                
                if (!selectedStatus) {
                    alert('Vui lòng chọn trạng thái.');
                    return;
                }
                
                // Show confirmation dialog
                if (confirm(`Bạn có chắc muốn cập nhật trạng thái thành "${selectedText}"?`)) {
                    // Submit the form normally - this will cause a page reload
                    this.submit();
                }
            });
        });
    </script>
</body>
</html> 