<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Quản lý Loại Bài đăng - Admin Dashboard</title>
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

                .dashboard-container {
                    display: flex;
                    min-height: 100vh;
                }

                .main-content {
                    flex: 1;
                    padding: 20px;
                    background-color: #f8f9fa;
                }

                @media (max-width: 768px) {
                    .main-content {
                        margin-left: 0 !important;
                    }
                }
            </style>
        </head>

        <body>
            <!-- Include Admin Header -->
            <jsp:include page="admin-header.jsp" />

            <div class="dashboard-container">
                <jsp:include page="sidebar.jsp" />

                <div class="main-content" style="margin-left: 250px;">
                    <!-- Breadcrumb -->
                    <jsp:include page="breadcrumb.jsp" />

                    <div
                        class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">
                            <i class="fas fa-tags text-primary"></i> Quản lý Loại Bài đăng
                        </h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <a href="admin_create_post_type.jsp" class="btn btn-primary">
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
                                        <h3 class="mb-0">14</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-tags fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card"
                                style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="mb-0">Job Posting</h6>
                                        <h3 class="mb-0">8</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-briefcase fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card"
                                style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h6 class="mb-0">Content</h6>
                                        <h3 class="mb-0">4</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-file-alt fa-2x"></i>
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
                                        <h3 class="mb-0">14</h3>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-check-circle fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Post Types List -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-list"></i> Danh sách Loại Bài đăng
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Mã Code</th>
                                            <th>Tên Loại</th>
                                            <th>Danh mục</th>
                                            <th>Mức ưu tiên</th>
                                            <th>Icon</th>
                                            <th>Trạng thái</th>
                                            <th>Thống kê</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td><code class="bg-light px-2 py-1 rounded">full_time</code></td>
                                            <td>
                                                <strong>Toàn thời gian</strong>
                                                <br><small class="text-muted">Công việc toàn thời gian 40+
                                                    giờ/tuần</small>
                                            </td>
                                            <td><span class="badge bg-secondary">job_posting</span></td>
                                            <td><span class="badge bg-info">1</span></td>
                                            <td><i class="fas fa-clock" style="color: #28a745; font-size: 1.2em;"></i>
                                            </td>
                                            <td><span class="badge bg-success"><i class="fas fa-check"></i>
                                                    Active</span></td>
                                            <td><small class="text-muted">0 bài đăng (0 active)</small></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="admin_edit_post_type.jsp?id=1"
                                                        class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="deletePostType(1, 'Toàn thời gian')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td><code class="bg-light px-2 py-1 rounded">part_time</code></td>
                                            <td>
                                                <strong>Bán thời gian</strong>
                                                <br><small class="text-muted">Công việc bán thời gian < 40
                                                        giờ/tuần</small>
                                            </td>
                                            <td><span class="badge bg-secondary">job_posting</span></td>
                                            <td><span class="badge bg-info">2</span></td>
                                            <td><i class="fas fa-hourglass-half"
                                                    style="color: #ffc107; font-size: 1.2em;"></i></td>
                                            <td><span class="badge bg-success"><i class="fas fa-check"></i>
                                                    Active</span></td>
                                            <td><small class="text-muted">0 bài đăng (0 active)</small></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="admin_edit_post_type.jsp?id=2"
                                                        class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="deletePostType(2, 'Bán thời gian')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td><code class="bg-light px-2 py-1 rounded">contract</code></td>
                                            <td>
                                                <strong>Hợp đồng</strong>
                                                <br><small class="text-muted">Công việc theo hợp đồng có thời
                                                    hạn</small>
                                            </td>
                                            <td><span class="badge bg-secondary">job_posting</span></td>
                                            <td><span class="badge bg-info">3</span></td>
                                            <td><i class="fas fa-file-contract"
                                                    style="color: #17a2b8; font-size: 1.2em;"></i></td>
                                            <td><span class="badge bg-success"><i class="fas fa-check"></i>
                                                    Active</span></td>
                                            <td><small class="text-muted">0 bài đăng (0 active)</small></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="admin_edit_post_type.jsp?id=3"
                                                        class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="deletePostType(3, 'Hợp đồng')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td><code class="bg-light px-2 py-1 rounded">internship</code></td>
                                            <td>
                                                <strong>Thực tập</strong>
                                                <br><small class="text-muted">Vị trí thực tập cho sinh viên</small>
                                            </td>
                                            <td><span class="badge bg-secondary">job_posting</span></td>
                                            <td><span class="badge bg-info">4</span></td>
                                            <td><i class="fas fa-graduation-cap"
                                                    style="color: #6f42c1; font-size: 1.2em;"></i></td>
                                            <td><span class="badge bg-success"><i class="fas fa-check"></i>
                                                    Active</span></td>
                                            <td><small class="text-muted">0 bài đăng (0 active)</small></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="admin_edit_post_type.jsp?id=4"
                                                        class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="deletePostType(4, 'Thực tập')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td><code class="bg-light px-2 py-1 rounded">freelance</code></td>
                                            <td>
                                                <strong>Freelance</strong>
                                                <br><small class="text-muted">Công việc tự do, dự án ngắn hạn</small>
                                            </td>
                                            <td><span class="badge bg-secondary">job_posting</span></td>
                                            <td><span class="badge bg-info">5</span></td>
                                            <td><i class="fas fa-user-tie"
                                                    style="color: #fd7e14; font-size: 1.2em;"></i></td>
                                            <td><span class="badge bg-success"><i class="fas fa-check"></i>
                                                    Active</span></td>
                                            <td><small class="text-muted">0 bài đăng (0 active)</small></td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="admin_edit_post_type.jsp?id=5"
                                                        class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="deletePostType(5, 'Freelance')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
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
                            <p>Bạn có chắc chắn muốn xóa loại bài đăng "<span id="deleteTypeName"></span>"?</p>
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
                function deletePostType(id, typeName) {
                    document.getElementById('deleteTypeName').textContent = typeName;
                    document.getElementById('deleteForm').action = 'content-type/post-types?action=delete&id=' + id;
                    new bootstrap.Modal(document.getElementById('deleteModal')).show();
                }
            </script>
        </body>

        </html>