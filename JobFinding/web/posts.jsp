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
        <link href="assets/css/Posts.css" rel="stylesheet" />
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <c:choose>
                        <c:when test="${isMyPosts}">
                            <h2 class="mb-1">Danh sách tin tuyển dụng của bạn</h2>
                            <p class="text-muted mb-0">Quản lý các tin tuyển dụng bạn đã đăng</p>
                        </c:when>
                        <c:otherwise>
                            <h2 class="mb-1">Danh sách tin tuyển dụng</h2>
                            <p class="text-muted mb-0">Tìm kiếm công việc phù hợp với bạn</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-flex gap-2">
                    <c:if test="${sessionScope.userType == 'recruiter'}">
                        <c:choose>
                            <c:when test="${isMyPosts}">
                                <a href="${pageContext.request.contextPath}/post?view=all"
                                   class="btn btn-outline-primary">Tất cả bài đăng</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/post?view=my-post"
                                   class="btn btn-outline-primary">Bài đăng của tôi</a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${sessionScope.role == 'recruiter'}">
                        <button class="btn btn-primary" onclick="window.location.href = 'create-post.jsp'">+ Đăng
                            tin mới</button>
                        </c:if>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>

            <!-- Search Form -->
            <div class="search-bar-section">
                <div class="card mb-4">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/post" method="GET" class="row g-3">
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" class="form-control" name="keyword"
                                           placeholder="Tìm kiếm theo tiêu đề, công ty..."
                                           value="${param.keyword}">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" name="jobType">
                                    <option value="">Tất cả loại hình</option>
                                    <option value="Full-time" ${param.jobType=='Full-time' ? 'selected' : '' }>
                                        Full-time</option>
                                    <option value="Part-time" ${param.jobType=='Part-time' ? 'selected' : '' }>
                                        Part-time</option>
                                    <option value="Contract" ${param.jobType=='Contract' ? 'selected' : '' }>
                                        Contract</option>
                                    <option value="Internship" ${param.jobType=='Internship' ? 'selected' : ''
                                            }>Internship</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" name="location">
                                    <option value="">Tất cả địa điểm</option>
                                    <option value="Hà Nội" ${param.location=='Hà Nội' ? 'selected' : '' }>Hà Nội
                                    </option>
                                    <option value="Hồ Chí Minh" ${param.location=='Hồ Chí Minh' ? 'selected'
                                                                  : '' }>Hồ Chí Minh</option>
                                    <option value="Đà Nẵng" ${param.location=='Đà Nẵng' ? 'selected' : '' }>Đà
                                        Nẵng</option>
                                    <option value="Remote" ${param.location=='Remote' ? 'selected' : '' }>Remote
                                    </option>
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
            </div>

            <div class="row">
                <c:forEach items="${posts}" var="post">
                    <div class="col-xl-4 col-lg-4 col-md-6">
                        <div class="card job-card">

                            <div
                                class="job-card-header-overlay d-flex justify-content-between align-items-center">
                                <div class="job-badges-left d-flex gap-2">
                                    <c:if test="${post.postType == 'hot'}">
                                        <span class="job-badge badge-new">Tin mới</span>
                                    </c:if>
                                    <c:if test="${post.postType == 'pro'}">
                                        <span class="job-badge badge-featured">Nổi bật</span>
                                    </c:if>
                                </div>

                            </div>

                            <div class="card-body">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="${post.companyLogo != null ? post.companyLogo : 'assets/img/icon/job-list1.png'}"
                                         alt="${post.companyName}" class="company-logo me-3">
                                    <div class="job-details">
                                        <h5 class="card-title mb-1">
                                            <a href="${pageContext.request.contextPath}/post/view?id=${post.id}"
                                               class="text-decoration-none text-dark job-title-truncate">
                                                ${post.title}
                                            </a>
                                        </h5>
                                        <p class="text-muted mb-1 company-name-truncate">${post.companyName}</p>
                                    </div>
                                </div>

                                <!-- Salary and Location Tags -->
                                <div class="d-flex flex-wrap gap-2">
                                    <span class="job-info-tag salary-tag">${post.salary}</span>
                                    <span class="job-info-tag location-tag">${post.location}</span>

                                    <form action="${pageContext.request.contextPath}/saved-jobs" method="post"
                                          style="display:inline;">
                                        <input type="hidden" name="postId" value="${post.id}" />
                                        <input type="hidden" name="action" value="save" />
                                        <button type="submit" class="btn btn-outline-primary save-job ms-auto">
                                            <i class="far fa-heart"></i> Lưu tin
                                        </button>
                                    </form>
                                </div>



                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!--Khu Phân trang -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-4">
                    <div class="simple-pagination d-flex justify-content-center align-items-center gap-3">
                        <!-- Nút trang trước -->
                        <a href="${currentPage == 1 ? '#' : pageContext.request.contextPath}/post?page=${currentPage - 1}${isMyPosts ? '&view=my-post' : ''}&keyword=${param.keyword}&jobType=${param.jobType}&location=${param.location}"
                           class="pagination-arrow ${currentPage == 1 ? 'disabled' : ''}">
                            <i class="fas fa-chevron-left"></i>
                        </a>

                        <span class="pagination-info">
                            <span class="current-page">${currentPage}</span> / <span
                                class="total-pages">${totalPages}</span> trang
                        </span>

                        <!-- Nút trang sau -->
                        <a href="${currentPage == totalPages ? '#' : pageContext.request.contextPath}/post?page=${currentPage + 1}${isMyPosts ? '&view=my-post' : ''}&keyword=${param.keyword}&jobType=${param.jobType}&location=${param.location}"
                           class="pagination-arrow ${currentPage == totalPages ? 'disabled' : ''}">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </nav>
            </c:if>
            <!--End-->


            <c:if test="${empty posts}">
                <div class="empty-state">
                    <i class="fas fa-search"></i>
                    <c:choose>
                        <c:when test="${isMyPosts}">
                            <h4 class="mt-3">Bạn chưa có tin tuyển dụng nào</h4>
                            <p class="text-muted">Hãy đăng tin tuyển dụng đầu tiên của bạn</p>
                        </c:when>
                        <c:otherwise>
                            <h4 class="mt-3">Không có tin tuyển dụng nào</h4>
                            <p class="text-muted">Hãy quay lại sau hoặc thử tìm kiếm với từ khóa khác</p>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${sessionScope.role == 'recruiter'}">
                        <button class="btn btn-primary" onclick="window.location.href = 'create-post.jsp'">+ Đăng
                            tin mới</button>
                        </c:if>
                </div>
            </c:if>
        </div>

        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <c:if test="${not empty sessionScope.notification}">
                <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header">
                        <i class="fas fa-check-circle text-success me-2"></i>
                        <strong class="me-auto">Thông báo</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                    <div class="toast-body">${sessionScope.notification}</div>
                </div>
                <c:remove var="notification" scope="session" />
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>