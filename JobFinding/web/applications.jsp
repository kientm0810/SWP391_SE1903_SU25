<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Việc làm đã ứng tuyển | JobFinding</title>

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
                            cursor: pointer;
                        }

                        .application-card:hover {
                            box-shadow: 0 4px 24px #b2f2e5;
                        }

                        .application-logo {
                            width: 64px;
                            height: 64px;
                            object-fit: contain;
                            border-radius: 10px;
                            background: #fff;
                            border: 1px solid #eee;
                            margin-right: 24px;
                        }

                        .application-info {
                            flex: 1;
                        }

                        .application-title {
                            font-size: 1.1rem;
                            font-weight: 600;
                            color: #222;
                            margin-bottom: 4px;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                            overflow: hidden;
                        }

                        .application-company {
                            color: #666;
                            font-size: 0.97rem;
                            margin-bottom: 2px;
                        }

                        .application-meta {
                            font-size: 0.97rem;
                            color: #888;
                            margin-bottom: 4px;
                        }

                        .application-salary {
                            color: #00c471;
                            font-weight: 600;
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
                            min-width: 120px;
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
                        }

                        .pagination-section {
                            background: #fff;
                            border-radius: 14px;
                            box-shadow: 0 2px 12px #e0e0e0;
                            padding: 20px;
                            margin-top: 24px;
                        }

                        .pagination .page-link {
                            color: #00b14f;
                            border: 1px solid #e0e0e0;
                            margin: 0 2px;
                            border-radius: 8px;
                        }

                        .pagination .page-link:hover {
                            color: #009443;
                            background-color: #f8f9fa;
                            border-color: #00b14f;
                        }

                        .pagination .page-item.active .page-link {
                            background-color: #00b14f;
                            border-color: #00b14f;
                        }

                        .empty-state {
                            text-align: center;
                            padding: 60px 20px;
                            background: #fff;
                            border-radius: 14px;
                            box-shadow: 0 2px 12px #e0e0e0;
                        }

                        .empty-state .empty-icon {
                            font-size: 4rem;
                            color: #ddd;
                            margin-bottom: 20px;
                        }

                        .empty-state h4 {
                            color: #666;
                            margin-bottom: 16px;
                        }

                        .empty-state p {
                            color: #888;
                            margin-bottom: 24px;
                        }

                        @media (max-width: 768px) {
                            .application-card {
                                flex-direction: column;
                                align-items: flex-start;
                            }

                            .application-logo {
                                margin-bottom: 12px;
                                margin-right: 0;
                            }

                            .application-status {
                                flex-direction: row;
                                width: 100%;
                                justify-content: space-between;
                                align-items: center;
                                margin-top: 12px;
                            }

                            .filter-section .row>* {
                                margin-bottom: 12px;
                            }
                        }
                    </style>
                </head>

                <body>

                    <!-- Preloader Start -->
                    <div id="preloader-active">
                        <div class="preloader d-flex align-items-center justify-content-center">
                            <div class="preloader-inner position-relative">
                                <div class="preloader-circle"></div>
                                <div class="preloader-img pere-text">
                                    <img src="assets/img/logo/logo.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Preloader Start -->
                    <%@ include file="header.jsp" %>
                        <div class="container py-5">
                            <h1 class="mb-4">Việc làm đã ứng tuyển</h1>

                            <!-- Filters -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form action="applications" method="GET" class="row g-3">
                                        <div class="col-md-4">
                                            <select name="status" class="form-select">
                                                <option value="">Tất cả trạng thái</option>
                                                <option value="new" ${param.status=='new' ? 'selected' : '' }>Mới
                                                </option>
                                                <option value="reviewed" ${param.status=='reviewed' ? 'selected' : '' }>
                                                    Đã xem
                                                </option>
                                                <option value="interviewed" ${param.status=='interviewed' ? 'selected'
                                                    : '' }>Đã
                                                    phỏng vấn</option>
                                                <option value="rejected" ${param.status=='rejected' ? 'selected' : '' }>
                                                    Từ chối
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" name="keyword" class="form-control"
                                                placeholder="Tìm theo tên công việc..." value="${param.keyword}">
                                        </div>
                                        <div class="col-md-4">
                                            <button type="submit" class="btn btn-primary w-100">
                                                <i class="fas fa-filter me-2"></i>Lọc
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Applications List -->
                            <div class="card">
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th scope="col">Công việc</th>
                                                    <th scope="col">Công ty</th>
                                                    <th scope="col">Ngày ứng tuyển</th>
                                                    <th scope="col">Trạng thái</th>
                                                    <th scope="col">CV đã nộp</th>
                                                    <th scope="col">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${not empty applications}">
                                                        <c:forEach items="${applications}" var="app">
                                                            <tr>
                                                                <td>
                                                                    <a href="${pageContext.request.contextPath}/post/view?id=${app.jobId}"
                                                                        class="text-decoration-none">
                                                                        <h6 class="mb-1">${app.jobTitle}</h6>
                                                                        <small class="text-muted">
                                                                            <i
                                                                                class="fas fa-map-marker-alt me-1"></i>${app.location}
                                                                        </small>
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <img src="${app.companyLogo}"
                                                                            class="rounded-3 me-2" width="32"
                                                                            height="32" alt="${app.companyName}">
                                                                        <div>
                                                                            <h6 class="mb-0">${app.companyName}</h6>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <fmt:formatDate value="${app.appliedAt}"
                                                                        pattern="dd/MM/yyyy" />
                                                                </td>
                                                                <td>
                                                                    <span
                                                                        class="badge bg-${app.statusColor}">${app.status}</span>
                                                                </td>
                                                                <td>
                                                                    <a href="download-cv?applicationId=${app.id}"
                                                                        class="text-decoration-none">
                                                                        <i
                                                                            class="fas fa-file-alt me-1"></i>${app.cvName}
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <div class="btn-group">
                                                                        <a href="${pageContext.request.contextPath}/post/view?id=${app.jobId}"
                                                                            class="btn btn-sm btn-outline-primary">
                                                                            <i class="fas fa-eye"></i>
                                                                        </a>
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-outline-danger withdraw-app"
                                                                            data-application-id="${app.id}"
                                                                            ${app.canWithdraw ? '' : 'disabled' }>
                                                                            <i class="fas fa-times"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td colspan="6" class="text-center py-5">

                                                                <h5>Chưa có ứng tuyển nào</h5>
                                                                <p class="text-muted">Bạn chưa ứng tuyển vào vị trí nào
                                                                </p>

                                                            </td>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Applications pagination" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage - 1}" tabindex="-1">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage + 1}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>

                        <!-- Withdraw Confirmation Modal -->
                        <div class="modal fade" id="withdrawModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Xác nhận hủy ứng tuyển</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Bạn có chắc chắn muốn hủy ứng tuyển này không?</p>
                                        <p class="text-danger"><small>Hành động này không thể hoàn tác.</small></p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Hủy</button>
                                        <button type="button" class="btn btn-danger" id="confirmWithdraw">Xác
                                            nhận</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Scripts -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const withdrawModal = new bootstrap.Modal(document.getElementById('withdrawModal'));
                                let applicationToWithdraw = null;

                                // Withdraw application
                                document.querySelectorAll('.withdraw-app').forEach(button => {
                                    button.addEventListener('click', function () {
                                        applicationToWithdraw = this.dataset.applicationId;
                                        console.log('Bấm hủy cho Application ID:', applicationToWithdraw);
                                        withdrawModal.show();
                                    });
                                });

                                document.getElementById('confirmWithdraw').addEventListener('click', function () {
                                    if (applicationToWithdraw) {
                                        console.log('Chuẩn bị gửi ID để hủy:', applicationToWithdraw);

                                        // Sử dụng URLSearchParams để đảm bảo định dạng body chính xác
                                        const params = new URLSearchParams();
                                        params.append('applicationId', applicationToWithdraw);

                                        fetch('withdraw_application', {
                                            method: 'POST',
                                            headers: {
                                                'Content-Type': 'application/x-www-form-urlencoded',
                                            },
                                            body: params // Gửi đối tượng params đã được chuẩn hóa
                                        })
                                            .then(response => {
                                                return response.json().then(data => ({ ok: response.ok, status: response.status, data }));
                                            })
                                            .then(({ ok, status, data }) => {
                                                if (ok && data.success) {
                                                    location.reload();
                                                } else {
                                                    throw new Error(data.message || `Lỗi không xác định từ server (status: ${status})`);
                                                }
                                            })
                                            .catch(error => {
                                                console.error('Lỗi khi hủy ứng tuyển:', error);
                                                alert(error.message || 'Có lỗi xảy ra. Vui lòng thử lại!');
                                            });
                                    }
                                    withdrawModal.hide();
                                });
                            });
                        </script>
                </body>

                </html>