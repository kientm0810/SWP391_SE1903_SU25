<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Hồ sơ cá nhân | JobFinding</title>

                <!-- CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link rel="stylesheet" href="assets/css/main.css">
            </head>

            <body>
                <div class="container py-5">
                    <div class="row">
                        <!-- Profile Information -->
                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-body text-center">
                                    <img src="${user.profilePicture}" alt="Avatar" class="rounded-circle img-fluid"
                                        style="width: 150px;">
                                    <h5 class="my-3">${user.fullName}</h5>
                                    <p class="text-muted mb-1">${user.desiredJobTitle}</p>
                                    <p class="text-muted mb-4">${user.location}</p>
                                    <div class="d-flex justify-content-center mb-2">
                                        <a href="edit_profile.jsp" class="btn btn-primary me-2">
                                            <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                        </a>
                                        <a href="settings.jsp" class="btn btn-outline-primary">
                                            <i class="fas fa-cog me-2"></i>Cài đặt
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Contact Information -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="mb-3">Thông tin liên hệ</h5>
                                    <div class="mb-3">
                                        <i class="fas fa-envelope me-2 text-primary"></i>
                                        <span>${user.email}</span>
                                    </div>
                                    <div class="mb-3">
                                        <i class="fas fa-phone me-2 text-primary"></i>
                                        <span>${user.phone}</span>
                                    </div>
                                    <div class="mb-3">
                                        <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                                        <span>${user.address}</span>
                                    </div>
                                    <div class="mb-3">
                                        <i class="fab fa-linkedin me-2 text-primary"></i>
                                        <a href="${user.linkedinUrl}" target="_blank" class="text-decoration-none">
                                            LinkedIn Profile
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Skills -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="mb-3">Kỹ năng</h5>
                                    <div class="d-flex flex-wrap gap-2">
                                        <c:forEach items="${user.skills}" var="skill">
                                            <span class="badge bg-primary">${skill}</span>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="col-lg-8">
                            <!-- About -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="mb-3">Giới thiệu</h5>
                                    <p>${user.about}</p>
                                </div>
                            </div>

                            <!-- Experience -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="mb-3">Kinh nghiệm làm việc</h5>
                                    <c:forEach items="${user.experiences}" var="exp">
                                        <div class="mb-4">
                                            <div class="d-flex justify-content-between mb-2">
                                                <h6 class="mb-0">${exp.position}</h6>
                                                <span class="text-muted">
                                                    <fmt:formatDate value="${exp.startDate}" pattern="MM/yyyy" /> -
                                                    <c:choose>
                                                        <c:when test="${exp.current}">Hiện tại</c:when>
                                                        <c:otherwise>
                                                            <fmt:formatDate value="${exp.endDate}" pattern="MM/yyyy" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <p class="text-muted mb-2">${exp.company}</p>
                                            <p>${exp.description}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Education -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="mb-3">Học vấn</h5>
                                    <c:forEach items="${user.education}" var="edu">
                                        <div class="mb-4">
                                            <div class="d-flex justify-content-between mb-2">
                                                <h6 class="mb-0">${edu.degree}</h6>
                                                <span class="text-muted">
                                                    <fmt:formatDate value="${edu.startDate}" pattern="yyyy" /> -
                                                    <fmt:formatDate value="${edu.endDate}" pattern="yyyy" />
                                                </span>
                                            </div>
                                            <p class="text-muted mb-2">${edu.school}</p>
                                            <p>${edu.description}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Certifications -->
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="mb-3">Chứng chỉ</h5>
                                    <div class="row">
                                        <c:forEach items="${user.certifications}" var="cert">
                                            <div class="col-md-6 mb-3">
                                                <div class="d-flex align-items-center">
                                                    <i class="fas fa-certificate text-primary me-3 fa-2x"></i>
                                                    <div>
                                                        <h6 class="mb-1">${cert.name}</h6>
                                                        <p class="text-muted mb-0">
                                                            ${cert.issuer} -
                                                            <fmt:formatDate value="${cert.issueDate}"
                                                                pattern="MM/yyyy" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/main.js"></script>
            </body>

            </html>