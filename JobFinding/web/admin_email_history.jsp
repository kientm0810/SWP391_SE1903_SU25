<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Lịch sử Email - Admin Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <style>
                    .email-status {
                        padding: 4px 8px;
                        border-radius: 4px;
                        font-size: 12px;
                        font-weight: bold;
                    }

                    .status-sent {
                        background-color: #d4edda;
                        color: #155724;
                    }

                    .status-failed {
                        background-color: #f8d7da;
                        color: #721c24;
                    }

                    .email-preview {
                        max-width: 300px;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        white-space: nowrap;
                    }

                    .stats-card {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        border-radius: 10px;
                        padding: 20px;
                        margin-bottom: 20px;
                    }

                    .filter-section {
                        background-color: #f8f9fa;
                        border-radius: 8px;
                        padding: 20px;
                        margin-bottom: 20px;
                    }
                </style>
            </head>

            <body>
                <div class="container-fluid">
                    <div class="row">
                        <!-- Sidebar -->
                        <jsp:include page="admin-common-styles.jsp" />

                        <!-- Main Content -->
                        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                            <div
                                class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                                <h1 class="h2">
                                    <i class="fas fa-envelope-open-text me-2"></i>
                                    Lịch sử Email
                                </h1>
                            </div>

                            <!-- Thống kê -->
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="stats-card">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="mb-0">${totalCount}</h4>
                                                <p class="mb-0">Tổng số email</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="fas fa-envelope fa-2x"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="stats-card"
                                        style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="mb-0">${sentCount}</h4>
                                                <p class="mb-0">Email đã gửi</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="fas fa-check-circle fa-2x"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="stats-card"
                                        style="background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h4 class="mb-0">${failedCount}</h4>
                                                <p class="mb-0">Email thất bại</p>
                                            </div>
                                            <div class="align-self-center">
                                                <i class="fas fa-exclamation-triangle fa-2x"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Bộ lọc -->
                            <div class="filter-section">
                                <form method="GET" action="${pageContext.request.contextPath}/admin/email-history"
                                    class="row g-3">
                                    <div class="col-md-3">
                                        <label for="statusFilter" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="statusFilter" name="status">
                                            <option value="">Tất cả</option>
                                            <option value="sent" ${statusFilter=='sent' ? 'selected' : '' }>Đã gửi
                                            </option>
                                            <option value="failed" ${statusFilter=='failed' ? 'selected' : '' }>Thất bại
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="emailFilter" class="form-label">Email người nhận</label>
                                        <input type="email" class="form-control" id="emailFilter" name="email"
                                            value="${emailFilter}" placeholder="Nhập email...">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="limit" class="form-label">Số lượng</label>
                                        <select class="form-select" id="limit" name="limit">
                                            <option value="10" ${limit==10 ? 'selected' : '' }>10</option>
                                            <option value="20" ${limit==20 ? 'selected' : '' }>20</option>
                                            <option value="50" ${limit==50 ? 'selected' : '' }>50</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary me-2">
                                            <i class="fas fa-search me-1"></i>Lọc
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/email-history"
                                            class="btn btn-secondary">
                                            <i class="fas fa-refresh me-1"></i>Làm mới
                                        </a>
                                    </div>
                                </form>
                            </div>

                            <!-- Bảng lịch sử email -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-list me-2"></i>
                                        Danh sách Email (${totalCount} kết quả)
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Người nhận</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Trạng thái</th>
                                                    <th>Thời gian gửi</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="email" items="${emailHistory}">
                                                    <tr>
                                                        <td>${email.id}</td>
                                                        <td>
                                                            <i class="fas fa-envelope me-1"></i>
                                                            ${email.recipientEmail}
                                                        </td>
                                                        <td>
                                                            <div class="email-preview" title="${email.subject}">
                                                                ${email.subject}
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="email-status ${email.status == 'sent' ? 'status-sent' : 'status-failed'}">
                                                                <i
                                                                    class="fas ${email.status == 'sent' ? 'fa-check' : 'fa-times'} me-1"></i>
                                                                ${email.status == 'sent' ? 'Đã gửi' : 'Thất bại'}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${email.sentAt}"
                                                                pattern="dd/MM/yyyy HH:mm:ss" />
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-info"
                                                                onclick="viewEmailDetails(${email.id})"
                                                                title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Phân trang -->
                                    <c:if test="${totalPages > 1}">
                                        <nav aria-label="Email history pagination">
                                            <ul class="pagination justify-content-center">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link"
                                                        href="?page=${currentPage - 1}&limit=${limit}&status=${statusFilter}&email=${emailFilter}">
                                                        <i class="fas fa-chevron-left"></i>
                                                    </a>
                                                </li>

                                                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                        <a class="page-link"
                                                            href="?page=${pageNum}&limit=${limit}&status=${statusFilter}&email=${emailFilter}">
                                                            ${pageNum}
                                                        </a>
                                                    </li>
                                                </c:forEach>

                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link"
                                                        href="?page=${currentPage + 1}&limit=${limit}&status=${statusFilter}&email=${emailFilter}">
                                                        <i class="fas fa-chevron-right"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </c:if>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>

                <!-- Modal xem chi tiết email -->
                <div class="modal fade" id="emailDetailModal" tabindex="-1">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-envelope-open-text me-2"></i>
                                    Chi tiết Email
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body" id="emailDetailContent">
                                <!-- Nội dung sẽ được load bằng AJAX -->
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function viewEmailDetails(emailId) {
                        // Hiển thị modal
                        const modal = new bootstrap.Modal(document.getElementById('emailDetailModal'));
                        modal.show();

                        // Load chi tiết email bằng AJAX (có thể implement sau)
                        document.getElementById('emailDetailContent').innerHTML =
                            '<div class="text-center"><i class="fas fa-spinner fa-spin fa-2x"></i><p>Đang tải...</p></div>';
                    }
                </script>
            </body>

            </html>