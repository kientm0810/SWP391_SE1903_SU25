<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Lịch sử Email | JobFinding</title>

                    <!-- CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                    <link rel="stylesheet" href="assets/css/main.css">
                    <link rel="stylesheet" href="assets/css/history_email.css?v=1.5" />
                    <style>
                        /* Layout Vertical - Card Style */
                        .email-card {
                            background: white;
                            border-radius: 12px;
                            padding: 20px;
                            margin-bottom: 20px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                            border: 1px solid #e0e0e0;
                            transition: all 0.3s ease;
                        }

                        .email-card:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                        }

                        .email-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: flex-start;
                            margin-bottom: 15px;
                            padding-bottom: 15px;
                            border-bottom: 1px solid #f0f0f0;
                        }

                        .email-subject {
                            font-size: 18px;
                            font-weight: 600;
                            color: #2c3e50;
                            margin-bottom: 8px;
                        }

                        .email-meta {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 15px;
                            font-size: 14px;
                            color: #7f8c8d;
                        }

                        .email-meta-item {
                            display: flex;
                            align-items: center;
                            gap: 5px;
                        }

                        .email-meta-item i {
                            color: #3498db;
                            width: 16px;
                        }

                        .email-status {
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }

                        .status-badge {
                            padding: 6px 12px;
                            border-radius: 20px;
                            font-size: 12px;
                            font-weight: 600;
                            text-transform: uppercase;
                        }

                        .status-sent {
                            background-color: #d5f5e3;
                            color: #27ae60;
                        }

                        .status-failed {
                            background-color: #fadbd8;
                            color: #e74c3c;
                        }

                        .status-pending {
                            background-color: #fdebd0;
                            color: #f39c12;
                        }

                        .email-date {
                            font-size: 13px;
                            color: #95a5a6;
                            font-weight: 500;
                        }

                        .email-actions {
                            display: flex;
                            gap: 10px;
                            margin-top: 15px;
                            padding-top: 15px;
                            border-top: 1px solid #f0f0f0;
                        }

                        .btn-sm {
                            padding: 8px 16px;
                            font-size: 13px;
                            border-radius: 6px;
                            font-weight: 500;
                        }

                        /* Statistics Cards */
                        .stats-cards {
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                            gap: 20px;
                            margin-bottom: 30px;
                        }

                        .stat-card {
                            background: white;
                            border-radius: 12px;
                            padding: 20px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                            text-align: center;
                            transition: transform 0.2s;
                        }

                        .stat-card:hover {
                            transform: translateY(-3px);
                        }

                        .stat-icon {
                            font-size: 24px;
                            margin-bottom: 10px;
                        }

                        .stat-total .stat-icon {
                            color: #3498db;
                        }

                        .stat-sent .stat-icon {
                            color: #2ecc71;
                        }

                        .stat-failed .stat-icon {
                            color: #e74c3c;
                        }

                        .stat-pending .stat-icon {
                            color: #f39c12;
                        }

                        .stat-number {
                            font-size: 28px;
                            font-weight: 700;
                            margin-bottom: 5px;
                        }

                        .stat-total .stat-number {
                            color: #3498db;
                        }

                        .stat-sent .stat-number {
                            color: #2ecc71;
                        }

                        .stat-failed .stat-number {
                            color: #e74c3c;
                        }

                        .stat-pending .stat-number {
                            color: #f39c12;
                        }

                        .stat-label {
                            font-size: 14px;
                            color: #7f8c8d;
                        }

                        /* Header Section */
                        .email-history-header {
                            margin-bottom: 30px;
                            padding-bottom: 15px;
                            border-bottom: 1px solid #e0e0e0;
                        }

                        .email-history-header h2 {
                            font-size: 28px;
                            font-weight: 600;
                            color: #2c3e50;
                            margin-bottom: 8px;
                        }

                        .email-history-header .desc {
                            font-size: 15px;
                            color: #7f8c8d;
                            margin-bottom: 10px;
                        }

                        .email-history-header .count {
                            font-size: 15px;
                            color: #34495e;
                        }

                        .email-history-header .count b {
                            font-weight: 600;
                            color: #2c3e50;
                        }

                        /* Filter Section */
                        .filter-section {
                            background: white;
                            border-radius: 12px;
                            padding: 20px;
                            margin-bottom: 30px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                        }

                        .filter-section label {
                            font-size: 14px;
                            margin-bottom: 8px;
                            display: block;
                            font-weight: 600;
                            color: #2c3e50;
                        }

                        /* Responsive */
                        @media (max-width: 768px) {
                            .email-header {
                                flex-direction: column;
                                gap: 10px;
                            }

                            .email-meta {
                                flex-direction: column;
                                gap: 8px;
                            }

                            .email-actions {
                                flex-direction: column;
                            }

                            .stats-cards {
                                grid-template-columns: repeat(2, 1fr);
                            }
                        }

                        @media (max-width: 576px) {
                            .stats-cards {
                                grid-template-columns: 1fr;
                            }
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="header.jsp" />

                    <div class="container-fluid py-4 px-4">
                        <!-- Header -->
                        <div class="email-history-header">
                            <h2><i class="fas fa-envelope-open me-2"></i>Lịch sử Email</h2>
                            <div class="desc">Xem lại tất cả email đã gửi cho ứng viên và trạng thái gửi.</div>
                            <div class="count">Tổng cộng <b>${totalEmails}</b> email đã gửi</div>
                        </div>

                        <!-- Statistics Cards -->
                        <div class="stats-cards">
                            <div class="stat-card stat-total">
                                <div class="stat-icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <div class="stat-number">${totalEmails}</div>
                                <div class="stat-label">Tổng số email</div>
                            </div>
                            <div class="stat-card stat-sent">
                                <div class="stat-icon">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div class="stat-number">${sentEmails}</div>
                                <div class="stat-label">Đã gửi thành công</div>
                            </div>
                            <div class="stat-card stat-failed">
                                <div class="stat-icon">
                                    <i class="fas fa-times-circle"></i>
                                </div>
                                <div class="stat-number">${failedEmails}</div>
                                <div class="stat-label">Gửi thất bại</div>
                            </div>
                            <div class="stat-card stat-pending">
                                <div class="stat-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="stat-number">${pendingEmails}</div>
                                <div class="stat-label">Đang chờ gửi</div>
                            </div>
                        </div>

                        <!-- Filter Section -->
                        <div class="filter-section">
                            <form id="filterForm" method="get" action="recruiter-email-history">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-3">
                                        <label for="status" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="">Tất cả trạng thái</option>
                                            <option value="sent" ${param.status=='sent' ? 'selected' : '' }>Đã gửi thành
                                                công</option>
                                            <option value="failed" ${param.status=='failed' ? 'selected' : '' }>Gửi thất
                                                bại</option>
                                            <option value="pending" ${param.status=='pending' ? 'selected' : '' }>Đang
                                                chờ gửi</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="emailType" class="form-label">Loại email</label>
                                        <select class="form-select" id="emailType" name="emailType">
                                            <option value="">Tất cả loại</option>
                                            <option value="application_received"
                                                ${param.emailType=='application_received' ? 'selected' : '' }>Xác nhận
                                                nhận hồ sơ</option>
                                            <option value="interview_invitation"
                                                ${param.emailType=='interview_invitation' ? 'selected' : '' }>Lời mời
                                                phỏng vấn</option>
                                            <option value="rejection" ${param.emailType=='rejection' ? 'selected' : ''
                                                }>Thư từ chối</option>
                                            <option value="offer" ${param.emailType=='offer' ? 'selected' : '' }>Lời mời
                                                làm việc</option>
                                            <option value="custom" ${param.emailType=='custom' ? 'selected' : '' }>Email
                                                tùy chỉnh</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="sortBy" class="form-label">Sắp xếp</label>
                                        <select class="form-select" id="sortBy" name="sortBy">
                                            <option value="sent_at" ${param.sortBy=='sent_at' ? 'selected' : '' }>Ngày
                                                gửi</option>
                                            <option value="recipient_email" ${param.sortBy=='recipient_email'
                                                ? 'selected' : '' }>Email người nhận</option>
                                            <option value="subject" ${param.sortBy=='subject' ? 'selected' : '' }>Tiêu
                                                đề</option>
                                            <option value="status" ${param.sortBy=='status' ? 'selected' : '' }>Trạng
                                                thái</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="keyword" class="form-label">Tìm kiếm</label>
                                        <input type="text" class="form-control" id="keyword" name="keyword"
                                            placeholder="Email, tiêu đề..." value="${param.keyword}">
                                    </div>
                                    <div class="col-12">
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

                        <!-- Email History List - Vertical Layout -->
                        <c:choose>
                            <c:when test="${not empty emailHistory}">
                                <div class="email-list">
                                    <c:forEach items="${emailHistory}" var="email">
                                        <div class="email-card">
                                            <div class="email-header">
                                                <div class="email-info">
                                                    <div class="email-subject">${email.subject}</div>
                                                    <div class="email-meta">
                                                        <div class="email-meta-item">
                                                            <i class="fas fa-envelope"></i>
                                                            <span>${email.recipientEmail}</span>
                                                        </div>
                                                        <div class="email-meta-item">
                                                            <i class="fas fa-tag"></i>
                                                            <span>${email.templateName}</span>
                                                        </div>
                                                        <div class="email-meta-item">
                                                            <i class="fas fa-calendar"></i>
                                                            <span>
                                                                <fmt:formatDate value="${email.sentAt}"
                                                                    pattern="HH:mm, dd/MM/yyyy" />
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="email-status">
                                                    <span class="status-badge status-${fn:toLowerCase(email.status)}">
                                                        <c:choose>
                                                            <c:when test="${fn:toLowerCase(email.status) == 'sent'}">Đã
                                                                gửi</c:when>
                                                            <c:when test="${fn:toLowerCase(email.status) == 'failed'}">
                                                                Thất bại</c:when>
                                                            <c:when test="${fn:toLowerCase(email.status) == 'pending'}">
                                                                Đang chờ</c:when>
                                                            <c:otherwise>${email.status}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="email-actions">
                                                <button type="button" class="btn btn-success btn-sm view-email-btn"
                                                    data-bs-toggle="modal" data-bs-target="#emailDetailModal"
                                                    data-subject="${email.subject}"
                                                    data-recipient-email="${email.recipientEmail}"
                                                    data-email-type="${email.templateName}"
                                                    data-sent-at="${email.sentAt}" data-status="${email.status}"
                                                    data-content="${email.bodyHtml}"
                                                    data-template-name="${email.templateName}">
                                                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                                                </button>
                                                <c:if test="${fn:toLowerCase(email.status) == 'failed'}">
                                                    <button type="button"
                                                        class="btn btn-warning btn-sm resend-email-btn"
                                                        onclick="resendEmail(${email.id})">
                                                        <i class="fas fa-redo me-1"></i>Gửi lại
                                                    </button>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="pagination-section">
                                        <div class="d-flex justify-content-center">
                                            <nav>
                                                <ul class="pagination mb-0">
                                                    <c:if test="${currentPage > 1}">
                                                        <li class="page-item">
                                                            <a class="page-link"
                                                                href="?page=${currentPage - 1}&status=${param.status}&emailType=${param.emailType}&sortBy=${param.sortBy}&keyword=${param.keyword}">
                                                                <i class="fas fa-chevron-left"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>

                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link"
                                                                href="?page=${i}&status=${param.status}&emailType=${param.emailType}&sortBy=${param.sortBy}&keyword=${param.keyword}">${i}</a>
                                                        </li>
                                                    </c:forEach>

                                                    <c:if test="${currentPage < totalPages}">
                                                        <li class="page-item">
                                                            <a class="page-link"
                                                                href="?page=${currentPage + 1}&status=${param.status}&emailType=${param.emailType}&sortBy=${param.sortBy}&keyword=${param.keyword}">
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
                                    <h5>Chưa có email nào được gửi</h5>
                                    <p class="text-muted">Khi bạn gửi email cho ứng viên, chúng sẽ hiển thị ở đây.</p>
                                    <a href="applications" class="btn btn-success mt-3">
                                        <i class="fas fa-users me-2"></i>Xem đơn ứng tuyển
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Email Detail Modal -->
                    <div class="modal fade email-detail-modal" id="emailDetailModal" tabindex="-1"
                        aria-labelledby="emailDetailModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="emailDetailModalLabel">
                                        <i class="fas fa-envelope-open me-2"></i>Chi tiết Email
                                    </h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="email-detail-content">
                                        <div class="email-detail-info">
                                            <h6><i class="fas fa-info-circle me-2"></i>Thông tin Email</h6>
                                            <div class="email-detail-row">
                                                <span class="email-detail-label">Tiêu đề:</span>
                                                <span class="email-detail-value" id="modal-email-subject"></span>
                                            </div>
                                            <div class="email-detail-row">
                                                <span class="email-detail-label">Email:</span>
                                                <span class="email-detail-value" id="modal-recipient-email"></span>
                                            </div>
                                            <div class="email-detail-row">
                                                <span class="email-detail-label">Loại email:</span>
                                                <span class="email-detail-value" id="modal-email-type"></span>
                                            </div>
                                            <div class="email-detail-row">
                                                <span class="email-detail-label">Template:</span>
                                                <span class="email-detail-value" id="modal-template-name"></span>
                                            </div>
                                            <div class="email-detail-row">
                                                <span class="email-detail-label">Ngày gửi:</span>
                                                <span class="email-detail-value" id="modal-sent-at"></span>
                                            </div>
                                            <div class="email-detail-row">
                                                <span class="email-detail-label">Trạng thái:</span>
                                                <span class="email-detail-value" id="modal-status"></span>
                                            </div>
                                        </div>

                                        <div class="email-detail-body">
                                            <h6><i class="fas fa-file-alt me-2"></i>Nội dung Email</h6>
                                            <div class="content" id="modal-email-content"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">
                                        <i class="fas fa-times me-2"></i>Đóng
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Scripts -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        function resetFilters() {
                            document.getElementById('status').value = '';
                            document.getElementById('emailType').value = '';
                            document.getElementById('sortBy').value = 'sent_at';
                            document.getElementById('keyword').value = '';
                            document.getElementById('filterForm').submit();
                        }

                        function resendEmail(emailId) {
                            if (confirm('Bạn có chắc muốn gửi lại email này?')) {
                                // Redirect to resend email endpoint
                                window.location.href = 'resend-email?emailId=' + emailId;
                            }
                        }

                        document.addEventListener("DOMContentLoaded", function () {
                            const emailDetailModal = document.getElementById('emailDetailModal');
                            if (!emailDetailModal) return;

                            const modalInstance = new bootstrap.Modal(emailDetailModal);

                            // Handle modal open - populate with email data
                            document.querySelectorAll('.view-email-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    // Populate modal with email info
                                    document.getElementById('modal-email-subject').textContent = this.dataset.subject || 'N/A';
                                    document.getElementById('modal-recipient-email').textContent = this.dataset.recipientEmail || 'N/A';
                                    document.getElementById('modal-email-type').textContent = this.dataset.emailType || 'N/A';
                                    document.getElementById('modal-template-name').textContent = this.dataset.templateName || 'N/A';
                                    document.getElementById('modal-sent-at').textContent = this.dataset.sentAt || 'N/A';
                                    document.getElementById('modal-status').textContent = this.dataset.status || 'N/A';
                                    document.getElementById('modal-email-content').innerHTML = this.dataset.content || 'N/A';

                                    modalInstance.show();
                                });
                            });
                        });
                    </script>
                </body>

                </html>