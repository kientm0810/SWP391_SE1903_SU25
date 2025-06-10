<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách tin tuyển dụng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="assets/css/stylePosts.css" rel="stylesheet">
  
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="mb-1">Danh sách tin tuyển dụng</h2>
                <p class="text-muted mb-0">Tìm kiếm công việc phù hợp với bạn</p>
            </div>
            <c:if test="${sessionScope.userId != null}">
                <a href="${pageContext.request.contextPath}/post/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Đăng tin mới
                </a>
            </c:if>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>

        <!-- Search Form -->
        <div class="card mb-4">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/post" method="GET" class="row g-3">
                    <div class="col-md-4">
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" class="form-control" name="keyword"
                                   placeholder="Tìm kiếm theo tiêu đề, công ty..." value="${param.keyword}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="jobType">
                            <option value="">Tất cả loại hình</option>
                            <option value="Full-time" ${param.jobType=='Full-time' ? 'selected' : '' }>Full-time</option>
                            <option value="Part-time" ${param.jobType=='Part-time' ? 'selected' : '' }>Part-time</option>
                            <option value="Contract" ${param.jobType=='Contract' ? 'selected' : '' }>Contract</option>
                            <option value="Internship" ${param.jobType=='Internship' ? 'selected' : '' }>Internship</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="location">
                            <option value="">Tất cả địa điểm</option>
                            <option value="Hà Nội" ${param.location=='Hà Nội' ? 'selected' : '' }>Hà Nội</option>
                            <option value="Hồ Chí Minh" ${param.location=='Hồ Chí Minh' ? 'selected' : '' }>Hồ Chí Minh</option>
                            <option value="Đà Nẵng" ${param.location=='Đà Nẵng' ? 'selected' : '' }>Đà Nẵng</option>
                            <option value="Remote" ${param.location=='Remote' ? 'selected' : '' }>Remote</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search me-1"></i> Tìm kiếm
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="row">
            <c:forEach items="${posts}" var="post">
                <div class="col-md-6">
                    <div class="card job-card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="d-flex">
                                    <img src="${post.companyLogo != null ? post.companyLogo : 'assets/img/icon/job-list1.png'}"
                                         alt="${post.companyName}" class="company-logo me-3">
                                    <div>
                                        <h5 class="card-title mb-1">
                                            <a href="${pageContext.request.contextPath}/post/view?id=${post.id}"
                                               class="text-decoration-none text-dark">
                                                ${post.title}
                                            </a>
                                        </h5>
                                        <p class="text-muted mb-1">${post.companyName}</p>
                                        <div class="d-flex flex-wrap">
                                            <div class="job-info-item">
                                                <i class="fas fa-map-marker-alt"></i>
                                                <span>${post.location}</span>
                                            </div>
                                            <div class="job-info-item">
                                                <i class="fas fa-briefcase"></i>
                                                <span>${post.experience}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <span class="job-type-badge">${post.jobType}</span>
                            </div>
                            <div class="mt-3">
                                <div class="job-description">
                                    ${post.jobDescription}
                                </div>
                                <div class="d-flex flex-wrap mt-2">
                                    <div class="job-info-item">
                                        <i class="fas fa-money-bill-wave"></i>
                                        <span class="salary-text">${post.salary}</span>
                                    </div>
                                    <div class="job-info-item">
                                        <i class="fas fa-clock"></i>
                                        <span class="deadline-text">Hạn nộp:
                                            <fmt:formatDate value="${post.deadline}" pattern="dd/MM/yyyy" />
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-3 d-flex justify-content-between align-items-center">
                                <div class="d-flex">
                                    <div class="job-info-item">
                                        <i class="fas fa-eye"></i>
                                        <span>${post.viewCount} lượt xem</span>
                                    </div>
                                    <div class="job-info-item">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>
                                            <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy" />
                                        </span>
                                    </div>
                                </div>
                                <c:if test="${sessionScope.userId != null && sessionScope.userId == post.userId}">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/post/edit?id=${post.id}"
                                           class="btn btn-outline-primary btn-action me-2">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/post/delete?id=${post.id}"
                                           class="btn btn-outline-danger btn-action"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa tin này?')">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Phân trang nâng cao -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <!-- Trang đầu tiên -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/post?page=1"
                           aria-label="Trang đầu" title="Trang đầu">
                            <i class="fas fa-angle-double-left"></i>
                        </a>
                    </li>
                    <!-- Nút trang trước -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/post?page=${currentPage - 1}"
                           aria-label="Trang trước" title="Trang trước">
                            <i class="fas fa-angle-left"></i>
                        </a>
                    </li>
                    <!-- Số trang với dấu ... -->
                    <c:set var="startPage" value="${currentPage - 2}" />
                    <c:set var="endPage" value="${currentPage + 2}" />
                    <c:if test="${startPage < 1}">
                        <c:set var="startPage" value="1" />
                    </c:if>
                    <c:if test="${endPage > totalPages}">
                        <c:set var="endPage" value="${totalPages}" />
                    </c:if>
                    <c:if test="${startPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/post?page=1">1</a>
                        </li>
                        <c:if test="${startPage > 2}">
                            <li class="page-item disabled">
                                <span class="page-link">...</span>
                            </li>
                        </c:if>
                    </c:if>
                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/post?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${endPage < totalPages}">
                        <c:if test="${endPage < totalPages - 1}">
                            <li class="page-item disabled">
                                <span class="page-link">...</span>
                            </li>
                        </c:if>
                        <li class="page-item">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/post?page=${totalPages}">${totalPages}</a>
                        </li>
                    </c:if>
                    <!-- Nút trang sau -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/post?page=${currentPage + 1}"
                           aria-label="Trang sau" title="Trang sau">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                    <!-- Trang cuối cùng -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/post?page=${totalPages}"
                           aria-label="Trang cuối" title="Trang cuối">
                            <i class="fas fa-angle-double-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>

        <c:if test="${empty posts}">
            <div class="empty-state">
                <i class="fas fa-search"></i>
                <h4 class="mt-3">Không có tin tuyển dụng nào</h4>
                <p class="text-muted">Hãy quay lại sau hoặc thử tìm kiếm với từ khóa khác</p>
                <c:if test="${sessionScope.userId != null}">
                    <a href="${pageContext.request.contextPath}/post/create" class="btn btn-primary mt-3">
                        <i class="fas fa-plus"></i> Đăng tin mới
                    </a>
                </c:if>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
