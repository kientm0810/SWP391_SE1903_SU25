<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                
                <style>
                    .text-primary {
                        color: #28a745 !important;
                    }
                    
                    .btn-primary, .badge.bg-primary {
                        color: #ffffff !important;
                        background-color: #28a745 !important;
                        border-color: #28a745 !important;
                    }
                    
                    .btn-primary:hover {
                        background-color: #218838 !important;
                        border-color: #1e7e34 !important;
                    }
                    
                    .btn-outline-primary {
                        color: #28a745 !important;
                        border-color: #28a745 !important;
                    }
                    
                    .btn-outline-primary:hover {
                        background-color: #28a745 !important;
                        border-color: #28a745 !important;
                        color: white !important;
                    }
                    
                    .profile-section {
                        background: #fff;
                        border-radius: 15px;
                        box-shadow: 0 0 20px rgba(0,0,0,0.08);
                        margin-bottom: 25px;
                        overflow: hidden;
                        border: 1px solid #e9ecef;
                    }
                    
                    .section-header {
                        background: linear-gradient(135deg, #28a745, #20c997);
                        color: white;
                        padding: 20px 25px;
                        border-bottom: none;
                        position: relative;
                    }
                    
                    .section-header::after {
                        content: '';
                        position: absolute;
                        bottom: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, #20c997, #17a2b8);
                    }
                    
                    .section-header h5 {
                        margin: 0;
                        font-weight: 600;
                        font-size: 1.1rem;
                    }
                    
                    .section-body {
                        padding: 25px;
                    }
                    
                    .timeline-item {
                        position: relative;
                        padding-left: 40px;
                        margin-bottom: 30px;
                        border-left: 2px solid #e9ecef;
                    }
                    
                    .timeline-item::before {
                        content: '';
                        position: absolute;
                        left: -8px;
                        top: 0;
                        width: 14px;
                        height: 14px;
                        background: #28a745;
                        border-radius: 50%;
                        border: 3px solid #fff;
                        box-shadow: 0 0 0 3px #e9ecef;
                    }
                    
                    .timeline-item.current::before {
                        background: #17a2b8;
                        animation: pulse 2s infinite;
                    }
                    
                    @keyframes pulse {
                        0% { box-shadow: 0 0 0 0 rgba(23, 162, 184, 0.7); }
                        70% { box-shadow: 0 0 0 10px rgba(23, 162, 184, 0); }
                        100% { box-shadow: 0 0 0 0 rgba(23, 162, 184, 0); }
                    }
                    
                    .item-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        margin-bottom: 12px;
                    }
                    
                    .item-title {
                        font-weight: 600;
                        color: #2c3e50;
                        font-size: 1.05rem;
                        margin-bottom: 5px;
                    }
                    
                    .item-company {
                        color: #28a745;
                        font-weight: 500;
                        font-size: 0.95rem;
                    }
                    
                    .item-meta {
                        color: #6c757d;
                        font-size: 0.85rem;
                        margin-bottom: 10px;
                    }
                    
                    .item-description {
                        color: #495057;
                        line-height: 1.6;
                        margin-bottom: 10px;
                    }
                    
                    .skills-tag {
                        display: inline-block;
                        background: #e8f5e8;
                        color: #28a745;
                        padding: 4px 10px;
                        border-radius: 15px;
                        font-size: 0.8rem;
                        margin: 2px;
                        border: 1px solid #c3e6cb;
                    }
                    
                    .current-badge {
                        background: linear-gradient(45deg, #17a2b8, #20c997);
                        color: white;
                        padding: 4px 12px;
                        border-radius: 20px;
                        font-size: 0.75rem;
                        font-weight: 500;
                    }
                    
                    .gpa-badge {
                        background: linear-gradient(45deg, #ffc107, #fd7e14);
                        color: white;
                        padding: 4px 12px;
                        border-radius: 20px;
                        font-size: 0.75rem;
                        font-weight: 500;
                    }
                    
                    .empty-state {
                        text-align: center;
                        padding: 50px 20px;
                        color: #6c757d;
                    }
                    
                    .empty-state i {
                        font-size: 3rem;
                        margin-bottom: 20px;
                        color: #dee2e6;
                    }
                    
                    .section-actions {
                        position: absolute;
                        right: 25px;
                        top: 50%;
                        transform: translateY(-50%);
                    }
                    
                    .item-actions {
                        display: flex;
                        gap: 8px;
                    }
                    
                    .btn-action {
                        width: 32px;
                        height: 32px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 0.8rem;
                        transition: all 0.3s ease;
                    }
                    
                    .credential-link {
                        color: #28a745;
                        text-decoration: none;
                        font-size: 0.9rem;
                    }
                    
                    .credential-link:hover {
                        text-decoration: underline;
                    }
                    
                    .certificate-image {
                        max-width: 60px;
                        height: 40px;
                        object-fit: cover;
                        border-radius: 8px;
                        border: 1px solid #dee2e6;
                    }
                    
                    @media (max-width: 768px) {
                        .item-header {
                            flex-direction: column;
                            gap: 10px;
                        }
                        
                        .section-actions {
                            position: static;
                            transform: none;
                            margin-top: 15px;
                        }
                        
                        .section-header {
                            padding: 15px 20px;
                        }
                        
                        .section-body {
                            padding: 20px;
                        }
                        
                        .timeline-item {
                            padding-left: 30px;
                        }
                    }
                </style>
            </head>

            <body>
                <%@ include file="header.jsp" %>
                <div class="container py-5">
                    <!-- Success/Error Messages -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="successMessage" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session" />
                    </c:if>
                    
                    <div class="row">
                        <!-- Profile Information -->
                        <div class="col-lg-4">
                            <div class="profile-section">
                                <div class="section-body text-center">
                                    <form id="avatarForm" method="post" action="avatar-upload" enctype="multipart/form-data">
                                        <input type="hidden" name="action" value="uploadAvatar">
                                        <input type="file" name="avatarFile" id="avatarFile" class="d-none" accept="image/png, image/jpeg" onchange="document.getElementById('avatarForm').submit();">
                                        <img src="${sessionScope.user.profilePicture != null ? sessionScope.user.profilePicture : 'assets/img/elements/user.png'}" alt="Avatar" class="rounded-circle img-fluid" style="width: 150px; cursor:pointer;" onclick="document.getElementById('avatarFile').click();">
                                        <small class="text-muted d-block mt-2">Nhấp vào ảnh để thay đổi</small>
                                    </form>
                                    <h5 class="my-3">${sessionScope.user.fullName}</h5>
                                    <p class="text-muted mb-1">${sessionScope.user.desiredJobTitle != null ? sessionScope.user.desiredJobTitle : 'Tìm việc làm'}</p>
                                    <p class="text-muted mb-4">${sessionScope.user.address != null ? sessionScope.user.address : 'Việt Nam'}</p>
                                </div>
                            </div>

                            <!-- Contact Information -->
                            <div class="profile-section">
                                <div class="section-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0"><i class="fas fa-address-card me-2"></i>Thông tin liên hệ</h5>
                                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editContactModal">
                                        <i class="fas fa-edit me-1"></i>Chỉnh sửa
                                    </button>
                                </div>
                                <div class="section-body">
                                    <div class="mb-3">
                                        <i class="fas fa-envelope me-2 text-primary"></i>
                                        <span>${sessionScope.user.email}</span>
                                    </div>
                                    <div class="mb-3">
                                        <i class="fas fa-phone me-2 text-primary"></i>
                                        <span>${sessionScope.user.phone != null ? sessionScope.user.phone : 'Chưa cập nhật'}</span>
                                    </div>
                                    <div class="mb-3">
                                        <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                                        <span>${sessionScope.user.address != null ? sessionScope.user.address : 'Chưa cập nhật'}</span>
                                    </div>
                                    <c:if test="${not empty sessionScope.user.portfolioUrl}">
                                        <div class="mb-3">
                                            <i class="fab fa-linkedin me-2 text-primary"></i>
                                            <a href="${sessionScope.user.portfolioUrl}" target="_blank" class="text-decoration-none">
                                                Portfolio/LinkedIn
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="col-lg-8">
                            <!-- Experience Section -->
                            <div class="profile-section">
                                <div class="section-header">
                                    <h5>
                                        <i class="fas fa-briefcase me-2"></i>
                                        Kinh nghiệm làm việc
                                        <span class="badge bg-light text-dark ms-2">${experienceCount}</span>
                                    </h5>
                                    <div class="section-actions">
                                        <a href="experience-add" class="btn btn-light btn-sm">
                                            <i class="fas fa-plus me-1"></i>Thêm
                                        </a>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <c:choose>
                                        <c:when test="${empty experiences}">
                                            <div class="empty-state">
                                                <i class="fas fa-briefcase"></i>
                                                <h6>Chưa có kinh nghiệm làm việc</h6>
                                                <p class="mb-3">Thêm kinh nghiệm làm việc để thu hút nhà tuyển dụng</p>
                                                <a href="experience-add" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm kinh nghiệm đầu tiên
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${experiences}" var="exp">
                                                <div class="timeline-item ${exp.current ? 'current' : ''}">
                                                    <div class="item-header">
                                                        <div>
                                                            <div class="item-title">${exp.position}</div>
                                                            <div class="item-company">${exp.companyName}</div>
                                                            <div class="item-meta">
                                                                <i class="fas fa-map-marker-alt me-1"></i>${exp.location}
                                                                <span class="mx-2">•</span>
                                                                <i class="fas fa-calendar me-1"></i>
                                                                <fmt:formatDate value="${exp.startDate}" pattern="MM/yyyy" /> - 
                                                                <c:choose>
                                                                    <c:when test="${exp.current}">
                                                                        <span class="current-badge">Hiện tại</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <fmt:formatDate value="${exp.endDate}" pattern="MM/yyyy" />
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                        <div class="item-actions">
                                                            <a href="experience-edit?id=${exp.id}" class="btn btn-outline-primary btn-action" title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <button class="btn btn-outline-danger btn-action" onclick="confirmDeleteExperience(${exp.id}, '${exp.position}')" title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <c:if test="${not empty exp.description}">
                                                        <div class="item-description">${exp.description}</div>
                                                    </c:if>
                                                    <c:if test="${not empty exp.skillsUsed}">
                                                        <div class="mt-2">
                                                            <c:forEach items="${fn:split(exp.skillsUsed, ',')}" var="skill">
                                                                <span class="skills-tag">${fn:trim(skill)}</span>
                                                            </c:forEach>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Education Section -->
                            <div class="profile-section">
                                <div class="section-header">
                                    <h5>
                                        <i class="fas fa-graduation-cap me-2"></i>
                                        Học vấn
                                        <span class="badge bg-light text-dark ms-2">${educationCount}</span>
                                    </h5>
                                    <div class="section-actions">
                                        <a href="education-add" class="btn btn-light btn-sm">
                                            <i class="fas fa-plus me-1"></i>Thêm
                                        </a>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <c:choose>
                                        <c:when test="${empty educations}">
                                            <div class="empty-state">
                                                <i class="fas fa-graduation-cap"></i>
                                                <h6>Chưa có thông tin học vấn</h6>
                                                <p class="mb-3">Thêm học vấn để hoàn thiện hồ sơ của bạn</p>
                                                <a href="education-add" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm học vấn
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${educations}" var="edu">
                                                <div class="timeline-item ${edu.current ? 'current' : ''}">
                                                    <div class="item-header">
                                                        <div>
                                                            <div class="item-title">${edu.degree} 
                                                                <c:if test="${not empty edu.fieldOfStudy}">- ${edu.fieldOfStudy}</c:if>
                                                            </div>
                                                            <div class="item-company">${edu.institutionName}</div>
                                                            <div class="item-meta">
                                                                <c:if test="${not empty edu.location}">
                                                                    <i class="fas fa-map-marker-alt me-1"></i>${edu.location}
                                                                    <span class="mx-2">•</span>
                                                                </c:if>
                                                                <i class="fas fa-calendar me-1"></i>
                                                                <fmt:formatDate value="${edu.startDate}" pattern="MM/yyyy" /> - 
                                                                <c:choose>
                                                                    <c:when test="${edu.current}">
                                                                        <span class="current-badge">Đang học</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <fmt:formatDate value="${edu.endDate}" pattern="MM/yyyy" />
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <c:if test="${not empty edu.gpa}">
                                                                    <span class="mx-2">•</span>
                                                                    <span class="gpa-badge">GPA: ${edu.gpa}</span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="item-actions">
                                                            <a href="education-edit?id=${edu.id}" class="btn btn-outline-primary btn-action" title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <button class="btn btn-outline-danger btn-action" onclick="confirmDeleteEducation(${edu.id}, '${edu.degree}')" title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <c:if test="${not empty edu.description}">
                                                        <div class="item-description">${edu.description}</div>
                                                    </c:if>
                                                    <c:if test="${not empty edu.activities}">
                                                        <div class="item-description">
                                                            <strong>Hoạt động:</strong> ${edu.activities}
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Certificates Section -->
                            <div class="profile-section">
                                <div class="section-header">
                                    <h5>
                                        <i class="fas fa-certificate me-2"></i>
                                        Chứng chỉ
                                        <span class="badge bg-light text-dark ms-2">${certificateCount}</span>
                                    </h5>
                                    <div class="section-actions">
                                        <a href="certificate-add" class="btn btn-light btn-sm">
                                            <i class="fas fa-plus me-1"></i>Thêm
                                        </a>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <c:choose>
                                        <c:when test="${empty certificates}">
                                            <div class="empty-state">
                                                <i class="fas fa-certificate"></i>
                                                <h6>Chưa có chứng chỉ nào</h6>
                                                <p class="mb-3">Thêm chứng chỉ để tăng uy tín với nhà tuyển dụng</p>
                                                <a href="certificate-add" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm chứng chỉ
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${certificates}" var="cert">
                                                <div class="timeline-item">
                                                    <div class="item-header">
                                                        <div class="d-flex align-items-start">
                                                            <c:if test="${not empty cert.imagePath}">
                                                                <img src="${cert.imagePath}" alt="Certificate" class="certificate-image me-3">
                                                            </c:if>
                                                            <div>
                                                                <div class="item-title">${cert.certificateName}</div>
                                                                <div class="item-company">${cert.issuingOrganization}</div>
                                                                <div class="item-meta">
                                                                    <i class="fas fa-calendar me-1"></i>
                                                                    <fmt:formatDate value="${cert.issueDate}" pattern="MM/yyyy" />
                                                                    <c:if test="${not empty cert.expiryDate}">
                                                                        - <fmt:formatDate value="${cert.expiryDate}" pattern="MM/yyyy" />
                                                                    </c:if>
                                                                    <c:if test="${not empty cert.credentialId}">
                                                                        <span class="mx-2">•</span>
                                                                        ID: ${cert.credentialId}
                                                                    </c:if>
                                                                </div>
                                                                <c:if test="${not empty cert.credentialUrl}">
                                                                    <div class="mt-2">
                                                                        <a href="${cert.credentialUrl}" target="_blank" class="credential-link">
                                                                            <i class="fas fa-external-link-alt me-1"></i>Xem chứng chỉ
                                                                        </a>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="item-actions">
                                                            <a href="certificate-edit?id=${cert.id}" class="btn btn-outline-primary btn-action" title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <button class="btn btn-outline-danger btn-action" onclick="confirmDeleteCertificate(${cert.id}, '${cert.certificateName}')" title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <c:if test="${not empty cert.description}">
                                                        <div class="item-description">${cert.description}</div>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Awards Section -->
                            <div class="profile-section">
                                <div class="section-header">
                                    <h5>
                                        <i class="fas fa-trophy me-2"></i>
                                        Giải thưởng
                                        <span class="badge bg-light text-dark ms-2">${awardCount}</span>
                                    </h5>
                                    <div class="section-actions">
                                        <a href="award-add" class="btn btn-light btn-sm">
                                            <i class="fas fa-plus me-1"></i>Thêm
                                        </a>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <c:choose>
                                        <c:when test="${empty awards}">
                                            <div class="empty-state">
                                                <i class="fas fa-trophy"></i>
                                                <h6>Chưa có giải thưởng nào</h6>
                                                <p class="mb-3">Thêm giải thưởng để làm nổi bật hồ sơ của bạn</p>
                                                <a href="award-add" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm giải thưởng
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${awards}" var="award">
                                                <div class="timeline-item">
                                                    <div class="item-header">
                                                        <div>
                                                            <div class="item-title">${award.awardName}</div>
                                                            <div class="item-company">${award.issuingOrganization}</div>
                                                            <div class="item-meta">
                                                                <i class="fas fa-calendar me-1"></i>
                                                                <fmt:formatDate value="${award.dateReceived}" pattern="MM/yyyy" />
                                                            </div>
                                                            <c:if test="${not empty award.certificateUrl}">
                                                                <div class="mt-2">
                                                                    <a href="${award.certificateUrl}" target="_blank" class="credential-link">
                                                                        <i class="fas fa-external-link-alt me-1"></i>Xem giải thưởng
                                                                    </a>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        <div class="item-actions">
                                                            <a href="award-edit?id=${award.id}" class="btn btn-outline-primary btn-action" title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <button class="btn btn-outline-danger btn-action" onclick="confirmDeleteAward(${award.id}, '${award.awardName}')" title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <c:if test="${not empty award.description}">
                                                        <div class="item-description">${award.description}</div>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- CV Management -->
                            <div class="profile-section">
                                <div class="section-header">
                                    <h5>
                                        <i class="fas fa-file-alt me-2"></i>
                                        Quản lý CV 
                                        <span class="badge bg-light text-dark ms-2">${totalCVs != null ? totalCVs : 0}</span>
                                    </h5>
                                    <div class="section-actions">
                                        <a href="cv-upload" class="btn btn-light btn-sm">
                                            <i class="fas fa-plus me-1"></i>Tạo CV mới
                                        </a>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <!-- Search Box -->
                                    <div class="mb-3">
                                        <form method="get" action="profile" class="position-relative">
                                            <input type="text" 
                                                   class="form-control" 
                                                   name="search" 
                                                   placeholder="Tìm kiếm CV theo tên hoặc vị trí..." 
                                                   value="${searchTerm}">
                                            <input type="hidden" name="page" value="1">
                                        </form>
                                    </div>

                                    <!-- CV List -->
                                    <c:choose>
                                        <c:when test="${empty cvList}">
                                            <div class="empty-state">
                                                <i class="fas fa-file-alt"></i>
                                                <h6>Chưa có CV nào</h6>
                                                <p class="mb-3">Hãy tạo CV đầu tiên để bắt đầu tìm việc làm</p>
                                                <a href="cv-upload" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Tạo CV ngay
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="row">
                                                <c:forEach items="${cvList}" var="cv">
                                                    <div class="col-md-6 mb-3">
                                                        <div class="card border">
                                                            <div class="card-body">
                                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                                    <h6 class="card-title mb-0">${cv.jobPosition}</h6>
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-sm btn-outline-secondary" 
                                                                                type="button" 
                                                                                data-bs-toggle="dropdown">
                                                                            <i class="fas fa-ellipsis-v"></i>
                                                                        </button>
                                                                        <ul class="dropdown-menu">
                                                                            <li>
                                                                                <a class="dropdown-item" href="cv-edit?id=${cv.id}">
                                                                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                                                                </a>
                                                                            </li>
                                                                            <c:if test="${not empty cv.pdfFilePath}">
                                                                                <li>
                                                                                    <a class="dropdown-item" href="${cv.pdfFilePath}" target="_blank">
                                                                                        <i class="fas fa-download me-2"></i>Tải xuống
                                                                                    </a>
                                                                                </li>
                                                                            </c:if>
                                                                            <li><hr class="dropdown-divider"></li>
                                                                            <li>
                                                                                <button class="dropdown-item text-danger" 
                                                                                        onclick="confirmDelete(${cv.id}, '${cv.jobPosition}')">
                                                                                    <i class="fas fa-trash me-2"></i>Xóa
                                                                                </button>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <p class="text-muted mb-1">
                                                                    <i class="fas fa-user me-1"></i>${cv.fullName}
                                                                </p>
                                                                <p class="text-muted small mb-2">
                                                                    <i class="fas fa-envelope me-1"></i>${cv.email}
                                                                </p>
                                                                <div class="d-flex justify-content-between text-muted small">
                                                                    <span>
                                                                        <i class="fas fa-calendar me-1"></i>
                                                                        <fmt:formatDate value="${cv.createdAt}" pattern="dd/MM/yyyy" />
                                                                    </span>
                                                                    <c:if test="${not empty cv.pdfFilePath}">
                                                                        <span class="text-success">
                                                                            <i class="fas fa-file-pdf me-1"></i>PDF
                                                                        </span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <div class="card-footer bg-light p-2">
                                                                <div class="d-flex gap-1">
                                                                    <a href="cv-edit?id=${cv.id}" class="btn btn-sm btn-outline-primary flex-fill">
                                                                        <i class="fas fa-edit me-1"></i>Sửa
                                                                    </a>
                                                                    <c:if test="${not empty cv.pdfFilePath}">
                                                                        <a href="${cv.pdfFilePath}" target="_blank" class="btn btn-sm btn-outline-success">
                                                                            <i class="fas fa-download"></i>
                                                                        </a>
                                                                    </c:if>
                                                                    <button class="btn btn-sm btn-outline-danger" 
                                                                            onclick="confirmDelete(${cv.id}, '${cv.jobPosition}')">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <!-- Pagination -->
                                            <c:if test="${totalPages > 1}">
                                                <nav class="d-flex justify-content-center mt-3">
                                                    <ul class="pagination">
                                                        <c:if test="${currentPage > 1}">
                                                            <li class="page-item">
                                                                <a class="page-link" href="profile?page=${currentPage - 1}&search=${searchTerm}">
                                                                    <i class="fas fa-chevron-left"></i>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                        
                                                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                                            <c:choose>
                                                                <c:when test="${pageNum == currentPage}">
                                                                    <li class="page-item active">
                                                                        <span class="page-link">${pageNum}</span>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li class="page-item">
                                                                        <a class="page-link" href="profile?page=${pageNum}&search=${searchTerm}">
                                                                            ${pageNum}
                                                                        </a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        
                                                        <c:if test="${currentPage < totalPages}">
                                                            <li class="page-item">
                                                                <a class="page-link" href="profile?page=${currentPage + 1}&search=${searchTerm}">
                                                                    <i class="fas fa-chevron-right"></i>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </ul>
                                                </nav>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete CV Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                    Xác nhận xóa CV
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa CV "<span id="cvName"></span>"?</p>
                                <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <form id="deleteForm" method="post" action="profile" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="cvId" id="deleteCvId">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash me-2"></i>Xóa CV
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete Experience Confirmation Modal -->
                <div class="modal fade" id="deleteExperienceModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                    Xác nhận xóa kinh nghiệm
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa kinh nghiệm "<span id="expName"></span>"?</p>
                                <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <form id="deleteExpForm" method="post" action="profile" class="d-inline">
                                    <input type="hidden" name="action" value="deleteExperience">
                                    <input type="hidden" name="experienceId" id="deleteExpId">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash me-2"></i>Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Similar modals for Certificate, Education, Award -->
                <div class="modal fade" id="deleteCertificateModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                    Xác nhận xóa chứng chỉ
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa chứng chỉ "<span id="certName"></span>"?</p>
                                <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <form id="deleteCertForm" method="post" action="profile" class="d-inline">
                                    <input type="hidden" name="action" value="deleteCertificate">
                                    <input type="hidden" name="certificateId" id="deleteCertId">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash me-2"></i>Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="deleteEducationModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                    Xác nhận xóa học vấn
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa học vấn "<span id="eduName"></span>"?</p>
                                <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <form id="deleteEduForm" method="post" action="profile" class="d-inline">
                                    <input type="hidden" name="action" value="deleteEducation">
                                    <input type="hidden" name="educationId" id="deleteEduId">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash me-2"></i>Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="deleteAwardModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                    Xác nhận xóa giải thưởng
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa giải thưởng "<span id="awardName"></span>"?</p>
                                <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <form id="deleteAwardForm" method="post" action="profile" class="d-inline">
                                    <input type="hidden" name="action" value="deleteAward">
                                    <input type="hidden" name="awardId" id="deleteAwardId">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash me-2"></i>Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/main.js"></script>
                
                <script>
                    function confirmDelete(cvId, cvName) {
                        document.getElementById('deleteCvId').value = cvId;
                        document.getElementById('cvName').textContent = cvName;
                        new bootstrap.Modal(document.getElementById('deleteModal')).show();
                    }

                    function confirmDeleteExperience(expId, expName) {
                        document.getElementById('deleteExpId').value = expId;
                        document.getElementById('expName').textContent = expName;
                        new bootstrap.Modal(document.getElementById('deleteExperienceModal')).show();
                    }

                    function confirmDeleteCertificate(certId, certName) {
                        document.getElementById('deleteCertId').value = certId;
                        document.getElementById('certName').textContent = certName;
                        new bootstrap.Modal(document.getElementById('deleteCertificateModal')).show();
                    }

                    function confirmDeleteEducation(eduId, eduName) {
                        document.getElementById('deleteEduId').value = eduId;
                        document.getElementById('eduName').textContent = eduName;
                        new bootstrap.Modal(document.getElementById('deleteEducationModal')).show();
                    }

                    function confirmDeleteAward(awardId, awardName) {
                        document.getElementById('deleteAwardId').value = awardId;
                        document.getElementById('awardName').textContent = awardName;
                        new bootstrap.Modal(document.getElementById('deleteAwardModal')).show();
                    }

                    // Auto-submit search form when typing (with debounce)
                    let searchTimeout;
                    const searchInput = document.querySelector('input[name="search"]');
                    if (searchInput) {
                        searchInput.addEventListener('input', function() {
                            clearTimeout(searchTimeout);
                            searchTimeout = setTimeout(() => {
                                this.form.submit();
                            }, 500);
                        });
                    }

                    // Auto-hide alerts after 5 seconds
                    setTimeout(() => {
                        const alerts = document.querySelectorAll('.alert');
                        alerts.forEach(alert => {
                            if (alert.querySelector('.btn-close')) {
                                const bsAlert = new bootstrap.Alert(alert);
                                bsAlert.close();
                            }
                        });
                    }, 5000);
                </script>
            </body>

            </html>
<!-- Edit Contact Info Modal -->
<div class="modal fade" id="editContactModal" tabindex="-1" aria-labelledby="editContactModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="post" action="profile">
        <input type="hidden" name="action" value="editContact" />
        <div class="modal-header" style="background: linear-gradient(135deg, #28a745, #20c997); color: white;">
          <h5 class="modal-title" id="editContactModalLabel"><i class="fas fa-address-card me-2"></i>Edit Contact Info</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.user.fullName}" required />
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.email}" required />
          </div>
          <div class="mb-3">
            <label for="phone" class="form-label">Phone</label>
            <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.user.phone}" />
          </div>
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="address" name="address" value="${sessionScope.user.address}" />
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary" style="background-color: #28a745; border-color: #28a745;">
            <i class="fas fa-save me-1"></i>Save Changes
          </button>
        </div>
      </form>
    </div>
  </div>
</div>