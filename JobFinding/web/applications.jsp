<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Việc làm đã ứng tuyển | JobFinding</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <div class="container py-5">
                    <h1 class="mb-4">Việc làm đã ứng tuyển</h1>

                    <!-- Filters -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form action="applications" method="GET" class="row g-3">
                                <div class="col-md-4">
                                    <select name="status" class="form-select">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="new" ${param.status=='new' ? 'selected' : '' }>Mới</option>
                                        <option value="reviewed" ${param.status=='reviewed' ? 'selected' : '' }>Đã xem
                                        </option>
                                        <option value="interviewed" ${param.status=='interviewed' ? 'selected' : '' }>Đã
                                            phỏng vấn</option>
                                        <option value="rejected" ${param.status=='rejected' ? 'selected' : '' }>Từ chối
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
                                                            <a href="job_detail.jsp?id=${app.jobId}"
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
                                                                <img src="${app.companyLogo}" class="rounded-3 me-2"
                                                                    width="32" height="32" alt="${app.companyName}">
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
                                                            <a href="preview_cv.jsp?id=${app.cvId}"
                                                                class="text-decoration-none">
                                                                <i class="fas fa-file-alt me-1"></i>${app.cvName}
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group">
                                                                <a href="job_detail.jsp?id=${app.jobId}"
                                                                    class="btn btn-sm btn-outline-primary">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <button type="button"
                                                                    class="btn btn-sm btn-outline-danger withdraw-app"
                                                                    data-app-id="${app.id}" ${app.canWithdraw ? ''
                                                                    : 'disabled' }>
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
                                                        <p class="text-muted">Bạn chưa ứng tuyển vào vị trí nào</p>
                                                     
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
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-danger" id="confirmWithdraw">Xác nhận</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const withdrawModal = new bootstrap.Modal(document.getElementById('withdrawModal'));
                        let applicationToWithdraw = null;

                        // Withdraw application
                        document.querySelectorAll('.withdraw-app').forEach(button => {
                            button.addEventListener('click', function () {
                                applicationToWithdraw = this.dataset.appId;
                                withdrawModal.show();
                            });
                        });

                        document.getElementById('confirmWithdraw').addEventListener('click', function () {
                            if (applicationToWithdraw) {
                                fetch('withdraw_application', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/x-www-form-urlencoded',
                                    },
                                    body: `applicationId=${applicationToWithdraw}`
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
                            withdrawModal.hide();
                        });
                    });
                </script>
            </body>

            </html>