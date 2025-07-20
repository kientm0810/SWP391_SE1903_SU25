<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Kinh Nghiệm Làm Việc | JobFinding</title>
    
    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
    
    <style>
        .text-primary {
            color: #28a745 !important;
        }
        
        .btn-primary {
            color: #ffffff !important;
            background-color: #28a745 !important;
            border-color: #28a745 !important;
        }
        
        .btn-primary:hover {
            background-color: #218838 !important;
            border-color: #1e7e34 !important;
        }
        
        .form-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(40, 167, 69, 0.1);
            margin-bottom: 30px;
            overflow: hidden;
        }
        
        .section-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 20px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .section-body {
            padding: 30px;
        }
        
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        
        .btn-outline-secondary {
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
        }
    </style>
</head>

<body>
    <%@ include file="header.jsp" %>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Page Header -->
                <div class="text-center mb-4">
                    <h2 class="text-primary"><i class="fas fa-briefcase me-2"></i>Thêm Kinh Nghiệm Làm Việc</h2>
                    <p class="text-muted">Cung cấp thông tin chi tiết về kinh nghiệm làm việc của bạn</p>
                </div>
                
                <!-- Experience Form -->
                <div class="form-section">
                    <div class="section-header">
                        <i class="fas fa-briefcase fa-lg"></i>
                        <h4 class="mb-0">Thông Tin Kinh Nghiệm</h4>
                    </div>
                    
                    <div class="section-body">
                        <form method="post" action="profile">
                            <input type="hidden" name="action" value="addExperience">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="position" class="form-label">
                                        <i class="fas fa-user-tie me-2 text-primary"></i>Vị trí công việc *
                                    </label>
                                    <input type="text" class="form-control" id="position" name="position" required
                                           placeholder="VD: Senior Developer, Marketing Manager">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="company" class="form-label">
                                        <i class="fas fa-building me-2 text-primary"></i>Công ty *
                                    </label>
                                    <input type="text" class="form-control" id="company" name="company" required
                                           placeholder="VD: FPT Software, Vietcombank">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="startDate" class="form-label">
                                        <i class="fas fa-calendar-alt me-2 text-primary"></i>Ngày bắt đầu *
                                    </label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="endDate" class="form-label">
                                        <i class="fas fa-calendar-check me-2 text-primary"></i>Ngày kết thúc
                                    </label>
                                    <input type="date" class="form-control" id="endDate" name="endDate">
                                    <div class="form-check mt-2">
                                        <input class="form-check-input" type="checkbox" id="isCurrent" name="isCurrent" value="true">
                                        <label class="form-check-label" for="isCurrent">
                                            Đang làm việc tại đây
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="skillsUsed" class="form-label">
                                    <i class="fas fa-code me-2 text-primary"></i>Kỹ năng sử dụng
                                </label>
                                <input type="text" class="form-control" id="skillsUsed" name="skillsUsed"
                                       placeholder="VD: Java, Spring Boot, React, MySQL (phân cách bằng dấu phẩy)">
                                <div class="form-text">Nhập các kỹ năng, phân cách bằng dấu phẩy</div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="achievements" class="form-label">
                                    <i class="fas fa-trophy me-2 text-primary"></i>Thành tích & Mô tả công việc
                                </label>
                                <textarea class="form-control" id="achievements" name="achievements" rows="4"
                                          placeholder="Mô tả chi tiết về công việc, thành tích và đóng góp của bạn..."></textarea>
                            </div>
                            
                            <!-- Action Buttons -->
                            <div class="d-flex gap-3 justify-content-center">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Lưu Kinh Nghiệm
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
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Disable end date when "currently working" is checked
        document.getElementById('isCurrent').addEventListener('change', function() {
            const endDateInput = document.getElementById('endDate');
            if (this.checked) {
                endDateInput.value = '';
                endDateInput.disabled = true;
            } else {
                endDateInput.disabled = false;
            }
        });
    </script>
</body>
</html> 