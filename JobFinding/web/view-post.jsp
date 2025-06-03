<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${post.title} - Chi tiết thông tin bài đăng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .post-header {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .company-logo {
            width: 120px;
            height: 120px;
            object-fit: contain;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 10px;
            background: white;
        }

        .job-type-badge {
            font-size: 0.9rem;
            padding: 0.35rem 1rem;
            border-radius: 20px;
            background-color: #E6F7FF;
            color: #0D99FF;
            font-weight: 500;
        }

        .salary-text {
            color: #00B14F;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .deadline-text {
            color: #FF4D4F;
            font-size: 1rem;
        }

        .job-info-item {
            display: flex;
            align-items: center;
            color: #666;
            font-size: 1rem;
            margin-right: 1.5rem;
        }

        .job-info-item i {
            margin-right: 0.5rem;
            color: #999;
            width: 20px;
        }

        .section-title {
            color: #333;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #f0f0f0;
        }

        .content-section {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .btn-action {
            padding: 0.5rem 1rem;
            font-size: 1rem;
        }

        .btn-action i {
            margin-right: 0.5rem;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/post">Danh sách tin</a></li>
                <li class="breadcrumb-item active" aria-current="page">${post.title}</li>
            </ol>
        </nav>

        <div class="post-header">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="mb-3">${post.title}</h1>
                    <div class="d-flex align-items-center mb-3">
                        <img src="${post.companyLogo != null ? post.companyLogo : 'assets/img/icon/job-list1.png'}"
                             alt="${post.companyName}" class="company-logo me-3">
                        <div>
                            <h4 class="mb-1">${post.companyName}</h4>
                            <div class="d-flex flex-wrap">
                                <div class="job-info-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${post.location}</span>
                                </div>
                                <div class="job-info-item">
                                    <i class="fas fa-briefcase"></i>
                                    <span>${post.experience}</span>
                                </div>
                                <div class="job-info-item">
                                    <i class="fas fa-clock"></i>
                                    <span>${post.workingTime}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-md-end">
                    <span class="job-type-badge mb-2 d-inline-block">${post.jobType}</span>
                    <div class="salary-text mb-2">${post.salary}</div>
                    <div class="deadline-text">
                        <i class="fas fa-calendar-alt"></i>
                        Hạn nộp:
                        <fmt:formatDate value="${post.deadline}" pattern="dd/MM/yyyy" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <!-- Mô tả công việc -->
                <div class="content-section">
                    <h3 class="section-title">Mô tả công việc</h3>
                    <div class="content">
                        ${post.jobDescription}
                    </div>
                </div>

                <!-- Yêu cầu ứng viên -->
                <div class="content-section">
                    <h3 class="section-title">Yêu cầu ứng viên</h3>
                    <div class="content">
                        ${post.requirements}
                    </div>
                </div>

                <!-- Quyền lợi -->
                <div class="content-section">
                    <h3 class="section-title">Quyền lợi</h3>
                    <div class="content">
                        ${post.benefits}
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <!-- Thông tin liên hệ -->
                <div class="content-section">
                    <h3 class="section-title">Thông tin liên hệ</h3>
                    <div class="content">
                        <div class="job-info-item mb-3">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>${post.contactAddress}</span>
                        </div>
                        <div class="job-info-item">
                            <i class="fas fa-info-circle"></i>
                            <span>${post.applicationMethod}</span>
                        </div>
                    </div>
                </div>

                <!-- Thông tin khác -->
                <div class="content-section">
                    <h3 class="section-title">Thông tin khác</h3>
                    <div class="content">
                        <div class="job-info-item mb-2">
                            <i class="fas fa-eye"></i>
                            <span>${post.viewCount} lượt xem</span>
                        </div>
                        <div class="job-info-item mb-2">
                            <i class="fas fa-calendar-alt"></i>
                            <span>Đăng ngày:
                                <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy" />
                            </span>
                        </div>
                        <c:if test="${sessionScope.userId != null && sessionScope.userId == post.userId}">
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/post/edit?id=${post.id}"
                                   class="btn btn-outline-primary btn-action w-100 mb-2">
                                    <i class="fas fa-edit"></i> Chỉnh sửa tin
                                </a>
                                <a href="${pageContext.request.contextPath}/post/delete?id=${post.id}"
                                   class="btn btn-outline-danger btn-action w-100"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa tin này?')">
                                    <i class="fas fa-trash"></i> Xóa tin
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
