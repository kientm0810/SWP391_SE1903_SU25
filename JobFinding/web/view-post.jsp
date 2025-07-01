<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${post.title} - Chi tiết thông tin bài đăng</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
              rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/styleViewPost.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="${post.title} - ${post.companyName}">
    </head>


    <body>
        <jsp:include page="header.jsp" />

        <div class="container mt-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/post">Danh sách
                            tin</a></li>
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
                                <a href="${pageContext.request.contextPath}/apply-job.jsp?id=${post.id}"
                                   class="btn btn-success btn-apply-topcv"><i class="fas fa-paper-plane"></i>
                                    Ứng tuyển ngay</a>
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
                <!-- Bên phải: Box công ty + Box thông tin chung -->
                <div class="col-lg-4">
                    <div class="sidebar-box company-box">
                        <div class="d-flex align-items-center mb-3">
                            <img src="${pageContext.request.contextPath}/${post.companyLogo}"
                                 alt="${post.companyName}" class="company-logo me-3">
                            <div>
                                <div class="fw-bold mb-1">${post.companyName}</div>
                                <div class="text-muted small"><i class="fas fa-users"></i> Quy mô:
                                    ${post.companySize}</div>
                                <div class="text-muted small"><i class="fas fa-briefcase"></i> Lĩnh vực: ...
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
                            <div class="info-item"><i class="fas fa-user-tie"></i> Cấp bậc: Nhân viên</div>
                            <div class="info-item"><i class="fas fa-graduation-cap"></i> Học vấn: Đại Học trở
                                lên</div>
                            <div class="info-item"><i class="fas fa-users"></i> Số lượng tuyển: 1 người</div>
                            <div class="info-item"><i class="fas fa-clock"></i> Hình thức làm việc: Toàn thời
                                gian</div>
                        </div>
                    </div>
                    <c:if test="${sessionScope.userId != null && sessionScope.userId == post.userId}">
                        <div class="sidebar-box owner-actions-box mt-4">
                            <h3 class="section-title">Quản lý tin</h3>
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/post/edit?id=${post.id}"
                                   class="btn btn-primary"><i class="fas fa-edit me-2"></i> Sửa tin</a>
                                <form action="${pageContext.request.contextPath}/post/delete?id=${post.id}"
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
                    <!-- Box việc làm liên quan -->
                    <c:if test="${not empty relatedPosts}">
                        <div class="related-jobs-box">
                            <div class="related-jobs-title">Việc làm liên quan</div>
                            <div class="row">
                                <c:forEach items="${relatedPosts}" var="rel">
                                    <div class="col-md-6 mb-3">
                                        <div class="related-job-card">
                                            <img src="${pageContext.request.contextPath}/assets/img/icon/job-list1.png"
                                                 class="related-job-logo" alt="logo">
                                            <div class="related-job-info">
                                                <div class="related-job-title">${rel.title}</div>
                                                <div class="related-job-company">${rel.companyName}</div>
                                                <div class="related-job-tags">
                                                    <span class="related-job-tag">${rel.salary}</span>
                                                    <span class="related-job-tag">${rel.location}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    <!-- Box chi tiết tin tuyển dụng -->
                    <div class="content-section">
                        <div class="section-title">
                            Chi tiết tin tuyển dụng
                            <a href="#" class="btn btn-similar-job"><i class="fas fa-bell"></i> Gửi tôi việc làm
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
                </div>
                <!-- Sidebar phải: để trống cho cân đối hoặc có thể thêm nội dung khác sau này -->
                <div class="col-lg-4"></div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>