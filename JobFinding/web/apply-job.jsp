<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

            .apply-cv-select {
                border: 2px solid #00b14f;
                border-radius: 12px;
                background: #f6fff9;
                padding: 18px 20px 18px 20px;
                margin-bottom: 18px;
                position: relative;
            }

            .apply-cv-select .apply-radio {
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

            .apply-cv-select .fa-check-circle {
                color: #00b14f;
                font-size: 1.3rem;
            }

            .apply-cv-select .fa-file-alt {
                color: #00b14f;
                font-size: 2.2rem;
                margin-bottom: 8px;
            }

            .apply-cv-select select.form-select {
                border: 1.5px solid #00b14f;
                border-radius: 8px;
                margin-top: 8px;
                margin-bottom: 8px;
                padding: 8px 12px;
            }

            .apply-cv-select select.form-select:focus {
                border-color: #00b14f;
                box-shadow: 0 0 0 0.2rem rgba(0, 177, 79, .15);
            }

            .apply-cv-select .create-cv-link {
                color: #00b14f;
                text-decoration: none;
                font-weight: 500;
            }

            .apply-cv-select .create-cv-link:hover {
                color: #00913d;
                text-decoration: underline;
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

            .no-cv-message {
                text-align: center;
                padding: 20px;
                background: #fff3cd;
                border: 1px solid #ffeaa7;
                border-radius: 8px;
                margin-bottom: 18px;
            }

            .no-cv-message .alert-icon {
                color: #856404;
                font-size: 2rem;
                margin-bottom: 10px;
            }
        </style>
    </head>

    <body>
        <div class="apply-overlay">
            <form class="modal-content p-0 apply-popup" method="POST" action="${pageContext.request.contextPath}/apply">
                <input type="hidden" name="postId" value="${post.id}">

                <div class="modal-header">
                    <span class="apply-radio"><i class="fas fa-check-circle"></i></span>
                    <span class="modal-title"><i class="fas fa-paper-plane" style="color:#00b14f;"></i> Ứng tuyển
                        <span class="job-title">
                            <c:out value="${post.title}" />
                        </span>
                    </span>
                </div>

                <div class="modal-body p-4">
                    <c:choose>
                        <c:when test="${not empty cvList}">
                            <div class="apply-cv-select">
                                <label for="cvId" class="form-label fw-bold">Chọn CV để ứng tuyển <span class="apply-required">*</span></label>
                                <select class="form-select" id="cvId" name="cvId" required>
                                    <c:forEach items="${cvList}" var="cv">
                                        <option value="${cv.id}">${cv.jobPosition} - ${cv.fullName}</option>
                                    </c:forEach>
                                </select>
                                <div class="text-center mt-3">
                                    hoặc <a href="${pageContext.request.contextPath}/create_cv.jsp" target="_blank" class="create-cv-link">Tạo CV mới</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-cv-message">
                                <div class="alert-icon"><i class="fas fa-file-excel"></i></div>
                                <h5 class="fw-bold">Bạn chưa có CV nào</h5>
                                <p class="mb-0">Vui lòng tạo một CV để ứng tuyển.</p>
                                <a href="${pageContext.request.contextPath}/create_cv.jsp" target="_blank" class="btn btn-primary mt-3">
                                    <i class="fas fa-plus me-2"></i>Tạo CV mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="modal-footer">
                     <c:if test="${not empty cvList}">
                        <button type="submit" class="btn btn-success">Nộp hồ sơ ứng tuyển</button>
                     </c:if>
                </div>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>