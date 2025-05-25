<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Danh sách công ty | JobFinding</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <div class="container py-5">
                    <h1 class="text-center mb-4">Khám phá công ty</h1>

                    <!-- Search Form -->
                    <form action="companies" method="GET" class="mb-4">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <input type="text" name="keyword" class="form-control"
                                    placeholder="Tên công ty, lĩnh vực..." value="${param.keyword}">
                            </div>
                            <div class="col-md-4">
                                <select name="industry" class="form-select">
                                    <option value="">Tất cả lĩnh vực</option>
                                    <c:forEach items="${industries}" var="industry">
                                        <option value="${industry.id}" ${param.industry==industry.id ? 'selected' : ''
                                            }>
                                            ${industry.name}
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

                    <!-- Company Grid -->
                    <div class="row g-4">
                        <c:forEach items="${companies}" var="company">
                            <div class="col-md-6 col-lg-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <img src="${company.logo}" class="rounded-3 me-3" width="64" height="64"
                                                alt="${company.name}">
                                            <div>
                                                <h5 class="card-title mb-1">
                                                    <a href="company_detail.jsp?id=${company.id}"
                                                        class="text-decoration-none text-dark">
                                                        ${company.name}
                                                    </a>
                                                </h5>
                                                <p class="text-muted mb-0">${company.industry}</p>
                                            </div>
                                        </div>
                                        <p class="card-text">${company.description}</p>
                                        <div class="company-meta">
                                            <span><i class="fas fa-map-marker-alt"></i> ${company.location}</span>
                                            <span><i class="fas fa-users"></i> ${company.size} nhân viên</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-primary">
                                                <strong>${company.openPositions}</strong> vị trí đang tuyển
                                            </span>
                                            <a href="company_detail.jsp?id=${company.id}"
                                                class="btn btn-outline-primary">
                                                Xem chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Company pagination" class="mt-4">
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

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/main.js"></script>
            </body>

            </html>