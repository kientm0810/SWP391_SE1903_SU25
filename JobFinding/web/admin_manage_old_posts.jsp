<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Quản lý bài đăng cũ - Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                .stats-card {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border-radius: 10px;
                    padding: 20px;
                    margin-bottom: 20px;
                }

                .danger-card {
                    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                    color: white;
                    border-radius: 10px;
                    padding: 20px;
                    margin-bottom: 20px;
                }

                .warning-card {
                    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                    color: white;
                    border-radius: 10px;
                    padding: 20px;
                    margin-bottom: 20px;
                }

                .btn-delete {
                    background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                    border: none;
                    color: white;
                    padding: 10px 20px;
                    border-radius: 5px;
                    transition: all 0.3s ease;
                }

                .btn-delete:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                    color: white;
                }

                .btn-soft-delete {
                    background: linear-gradient(135deg, #feca57 0%, #ff9ff3 100%);
                    border: none;
                    color: white;
                    padding: 10px 20px;
                    border-radius: 5px;
                    transition: all 0.3s ease;
                }

                .btn-soft-delete:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                    color: white;
                }
            </style>
        </head>

        <body>
            <jsp:include page="admin-header.jsp" />

            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="sidebar.jsp" />

                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">
                                <i class="fas fa-trash-alt me-2"></i>
                                Quản lý bài đăng cũ
                            </h1>
                        </div>

                        <!-- Thống kê -->
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="stats-card">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4 id="oldPostsCount">0</h4>
                                            <p class="mb-0">Bài đăng cũ</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-clock fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="warning-card">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4 id="totalPostsCount">0</h4>
                                            <p class="mb-0">Tổng bài đăng</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-file-alt fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="danger-card">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4 id="deletedPostsCount">0</h4>
                                            <p class="mb-0">Đã xóa</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-trash fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Cảnh báo -->
                        <div class="alert alert-warning" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Cảnh báo:</strong> Việc xóa bài đăng cũ sẽ không thể hoàn tác. Hãy cân nhắc kỹ trước
                            khi thực hiện.
                        </div>

                        <!-- Nút xóa -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="mb-0">
                                            <i class="fas fa-archive me-2"></i>
                                            Xóa mềm (Soft Delete)
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <p class="text-muted">Đánh dấu bài đăng là đã xóa nhưng vẫn giữ lại trong
                                            database.</p>
                                        <button type="button" class="btn btn-soft-delete"
                                            onclick="deleteOldPosts('soft')">
                                            <i class="fas fa-archive me-2"></i>
                                            Xóa mềm bài đăng cũ
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="mb-0">
                                            <i class="fas fa-trash me-2"></i>
                                            Xóa cứng (Hard Delete)
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <p class="text-muted">Xóa vĩnh viễn bài đăng khỏi database. <strong>Không thể
                                                hoàn tác!</strong></p>
                                        <button type="button" class="btn btn-delete" onclick="confirmHardDelete()">
                                            <i class="fas fa-trash me-2"></i>
                                            Xóa cứng bài đăng cũ
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Lịch sử xóa -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-history me-2"></i>
                                    Lịch sử xóa gần đây
                                </h5>
                            </div>
                            <div class="card-body">
                                <div id="deleteHistory">
                                    <p class="text-muted">Chưa có lịch sử xóa.</p>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>

            <!-- Modal xác nhận xóa cứng -->
            <div class="modal fade" id="confirmHardDeleteModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                Xác nhận xóa cứng
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>Bạn có chắc chắn muốn xóa cứng tất cả bài đăng cũ?</strong></p>
                            <p class="text-danger">Hành động này sẽ:</p>
                            <ul class="text-danger">
                                <li>Xóa vĩnh viễn bài đăng khỏi database</li>
                                <li>Không thể hoàn tác</li>
                                <li>Mất tất cả dữ liệu liên quan</li>
                            </ul>
                            <p>Nhập <strong>DELETE</strong> để xác nhận:</p>
                            <input type="text" class="form-control" id="confirmText" placeholder="Nhập DELETE">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="button" class="btn btn-danger" onclick="deleteOldPosts('hard')"
                                id="confirmHardDeleteBtn" disabled>
                                <i class="fas fa-trash me-2"></i>
                                Xóa cứng
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Load statistics on page load
                document.addEventListener('DOMContentLoaded', function () {
                    loadStatistics();
                });

                // Load statistics
                function loadStatistics() {
                    fetch('${pageContext.request.contextPath}/post/old-posts-count')
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                document.getElementById('oldPostsCount').textContent = data.oldPostsCount;
                            }
                        })
                        .catch(error => {
                            console.error('Error loading statistics:', error);
                        });
                }

                // Delete old posts
                function deleteOldPosts(type) {
                    const button = event.target;
                    const originalText = button.innerHTML;

                    // Disable button and show loading
                    button.disabled = true;
                    button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xóa...';

                    fetch('${pageContext.request.contextPath}/post/delete-old?type=' + type)
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                showAlert('success', data.message);
                                loadStatistics();
                                addToHistory(type, data.deletedCount);
                            } else {
                                showAlert('danger', data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error deleting old posts:', error);
                            showAlert('danger', 'Lỗi khi xóa bài đăng cũ');
                        })
                        .finally(() => {
                            // Re-enable button
                            button.disabled = false;
                            button.innerHTML = originalText;

                            // Close modal if it's open
                            const modal = bootstrap.Modal.getInstance(document.getElementById('confirmHardDeleteModal'));
                            if (modal) {
                                modal.hide();
                            }
                        });
                }

                // Confirm hard delete
                function confirmHardDelete() {
                    const modal = new bootstrap.Modal(document.getElementById('confirmHardDeleteModal'));
                    modal.show();
                }

                // Handle confirm text input
                document.getElementById('confirmText').addEventListener('input', function () {
                    const confirmBtn = document.getElementById('confirmHardDeleteBtn');
                    confirmBtn.disabled = this.value !== 'DELETE';
                });

                // Add to delete history
                function addToHistory(type, count) {
                    const historyDiv = document.getElementById('deleteHistory');
                    const timestamp = new Date().toLocaleString('vi-VN');
                    const typeText = type === 'hard' ? 'Xóa cứng' : 'Xóa mềm';

                    const historyItem = document.createElement('div');
                    historyItem.className = 'alert alert-info';
                    historyItem.innerHTML = `
                <i class="fas fa-info-circle me-2"></i>
                <strong>${timestamp}</strong> - ${typeText}: ${count} bài đăng
            `;

                    historyDiv.insertBefore(historyItem, historyDiv.firstChild);

                    // Keep only last 10 items
                    const items = historyDiv.querySelectorAll('.alert');
                    if (items.length > 10) {
                        items[items.length - 1].remove();
                    }
                }

                // Show alert
                function showAlert(type, message) {
                    const alertDiv = document.createElement('div');
                    alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
                    alertDiv.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                    alertDiv.innerHTML = `
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;

                    document.body.appendChild(alertDiv);

                    // Auto remove after 5 seconds
                    setTimeout(() => {
                        if (alertDiv.parentNode) {
                            alertDiv.remove();
                        }
                    }, 5000);
                }
            </script>
        </body>

        </html>