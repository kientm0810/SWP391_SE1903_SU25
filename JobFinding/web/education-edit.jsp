<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Học Vấn | JobFinding</title>
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
                    <i class="fas fa-graduation-cap fa-lg"></i>
                    <h3 class="mb-0">Chỉnh sửa Học Vấn</h3>
                </div>
                <div class="section-body">
                    <form method="post" action="profile">
                        <input type="hidden" name="action" value="editEducation">
                        <input type="hidden" name="educationId" value="${edu.id}">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="degree" class="form-label">Bằng cấp <span class="required">*</span></label>
                                <select class="form-select" id="degree" name="degree" required>
                                    <option value="">Chọn bằng cấp</option>
                                    <option value="Trung học phổ thông" ${edu.degree == 'Trung học phổ thông' ? 'selected' : ''}>Trung học phổ thông</option>
                                    <option value="Trung cấp" ${edu.degree == 'Trung cấp' ? 'selected' : ''}>Trung cấp</option>
                                    <option value="Cao đẳng" ${edu.degree == 'Cao đẳng' ? 'selected' : ''}>Cao đẳng</option>
                                    <option value="Cử nhân" ${edu.degree == 'Cử nhân' ? 'selected' : ''}>Cử nhân</option>
                                    <option value="Kỹ sư" ${edu.degree == 'Kỹ sư' ? 'selected' : ''}>Kỹ sư</option>
                                    <option value="Thạc sĩ" ${edu.degree == 'Thạc sĩ' ? 'selected' : ''}>Thạc sĩ</option>
                                    <option value="Tiến sĩ" ${edu.degree == 'Tiến sĩ' ? 'selected' : ''}>Tiến sĩ</option>
                                    <option value="Khác" ${edu.degree == 'Khác' ? 'selected' : ''}>Khác</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="fieldOfStudy" class="form-label">Chuyên ngành <span class="required">*</span></label>
                                <input type="text" class="form-control" id="fieldOfStudy" name="fieldOfStudy" required value="${edu.fieldOfStudy}" placeholder="VD: Công nghệ thông tin, Kinh tế, Marketing">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="institution" class="form-label">Trường học <span class="required">*</span></label>
                            <input type="text" class="form-control" id="institution" name="institution" required value="${edu.institutionName}" placeholder="VD: Đại học FPT, Đại học Bách Khoa Hà Nội">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="startDate" class="form-label">Ngày bắt đầu <span class="required">*</span></label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required value="${edu.startDate}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="endDate" class="form-label">Ngày kết thúc</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" value="${edu.endDate}">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả học vấn</label>
                            <textarea class="form-control" id="description" name="description" rows="3" placeholder="Mô tả chi tiết về quá trình học tập, thành tích, dự án...">${edu.description}</textarea>
                        </div>
                        <div class="mb-4">
                            <label for="activities" class="form-label">Hoạt động ngoại khóa</label>
                            <textarea class="form-control" id="activities" name="activities" rows="3" placeholder="Mô tả các hoạt động ngoại khóa, thành tích học tập, dự án đã tham gia...">${edu.activities}</textarea>
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