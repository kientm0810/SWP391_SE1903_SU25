<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Cập nhật trạng thái ứng tuyển | JobFinding</title>

                    <!-- CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                    <link rel="stylesheet" href="assets/css/main.css">
                    <style>
                        body {
                            background: #f5f7fa;
                        }

                        .update-status-container {
                            max-width: 800px;
                            margin: 0 auto;
                            padding: 20px;
                        }

                        .status-header {
                            background: linear-gradient(90deg, #009966 0%, #00c471 100%);
                            border-radius: 18px;
                            color: #fff;
                            padding: 32px;
                            margin-bottom: 32px;
                            text-align: center;
                        }

                        .status-header h2 {
                            font-weight: bold;
                            margin-bottom: 8px;
                        }

                        .status-header .desc {
                            font-size: 1.1rem;
                            opacity: 0.95;
                        }

                        .application-info-card {
                            background: #fff;
                            border-radius: 14px;
                            box-shadow: 0 2px 12px #e0e0e0;
                            padding: 24px;
                            margin-bottom: 24px;
                        }

                        .candidate-avatar {
                            width: 80px;
                            height: 80px;
                            object-fit: cover;
                            border-radius: 50%;
                            border: 3px solid #e9ecef;
                            margin-bottom: 16px;
                        }

                        .candidate-info h4 {
                            color: #333;
                            font-weight: 600;
                            margin-bottom: 8px;
                        }

                        .candidate-info p {
                            color: #666;
                            margin-bottom: 4px;
                        }

                        .job-info {
                            background: #f8f9fa;
                            border-radius: 8px;
                            padding: 16px;
                            margin-top: 16px;
                        }

                        .job-info h5 {
                            color: #333;
                            font-weight: 600;
                            margin-bottom: 8px;
                        }

                        .update-form-card {
                            background: #fff;
                            border-radius: 14px;
                            box-shadow: 0 2px 12px #e0e0e0;
                            padding: 24px;
                        }

                        .form-label {
                            font-weight: 600;
                            color: #333;
                            margin-bottom: 8px;
                        }

                        .form-select,
                        .form-control {
                            border: 1.5px solid #e0e0e0;
                            border-radius: 8px;
                            padding: 12px;
                        }

                        .form-select:focus,
                        .form-control:focus {
                            border-color: #00b14f;
                            box-shadow: 0 0 0 0.2rem rgba(0, 177, 79, .15);
                        }

                        .btn-primary {
                            background: #00b14f;
                            border-color: #00b14f;
                            border-radius: 8px;
                            padding: 12px 24px;
                            font-weight: 600;
                        }

                        .btn-primary:hover {
                            background: #009443;
                            border-color: #009443;
                        }

                        .btn-secondary {
                            background: #6c757d;
                            border-color: #6c757d;
                            border-radius: 8px;
                            padding: 12px 24px;
                            font-weight: 600;
                        }

                        .email-notification {
                            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
                            border: 1px solid #2196f3;
                            color: #1565c0;
                            border-radius: 8px;
                            padding: 16px;
                            margin-bottom: 20px;
                        }

                        .email-notification i {
                            color: #2196f3;
                        }

                        .alert {
                            border-radius: 8px;
                            border: none;
                        }

                        .alert-success {
                            background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
                            color: #2e7d32;
                        }

                        .alert-danger {
                            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
                            color: #c62828;
                        }

                        .status-badge {
                            display: inline-block;
                            padding: 6px 14px;
                            border-radius: 20px;
                            font-size: 0.875rem;
                            font-weight: 600;
                            text-align: center;
                            min-width: 100px;
                        }

                        .status-new {
                            background: #e3f2fd;
                            color: #1976d2;
                        }

                        .status-reviewed {
                            background: #fff3e0;
                            color: #f57c00;
                        }

                        .status-interviewed {
                            background: #f3e5f5;
                            color: #7b1fa2;
                        }

                        .status-offered {
                            background: #e8f5e8;
                            color: #388e3c;
                        }

                        .status-rejected {
                            background: #ffebee;
                            color: #d32f2f;
                        }

                        .loading-spinner {
                            display: none;
                        }

                        .loading-spinner.show {
                            display: inline-block;
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="header.jsp" />

                    <div class="update-status-container">
                        <!-- Header -->
                        <div class="status-header">
                            <h2><i class="fas fa-edit me-2"></i>Cập nhật trạng thái ứng tuyển</h2>
                            <div class="desc">Cập nhật trạng thái và gửi email thông báo cho ứng viên</div>
                        </div>

                        <!-- Success/Error Messages -->
                        <c:if test="${not empty sessionScope.success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${sessionScope.success}
                                <c:if test="${not empty sessionScope.emailSent}">
                                    <br><i class="fas fa-envelope me-2"></i><strong>Email đã được gửi tự động</strong>
                                    trực tiếp đến email của ứng viên.
                                </c:if>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <c:remove var="success" scope="session" />
                            <c:remove var="emailSent" scope="session" />
                        </c:if>

                        <c:if test="${not empty sessionScope.error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <c:remove var="error" scope="session" />
                        </c:if>

                        <!-- Application Info -->
                        <div class="application-info-card">
                            <div class="row align-items-center">
                                <div class="col-md-3 text-center">
                                    <img src="${not empty application.jobseeker.profilePicture ? application.jobseeker.profilePicture : 'assets/img/icon/user-default.png'}"
                                        class="candidate-avatar" alt="${application.jobseeker.fullName}">
                                </div>
                                <div class="col-md-9">
                                    <div class="candidate-info">
                                        <h4>${application.jobseeker.fullName}</h4>
                                        <p><i class="fas fa-envelope me-2"></i>${application.jobseeker.email}</p>
                                        <p><i class="fas fa-phone me-2"></i>${application.jobseeker.phone}</p>
                                        <p><i class="fas fa-calendar me-2"></i>Ứng tuyển:
                                            <fmt:formatDate value="${application.createdAt}"
                                                pattern="HH:mm, dd/MM/yyyy" />
                                        </p>

                                        <div class="job-info">
                                            <h5><i class="fas fa-briefcase me-2"></i>Thông tin công việc</h5>
                                            <p><strong>Vị trí:</strong> ${application.post.title}</p>
                                            <p><strong>Công ty:</strong> ${application.post.companyName}</p>
                                            <p><strong>Trạng thái hiện tại:</strong>
                                                <span class="status-badge status-${fn:toLowerCase(application.status)}">
                                                    <c:choose>
                                                        <c:when test="${fn:toLowerCase(application.status) == 'new'}">
                                                            Mới
                                                        </c:when>
                                                        <c:when
                                                            test="${fn:toLowerCase(application.status) == 'reviewed'}">
                                                            Đã xem</c:when>
                                                        <c:when
                                                            test="${fn:toLowerCase(application.status) == 'interviewed'}">
                                                            Phỏng vấn</c:when>
                                                        <c:when
                                                            test="${fn:toLowerCase(application.status) == 'offered'}">
                                                            Mời nhận việc</c:when>
                                                        <c:when
                                                            test="${fn:toLowerCase(application.status) == 'rejected'}">
                                                            Từ chối</c:when>
                                                        <c:otherwise>${application.status}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </p>
                                            <c:if test="${not empty application.cvFile}">
                                                <p class="mt-2">
                                                    <a href="download-cv?applicationId=${application.applicationId}"
                                                        class="btn btn-info btn-sm">
                                                        <i class="fas fa-download me-1"></i>Tải CV của ứng viên
                                                    </a>
                                                </p>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Update Status Form -->
                        <div class="update-form-card">
                            <h4 class="mb-4"><i class="fas fa-edit me-2"></i>Cập nhật trạng thái</h4>

                            <!-- Email Notification Info -->
                            <div class="email-notification" role="alert">
                                <i class="fas fa-info-circle me-2"></i>
                                <strong>Lưu ý:</strong> Khi cập nhật trạng thái, hệ thống sẽ <strong>tự động gửi
                                    email</strong>
                                thông báo trực tiếp đến: <strong>${application.jobseeker.email}</strong>
                            </div>

                            <form id="updateStatusForm" action="update-application-status" method="POST">
                                <input type="hidden" name="applicationId" value="${application.applicationId}" />
                                <input type="hidden" name="action" value="update" />

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Trạng thái mới</label>
                                            <select id="status" name="status" class="form-select" required>
                                                <option value="">-- Chọn trạng thái --</option>
                                                <option value="new" ${application.status=='new' ? 'selected' : '' }>Mới
                                                </option>
                                                <option value="reviewed" ${application.status=='reviewed' ? 'selected'
                                                    : '' }>Đã xem</option>
                                                <option value="interviewed" ${application.status=='interviewed'
                                                    ? 'selected' : '' }>Phỏng vấn</option>
                                                <option value="offered" ${application.status=='offered' ? 'selected'
                                                    : '' }>
                                                    Mời nhận việc</option>
                                                <option value="rejected" ${application.status=='rejected' ? 'selected'
                                                    : '' }>Từ chối</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="emailPreview" class="form-label">Email sẽ được gửi đến</label>
                                            <input type="text" class="form-control" id="emailPreview"
                                                value="${application.jobseeker.email}" readonly>
                                        </div>
                                    </div>
                                </div>

                                <!-- Lý do từ chối (hiển thị khi chọn "Từ chối") -->
                                <div id="rejectionReasonDiv" class="mb-3" style="display: none;">
                                    <label for="rejectionReason" class="form-label">Lý do từ chối:</label>
                                    <textarea id="rejectionReason" name="rejectionReason" class="form-control" rows="4"
                                        placeholder="Nhập lý do từ chối ứng viên..."></textarea>
                                </div>

                                <!-- Chi tiết đề nghị (hiển thị khi chọn "Mời nhận việc") -->
                                <div id="offerDetailsDiv" class="mb-3" style="display: none;">
                                    <label for="offerDetails" class="form-label">Chi tiết đề nghị:</label>
                                    <textarea id="offerDetails" name="offerDetails" class="form-control" rows="4"
                                        placeholder="Nhập chi tiết đề nghị việc làm..."></textarea>
                                </div>

                                <!-- Email Preview -->
                                <div id="emailPreviewDiv" class="mb-3" style="display: none;">
                                    <label class="form-label">Xem trước email sẽ gửi:</label>
                                    <div class="border rounded p-3 bg-light">
                                        <div id="emailPreviewContent"></div>
                                    </div>
                                </div>

                                <div class="d-flex gap-3">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-1"></i>
                                        <span class="btn-text">Cập nhật trạng thái</span>
                                        <i class="fas fa-spinner fa-spin loading-spinner"></i>
                                    </button>
                                    <a href="applications" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left me-1"></i> Quay lại
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Scripts -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const statusSelect = document.getElementById('status');
                            const rejectionReasonDiv = document.getElementById('rejectionReasonDiv');
                            const offerDetailsDiv = document.getElementById('offerDetailsDiv');
                            const rejectionReason = document.getElementById('rejectionReason');
                            const offerDetails = document.getElementById('offerDetails');
                            const emailPreviewDiv = document.getElementById('emailPreviewDiv');
                            const emailPreviewContent = document.getElementById('emailPreviewContent');
                            const updateStatusForm = document.getElementById('updateStatusForm');
                            const candidateEmail = '${application.jobseeker.email}';
                            const candidateName = '${application.jobseeker.fullName}';
                            const jobTitle = '${application.post.title}';
                            const companyName = '${application.post.companyName}';

                            // Handle status change
                            statusSelect.addEventListener('change', function () {
                                const selectedStatus = this.value;

                                // Hide all additional fields first
                                rejectionReasonDiv.style.display = 'none';
                                offerDetailsDiv.style.display = 'none';
                                emailPreviewDiv.style.display = 'none';

                                // Show relevant field based on selected status
                                if (selectedStatus === 'rejected') {
                                    rejectionReasonDiv.style.display = 'block';
                                    rejectionReason.required = true;
                                    offerDetails.required = false;
                                } else if (selectedStatus === 'offered') {
                                    offerDetailsDiv.style.display = 'block';
                                    offerDetails.required = true;
                                    rejectionReason.required = false;
                                } else {
                                    rejectionReason.required = false;
                                    offerDetails.required = false;
                                }

                                // Show email preview
                                if (selectedStatus) {
                                    showEmailPreview(selectedStatus);
                                }
                            });

                            // Function to show email preview
                            function showEmailPreview(status) {
                                let emailSubject = '';
                                let emailBody = '';

                                switch (status) {
                                    case 'reviewed':
                                        emailSubject = 'Thông báo: Hồ sơ của bạn đã được xem xét';
                                        emailBody = `Xin chào ${candidateName},<br><br>
                                   Chúng tôi xin thông báo rằng hồ sơ ứng tuyển của bạn cho vị trí <strong>${jobTitle}</strong> 
                                   tại <strong>${companyName}</strong> đã được chúng tôi xem xét.<br><br>
                                   Chúng tôi sẽ liên hệ với bạn sớm nhất có thể về kết quả tiếp theo.<br><br>
                                   Trân trọng,<br>Đội ngũ ${companyName}`;
                                        break;
                                    case 'interviewed':
                                        emailSubject = 'Cảm ơn bạn đã tham gia phỏng vấn';
                                        emailBody = `Xin chào ${candidateName},<br><br>
                                   Cảm ơn bạn đã dành thời gian tham gia buổi phỏng vấn cho vị trí <strong>${jobTitle}</strong> 
                                   tại <strong>${companyName}</strong>.<br><br>
                                   Chúng tôi đánh giá cao sự quan tâm của bạn và sẽ thông báo kết quả trong thời gian sớm nhất.<br><br>
                                   Trân trọng,<br>Đội ngũ ${companyName}`;
                                        break;
                                    case 'rejected':
                                        emailSubject = 'Thông báo về đơn ứng tuyển của bạn';
                                        emailBody = `Xin chào ${candidateName},<br><br>
                                   Cảm ơn bạn đã quan tâm đến vị trí <strong>${jobTitle}</strong> tại <strong>${companyName}</strong>.<br><br>
                                   Sau khi xem xét kỹ lưỡng hồ sơ của bạn, chúng tôi rất tiếc phải thông báo rằng 
                                   chúng tôi không thể tiến hành với đơn ứng tuyển của bạn vào lúc này.<br><br>
                                   <strong>Lý do:</strong> <span id="rejection-reason-preview">[Lý do sẽ được điền khi bạn nhập]</span><br><br>
                                   Chúng tôi chúc bạn thành công trong các cơ hội việc làm khác.<br><br>
                                   Trân trọng,<br>Đội ngũ ${companyName}`;
                                        break;
                                    case 'offered':
                                        emailSubject = 'Chúc mừng! Bạn đã được mời nhận việc';
                                        emailBody = `Xin chào ${candidateName},<br><br>
                                   Chúc mừng! Chúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí 
                                   <strong>${jobTitle}</strong> tại <strong>${companyName}</strong>.<br><br>
                                   <strong>Chi tiết đề nghị:</strong><br>
                                   <span id="offer-details-preview">[Chi tiết sẽ được điền khi bạn nhập]</span><br><br>
                                   Chúng tôi mong đợi được làm việc cùng bạn!<br><br>
                                   Trân trọng,<br>Đội ngũ ${companyName}`;
                                        break;
                                    default:
                                        emailSubject = 'Thông báo cập nhật trạng thái ứng tuyển';
                                        emailBody = `Xin chào ${candidateName},<br><br>
                                   Trạng thái đơn ứng tuyển của bạn cho vị trí <strong>${jobTitle}</strong> 
                                   tại <strong>${companyName}</strong> đã được cập nhật.<br><br>
                                   Trân trọng,<br>Đội ngũ ${companyName}`;
                                }

                                emailPreviewContent.innerHTML = `
                    <div class="mb-2"><strong>Đến:</strong> ${candidateEmail}</div>
                    <div class="mb-2"><strong>Tiêu đề:</strong> ${emailSubject}</div>
                    <div class="mb-2"><strong>Nội dung:</strong></div>
                    <div class="border-start border-3 border-primary ps-3">${emailBody}</div>
                `;
                                emailPreviewDiv.style.display = 'block';
                            }

                            // Update email preview when rejection reason or offer details change
                            rejectionReason.addEventListener('input', function () {
                                const preview = document.getElementById('rejection-reason-preview');
                                if (preview) {
                                    preview.textContent = this.value || '[Lý do sẽ được điền khi bạn nhập]';
                                }
                            });

                            offerDetails.addEventListener('input', function () {
                                const preview = document.getElementById('offer-details-preview');
                                if (preview) {
                                    preview.textContent = this.value || '[Chi tiết sẽ được điền khi bạn nhập]';
                                }
                            });

                            // Handle form submission
                            updateStatusForm.addEventListener('submit', function (e) {
                                e.preventDefault();

                                const selectedStatus = statusSelect.value;
                                const selectedText = statusSelect.options[statusSelect.selectedIndex].text;

                                // Validation
                                if (!selectedStatus) {
                                    alert('Vui lòng chọn trạng thái.');
                                    return;
                                }

                                if (selectedStatus === 'rejected' && !rejectionReason.value.trim()) {
                                    alert('Vui lòng nhập lý do từ chối.');
                                    return;
                                }

                                if (selectedStatus === 'offered' && !offerDetails.value.trim()) {
                                    alert('Vui lòng nhập chi tiết đề nghị.');
                                    return;
                                }

                                // Show confirmation
                                const emailMessage = getEmailMessage(selectedStatus);
                                const confirmMessage = `Bạn có chắc muốn cập nhật trạng thái thành "${selectedText}"?\n\n${emailMessage}`;

                                if (confirm(confirmMessage)) {
                                    // Show loading state
                                    const submitBtn = this.querySelector('button[type="submit"]');
                                    const btnText = submitBtn.querySelector('.btn-text');
                                    const spinner = submitBtn.querySelector('.loading-spinner');

                                    btnText.textContent = 'Đang cập nhật...';
                                    spinner.classList.add('show');
                                    submitBtn.disabled = true;

                                    // Submit form
                                    this.submit();
                                }
                            });

                            // Function to get email message for confirmation
                            function getEmailMessage(status) {
                                switch (status) {
                                    case 'reviewed':
                                        return `📧 Email thông báo "Đã xem hồ sơ" sẽ được gửi tự động đến: ${candidateEmail}`;
                                    case 'interviewed':
                                        return `📧 Email cảm ơn "Đã tham gia phỏng vấn" sẽ được gửi tự động đến: ${candidateEmail}`;
                                    case 'rejected':
                                        return `📧 Email từ chối với lý do sẽ được gửi tự động đến: ${candidateEmail}`;
                                    case 'offered':
                                        return `📧 Email chấp nhận với chi tiết đề nghị sẽ được gửi tự động đến: ${candidateEmail}`;
                                    default:
                                        return `📧 Email thông báo sẽ được gửi tự động đến: ${candidateEmail}`;
                                }
                            }

                            // Initialize email preview if status is already selected
                            if (statusSelect.value) {
                                showEmailPreview(statusSelect.value);
                            }
                        });
                    </script>
                </body>

                </html>