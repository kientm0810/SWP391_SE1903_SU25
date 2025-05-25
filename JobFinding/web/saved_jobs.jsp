<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Việc làm đã lưu | JobFinding</title>

        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="assets/css/main.css">
    </head>

    <body>
        <div class="container py-5">
            <h1 class="mb-4">Việc làm đã lưu</h1>

            <!-- Job List -->
            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty savedJobs}">
                        <c:forEach items="${savedJobs}" var="job">
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <img src="${job.companyLogo}" class="rounded-3 me-3" width="64"
                                                 height="64" alt="${job.companyName}">
                                            <div>
                                                <h5 class="card-title mb-1">
                                                    <a href="job_detail.jsp?id=${job.id}"
                                                       class="text-decoration-none text-dark">
                                                        ${job.title}
                                                    </a>
                                                </h5>
                                                <p class="text-muted mb-0">${job.companyName}</p>
                                            </div>
                                        </div>
                                        <div class="job-meta mb-3">
                                            <span><i class="fas fa-map-marker-alt"></i> ${job.location}</span>
                                            <span><i class="fas fa-money-bill-wave"></i> ${job.salary}</span>
                                            <span><i class="fas fa-clock"></i> ${job.type}</span>
                                        </div>
                                        <p class="card-text">${job.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                <i class="fas fa-calendar-alt me-1"></i>
                                                Đã lưu:
                                                <fmt:formatDate value="${job.savedAt}" pattern="dd/MM/yyyy" />
                                            </small>
                                            <div class="btn-group">
                                                <a href="job_detail.jsp?id=${job.id}" class="btn btn-primary">
                                                    <i class="fas fa-paper-plane me-1"></i>Ứng tuyển
                                                </a>
                                                <button type="button" class="btn btn-outline-danger unsave-job"
                                                        data-job-id="${job.id}">
                                                    <i class="fas fa-heart"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="text-center py-5">
                                <img src="assets/images/empty-saved.png" alt="No saved jobs" class="mb-4"
                                     style="width: 200px;">
                                <h5>Chưa có việc làm nào được lưu</h5>
                                <p class="text-muted">Hãy lưu những việc làm bạn quan tâm để xem lại sau!</p>
                                <a href="job_search.jsp" class="btn btn-primary mt-3">
                                    <i class="fas fa-search me-2"></i>Tìm việc ngay
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Saved jobs pagination" class="mt-4">
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
                const successToast = new bootstrap.Toast(document.getElementById('successToast'));

                // Unsave job
                document.querySelectorAll('.unsave-job').forEach(button => {
                    button.addEventListener('click', function () {
                        const jobId = this.dataset.jobId;
                        fetch('save_job', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: `jobId=${jobId}&action=unsave`
                        })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        // Remove the job card from the list
                                        this.closest('.col-md-6').remove();

                                        // Show success message
                                        document.querySelector('#successToast .toast-body').textContent = 'Đã bỏ lưu việc làm';
                                        successToast.show();

                                        // If no jobs left, show empty state
                                        if (document.querySelectorAll('.col-md-6').length === 0) {
                                            location.reload();
                                        }
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
            });
        </script>
    </body>

</html>