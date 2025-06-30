<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Việc làm đã lưu | JobFinding</title>
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                    <style>
                        body {
                            background: #f5f7fa;
                        }

                        .saved-header {
                            background: linear-gradient(90deg, #009966 0%, #00c471 100%);
                            border-radius: 18px;
                            color: #fff;
                            padding: 32px 32px 24px 32px;
                            margin-bottom: 32px;
                        }

                        .saved-header h2 {
                            font-weight: bold;
                        }

                        .saved-header .desc {
                            font-size: 1.1rem;
                            opacity: 0.95;
                        }

                        .saved-header .count {
                            font-size: 1.05rem;
                            margin-top: 12px;
                        }

                        .saved-job-card {
                            background: #fff;
                            border-radius: 14px;
                            box-shadow: 0 2px 12px #e0e0e0;
                            margin-bottom: 24px;
                            padding: 24px 20px;
                            display: flex;
                            align-items: center;
                            transition: box-shadow 0.2s;
                        }

                        .saved-job-card:hover {
                            box-shadow: 0 4px 24px #b2f2e5;
                        }

                        .saved-job-logo {
                            width: 64px;
                            height: 64px;
                            object-fit: contain;
                            border-radius: 10px;
                            background: #fff;
                            border: 1px solid #eee;
                            margin-right: 24px;
                        }

                        .saved-job-info {
                            flex: 1;
                        }

                        .saved-job-title {
                            font-size: 1.1rem;
                            font-weight: 600;
                            color: #222;
                            margin-bottom: 2px;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                            overflow: hidden;
                        }

                        .saved-job-company {
                            color: #666;
                            font-size: 0.97rem;
                            margin-bottom: 2px;
                        }

                        .saved-job-meta {
                            font-size: 0.97rem;
                            color: #888;
                            margin-bottom: 4px;
                        }

                        .saved-job-salary {
                            color: #00c471;
                            font-weight: 600;
                        }

                        .saved-job-date {
                            font-size: 0.93rem;
                            color: #888;
                        }

                        .saved-job-badges .badge {
                            background: #f1f3f6;
                            color: #009966;
                            font-size: 0.92rem;
                            margin-right: 6px;
                        }

                        .saved-job-actions {
                            display: flex;
                            flex-direction: column;
                            gap: 8px;
                            align-items: flex-end;
                        }

                        .saved-job-actions .btn {
                            min-width: 100px;
                        }

                        @media (max-width: 600px) {
                            .saved-job-card {
                                flex-direction: column;
                                align-items: flex-start;
                            }

                            .saved-job-logo {
                                margin-bottom: 12px;
                                margin-right: 0;
                            }

                            .saved-job-actions {
                                flex-direction: row;
                                width: 100%;
                                justify-content: flex-end;
                            }
                        }
                    </style>
                </head>

                <body>
                    <c:if test="${not empty sessionScope.notification}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${sessionScope.notification}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="notification" scope="session" />
                    </c:if>
                    <div class="container py-4">
                        <!-- Header -->
                        <div class="saved-header mb-4">
                            <h2>Việc làm đã lưu</h2>
                            <div class="desc">Xem lại danh sách những việc làm bạn đã quan tâm và lưu trước đó.</div>
                            <div class="count mt-2">Danh sách <b>${fn:length(savedJobs)}</b> việc làm đã lưu</div>
                        </div>

                        <c:choose>
                            <c:when test="${not empty savedJobs}">
                                <c:forEach items="${savedJobs}" var="job">
                                    <div class="saved-job-card">
                                        <img src="${job.companyLogo != null ? job.companyLogo : 'assets/img/icon/job-list1.png'}"
                                            class="saved-job-logo" alt="${job.companyName}">
                                        <div class="saved-job-info">
                                            <div class="saved-job-title">${job.title}</div>
                                            <div class="saved-job-company">${job.companyName}</div>
                                            <div class="saved-job-meta">
                                                <span><i class="fas fa-map-marker-alt"></i> ${job.location}</span>
                                                <span class="mx-2">|</span>
                                                <span class="saved-job-salary">${job.salary}</span>
                                            </div>
                                            <div class="saved-job-date">
                                                Đã lưu:
                                                <fmt:formatDate value="${job.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </div>
                                            <div class="saved-job-badges mt-2">
                                                <span class="badge"><i class="fas fa-map-marker-alt"></i>
                                                    ${job.location}</span>
                                                <span class="badge">Cập nhật trước</span>
                                            </div>
                                        </div>
                                        <div class="saved-job-actions ms-3">
                                            <a href="${pageContext.request.contextPath}/post/view?id=${job.id}"
                                                class="btn btn-success btn-sm">
                                                <c:choose>
                                                    <c:when test="${sessionScope.role == 'jobseeker'}">
                                                        <i class="fas fa-paper-plane"></i> Ứng tuyển
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-eye"></i> Xem chi tiết
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <form action="${pageContext.request.contextPath}/saved-jobs" method="post"
                                                style="display:inline;">
                                                <input type="hidden" name="postId" value="${job.id}" />
                                                <input type="hidden" name="action" value="unsave" />
                                                <button type="submit" class="btn btn-outline-danger btn-sm">
                                                    <i class="fas fa-heart-broken"></i> Bỏ lưu
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <h5>Chưa có việc làm nào được lưu</h5>
                                    <p class="text-muted">Hãy lưu những việc làm bạn quan tâm để xem lại sau!</p>
                                    <a href="${pageContext.request.contextPath}/posts" class="btn btn-primary mt-3">
                                        <i class="fas fa-search me-2"></i>Tìm việc ngay
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                </body>

                </html>