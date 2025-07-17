<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gửi Email | JobFinding</title>

        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="assets/css/main.css">

        <!-- TinyMCE -->
        <script src="tinymce/tinymce.min.js"></script>

        <style>
            body {
                background: #f5f7fa;
            }

            .email-header {
                background: linear-gradient(135deg, #00c6a2 0%, #00a7e1 100%); /* Xanh lá → Xanh dương */
                border-radius: 18px;
                color: #fff;
                padding: 32px 32px 24px 32px;
                margin-bottom: 32px;
            }

            .email-header h2 {
                font-weight: bold;
            }

            .email-header .desc {
                font-size: 1.1rem;
                opacity: 0.95;
            }


            .email-form-card {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                padding: 32px;
                margin-bottom: 24px;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 8px;
            }

            .form-control,
            .form-select {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 32px;
                font-weight: 600;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            }

            .btn-secondary {
                background: #6c757d;
                border: none;
                border-radius: 10px;
                padding: 12px 32px;
                font-weight: 600;
                font-size: 1rem;
            }

            .btn-secondary:hover {
                background: #5a6268;
            }

            .template-section {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 24px;
            }

            .template-item {
                background: #fff;
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 16px;
                margin-bottom: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .template-item:hover {
                border-color: #667eea;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
            }

            .template-item.selected {
                border-color: #667eea;
                background: #f0f4ff;
            }

            .template-title {
                font-weight: 600;
                color: #333;
                margin-bottom: 4px;
            }

            .template-desc {
                color: #666;
                font-size: 0.9rem;
            }

            .recipient-info {
                background: #e8f4fd;
                border-radius: 10px;
                padding: 16px;
                margin-bottom: 20px;
            }

            .recipient-info h6 {
                color: #0d6efd;
                margin-bottom: 8px;
            }

            .recipient-details {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }

            .recipient-detail {
                display: flex;
                align-items: center;
                gap: 8px;
                color: #666;
            }

            .recipient-detail i {
                color: #0d6efd;
            }

            .preview-section {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 20px;
                margin-top: 24px;
            }

            .preview-content {
                background: #fff;
                border-radius: 8px;
                padding: 20px;
                border: 1px solid #dee2e6;
            }

            .loading-spinner {
                display: none;
            }

            .email-status {
                margin-top: 16px;
            }

            .status-success {
                background: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
                padding: 12px;
                border-radius: 8px;
            }

            .status-error {
                background: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
                padding: 12px;
                border-radius: 8px;
            }

            .additional-field-group {
                background: #f0f4ff;
                /* Light blue background for additional fields */
                border: 1px solid #cce5ff;
                border-radius: 8px;
                padding: 15px;
                margin-top: 15px;
                margin-bottom: 15px;
            }

            .additional-field-group h6 {
                margin-bottom: 10px;
            }

            .additional-field-group .form-label {
                color: #333;
            }

            .additional-field-group .form-control,
            .additional-field-group .form-select {
                border-color: #b8daff;
                /* Lighter border for additional fields */
            }

            .additional-field-group .form-control:focus,
            .additional-field-group .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            }

            @media (max-width: 768px) {
                .email-form-card {
                    padding: 20px;
                }

                .recipient-details {
                    flex-direction: column;
                    gap: 8px;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container py-4">
            <!-- Header -->
            <div class="email-header">
                <h2><i class="fas fa-envelope me-2"></i>Gửi Email</h2>
                <div class="desc">Gửi email thông báo tùy chỉnh cho ứng viên</div>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="success" scope="session" />
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="error" scope="session" />
            </c:if>

            <!-- Email Form -->
            <div class="email-form-card">
                <form id="emailForm" action="send-custom-email" method="POST">
                    <!-- Recipient Information -->
                    <div class="recipient-info">
                        <h6><i class="fas fa-user me-2"></i>Thông tin người nhận</h6>
                        <div class="recipient-details">
                            <div class="recipient-detail">
                                <i class="fas fa-user-circle"></i>
                                <span><strong>Tên:</strong> ${requestScope.candidateName}</span>
                            </div>
                            <div class="recipient-detail">
                                <i class="fas fa-envelope"></i>
                                <span><strong>Email:</strong> ${requestScope.recipientEmail}</span>
                            </div>
                            <div class="recipient-detail">
                                <i class="fas fa-briefcase"></i>
                                <span><strong>Vị trí:</strong> ${requestScope.jobTitle}</span>
                            </div>
                            <div class="recipient-detail">
                                <i class="fas fa-building"></i>
                                <span><strong>Công ty:</strong> ${requestScope.companyName}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" name="recipientEmail" value="${requestScope.recipientEmail}">
                    <input type="hidden" name="candidateName" value="${requestScope.candidateName}">
                    <input type="hidden" name="jobTitle" value="${requestScope.jobTitle}">
                    <input type="hidden" name="companyName" value="${requestScope.companyName}">
                    <input type="hidden" name="applicationId" value="${requestScope.applicationId}">
                    <input type="hidden" name="emailContentHidden" id="emailContentHidden">

                    <!-- Email Type Selection -->
                    <div class="mb-4">
                        <label for="emailType" class="form-label">
                            <i class="fas fa-list me-2"></i>Loại email
                        </label>
                        <select class="form-select" id="emailType" name="emailType" required>
                            <option value="">-- Chọn loại email --</option>                        
                            <option value="application_received">Xác nhận nhận hồ sơ</option>
                            <option value="interview_invitation">Lời mời phỏng vấn</option>

                            <option value="rejection">Thư từ chối</option>
                            <option value="offer">Lời mời làm việc</option>
                            <option value="custom">Email tùy chỉnh</option>
                        </select>
                    </div>

                    <!-- Template Selection (shown when email type is selected) -->
                    <div id="templateSection" class="template-section" style="display: none;">
                        <h6 class="mb-3"><i class="fas fa-file-alt me-2"></i><span id="templateHeader">Chọn
                                template</span></h6>
                        <div id="templateList">
                            <!-- Templates will be loaded here -->
                        </div>
                    </div>

                    <!-- Custom Email Fields -->
                    <div id="customEmailFields">
                        <div class="mb-4">
                            <label for="subject" class="form-label">
                                <i class="fas fa-heading me-2"></i>Tiêu đề email
                            </label>
                            <input type="text" class="form-control" id="subject" name="subject"
                                   placeholder="Nhập tiêu đề email..." required>
                        </div>

                        <div class="mb-4">
                            <label for="emailContent" class="form-label">
                                <i class="fas fa-edit me-2"></i>Nội dung email
                            </label>
                            <textarea class="form-control" id="emailContent" name="emailContent" rows="12"
                                      placeholder="Nhập nội dung email..." required></textarea>
                        </div>
                    </div>

                    <!-- Dynamic Additional Fields -->
                    <div id="additionalFields" style="display: none;">
                        <!-- Interview Invitation Fields -->
                        <div id="interviewInvitationFields" class="additional-field-group"
                             style="display: none;">
                            <h6 class="mb-3 text-primary"><i class="fas fa-calendar-alt me-2"></i>Thông tin
                                phỏng vấn</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="interviewDate" class="form-label">Ngày phỏng vấn</label>
                                    <input type="date" class="form-control" id="interviewDate"
                                           name="interviewDate">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="interviewTime" class="form-label">Giờ phỏng vấn</label>
                                    <input type="time" class="form-control" id="interviewTime"
                                           name="interviewTime">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="interviewLocation" class="form-label">Địa điểm phỏng vấn</label>
                                    <input type="text" class="form-control" id="interviewLocation"
                                           name="interviewLocation"
                                           placeholder="Ví dụ: Văn phòng công ty, Tầng 5, 123 ABC Street">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="interviewerName" class="form-label">Người phỏng vấn</label>
                                    <input type="text" class="form-control" id="interviewerName"
                                           name="interviewerName" placeholder="Tên người phỏng vấn">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="interviewType" class="form-label">Hình thức phỏng vấn</label>
                                    <select class="form-select" id="interviewType" name="interviewType">
                                        <option value="Phỏng vấn trực tiếp">Phỏng vấn trực tiếp</option>
                                        <option value="Phỏng vấn online">Phỏng vấn online</option>
                                        <option value="Phỏng vấn qua điện thoại">Phỏng vấn qua điện thoại
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="interviewDuration" class="form-label">Thời gian dự kiến</label>
                                    <input type="text" class="form-control" id="interviewDuration"
                                           name="interviewDuration" placeholder="Ví dụ: 60 phút">
                                </div>
                            </div>
                        </div>

                        <!-- Interview Reminder Fields -->
                        <div id="interviewReminderFields" class="additional-field-group" style="display: none;">
                            <h6 class="mb-3 text-warning"><i class="fas fa-bell me-2"></i>Thông tin nhắc nhở
                                phỏng vấn</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="reminderInterviewDate" class="form-label">Ngày phỏng vấn</label>
                                    <input type="date" class="form-control" id="reminderInterviewDate"
                                           name="reminderInterviewDate">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="reminderInterviewTime" class="form-label">Giờ phỏng vấn</label>
                                    <input type="time" class="form-control" id="reminderInterviewTime"
                                           name="reminderInterviewTime">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="reminderLocation" class="form-label">Địa điểm phỏng vấn</label>
                                    <input type="text" class="form-control" id="reminderLocation"
                                           name="reminderLocation" placeholder="Địa điểm phỏng vấn">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="reminderInterviewer" class="form-label">Người phỏng vấn</label>
                                    <input type="text" class="form-control" id="reminderInterviewer"
                                           name="reminderInterviewer" placeholder="Tên người phỏng vấn">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="reminderNotes" class="form-label">Ghi chú bổ sung</label>
                                <textarea class="form-control" id="reminderNotes" name="reminderNotes" rows="3"
                                          placeholder="Những lưu ý quan trọng cho ứng viên..."></textarea>
                            </div>
                        </div>

                        <!-- Rejection Fields -->
                        <div id="rejectionFields" class="additional-field-group" style="display: none;">
                            <h6 class="mb-3 text-danger"><i class="fas fa-times-circle me-2"></i>Thông tin từ
                                chối</h6>
                            <div class="mb-3">
                                <label for="rejectionReason" class="form-label">Lý do từ chối</label>
                                <select class="form-select" id="rejectionReason" name="rejectionReason">
                                    <option value="">-- Chọn lý do --</option>
                                    <option value="Không phù hợp với yêu cầu công việc">Không phù hợp với yêu
                                        cầu công việc</option>
                                    <option value="Thiếu kinh nghiệm cần thiết">Thiếu kinh nghiệm cần thiết
                                    </option>
                                    <option value="Kỹ năng không đáp ứng yêu cầu">Kỹ năng không đáp ứng yêu cầu
                                    </option>
                                    <option value="Đã chọn ứng viên khác phù hợp hơn">Đã chọn ứng viên khác phù
                                        hợp hơn</option>
                                    <option value="Vị trí đã được lấp đầy">Vị trí đã được lấp đầy</option>
                                    <option value="Khác">Khác</option>
                                </select>
                            </div>
                            <div class="mb-3" id="customRejectionReasonDiv" style="display: none;">
                                <label for="customRejectionReason" class="form-label">Lý do cụ thể</label>
                                <textarea class="form-control" id="customRejectionReason"
                                          name="customRejectionReason" rows="3"
                                          placeholder="Mô tả chi tiết lý do từ chối..."></textarea>
                            </div>

                        </div>

                        <!-- Offer Fields -->
                        <div id="offerFields" class="additional-field-group" style="display: none;">
                            <h6 class="mb-3 text-success"><i class="fas fa-handshake me-2"></i>Thông tin lời mời
                                làm việc</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="salaryOffer" class="form-label">Mức lương đề xuất</label>
                                    <input type="text" class="form-control" id="salaryOffer" name="salaryOffer"
                                           placeholder="Ví dụ: 15,000,000 VND/tháng">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="workingTime" class="form-label">Thời gian làm việc</label>
                                    <input type="text" class="form-control" id="workingTime" name="workingTime"
                                           placeholder="Ví dụ: 8 giờ/ngày, Thứ 2 - Thứ 6">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="workLocation" class="form-label">Địa điểm làm việc</label>
                                    <input type="text" class="form-control" id="workLocation"
                                           name="workLocation" placeholder="Địa chỉ văn phòng làm việc">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="responseDeadline" class="form-label">Hạn phản hồi (ngày)</label>
                                    <input type="number" class="form-control" id="responseDeadline"
                                           name="responseDeadline" placeholder="7" min="1" max="30">
                                </div>

                            </div>

                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 justify-content-end">
                        <button type="button" class="btn btn-secondary" onclick="goBack()">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </button>
                        <button type="submit" class="btn btn-primary" id="sendButton">
                            <i class="fas fa-paper-plane me-2"></i>Gửi Email
                            <span class="loading-spinner ms-2">
                                <i class="fas fa-spinner fa-spin"></i>
                            </span>
                        </button>
                    </div>
                </form>
            </div>



            <!-- Email Status -->
            <div id="emailStatus" class="email-status"></div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            // Initialize TinyMCE
                            tinymce.init({
                                selector: '#emailContent',
                                height: 400,
                                plugins: [
                                    'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                                    'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
                                    'insertdatetime', 'media', 'table', 'help', 'wordcount'
                                ],
                                toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
                                content_style: 'body { font-family: Arial, sans-serif; font-size: 14px; }',
                                setup: function (editor) {
                                    editor.on('change', function () {
                                        updatePreview();
                                    });
                                }
                            });

                            // Email type change handler
                            document.getElementById('emailType').addEventListener('change', function () {
                                const emailType = this.value;
                                const customFields = document.getElementById('customEmailFields');
                                const additionalFields = document.getElementById('additionalFields');
                                const templateSection = document.getElementById('templateSection');

                                // Hide all additional field groups first
                                document.querySelectorAll('.additional-field-group').forEach(group => {
                                    group.style.display = 'none';
                                });

                                if (emailType) {
                                    if (emailType === 'custom') {
                                        customFields.style.display = 'block';
                                        additionalFields.style.display = 'none';
                                        templateSection.style.display = 'block';
                                        document.getElementById('subject').required = true;
                                        document.getElementById('emailContent').required = true;
                                        // Load custom email template
                                        loadTemplates(emailType);
                                    } else {
                                        customFields.style.display = 'none';
                                        additionalFields.style.display = 'block';
                                        templateSection.style.display = 'block';
                                        document.getElementById('subject').required = false;
                                        document.getElementById('emailContent').required = false;

                                        // Show specific additional fields based on email type
                                        switch (emailType) {
                                            case 'interview_invitation':
                                                document.getElementById('interviewInvitationFields').style.display = 'block';
                                                break;
                                            case 'interview_reminder':
                                                document.getElementById('interviewReminderFields').style.display = 'block';
                                                break;
                                            case 'rejection':
                                                document.getElementById('rejectionFields').style.display = 'block';
                                                break;
                                            case 'offer':
                                                document.getElementById('offerFields').style.display = 'block';
                                                break;
                                        }

                                        loadTemplates(emailType);
                                    }
                                } else {
                                    customFields.style.display = 'none';
                                    additionalFields.style.display = 'none';
                                    templateSection.style.display = 'none';
                                }
                            });

                            // Load email templates from database by type
                            function loadTemplates(emailType) {
                                const templateList = document.getElementById('templateList');
                                const templateHeader = document.getElementById('templateHeader');

                                // Update template header with email type
                                const emailTypeLabels = {
                                    'application_received': 'Xác nhận nhận hồ sơ',
                                    'interview_invitation': 'Lời mời phỏng vấn',
                                    'rejection': 'Thư từ chối',
                                    'offer': 'Lời mời làm việc',
                                    'custom': 'Email tùy chỉnh'
                                };

                                const emailTypeLabel = emailTypeLabels[emailType] || emailType;
                                templateHeader.textContent = emailTypeLabel;

                                templateList.innerHTML = '<div class="text-center"><i class="fas fa-spinner fa-spin"></i> Đang tải templates...</div>';

                                if (window.debugMode) {
                                    console.log('Loading templates for type:', emailType);
                                }

                                // Load templates from server
                                fetch('load-email-templates?emailType=' + encodeURIComponent(emailType))
                                        .then(response => {
                                            if (window.debugMode) {
                                                console.log('Response status:', response.status);
                                                console.log('Response headers:', response.headers);
                                            }

                                            if (!response.ok) {
                                                throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                                            }
                                            return response.text();
                                        })
                                        .then(text => {
                                            if (window.debugMode) {
                                                console.log('Raw response:', text);
                                            }

                                            try {
                                                const templates = JSON.parse(text);
                                                if (templates.error) {
                                                    throw new Error(templates.error);
                                                }
                                                displayTemplates(templates);
                                            } catch (parseError) {
                                                console.error('JSON parse error:', parseError);
                                                console.error('Response text:', text);
                                                throw new Error('Invalid JSON response from server');
                                            }
                                        })
                                        .catch(error => {
                                            console.error('Error loading templates:', error);
                                            templateList.innerHTML = `
                            <div class="text-center text-danger">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                Lỗi khi tải templates: ${error.message}
                                <br><small>Email Type: ${emailType}</small>
                                <br><small>Vui lòng kiểm tra console để biết thêm chi tiết.</small>
                                <br><small><a href="test-email-templates" target="_blank">Kiểm tra dữ liệu database</a></small>
                            </div>
                        `;
                                        });
                            }

                            // Display templates by name
                            function displayTemplates(templates) {
                                const templateList = document.getElementById('templateList');

                                if (templates.length === 0) {
                                    templateList.innerHTML = '<div class="text-center text-muted">Không có template nào cho loại email này.</div>';
                                    return;
                                }

                                let html = '';
                                templates.forEach(template => {
                                    // Escape single quotes in template name to prevent JavaScript errors
                                    const escapedTemplateName = template.templateName.replace(/'/g, "\\'");
                                    html += `
            <div class="template-item" data-template-name="${template.templateName}" onclick="selectTemplate('${escapedTemplateName}')">
                <div class="template-title">${template.templateName}</div>
                <div class="template-desc">Click để chọn template này</div>
            </div>
        `;
                                });

                                templateList.innerHTML = html;
                            }

                            // Select template by name
                            function selectTemplate(templateName) {
                                // Remove previous selection
                                document.querySelectorAll('.template-item').forEach(item => {
                                    item.classList.remove('selected');
                                });

                                // Add selection to clicked item
                                event.currentTarget.classList.add('selected');

                                // Load template content from server
                                fetch('load-email-templates?emailType=' + encodeURIComponent(document.getElementById('emailType').value))
                                        .then(response => response.json())
                                        .then(templates => {
                                            const template = templates.find(t => t.templateName === templateName);
                                            if (template) {
                                                const emailType = document.getElementById('emailType').value;

                                                if (emailType === 'custom') {
                                                    // For custom email, just set the template structure
                                                    document.getElementById('subject').value = '';
                                                    tinymce.get('emailContent').setContent('');
                                                } else {
                                                    // For other email types, process the template
                                                    document.getElementById('subject').value = processTemplate(template.subject);
                                                    tinymce.get('emailContent').setContent(processTemplate(template.bodyHtml));
                                                }

                                                // Update preview after a short delay to ensure TinyMCE content is set
                                                setTimeout(() => {
                                                    updatePreview();
                                                }, 100);
                                            }
                                        })
                                        .catch(error => {
                                            console.error('Error loading template content:', error);
                                        });
                            }

                            // Process template variables
                            function processTemplate(template) {
                                const variables = {
                                    'candidateName': '${requestScope.candidateName}',
                                    'jobTitle': '${requestScope.jobTitle}',
                                    'companyName': '${requestScope.companyName}',
                                    'applicationDate': new Date().toLocaleDateString('vi-VN'),
                                    'recruiterName': '${requestScope.recruiterName}',
                                    // Interview invitation variables
                                    'interviewDate': getFormValue('interviewDate') || new Date(Date.now() + 2 * 24 * 60 * 60 * 1000).toLocaleDateString('vi-VN'),
                                    'interviewTime': getFormValue('interviewTime') || '09:00',
                                    'location': getFormValue('interviewLocation') || 'Văn phòng công ty',
                                    'interviewerName': getFormValue('interviewerName') || 'Người phỏng vấn',
                                    'interviewType': getFormValue('interviewType') || 'Phỏng vấn trực tiếp',
                                    'duration': getFormValue('interviewDuration') || '60',
                                    // Interview reminder variables
                                    'reminderInterviewDate': getFormValue('reminderInterviewDate') || new Date(Date.now() + 1 * 24 * 60 * 60 * 1000).toLocaleDateString('vi-VN'),
                                    'reminderInterviewTime': getFormValue('reminderInterviewTime') || '09:00',
                                    'reminderLocation': getFormValue('reminderLocation') || 'Văn phòng công ty',
                                    'reminderInterviewer': getFormValue('reminderInterviewer') || 'Người phỏng vấn',
                                    'reminderNotes': getFormValue('reminderNotes') || '',
                                    // Rejection variables
                                    'rejectionReason': getFormValue('rejectionReason') || getFormValue('customRejectionReason') || 'Không phù hợp với yêu cầu công việc',
                                    'futureOpportunities': getFormValue('futureOpportunities') || '',
                                    // Offer variables
                                    'salaryOffer': getFormValue('salaryOffer') || 'Thỏa thuận',
                                    'startDate': getFormValue('startDate') || new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toLocaleDateString('vi-VN'),
                                    'workingTime': getFormValue('workingTime') || '8 giờ/ngày',
                                    'workLocation': getFormValue('workLocation') || 'Văn phòng công ty',
                                    'responseDeadline': getFormValue('responseDeadline') || '7',
                                    'benefits': getFormValue('benefits') || '',
                                    'offerNotes': getFormValue('offerNotes') || ''
                                };

                                let result = template;
                                for (const [key, value] of Object.entries(variables)) {
                                    result = result.replace(new RegExp(`{{${key}}}`, 'g'), value);
                                }

                                return result;
                            }

                            // Helper function to get form values
                            function getFormValue(fieldName) {
                                const element = document.getElementById(fieldName);
                                return element ? element.value : '';
                            }

                            // Update preview
                            function updatePreview() {
                                const subject = document.getElementById('subject').value;
                                const content = tinymce.get('emailContent').getContent();

                                if (subject || content) {
                                    document.getElementById('previewSection').style.display = 'block';
                                    document.getElementById('emailPreview').innerHTML = `
            <div class="mb-3">
                <strong>Tiêu đề:</strong> ${subject}
            </div>
            <div>
                <strong>Nội dung:</strong>
                <div class="mt-2">${content}</div>
            </div>
        `;
                                } else {
                                    document.getElementById('previewSection').style.display = 'none';
                                }
                            }

                            // Form submission
                            document.getElementById('emailForm').addEventListener('submit', function (e) {
                                e.preventDefault();

                                const emailType = document.getElementById('emailType').value;
                                const subject = document.getElementById('subject').value;
                                const emailContent = tinymce.get('emailContent').getContent();

                                // Validate form based on email type
                                if (emailType === 'custom') {
                                    if (!subject || subject.trim() === '') {
                                        showError('Vui lòng nhập tiêu đề email.');
                                        document.getElementById('subject').focus();
                                        return;
                                    }
                                    if (!validateEmailContent(emailContent)) {
                                        showError('Vui lòng nhập nội dung email.');
                                        tinymce.get('emailContent').focus();
                                        return;
                                    }

                                    // Additional validation for custom email
                                    const emailContentValue = tinymce.get('emailContent').getContent();
                                    if (!emailContentValue || emailContentValue.trim() === '' || emailContentValue === '<p></p>') {
                                        showError('Vui lòng nhập nội dung email.');
                                        tinymce.get('emailContent').focus();
                                        return;
                                    }
                                } else if (emailType === '') {
                                    showError('Vui lòng chọn loại email.');
                                    document.getElementById('emailType').focus();
                                    return;
                                }

                                const sendButton = document.getElementById('sendButton');
                                const loadingSpinner = document.querySelector('.loading-spinner');

                                // Copy TinyMCE content to hidden field
                                const emailContentValue = tinymce.get('emailContent').getContent();
                                document.getElementById('emailContentHidden').value = emailContentValue;

                                // Clear any previous status messages
                                document.getElementById('emailStatus').innerHTML = '';

                                // Show loading
                                sendButton.disabled = true;
                                loadingSpinner.style.display = 'inline-block';

                                // Submit form
                                this.submit();
                            });

                            // Go back function
                            function goBack() {
                                window.history.back();
                            }

                            // Helper function to validate email content
                            function validateEmailContent(content) {
                                // Remove HTML tags for validation
                                const tempDiv = document.createElement('div');
                                tempDiv.innerHTML = content;
                                const textContent = tempDiv.textContent || tempDiv.innerText || '';
                                return textContent.trim().length > 0;
                            }

                            // Helper function to show error message
                            function showError(message) {
                                const statusDiv = document.getElementById('emailStatus');
                                statusDiv.innerHTML = `
                    <div class="status-error">
                        <i class="fas fa-exclamation-circle me-2"></i>${message}
                    </div>
                `;
                                statusDiv.scrollIntoView({behavior: 'smooth'});
                            }

                            // Helper function to show success message
                            function showSuccess(message) {
                                const statusDiv = document.getElementById('emailStatus');
                                statusDiv.innerHTML = `
                    <div class="status-success">
                        <i class="fas fa-check-circle me-2"></i>${message}
                    </div>
                `;
                                statusDiv.scrollIntoView({behavior: 'smooth'});
                            }



                            // Test API connection
                            function testApiConnection() {
                                console.log('Testing API connection...');
                                fetch('load-email-templates?emailType=application_received')
                                        .then(response => {
                                            console.log('Response status:', response.status);
                                            console.log('Response headers:', response.headers);
                                            return response.text();
                                        })
                                        .then(text => {
                                            console.log('Response text:', text);
                                            try {
                                                const json = JSON.parse(text);
                                                console.log('Parsed JSON:', json);
                                            } catch (e) {
                                                console.error('Failed to parse JSON:', e);
                                            }
                                        })
                                        .catch(error => {
                                            console.error('API test failed:', error);
                                        });
                            }

                            // Initialize preview on page load
                            document.addEventListener('DOMContentLoaded', function () {
                                updatePreview();

                                // Handle rejection reason selection
                                document.getElementById('rejectionReason').addEventListener('change', function () {
                                    const customReasonDiv = document.getElementById('customRejectionReasonDiv');
                                    if (this.value === 'Khác') {
                                        customReasonDiv.style.display = 'block';
                                        document.getElementById('customRejectionReason').required = true;
                                    } else {
                                        customReasonDiv.style.display = 'none';
                                        document.getElementById('customRejectionReason').required = false;
                                    }
                                });

                                // Add event listeners for form fields to update preview
                                const formFields = [
                                    'interviewDate', 'interviewTime', 'interviewLocation', 'interviewerName', 'interviewType', 'interviewDuration',
                                    'reminderInterviewDate', 'reminderInterviewTime', 'reminderLocation', 'reminderInterviewer', 'reminderNotes',
                                    'rejectionReason', 'customRejectionReason', 'futureOpportunities',
                                    'salaryOffer', 'startDate', 'workingTime', 'workLocation', 'responseDeadline', 'benefits', 'offerNotes'
                                ];

                                formFields.forEach(fieldName => {
                                    const element = document.getElementById(fieldName);
                                    if (element) {
                                        element.addEventListener('input', updatePreview);
                                        element.addEventListener('change', updatePreview);
                                    }
                                });

                                // Test API connection on page load (for debugging)
                                // Uncomment the line below to test API connection
                                // testApiConnection();

                                // Enable debug mode (uncomment to enable)
                                // window.debugMode = true;
                            });
        </script>
    </body>

</html>