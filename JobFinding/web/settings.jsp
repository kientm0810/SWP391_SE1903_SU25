<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài đặt tài khoản | JobFinding</title>

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
    <style>
        .nav-pills .nav-link {
            color: #6c757d;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .nav-pills .nav-link.active {
            background-color: #f8f9fa;
            color: #0d6efd;
            font-weight: 500;
        }

        .nav-pills .nav-link:hover:not(.active) {
            background-color: #f8f9fa;
        }

        .form-label {
            font-weight: 500;
        }

        .settings-header {
            border-bottom: 1px solid #dee2e6;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
        }

        .settings-section {
            margin-bottom: 2rem;
        }
    </style>
</head>

<body class="bg-light">
    <div class="container py-5">
        <div class="settings-header d-flex justify-content-between align-items-center">
            <h1 class="h3 mb-0">Cài đặt tài khoản</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="dashboard.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Cài đặt</li>
                </ol>
            </nav>
        </div>

        <!-- Settings Navigation -->
        <div class="row g-4">
            <div class="col-md-3">
                <div class="nav flex-column nav-pills me-3 bg-white p-3 rounded-3 shadow-sm" id="v-pills-tab"
                    role="tablist">
                    <button class="nav-link active" data-bs-toggle="pill" data-bs-target="#account">
                        <i class="fas fa-user-circle me-2"></i>Tài khoản
                    </button>
                    <button class="nav-link" data-bs-toggle="pill" data-bs-target="#security">
                        <i class="fas fa-shield-alt me-2"></i>Bảo mật
                    </button>
                    <button class="nav-link" data-bs-toggle="pill" data-bs-target="#notifications">
                        <i class="fas fa-bell me-2"></i>Thông báo
                    </button>
                    <button class="nav-link" data-bs-toggle="pill" data-bs-target="#privacy">
                        <i class="fas fa-lock me-2"></i>Quyền riêng tư
                    </button>
                </div>
            </div>

            <div class="col-md-9">
                <div class="tab-content" id="v-pills-tabContent">
                    <!-- Account Settings -->
                    <div class="tab-pane fade show active" id="account">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Thông tin tài khoản</h5>
                                <form action="update_account" method="POST" class="needs-validation" novalidate>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="email" class="form-label">Email</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i
                                                        class="fas fa-envelope"></i></span>
                                                <input type="email" class="form-control" id="email"
                                                    value="${user.email}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="username" class="form-label">Tên đăng nhập</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i
                                                        class="fas fa-user"></i></span>
                                                <input type="text" class="form-control" id="username"
                                                    value="${user.username}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="fullName" class="form-label">Họ và tên</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i
                                                        class="fas fa-id-card"></i></span>
                                                <input type="text" class="form-control" id="fullName"
                                                    name="fullName" value="${user.fullName}" required
                                                    pattern="^[a-zA-ZÀ-ỹ\s]{2,}$">
                                                <div class="invalid-feedback">
                                                    Vui lòng nhập họ tên hợp lệ (ít nhất 2 ký tự)
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="phone" class="form-label">Số điện thoại</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i
                                                        class="fas fa-phone"></i></span>
                                                <input type="tel" class="form-control" id="phone" name="phone"
                                                    value="${user.phone}" required pattern="^(0|\+84)[0-9]{9}$">
                                                <div class="invalid-feedback">
                                                    Vui lòng nhập số điện thoại hợp lệ
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary mt-4">
                                        <i class="fas fa-save me-2"></i>Lưu thay đổi
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Security Settings -->
                    <div class="tab-pane fade" id="security">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Bảo mật</h5>
                                <form action="change_password" method="POST" class="needs-validation"
                                    novalidate>
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                                        <input type="password" class="form-control" id="currentPassword"
                                            name="currentPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                        <input type="password" class="form-control" id="newPassword"
                                            name="newPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                                        <input type="password" class="form-control" id="confirmPassword"
                                            name="confirmPassword" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-key me-2"></i>Đổi mật khẩu
                                    </button>
                                </form>

                                <hr class="my-4">

                                <h6>Xác thực hai lớp</h6>
                                <p class="text-muted">Bảo vệ tài khoản của bạn bằng xác thực hai lớp</p>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="enable2FA"
                                        ${user.twoFactorEnabled ? 'checked' : '' }>
                                    <label class="form-check-label" for="enable2FA">
                                        Bật xác thực hai lớp
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Notification Settings -->
                    <div class="tab-pane fade" id="notifications">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Cài đặt thông báo</h5>
                                <form action="update_notifications" method="POST">
                                    <h6 class="mb-3">Email</h6>
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="emailJobAlert"
                                                name="notifications[]" value="jobAlert"
                                                ${user.notifications.contains('jobAlert') ? 'checked' : '' }>
                                            <label class="form-check-label" for="emailJobAlert">
                                                Thông báo việc làm phù hợp
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox"
                                                id="emailApplicationUpdate" name="notifications[]"
                                                value="applicationUpdate"
                                                ${user.notifications.contains('applicationUpdate') ? 'checked'
                                                : '' }>
                                            <label class="form-check-label" for="emailApplicationUpdate">
                                                Cập nhật trạng thái ứng tuyển
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="emailNewsletter"
                                                name="notifications[]" value="newsletter"
                                                ${user.notifications.contains('newsletter') ? 'checked' : '' }>
                                            <label class="form-check-label" for="emailNewsletter">
                                                Bản tin và cập nhật từ JobFinding
                                            </label>
                                        </div>
                                    </div>

                                    <h6 class="mb-3">Thông báo đẩy</h6>
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="pushJobAlert"
                                                name="pushNotifications[]" value="jobAlert"
                                                ${user.pushNotifications.contains('jobAlert') ? 'checked' : ''
                                                }>
                                            <label class="form-check-label" for="pushJobAlert">
                                                Thông báo việc làm phù hợp
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox"
                                                id="pushApplicationUpdate" name="pushNotifications[]"
                                                value="applicationUpdate"
                                                ${user.pushNotifications.contains('applicationUpdate')
                                                ? 'checked' : '' }>
                                            <label class="form-check-label" for="pushApplicationUpdate">
                                                Cập nhật trạng thái ứng tuyển
                                            </label>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Lưu thay đổi
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Privacy Settings -->
                    <div class="tab-pane fade" id="privacy">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Cài đặt quyền riêng tư</h5>
                                <form action="update_privacy" method="POST">
                                    <div class="mb-3">
                                        <label class="form-label">Hiển thị hồ sơ với</label>
                                        <select class="form-select" name="profileVisibility">
                                            <option value="public" ${user.profileVisibility=='public'
                                                ? 'selected' : '' }>
                                                Tất cả mọi người
                                            </option>
                                            <option value="recruiters" ${user.profileVisibility=='recruiters'
                                                ? 'selected' : '' }>
                                                Chỉ nhà tuyển dụng
                                            </option>
                                            <option value="private" ${user.profileVisibility=='private'
                                                ? 'selected' : '' }>
                                                Chỉ mình tôi
                                            </option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Cho phép nhà tuyển dụng liên hệ</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="allowContact"
                                                name="allowContact" ${user.allowContact ? 'checked' : '' }>
                                            <label class="form-check-label" for="allowContact">
                                                Nhà tuyển dụng có thể liên hệ với tôi về cơ hội việc làm phù hợp
                                            </label>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Hiển thị thông tin liên hệ</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="showEmail"
                                                name="showEmail" ${user.showEmail ? 'checked' : '' }>
                                            <label class="form-check-label" for="showEmail">
                                                Hiển thị email
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="showPhone"
                                                name="showPhone" ${user.showPhone ? 'checked' : '' }>
                                            <label class="form-check-label" for="showPhone">
                                                Hiển thị số điện thoại
                                            </label>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Lưu thay đổi
                                    </button>
                                </form>

                                <hr class="my-4">

                                <h6 class="text-danger">Xóa tài khoản</h6>
                                <p class="text-muted">
                                    Khi xóa tài khoản, tất cả dữ liệu của bạn sẽ bị xóa vĩnh viễn và không thể
                                    khôi phục.
                                </p>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                    data-bs-target="#deleteAccountModal">
                                    <i class="fas fa-trash-alt me-2"></i>Xóa tài khoản
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Account Modal -->
    <div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa tài khoản</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa tài khoản? Hành động này không thể hoàn tác.</p>
                    <form id="deleteAccountForm">
                        <div class="mb-3">
                            <label for="deleteConfirm" class="form-label">
                                Nhập "XÓA TÀI KHOẢN" để xác nhận
                            </label>
                            <input type="text" class="form-control" id="deleteConfirm" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger" id="confirmDelete" disabled>
                        Xóa tài khoản
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Toast -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-check-circle text-success me-2"></i>
                <strong class="me-auto">Thành công</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body"></div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const successToast = new bootstrap.Toast(document.getElementById('successToast'));
            const deleteConfirmInput = document.getElementById('deleteConfirm');
            const confirmDeleteBtn = document.getElementById('confirmDelete');

            // Form validation
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                });
            });

            // Password confirmation validation
            const newPasswordInput = document.getElementById('newPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            if (newPasswordInput && confirmPasswordInput) {
                confirmPasswordInput.addEventListener('input', function () {
                    if (this.value !== newPasswordInput.value) {
                        this.setCustomValidity('Mật khẩu không khớp');
                    } else {
                        this.setCustomValidity('');
                    }
                });
            }

            // 2FA toggle
            const enable2FASwitch = document.getElementById('enable2FA');
            if (enable2FASwitch) {
                enable2FASwitch.addEventListener('change', function () {
                    fetch('update_2fa', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `enabled=${this.checked}`
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                document.querySelector('#successToast .toast-body').textContent =
                                    `Xác thực hai lớp đã được ${this.checked ? 'bật' : 'tắt'}`;
                                successToast.show();
                            } else {
                                throw new Error(data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            this.checked = !this.checked;
                            alert('Có lỗi xảy ra. Vui lòng thử lại!');
                        });
                });
            }

            // Delete account confirmation
            if (deleteConfirmInput) {
                deleteConfirmInput.addEventListener('input', function () {
                    confirmDeleteBtn.disabled = this.value !== 'XÓA TÀI KHOẢN';
                });
            }

            if (confirmDeleteBtn) {
                confirmDeleteBtn.addEventListener('click', function () {
                    fetch('delete_account', {
                        method: 'POST'
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                window.location.href = 'logout';
                            } else {
                                throw new Error(data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra. Vui lòng thử lại!');
                        });
                });
            }
        });
    </script>
</body>

</html>