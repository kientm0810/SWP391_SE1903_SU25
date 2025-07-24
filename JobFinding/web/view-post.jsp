<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${post.title} - Chi tiết thông tin bài đăng</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
              rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
              rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/styleViewPost.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/slicknav.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}assets/css/header.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="${post.title} - ${post.companyName}">
    </head>


    <body>
        <!-- Preloader Start -->
        <div id="preloader-active">
            <div class="preloader d-flex align-items-center justify-content-center">
                <div class="preloader-inner position-relative">
                    <div class="preloader-circle"></div>
                    <div class="preloader-img pere-text">
                        <img src="assets/img/logo/logo.png" alt="">
                    </div>
                </div>
            </div>
        </div>
        <!-- Preloader Start -->
        <%@ include file="header.jsp" %>


        <div class="container mt-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a
                            href="${pageContext.request.contextPath}/home">Home</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">${post.title}</li>
                </ol>
            </nav>

            <!-- Header: Bên trái là job info, bên phải là box công ty + box thông tin chung -->
            <div class="row mb-4 align-items-stretch">
                <!-- Bên trái: Job header -->
                <div class="col-lg-8">
                    <div class="job-header-card topcv-style">
                        <div class="job-header-content-col">
                            <div class="job-header-title">${post.title}</div>
                            <div class="job-header-info-row">
                                <div class="job-header-info-box">
                                    <div class="info-icon"><i class="fas fa-money-bill-wave"></i></div>
                                    <div class="info-label">Mức lương</div>
                                    <div class="info-value">${post.salary}</div>
                                </div>
                                <div class="job-header-info-box">
                                    <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
                                    <div class="info-label">Địa điểm</div>
                                    <div class="info-value">${post.location}</div>
                                </div>
                                <div class="job-header-info-box">
                                    <div class="info-icon"><i class="fas fa-user-tie"></i></div>
                                    <div class="info-label">Kinh nghiệm</div>
                                    <div class="info-value">${post.experience}</div>
                                </div>
                            </div>
                            <div class="job-header-sub-row">
                                <a href="#" class="btn btn-applicant-count">
                                    <i class="fas fa-eye"></i> Xem số người đã ứng tuyển
                                    <span class="badge-new">New</span>
                                </a>
                                <span class="job-header-deadline">
                                    <i class="fas fa-calendar-alt"></i> Hạn nộp hồ sơ:
                                    <fmt:formatDate value="${post.deadline}" pattern="dd/MM/yyyy" />
                                </span>
                            </div>
                            <div class="job-header-action-row">
                                <c:choose>
                                    <c:when
                                        test="${not empty sessionScope.user && sessionScope.role == 'job-seeker'}">
                                        <a href="${pageContext.request.contextPath}/apply?id=${post.id}"
                                           class="btn btn-success btn-apply-topcv">
                                            <i class="fas fa-paper-plane"></i> Ứng tuyển ngay
                                        </a>
                                    </c:when>
                                    <c:when
                                        test="${not empty sessionScope.user && sessionScope.role == 'recruiter'}">
                                        <button class=btn btn-secondary btn-apply-topcv" disabled>
                                            <i class="fas fa-user-tie"></i> Bạn là nhà tuyển dụng
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login.jsp"
                                           class="btn btn-success btn-apply-topcv">
                                            <i class="fas fa-sign-in-alt"></i> Đăng nhập để ứng tuyển
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                <form action="${pageContext.request.contextPath}/saved-jobs"
                                      method="post" style="display:inline;">
                                    <input type="hidden" name="postId" value="${post.id}" />
                                    <input type="hidden" name="action" value="save" />
                                    <button type="submit"
                                            class="btn btn-outline-primary save-job ms-auto">
                                        <i class="far fa-heart"></i> Lưu tin
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Bên phải: Box công ty + Box thông tin chung -->
                <div class="col-lg-4">
                    <div class="sidebar-box company-box">
                        <div class="d-flex align-items-center mb-3">
                            <img src="/JobFinding/${post.companyLogo}"
                                 alt="${post.companyName}" class="company-logo me-3">
                            <div>
                                <div class="fw-bold mb-1">${post.companyName}</div>
                                <div class="text-muted small"><i class="fas fa-users"></i> Quy mô:
                                    ${post.companySize}</div>
                                <div class="text-muted small"><i class="fas fa-briefcase"></i> Lĩnh vực:
                                    ...
                                </div>
                                <div class="text-muted small"><i class="fas fa-map-marker-alt"></i>
                                    ${post.location}</div>
                                    <c:if test="${not empty post.companyWebsite}">
                                    <div class="mt-1"><a href="${post.companyWebsite}" target="_blank"
                                                         class="text-success">Xem trang công ty <i
                                                class="fas fa-external-link-alt"></i></a></div>
                                        </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="sidebar-box info-box">
                        <div class="section-title">Thông tin chung</div>
                        <div class="info-list">
                            <div class="info-item"><i class="fas fa-user-tie"></i> Cấp bậc: Nhân viên
                            </div>
                            <div class="info-item"><i class="fas fa-graduation-cap"></i> Học vấn: Đại
                                Học
                                trở
                                lên</div>
                            <div class="info-item"><i class="fas fa-users"></i> Số lượng tuyển: 1 người
                            </div>
                            <div class="info-item"><i class="fas fa-clock"></i> Hình thức làm việc: Toàn
                                thời
                                gian</div>
                        </div>
                    </div>
                    <c:if test="${sessionScope.userId != null && sessionScope.userId == post.userId}">
                        <div class="sidebar-box owner-actions-box mt-4">
                            <h3 class="section-title">Quản lý tin</h3>
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/post/edit?id=${post.id}"
                                   class="btn btn-primary"><i class="fas fa-edit me-2"></i> Sửa tin</a>
                                <form
                                    action="${pageContext.request.contextPath}/post/delete?id=${post.id}"
                                    method="POST"
                                    onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin này không?');"
                                    class="d-grid">
                                    <button type="submit" class="btn btn-danger"><i
                                            class="fas fa-trash me-2"></i> Xóa tin</button>
                                </form>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>


            <div class="row">
                <!-- Main content -->
                <div class="col-lg-8">

                    <!-- Box chi tiết tin tuyển dụng -->
                    <div class="content-section">
                        <div class="section-title">
                            Chi tiết tin tuyển dụng
                            <a href="#" class="btn btn-similar-job"><i class="fas fa-bell"></i> Gửi tôi
                                việc
                                làm
                                tương tự</a>


                        </div>

                        <c:if test="${not empty post.keywords}">

                            <div class="keywords-container">
                                <c:forEach items="${post.keywords.split(',')}" var="keyword">
                                    <span class="keyword-tag">${keyword.trim()}</span>
                                </c:forEach>
                            </div>
                        </c:if>

                        <h3 class="section-title">Mô tả công việc</h3>
                        <div class="content">${post.jobDescription}</div>
                        <h3 class="section-title">Yêu cầu ứng viên</h3>
                        <div class="content">${post.requirements}</div>
                        <h3 class="section-title">Quyền lợi</h3>
                        <div class="content">${post.benefits}</div>


                    </div>

                    <!-- Box việc làm liên quan -->
                    <div class="related-jobs-section mb-4">
                        <div class="section-header">
                            <h4 class="section-title">
                                <i class="fas fa-briefcase me-2"></i>Việc làm liên quan
                            </h4>
                        </div>
                        <div class="related-jobs-container">
                            <c:choose>
                                <c:when test="${not empty relatedPosts}">
                                    <div class="row">
                                        <c:forEach items="${relatedPosts}" var="rel">
                                            <div class="col-xl-4 col-lg-4 col-md-6 mb-3">
                                                <div class="card job-card">
                                                    <div
                                                        class="job-card-header-overlay d-flex justify-content-between align-items-center">
                                                        <div class="job-badges-left d-flex gap-2">
                                                            <c:if test="${rel.postType == 'hot'}">
                                                                <span class="job-badge badge-new">Tin
                                                                    mới</span>
                                                                </c:if>
                                                                <c:if test="${rel.postType == 'pro'}">
                                                                <span
                                                                    class="job-badge badge-featured">Nổi
                                                                    bật</span>
                                                                </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="d-flex align-items-center mb-3">
                                                            <img src="${rel.companyLogo != null ? "/JobFinding/" + rel.companyLogo : 'assets/img/icon/job-list1.png'}"
                                                                 alt="${rel.companyName}"
                                                                 class="company-logo me-3">
                                                            <div class="job-details">
                                                                <h5 class="card-title mb-1">
                                                                    <a href="${pageContext.request.contextPath}/post/view?id=${rel.id}"
                                                                       class="text-decoration-none text-dark job-title-truncate">
                                                                        ${rel.title}
                                                                    </a>
                                                                </h5>
                                                                <p
                                                                    class="text-muted mb-1 company-name-truncate">
                                                                    ${rel.companyName}</p>
                                                            </div>
                                                        </div>
                                                        <!-- Salary and Location Tags -->
                                                        <div class="d-flex flex-wrap gap-2">
                                                            <span
                                                                class="job-info-tag salary-tag">${rel.salary}</span>
                                                            <span
                                                                class="job-info-tag location-tag">${rel.location}</span>
                                                            <form
                                                                action="${pageContext.request.contextPath}/saved-jobs"
                                                                method="post" style="display:inline;">
                                                                <input type="hidden" name="postId"
                                                                       value="${rel.id}" />
                                                                <input type="hidden" name="action"
                                                                       value="save" />
                                                                <button type="submit"
                                                                        class="btn btn-outline-primary save-job ms-auto">
                                                                    <i class="far fa-heart"></i> Lưu tin
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-related-jobs">
                                        <div class="empty-state">
                                            <i class="fas fa-search"></i>
                                            <p>Không có việc làm liên quan</p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>


                </div>
                <!-- Sidebar phải: để trống cho cân đối hoặc có thể thêm nội dung khác sau này -->
                <div class="col-lg-4"></div>
            </div>
        </div>


        <!--                        <script
                                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>-->
        <jsp:include page="footer.jsp" />

    </body>

</html>