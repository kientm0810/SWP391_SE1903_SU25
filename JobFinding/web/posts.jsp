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
                <style>
                    .job-card {
                        transition: all 0.3s ease;
                        margin-bottom: 20px;
                        border: 1px solid #e5e5e5;
                        border-radius: 8px;
                    }

                    .job-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                        border-color: #0D99FF;
                    }

                    .company-logo {
                        width: 80px;
                        height: 80px;
                        object-fit: contain;
                        border: 1px solid #e5e5e5;
                        border-radius: 8px;
                        padding: 5px;
                        background: white;
                    }

                    .job-type-badge {
                        font-size: 0.8rem;
                        padding: 0.25rem 0.75rem;
                        border-radius: 20px;
                        background-color: #E6F7FF;
                        color: #0D99FF;
                        font-weight: 500;
                    }

                    .salary-text {
                        color: #00B14F;
                        font-weight: 500;
                    }

                    .deadline-text {
                        color: #FF4D4F;
                        font-size: 0.9rem;
                    }

                    .job-info-item {
                        display: flex;
                        align-items: center;
                        color: #666;
                        font-size: 0.9rem;
                        margin-right: 1rem;
                    }

                    .job-info-item i {
                        margin-right: 0.5rem;
                        color: #999;
                    }

                    .job-description {
                        color: #666;
                        font-size: 0.9rem;
                        display: -webkit-box;
                        -webkit-line-clamp: 2;
                        -webkit-box-orient: vertical;
                        overflow: hidden;
                        margin: 0.5rem 0;
                    }

                    .btn-action {
                        padding: 0.25rem 0.5rem;
                        font-size: 0.875rem;
                        border-radius: 4px;
                    }

                    .btn-action i {
                        margin-right: 0.25rem;
                    }

                    .empty-state {
                        text-align: center;
                        padding: 3rem 0;
                        color: #666;
                    }

                    .empty-state i {
                        font-size: 3rem;
                        color: #ccc;
                        margin-bottom: 1rem;
                    }
                </style>
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
                                                        <fmt:formatDate value="${post.createdAt}"
                                                            pattern="dd/MM/yyyy" />
                                                    </span>
                                                </div>
                                            </div>
                                            <c:if
                                                test="${sessionScope.userId != null && sessionScope.userId == post.userId}">
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