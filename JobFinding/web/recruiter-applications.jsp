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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
              rel="stylesheet">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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

            .filter-section .form-select,
            .filter-section .form-control {
                border: 1.5px solid #e0e0e0;
                border-radius: 8px;
            }

            .filter-section .form-select:focus,
            .filter-section .form-control:focus {
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

            .cv-download-btn.disabled {
                background: #6c757d;
                border-color: #6c757d;
                opacity: 0.6;
                cursor: not-allowed;
            }

            .cv-download-btn.disabled:hover {
                background: #6c757d;
                border-color: #6c757d;
            }

            .btn-secondary.disabled {
                background: #6c757d;
                border-color: #6c757d;
                opacity: 0.6;
                cursor: not-allowed;
            }

            .btn-secondary.disabled:hover {
                background: #6c757d;
                border-color: #6c757d;
                opacity: 0.6;
            }

            /* Additional form field styles */
            .form-text {
                font-size: 0.875rem;
                color: #6c757d;
                margin-top: 0.25rem;
            }

            .alert-info {
                background-color: #d1ecf1;
                border-color: #bee5eb;
                color: #0c5460;
            }

            .text-danger {
                color: #dc3545 !important;
            }

            .text-success {
                color: #28a745 !important;
            }

            .fw-semibold {
                font-weight: 600 !important;
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
                    flex-wrap: wrap;
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
                <div class="desc">Quản lý và xem xét các đơn ứng tuyển từ ứng viên cho các vị trí của bạn.
                </div>
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
                                <option value="new" ${param.status=='new' ? 'selected' : '' }>Mới</option>
                                <option value="reviewed" ${param.status=='reviewed' ? 'selected' : '' }>Đã
                                    xem</option>
                                <option value="interviewed" ${param.status=='interviewed' ? 'selected' : ''
                                        }>Đã phỏng vấn</option>
                                <option value="offered" ${param.status=='offered' ? 'selected' : '' }>Đã đề
                                    nghị</option>
                                <option value="rejected" ${param.status=='rejected' ? 'selected' : '' }>Từ
                                    chối</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="sortBy" class="form-label fw-semibold text-dark">Sắp xếp</label>
                            <select class="form-select" id="sortBy" name="sortBy">
                                <option value="applied_at" ${param.sortBy=='applied_at' ? 'selected' : '' }>
                                    Ngày ứng tuyển</option>
                                <option value="candidate_name" ${param.sortBy=='candidate_name' ? 'selected'
                                                                 : '' }>Tên ứng viên</option>
                                <option value="job_title" ${param.sortBy=='job_title' ? 'selected' : '' }>Vị
                                    trí</option>
                                <option value="status" ${param.sortBy=='status' ? 'selected' : '' }>Trạng
                                    thái</option>
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
                                <button type="button" class="btn btn-outline-secondary"
                                        onclick="resetFilters()">
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
                    <c:if test="${not empty sessionScope.emailSent}">
                        <br><i class="fas fa-envelope me-2"></i><strong>Email đã được gửi tự động</strong>
                        trực tiếp đến email của ứng viên.
                    </c:if>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="success" scope="session" />
                <c:remove var="emailSent" scope="session" />
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
                                    Ứng tuyển:
                                    <fmt:formatDate value="${app.createdAt}" pattern="HH:mm, dd/MM/yyyy" />
                                </div>
                            </div>

                            <div class="application-status">
                                <span class="status-badge status-${fn:toLowerCase(app.status)}"
                                      data-app-id="${app.applicationId}">
                                    <c:choose>
                                        <c:when test="${fn:toLowerCase(app.status) == 'new'}">Mới</c:when>
                                        <c:when test="${fn:toLowerCase(app.status) == 'reviewed'}">Đã xem
                                        </c:when>
                                        <c:when test="${fn:toLowerCase(app.status) == 'interviewed'}">Phỏng
                                            vấn</c:when>
                                        <c:when test="${fn:toLowerCase(app.status) == 'offered'}">Mời nhận
                                            việc</c:when>
                                        <c:when test="${fn:toLowerCase(app.status) == 'rejected'}">Từ chối
                                        </c:when>
                                        <c:otherwise>${app.status}</c:otherwise>
                                    </c:choose>
                                </span>

                                <div class="application-actions">
                                    <button type="button" class="btn btn-primary btn-sm view-candidate-btn"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#candidateModal-${app.applicationId}"
                                            data-fullname="${app.jobseeker.fullName}"
                                            data-email="${app.jobseeker.email}"
                                            data-phone="${app.jobseeker.phone}"
                                            data-avatar="${not empty app.jobseeker.profilePicture ? app.jobseeker.profilePicture : 'assets/img/icon/user-default.png'}"
                                            data-cv-url="${pageContext.request.contextPath}/${app.cvFile}"
                                            data-application-id="${app.applicationId}"
                                            data-current-status="${app.status}"
                                            data-job-title="${app.post.title}"
                                            data-company-name="${app.post.companyName}">
                                        <i class="fas fa-eye me-1"></i>Xem Chi Tiết
                                    </button>
                                    <c:choose>
                                        <c:when test="${not empty app.cvFile}">
                                            <a href="${pageContext.request.contextPath}/${app.cvFile}"
                                               class="btn btn-info btn-sm" target="_blank">
                                                <i class="fas fa-download me-1"></i>Tải CV
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-secondary btn-sm" disabled
                                                    title="CV không có sẵn">
                                                <i class="fas fa-download me-1"></i>Tải CV
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
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
                                                <a class="page-link"
                                                   href="?page=${currentPage - 1}&status=${param.status}&sortBy=${param.sortBy}&keyword=${param.keyword}">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link"
                                                   href="?page=${i}&status=${param.status}&sortBy=${param.sortBy}&keyword=${param.keyword}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                   href="?page=${currentPage + 1}&status=${param.status}&sortBy=${param.sortBy}&keyword=${param.keyword}">
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
                        <p class="text-muted">Khi có ứng viên ứng tuyển vào các vị trí của bạn, chúng sẽ
                            hiển thị ở đây.</p>
                        <a href="create-post.jsp" class="btn btn-primary mt-3">
                            <i class="fas fa-plus me-2"></i>Đăng tin tuyển dụng
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Candidate Details Modal -->
        <c:forEach items="${applications}" var="app" varStatus="status">
            <div class="modal fade candidate-modal" id="candidateModal-${app.applicationId}" tabindex="-1"
                 aria-labelledby="candidateModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="candidateModalLabel">
                                <i class="fas fa-user-circle me-2"></i>Thông tin ứng viên
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <!-- Profile Sidebar -->
                                <div class="col-lg-4 mb-4 mb-lg-0">
                                    <div class="text-center mb-4">
                                        <img src="${not empty app.jobseeker.profilePicture ? app.jobseeker.profilePicture : 'assets/img/elements/user.png'}" alt="Avatar" class="rounded-circle img-fluid border border-3" style="width: 140px;">
                                        <h4 class="mt-3 mb-1">${app.jobseeker.fullName}</h4>
                                        <p class="text-muted mb-1">${not empty app.jobseeker.desiredJobTitle ? app.jobseeker.desiredJobTitle : 'Ứng viên'}</p>
                                        <p class="text-muted mb-2"><i class="fas fa-map-marker-alt me-1"></i>${not empty app.jobseeker.address ? app.jobseeker.address : 'Chưa cập nhật'}</p>
                                    </div>
                                    <div class="bg-white rounded-3 shadow-sm p-3 mb-3">
                                        <h6 class="fw-bold mb-3 text-success"><i class="fas fa-address-card me-2"></i>Liên hệ</h6>
                                        <div class="mb-2"><i class="fas fa-envelope me-2 text-success"></i>${app.jobseeker.email}</div>
                                        <div class="mb-2"><i class="fas fa-phone me-2 text-success"></i>${not empty app.jobseeker.phone ? app.jobseeker.phone : 'Chưa cập nhật'}</div>
                                        <div class="mb-2"><i class="fas fa-birthday-cake me-2 text-success"></i>${not empty app.jobseeker.dateOfBirth ? app.jobseeker.dateOfBirth : 'Chưa cập nhật'}</div>
                                        <div class="mb-2"><i class="fas fa-venus-mars me-2 text-success"></i>${not empty app.jobseeker.gender ? app.jobseeker.gender : 'Chưa cập nhật'}</div>
                                            <c:if test="${not empty app.jobseeker.portfolioUrl}">
                                            <div class="mb-2"><i class="fab fa-linkedin me-2 text-success"></i><a href="${app.jobseeker.portfolioUrl}" target="_blank" class="text-decoration-none">Portfolio/LinkedIn</a></div>
                                                </c:if>
                                    </div>
                                </div>
                                <!-- Main Content -->
                                <div class="col-lg-8">
                                    <!-- Experience Section -->
                                    <div class="profile-section mb-4">
                                        <div class="section-header d-flex align-items-center" style="background: linear-gradient(135deg, #28a745, #20c997); color: white; border-radius: 12px 12px 0 0; padding: 16px 24px;">
                                            <h6 class="mb-0"><i class="fas fa-briefcase me-2"></i>Kinh nghiệm làm việc</h6>
                                        </div>
                                        <div class="section-body p-3 bg-white rounded-bottom">
                                            <c:choose>
                                                <c:when test="${empty app.jobseeker.experiences}">
                                                    <div class="text-center text-muted py-3">Chưa có kinh nghiệm làm việc</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${app.jobseeker.experiences}" var="exp">
                                                        <div class="timeline-item mb-3">
                                                            <div class="item-header d-flex justify-content-between align-items-start">
                                                                <div>
                                                                    <div class="item-title fw-bold">${exp.position}</div>
                                                                    <div class="item-company text-success">${exp.companyName}</div>
                                                                    <div class="item-meta text-muted small">
                                                                        <i class="fas fa-map-marker-alt me-1"></i>${exp.location}
                                                                        <span class="mx-2">•</span>
                                                                        <i class="fas fa-calendar me-1"></i>
                                                                        <fmt:formatDate value="${exp.startDate}" pattern="MM/yyyy" /> -
                                                                        <c:choose>
                                                                            <c:when test="${exp.current}"><span class="badge bg-info text-white">Hiện tại</span></c:when>
                                                                            <c:otherwise><fmt:formatDate value="${exp.endDate}" pattern="MM/yyyy" /></c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <c:if test="${not empty exp.description}">
                                                                <div class="item-description mt-2">${exp.description}</div>
                                                            </c:if>
                                                            <c:if test="${not empty exp.skillsUsed}">
                                                                <div class="mt-2">
                                                                    <c:forEach items="${fn:split(exp.skillsUsed, ',')}" var="skill">
                                                                        <span class="badge bg-light text-success border me-1">${fn:trim(skill)}</span>
                                                                    </c:forEach>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <!-- Education Section -->
                                    <div class="profile-section mb-4">
                                        <div class="section-header d-flex align-items-center" style="background: linear-gradient(135deg, #28a745, #20c997); color: white; border-radius: 12px 12px 0 0; padding: 16px 24px;">
                                            <h6 class="mb-0"><i class="fas fa-graduation-cap me-2"></i>Học vấn</h6>
                                        </div>
                                        <div class="section-body p-3 bg-white rounded-bottom">
                                            <c:choose>
                                                <c:when test="${empty app.jobseeker.educations}">
                                                    <div class="text-center text-muted py-3">Chưa có thông tin học vấn</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${app.jobseeker.educations}" var="edu">
                                                        <div class="timeline-item mb-3">
                                                            <div class="item-header d-flex justify-content-between align-items-start">
                                                                <div>
                                                                    <div class="item-title fw-bold">${edu.degree} <c:if test="${not empty edu.fieldOfStudy}">- ${edu.fieldOfStudy}</c:if></div>
                                                                    <div class="item-company text-success">${edu.institutionName}</div>
                                                                    <div class="item-meta text-muted small">
                                                                        <c:if test="${not empty edu.location}"><i class="fas fa-map-marker-alt me-1"></i>${edu.location}<span class="mx-2">•</span></c:if>
                                                                            <i class="fas fa-calendar me-1"></i>
                                                                        <fmt:formatDate value="${edu.startDate}" pattern="MM/yyyy" /> -
                                                                        <c:choose>
                                                                            <c:when test="${edu.current}"><span class="badge bg-info text-white">Đang học</span></c:when>
                                                                            <c:otherwise><fmt:formatDate value="${edu.endDate}" pattern="MM/yyyy" /></c:otherwise>
                                                                        </c:choose>
                                                                        <c:if test="${not empty edu.gpa}"><span class="mx-2">•</span><span class="badge bg-warning text-dark">GPA: ${edu.gpa}</span></c:if>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            <c:if test="${not empty edu.description}">
                                                                <div class="item-description mt-2">${edu.description}</div>
                                                            </c:if>
                                                            <c:if test="${not empty edu.activities}">
                                                                <div class="item-description mt-2"><strong>Hoạt động:</strong> ${edu.activities}</div>
                                                            </c:if>
                                                        </div>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <!-- Certificates Section -->
                                    <div class="profile-section mb-4">
                                        <div class="section-header d-flex align-items-center" style="background: linear-gradient(135deg, #28a745, #20c997); color: white; border-radius: 12px 12px 0 0; padding: 16px 24px;">
                                            <h6 class="mb-0"><i class="fas fa-certificate me-2"></i>Chứng chỉ</h6>
                                        </div>
                                        <div class="section-body p-3 bg-white rounded-bottom">
                                            <c:choose>
                                                <c:when test="${empty app.jobseeker.certificates}">
                                                    <div class="text-center text-muted py-3">Chưa có chứng chỉ nào</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${app.jobseeker.certificates}" var="cert">
                                                        <div class="timeline-item mb-3">
                                                            <div class="item-header d-flex align-items-start">
                                                                <c:if test="${not empty cert.imagePath}">
                                                                    <img src="${cert.imagePath}" alt="Certificate" class="me-3 rounded-2 border" style="max-width: 60px; height: 40px; object-fit: cover;">
                                                                </c:if>
                                                                <div>
                                                                    <div class="item-title fw-bold">${cert.certificateName}</div>
                                                                    <div class="item-company text-success">${cert.issuingOrganization}</div>
                                                                    <div class="item-meta text-muted small">
                                                                        <i class="fas fa-calendar me-1"></i>
                                                                        <fmt:formatDate value="${cert.issueDate}" pattern="MM/yyyy" />
                                                                        <c:if test="${not empty cert.expiryDate}">- <fmt:formatDate value="${cert.expiryDate}" pattern="MM/yyyy" /></c:if>
                                                                        <c:if test="${not empty cert.credentialId}"><span class="mx-2">•</span>ID: ${cert.credentialId}</c:if>
                                                                        </div>
                                                                    <c:if test="${not empty cert.credentialUrl}">
                                                                        <div class="mt-2"><a href="${cert.credentialUrl}" target="_blank" class="text-success text-decoration-underline"><i class="fas fa-external-link-alt me-1"></i>Xem chứng chỉ</a></div>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <c:if test="${not empty cert.description}">
                                                                <div class="item-description mt-2">${cert.description}</div>
                                                            </c:if>
                                                        </div>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <!-- Awards Section -->
                                    <div class="profile-section mb-4">
                                        <div class="section-header d-flex align-items-center" style="background: linear-gradient(135deg, #28a745, #20c997); color: white; border-radius: 12px 12px 0 0; padding: 16px 24px;">
                                            <h6 class="mb-0"><i class="fas fa-trophy me-2"></i>Giải thưởng</h6>
                                        </div>
                                        <div class="section-body p-3 bg-white rounded-bottom">
                                            <c:choose>
                                                <c:when test="${empty app.jobseeker.awards}">
                                                    <div class="text-center text-muted py-3">Chưa có giải thưởng nào</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${app.jobseeker.awards}" var="award">
                                                        <div class="timeline-item mb-3">
                                                            <div class="item-header d-flex justify-content-between align-items-start">
                                                                <div>
                                                                    <div class="item-title fw-bold">${award.awardName}</div>
                                                                    <div class="item-company text-success">${award.issuingOrganization}</div>
                                                                    <div class="item-meta text-muted small">
                                                                        <i class="fas fa-calendar me-1"></i>
                                                                        <fmt:formatDate value="${award.dateReceived}" pattern="MM/yyyy" />
                                                                    </div>
                                                                    <c:if test="${not empty award.certificateUrl}">
                                                                        <div class="mt-2"><a href="${award.certificateUrl}" target="_blank" class="text-success text-decoration-underline"><i class="fas fa-external-link-alt me-1"></i>Xem giải thưởng</a></div>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <c:if test="${not empty award.description}">
                                                                <div class="item-description mt-2">${award.description}</div>
                                                            </c:if>
                                                        </div>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <!-- CVs Section -->
                                    <div class="profile-section mb-2">
                                        <div class="section-header d-flex align-items-center" style="background: linear-gradient(135deg, #28a745, #20c997); color: white; border-radius: 12px 12px 0 0; padding: 16px 24px;">
                                            <h6 class="mb-0"><i class="fas fa-file-alt me-2"></i>CV đã nộp</h6>
                                        </div>
                                        <div class="section-body p-3 bg-white rounded-bottom">
                                            <c:choose>
                                                <c:when test="${empty app.jobseeker.cvTemplates}">
                                                    <div class="text-center text-muted py-3">Chưa có CV nào</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="row">
                                                        <c:forEach items="${app.jobseeker.cvTemplates}" var="cv">
                                                            <div class="col-md-6 mb-3">
                                                                <div class="card border">
                                                                    <div class="card-body">
                                                                        <h6 class="card-title mb-1">${cv.jobPosition}</h6>
                                                                        <p class="text-muted mb-1"><i class="fas fa-user me-1"></i>${cv.fullName}</p>
                                                                        <p class="text-muted small mb-2"><i class="fas fa-envelope me-1"></i>${cv.email}</p>
                                                                        <div class="d-flex justify-content-between text-muted small">
                                                                            <span><i class="fas fa-calendar me-1"></i><fmt:formatDate value="${cv.createdAt}" pattern="dd/MM/yyyy" /></span>
                                                                            <c:if test="${not empty cv.pdfFilePath}"><span class="text-success"><i class="fas fa-file-pdf me-1"></i>PDF</span></c:if>
                                                                            </div>
                                                                        </div>
                                                                        <div class="card-footer bg-light p-2">
                                                                            <div class="d-flex gap-1">
                                                                            <c:if test="${not empty cv.pdfFilePath}">
                                                                                <a href="${cv.pdfFilePath}" target="_blank" class="btn btn-sm btn-outline-success flex-fill"><i class="fas fa-download"></i> Tải xuống</a>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="action-section text-center p-3">
                                <a id="modal-download-cv-btn" href="#" class="btn btn-success me-2"
                                   target="_blank" style="display: none;">
                                    <i class="fas fa-download me-2"></i> Tải CV
                                </a>
                                <a id="modal-send-email-btn" href="#" class="btn btn-info me-2">
                                    <i class="fas fa-envelope me-2"></i> Gửi Email
                                </a>
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                    <i class="fas fa-times me-2"></i> Đóng
                                </button>
                            </div>
                            <!-- Trong phần modal, thay đổi các ID để unique cho từng modal -->
                            <div class="update-status-section p-3 bg-light rounded">
                                <h6 class="mb-3">
                                    <i class="fas fa-edit me-2"></i>Cập nhật trạng thái
                                </h6>

                                <!-- Email Notification Info -->
                                <div class="alert alert-info mb-3" role="alert">
                                    <i class="fas fa-info-circle me-2"></i>
                                    <strong>Lưu ý:</strong> Khi cập nhật trạng thái, hệ thống sẽ <strong>tự động gửi email</strong>
                                    thông báo trực tiếp đến ứng viên.
                                </div>

                                <form class="updateStatusForm" action="update-application-status" method="POST">
                                    <input type="hidden" class="modal-application-id" name="applicationId" value="${app.applicationId}"/>
                                    <input type="hidden" name="action" value="update" />

                                    <div class="mb-3">
                                        <label for="statusSelect-${app.applicationId}" class="form-label fw-semibold">Trạng thái mới</label>
                                        <!-- Thêm app.applicationId vào ID để unique -->
                                        <select class="form-select status-select" id="statusSelect-${app.applicationId}" name="status" required>
                                            <option value="">-- Chọn trạng thái --</option>
                                            <option value="new">Mới</option>
                                            <option value="reviewed">Đã xem</option>
                                            <option value="interviewed">Phỏng vấn</option>
                                            <option value="offered">Mời nhận việc</option>
                                            <option value="rejected">Từ chối</option>
                                        </select>
                                    </div>

                                    <!-- Rejection Reason Field -->
                                    <div class="rejection-reason-field mb-3" id="rejectionReasonField-${app.applicationId}" style="display: none;">
                                        <label for="rejectionReason-${app.applicationId}" class="form-label fw-semibold text-danger">
                                            <i class="fas fa-exclamation-triangle me-1"></i>Lý do từ chối
                                        </label>
                                        <textarea id="rejectionReason-${app.applicationId}" name="rejectionReason"
                                                  class="form-control" rows="3"
                                                  placeholder="Nhập lý do từ chối ứng viên..."></textarea>
                                        <div class="form-text">Lý do này sẽ được gửi trong email thông báo cho ứng viên.</div>
                                    </div>

                                    <!-- Offer Details Field -->
                                    <div class="offer-details-field mb-3" id="offerDetailsField-${app.applicationId}" style="display: none;">
                                        <label for="offerDetails-${app.applicationId}" class="form-label fw-semibold text-success">
                                            <i class="fas fa-handshake me-1"></i>Chi tiết đề nghị
                                        </label>
                                        <textarea id="offerDetails-${app.applicationId}" name="offerDetails" class="form-control"
                                                  rows="3" placeholder="Nhập chi tiết đề nghị việc làm..."></textarea>
                                        <div class="form-text">Chi tiết này sẽ được gửi trong email chấp nhận cho ứng viên.</div>
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="fas fa-save me-1"></i> Cập nhật trạng thái
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Scripts -->
        <!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>-->
        <script>
            // Thay thế toàn bộ JavaScript trong file JSP bằng code này:

            function resetFilters() {
                document.getElementById('status').value = '';
                document.getElementById('sortBy').value = 'applied_at';
                document.getElementById('keyword').value = '';
                document.getElementById('filterForm').submit();
            }

// Sử dụng event delegation thay vì add listener cho từng modal
            document.addEventListener('change', function (e) {
                if (e.target.classList.contains('status-select')) {
                    console.log('Status select changed:', e.target.value);

                    const modal = e.target.closest('.modal');
                    const selectedStatus = e.target.value;

                    console.log('Modal found:', modal);

                    // Tìm các fields trong modal này
                    const rejectionField = modal.querySelector('.rejection-reason-field');
                    const offerField = modal.querySelector('.offer-details-field');

                    console.log('Rejection field:', rejectionField);
                    console.log('Offer field:', offerField);

                    // Hide all fields
                    if (rejectionField)
                        rejectionField.style.display = 'none';
                    if (offerField)
                        offerField.style.display = 'none';

                    // Show based on status
                    if (selectedStatus === 'rejected' && rejectionField) {
                        console.log('Showing rejection field');
                        rejectionField.style.display = 'block';
                    } else if (selectedStatus === 'offered' && offerField) {
                        console.log('Showing offer field');
                        offerField.style.display = 'block';
                    }
                }
            });

            document.addEventListener("DOMContentLoaded", function () {
                // Handle modal open
                document.querySelectorAll('.view-candidate-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        const applicationId = this.dataset.applicationId;
                        const modal = document.getElementById(`candidateModal-${applicationId}`);

                        if (!modal)
                            return;

                        // Set application data
                        const modalApplicationIdInput = modal.querySelector('.modal-application-id');
                        if (modalApplicationIdInput) {
                            modalApplicationIdInput.value = applicationId;
                        }

                        // Set current status
                        const statusSelect = modal.querySelector('.status-select');
                        const currentStatus = this.dataset.currentStatus || '';
                        if (statusSelect) {
                            statusSelect.value = currentStatus.toLowerCase();
                        }

                        // Reset fields
                        const rejectionField = modal.querySelector('.rejection-reason-field');
                        const offerField = modal.querySelector('.offer-details-field');
                        const rejectionInput = modal.querySelector('textarea[name="rejectionReason"]');
                        const offerInput = modal.querySelector('textarea[name="offerDetails"]');

                        if (rejectionInput)
                            rejectionInput.value = '';
                        if (offerInput)
                            offerInput.value = '';
                        if (rejectionField)
                            rejectionField.style.display = 'none';
                        if (offerField)
                            offerField.style.display = 'none';

                        // Handle CV and email buttons
                        const modalDownloadCvBtn = modal.querySelector('#modal-download-cv-btn');
                        const modalSendEmailBtn = modal.querySelector('#modal-send-email-btn');

                        const cvUrl = this.dataset.cvUrl;
                        if (modalDownloadCvBtn) {
                            if (cvUrl && cvUrl !== 'null' && cvUrl !== '' && !cvUrl.includes('null')) {
                                modalDownloadCvBtn.href = cvUrl;
                                modalDownloadCvBtn.style.display = 'inline-block';
                                modalDownloadCvBtn.classList.remove('disabled');
                            } else {
                                modalDownloadCvBtn.href = '#';
                                modalDownloadCvBtn.style.display = 'inline-block';
                                modalDownloadCvBtn.classList.add('disabled');
                            }
                        }

                        if (modalSendEmailBtn) {
                            const sendEmailUrl = 'send-custom-email?recipientEmail=' + encodeURIComponent(this.dataset.email) +
                                    '&candidateName=' + encodeURIComponent(this.dataset.fullname) +
                                    '&jobTitle=' + encodeURIComponent(this.dataset.jobTitle || '') +
                                    '&companyName=' + encodeURIComponent(this.dataset.companyName || '') +
                                    '&applicationId=' + applicationId;
                            modalSendEmailBtn.href = sendEmailUrl;
                        }
                    });
                });

                // Handle form submission
                document.addEventListener('submit', function (e) {
                    if (e.target.classList.contains('updateStatusForm')) {
                        e.preventDefault();

                        const form = e.target;
                        const modal = form.closest('.modal');
                        const statusSelect = modal.querySelector('.status-select');
                        const selectedStatus = statusSelect ? statusSelect.value : '';

                        if (!selectedStatus) {
                            alert('Vui lòng chọn trạng thái.');
                            return;
                        }

                        const rejectionInput = modal.querySelector('textarea[name="rejectionReason"]');
                        const offerInput = modal.querySelector('textarea[name="offerDetails"]');

                        if (selectedStatus === 'rejected' && rejectionInput && !rejectionInput.value.trim()) {
                            alert('Vui lòng nhập lý do từ chối.');
                            rejectionInput.focus();
                            return;
                        }

                        if (selectedStatus === 'offered' && offerInput && !offerInput.value.trim()) {
                            alert('Vui lòng nhập chi tiết đề nghị.');
                            offerInput.focus();
                            return;
                        }

                        const selectedText = statusSelect.options[statusSelect.selectedIndex].text;
                        if (confirm(`Bạn có chắc muốn cập nhật trạng thái thành "${selectedText}"?`)) {
                            form.submit();
                        }
                    }
                });
            });
        </script>
    </body>

</html>