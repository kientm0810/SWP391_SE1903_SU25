<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Ứng tuyển việc làm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding: 0;
            }

            .apply-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.18);
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
            }

            .apply-popup {
                width: 430px;
                background: #fff;
                border-radius: 18px;
                box-shadow: 0 8px 32px rgba(60, 60, 60, 0.18);
                border: none;
                position: relative;
                animation: popupIn .25s cubic-bezier(.4, 0, .2, 1);
            }

            @keyframes popupIn {
                from {
                    transform: translateY(40px) scale(.98);
                    opacity: 0;
                }

                to {
                    transform: none;
                    opacity: 1;
                }
            }

            .apply-popup .modal-header {
                border-bottom: 2.5px solid #00b14f;
                background: #fff;
                border-radius: 18px 18px 0 0;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                padding: 18px 24px 12px 24px;
            }

            .apply-popup .close-btn {
                position: absolute;
                right: 18px;
                top: 18px;
                background: none;
                border: none;
                font-size: 1.3rem;
                color: #888;
                cursor: pointer;
                transition: color 0.2s;
            }

            .apply-popup .close-btn:hover {
                color: #00b14f;
            }

            .apply-popup .modal-title {
                font-size: 1.15rem;
                font-weight: 600;
                color: #222;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .apply-popup .job-title {
                color: #00b14f;
                font-weight: 700;
            }

            .apply-cv-upload {
                border: 2px dashed #00b14f;
                border-radius: 12px;
                background: #f6fff9;
                padding: 18px 12px 12px 12px;
                text-align: center;
                margin-bottom: 18px;
                position: relative;
            }

            .apply-cv-upload .apply-radio {
                position: absolute;
                left: 18px;
                top: -18px;
                background: #fff;
                border-radius: 50%;
                border: 2.5px solid #00b14f;
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .apply-cv-upload .fa-check-circle {
                color: #00b14f;
                font-size: 1.3rem;
            }

            .apply-cv-upload .fa-upload {
                color: #00b14f;
                font-size: 2.2rem;
                margin-bottom: 8px;
            }

            .apply-cv-upload .btn {
                background: #e8f8f0;
                color: #00b14f;
                border: 1.5px solid #00b14f;
                font-weight: 600;
                border-radius: 6px;
                margin-top: 8px;
                margin-bottom: 4px;
                padding: 6px 18px;
            }

            .apply-cv-upload .btn:hover {
                background: #00b14f;
                color: #fff;
            }

            .apply-popup .form-label {
                font-weight: 500;
            }

            .apply-popup .form-control:focus {
                border-color: #00b14f;
                box-shadow: 0 0 0 0.2rem rgba(0, 177, 79, .15);
            }

            .apply-popup .modal-footer {
                border-top: none;
                justify-content: center;
                gap: 10px;
                padding: 0 24px 24px 24px;
            }

            .apply-popup .btn-success {
                background: #00b14f;
                border: none;
                font-weight: 700;
                padding: 12px 0;
                border-radius: 10px;
                width: 100%;
                font-size: 1.1rem;
                margin-top: 8px;
            }

            .apply-popup .btn-success:hover {
                background: #00913d;
            }

            .apply-popup .btn-secondary {
                background: #e0e0e0;
                color: #222;
                border: none;
                font-weight: 700;
                border-radius: 10px;
                width: 100%;
                font-size: 1.1rem;
            }

            .apply-required {
                color: #e74c3c;
            }

            .apply-note {
                font-size: 0.95rem;
                color: #888;
            }

            .apply-info {
                color: #00b14f;
                font-size: 1rem;
                margin-bottom: 8px;
                font-weight: 500;
            }

            .apply-info-red {
                color: #e74c3c;
                font-size: 0.98rem;
                font-weight: 500;
            }

            .apply-leaf {
                color: #00b14f;
                font-size: 1.2rem;
                margin-right: 4px;
            }

            .apply-popup textarea.form-control {
                min-height: 80px;
            }
        </style>
    </head>

    <body>
        <div class="apply-overlay">
            <div class="modal-content p-0 apply-popup">
                <div class="modal-header">
                    <span class="apply-radio"><i class="fas fa-check-circle"></i></span>
                    <span class="modal-title"><i class="fas fa-paper-plane" style="color:#00b14f;"></i> Ứng tuyển
                        <span class="job-title">
                            <c:out value="${jobTitle != null ? jobTitle : 'Công việc'}" />
                        </span></span>
                    <button class="close-btn" onclick="window.history.back()"><i class="fas fa-times"></i></button>
                </div>
                <form action="${pageContext.request.contextPath}/apply" method="post" enctype="multipart/form-data"
                      id="applyForm">
                    <div class="modal-body p-4">
                        <!-- Chọn CV -->
                        <div class="apply-cv-upload mb-3">
                            <span class="apply-radio"><i class="fas fa-check-circle"></i></span>
                            <i class="fas fa-upload"></i>
                            <div><b>Tải lên CV từ máy tính, chọn hoặc kéo thả</b></div>
                            <input type="file" class="form-control mt-2" name="cvFile" accept=".pdf,.doc,.docx"
                                   required style="display:inline-block;max-width:220px;margin:auto;">
                            <button type="button" class="btn btn-outline-success btn-sm"
                                    onclick="document.querySelector('[name='cvFile']').click();">Chọn CV</button>
                            <div class="apply-note">Hỗ trợ định dạng .doc, .docx, .pdf có kích thước dưới 5MB</div>
                        </div>
                        <div class="apply-info">Vui lòng nhập đầy đủ thông tin chi tiết:</div>
                        <div class="apply-info-red">(*) Thông tin bắt buộc.</div>
                        <!-- Thông tin cá nhân -->
                        <div class="mb-3">
                            <label class="form-label">Họ và tên <span class="apply-required">*</span></label>
                            <input type="text" class="form-control" name="fullName" required
                                   placeholder="Họ tên hiển thị với NTD">
                        </div>
                        <div class="row g-2 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Email <span class="apply-required">*</span></label>
                                <input type="email" class="form-control" name="email" required
                                       placeholder="Email hiển thị với NTD">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại <span
                                        class="apply-required">*</span></label>
                                <input type="text" class="form-control" name="phone" required
                                       placeholder="Số điện thoại hiển thị với NTD">
                            </div>
                        </div>
                        <!-- Thư giới thiệu -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-leaf apply-leaf"></i>Thư giới thiệu:</label>
                            <textarea class="form-control" name="coverLetter" rows="3"
                                      placeholder="Một thư giới thiệu ngắn gọn, chỉn chu sẽ giúp bạn trở nên chuyên nghiệp và gây ấn tượng hơn với nhà tuyển dụng."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="window.history.back()">Hủy</button>
                        <button type="submit" class="btn btn-success">Nộp hồ sơ ứng tuyển</button>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>