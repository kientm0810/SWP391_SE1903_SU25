<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Quản lý Loại Blog - Admin Dashboard</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                .type-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 5px;
                    padding: 5px 10px;
                    border-radius: 15px;
                    font-size: 12px;
                    font-weight: 500;
                }

                .stats-card {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border-radius: 10px;
                    padding: 20px;
                }

                .action-buttons {
                    display: flex;
                    gap: 5px;
                }

                .btn-sm {
                    padding: 0.25rem 0.5rem;
                    font-size: 0.875rem;
                }

                .audience-badge {
                    font-size: 10px;
                    padding: 2px 6px;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- Sidebar -->
                    <nav class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                        <div class="position-sticky pt-3">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="admin_dashboard.jsp">
                                        <i class="fas fa-tachometer-alt"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="admin_post_types.jsp">
                                        <i class="fas fa-tags"></i> Loại Bài đăng
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white active" href="admin_blog_types.jsp">
                                        <i class="fas fa-blog"></i> Loại Blog
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </nav>

                    <!-- Main content -->
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">
                                <i class="fas fa-blog text-primary"></i> Quản lý Loại Blog
                            </h1>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <a href="admin_create_blog_type.jsp" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Thêm Loại Mới
                                </a>
                            </div>
                        </div>

                        <!-- Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Statistics Cards -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="mb-0">Tổng Loại</h6>
                                            <h3 class="mb-0">${blogTypes.size()}</h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-blog fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card"
                                    style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="mb-0">Career Advice</h6>
                                            <h3 class="mb-0">
                                                <c:set var="careerAdviceCount" value="0" />
                                                <c:forEach var="type" items="${blogTypes}">
                                                    <c:if test="${type.category == 'career_advice'}">
                                                        <c:set var="careerAdviceCount"
                                                            value="${careerAdviceCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${careerAdviceCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-lightbulb fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card"
                                    style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="mb-0">Job Seekers</h6>
                                            <h3 class="mb-0">
                                                <c:set var="jobSeekersCount" value="0" />
                                                <c:forEach var="type" items="${blogTypes}">
                                                    <c:if test="${type.targetAudience == 'job_seekers'}">
                                                        <c:set var="jobSeekersCount" value="${jobSeekersCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${jobSeekersCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-user-tie fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card"
                                    style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6 class="mb-0">Active</h6>
                                            <h3 class="mb-0">
                                                <c:set var="activeCount" value="0" />
                                                <c:forEach var="type" items="${blogTypes}">
                                                    <c:if test="${type.active}">
                                                        <c:set var="activeCount" value="${activeCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${activeCount}
                                            </h3>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-check-circle fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Blog Types Table -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-list"></i> Danh sách Loại Blog
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Mã Code</th>
                                                <th>Tên Loại</th>
                                                <th>Danh mục</th>
                                                <th>Đối tượng</th>
                                                <th>Định dạng</th>
                                                <th>Icon</th>
                                                <th>Trạng thái</th>
                                                <th>Thống kê</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="blogType" items="${blogTypes}">
                                                <tr>
                                                    <td>${blogType.id}</td>
                                                    <td>
                                                        <code
                                                            class="bg-light px-2 py-1 rounded">${blogType.typeCode}</code>
                                                    </td>
                                                    <td>
                                                        <strong>${blogType.typeName}</strong>
                                                        <c:if test="${not empty blogType.description}">
                                                            <br><small
                                                                class="text-muted">${blogType.description}</small>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary">${blogType.category}</span>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge bg-info audience-badge">${blogType.targetAudience}</span>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge bg-warning text-dark">${blogType.contentFormat}</span>
                                                    </td>
                                                    <td>
                                                        <c:if test="${not empty blogType.iconClass}">
                                                            <i class="${blogType.iconClass}"
                                                                style="color: ${blogType.colorCode}; font-size: 1.2em;"></i>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${blogType.active}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check"></i> Active
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">
                                                                    <i class="fas fa-times"></i> Inactive
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="stat" items="${stats}">
                                                            <c:if test="${stat[1] == blogType.typeCode}">
                                                                <small class="text-muted">
                                                                    ${stat[4]} blog (${stat[5]} published)
                                                                </small>
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="admin_edit_blog_type.jsp?id=${blogType.id}"
                                                                class="btn btn-sm btn-outline-primary"
                                                                title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <button type="button" class="btn btn-sm btn-outline-danger"
                                                                onclick="deleteBlogType(${blogType.id}, '${blogType.typeName}')"
                                                                title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="modal fade" id="deleteModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Xác nhận xóa</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn có chắc chắn muốn xóa loại blog "<span id="deleteTypeName"></span>"?</p>
                            <p class="text-danger"><small>Hành động này không thể hoàn tác!</small></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <form id="deleteForm" method="POST" style="display: inline;">
                                <button type="submit" class="btn btn-danger">Xóa</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function deleteBlogType(id, typeName) {
                    document.getElementById('deleteTypeName').textContent = typeName;
                    document.getElementById('deleteForm').action = 'content-type/blog-types?action=delete&id=' + id;
                    new bootstrap.Modal(document.getElementById('deleteModal')).show();
                }

                // Auto-hide alerts after 5 seconds
                setTimeout(function () {
                    const alerts = document.querySelectorAll('.alert');
                    alerts.forEach(function (alert) {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    });
                }, 5000);
            </script>
        </body>

        </html>