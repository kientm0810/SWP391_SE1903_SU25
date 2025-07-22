<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Kinh Nghiệm Làm Việc | JobFinding</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
    <style>
        body { background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%); }
        .form-section { background: #fff; border-radius: 18px; box-shadow: 0 8px 32px rgba(40,167,69,0.10); margin-bottom: 30px; overflow: hidden; }
        .section-header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 24px 32px; display: flex; align-items: center; gap: 18px; border-radius: 18px 18px 0 0; }
        .section-body { padding: 32px; }
        .form-label { font-weight: 600; color: #2c3e50; margin-bottom: 8px; }
        .form-control, .form-select { border-radius: 10px; border: 2px solid #e9ecef; padding: 12px 15px; transition: all 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: #28a745; box-shadow: 0 0 0 0.2rem rgba(40,167,69,0.15); }
        .btn-primary { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); border: none; font-weight: 600; }
        .btn-primary:hover { background: #218838; }
        .btn-outline-secondary { border-radius: 10px; padding: 12px 30px; font-weight: 600; }
        .required { color: #dc3545; }
        @media (max-width: 768px) { .section-body { padding: 16px; } }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="form-section">
                <div class="section-header">
                    <i class="fas fa-briefcase fa-lg"></i>
                    <h3 class="mb-0">Chỉnh sửa Kinh Nghiệm Làm Việc</h3>
                </div>
                <div class="section-body">
                    <form method="post" action="profile">
                        <input type="hidden" name="action" value="editExperience">
                        <input type="hidden" name="experienceId" value="${exp.id}">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="position" class="form-label">Vị trí công việc <span class="required">*</span></label>
                                <input type="text" class="form-control" id="position" name="position" required value="${exp.position}" placeholder="VD: Senior Developer, Marketing Manager">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="company" class="form-label">Công ty <span class="required">*</span></label>
                                <input type="text" class="form-control" id="company" name="company" required value="${exp.companyName}" placeholder="VD: FPT Software, Vietcombank">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="startDate" class="form-label">Ngày bắt đầu <span class="required">*</span></label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required value="${exp.startDate}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="endDate" class="form-label">Ngày kết thúc</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" value="${exp.endDate}">
                                <div class="form-check mt-2">
                                    <input class="form-check-input" type="checkbox" id="isCurrent" name="isCurrent" value="true" ${exp.current ? 'checked' : ''}>
                                    <label class="form-check-label" for="isCurrent">Đang làm việc tại đây</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="skillsUsed" class="form-label">Kỹ năng sử dụng</label>
                            <input type="text" class="form-control" id="skillsUsed" name="skillsUsed" value="${exp.skillsUsed}" placeholder="VD: Java, Spring Boot, React, MySQL (phân cách bằng dấu phẩy)">
                            <div class="form-text">Nhập các kỹ năng, phân cách bằng dấu phẩy</div>
                        </div>
                        <div class="mb-4">
                            <label for="achievements" class="form-label">Thành tích & Mô tả công việc</label>
                            <textarea class="form-control" id="achievements" name="achievements" rows="4" placeholder="Mô tả chi tiết về công việc, thành tích và đóng góp của bạn...">${exp.achievements}</textarea>
                        </div>
                        <div class="d-flex gap-3 justify-content-center">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fas fa-save me-2"></i>Lưu thay đổi
                            </button>
                            <a href="profile" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 