<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Tìm kiếm việc làm | JobFinding</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <div class="container py-5">
                    <h1 class="text-center mb-4">Tìm kiếm việc làm</h1>

                    <!-- Search Form -->
                    <form action="job_search" method="GET" class="mb-4">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <input type="text" name="keyword" class="form-control" placeholder="Nhập từ khóa..."
                                    value="${param.keyword}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" name="location" class="form-control" placeholder="Địa điểm"
                                    value="${param.location}">
                            </div>
                            <div class="col-md-3">
                                <select name="category" class="form-select">
                                    <option value="">Tất cả ngành nghề</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.id}" ${param.category==category.id ? 'selected' : ''
                                            }>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search me-2"></i>Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Search Results -->
                    <div class="row">
                        <div class="col-md-12">
                            <c:choose>
                                <c:when test="${not empty jobs}">
                                    <div class="card-list">
                                        <c:forEach items="${jobs}" var="job">
                                            <div class="card mb-3">
                                                <div class="card-body">
                                                    <h5 class="card-title">
                                                        <a href="job_detail.jsp?id=${job.id}"
                                                            class="text-decoration-none">
                                                            ${job.title}
                                                        </a>
                                                    </h5>
                                                    <h6 class="card-subtitle mb-2 text-muted">${job.companyName}</h6>
                                                    <div class="job-meta">
                                                        <span><i class="fas fa-map-marker-alt"></i>
                                                            ${job.location}</span>
                                                        <span><i class="fas fa-money-bill-wave"></i>
                                                            ${job.salary}</span>
                                                        <span><i class="fas fa-clock"></i> ${job.type}</span>
                                                    </div>
                                                    <p class="card-text">${job.description}</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="text-muted">Đăng ${job.postedDate}</small>
                                                        <div class="btn-group">
                                                            <a href="job_detail.jsp?id=${job.id}"
                                                                class="btn btn-sm btn-outline-primary">Chi tiết</a>
                                                            <button type="button"
                                                                class="btn btn-sm btn-outline-secondary save-job"
                                                                data-job-id="${job.id}">
                                                                <i class="far fa-heart"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-5">
                                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                        <h5>Không tìm thấy việc làm phù hợp</h5>
                                        <p class="text-muted">Vui lòng thử lại với từ khóa khác</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/main.js"></script>
            </body>

            </html>