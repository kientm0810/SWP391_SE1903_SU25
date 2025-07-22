<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Học Vấn | JobFinding</title>
    
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
                    <h2 class="text-primary"><i class="fas fa-graduation-cap me-2"></i>Thêm Học Vấn</h2>
                    <p class="text-muted">Thêm thông tin về quá trình học tập và đào tạo của bạn</p>
                </div>
                
                <!-- Education Form -->
                <div class="form-section">
                    <div class="section-header">
                        <i class="fas fa-graduation-cap fa-lg"></i>
                        <h4 class="mb-0">Thông Tin Học Vấn</h4>
                    </div>
                    
                    <div class="section-body">
                        <form method="post" action="profile">
                            <input type="hidden" name="action" value="addEducation">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="degree" class="form-label">
                                        <i class="fas fa-scroll me-2 text-primary"></i>Bằng cấp *
                                    </label>
                                    <select class="form-select" id="degree" name="degree" required>
                                        <option value="">Chọn bằng cấp</option>
                                        <option value="Trung học phổ thông">Trung học phổ thông</option>
                                        <option value="Trung cấp">Trung cấp</option>
                                        <option value="Cao đẳng">Cao đẳng</option>
                                        <option value="Cử nhân">Cử nhân</option>
                                        <option value="Kỹ sư">Kỹ sư</option>
                                        <option value="Thạc sĩ">Thạc sĩ</option>
                                        <option value="Tiến sĩ">Tiến sĩ</option>
                                        <option value="Khác">Khác</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="fieldOfStudy" class="form-label">
                                        <i class="fas fa-book me-2 text-primary"></i>Chuyên ngành *
                                    </label>
                                    <input type="text" class="form-control" id="fieldOfStudy" name="fieldOfStudy" required
                                           placeholder="VD: Công nghệ thông tin, Kinh tế, Marketing">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="institution" class="form-label">
                                    <i class="fas fa-university me-2 text-primary"></i>Trường học *
                                </label>
                                <input type="text" class="form-control" id="institution" name="institution" required
                                       placeholder="VD: Đại học FPT, Đại học Bách Khoa Hà Nội">
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
                                            Đang học
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="gpa" class="form-label">
                                        <i class="fas fa-star me-2 text-primary"></i>GPA/Điểm trung bình
                                    </label>
                                    <input type="number" class="form-control" id="gpa" name="gpa" 
                                           step="0.01" min="0" max="10"
                                           placeholder="VD: 8.5">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="maxGpa" class="form-label">
                                        <i class="fas fa-chart-line me-2 text-primary"></i>Thang điểm
                                    </label>
                                    <select class="form-select" id="maxGpa" name="maxGpa">
                                        <option value="">Chọn thang điểm</option>
                                        <option value="4.0">4.0</option>
                                        <option value="10.0">10.0</option>
                                        <option value="100.0">100.0</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="activities" class="form-label">
                                    <i class="fas fa-users me-2 text-primary"></i>Hoạt động ngoại khóa
                                </label>
                                <textarea class="form-control" id="activities" name="activities" rows="3"
                                          placeholder="Mô tả các hoạt động ngoại khóa, thành tích học tập, dự án đã tham gia..."></textarea>
                            </div>
                            
                            <!-- Action Buttons -->
                            <div class="d-flex gap-3 justify-content-center">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Lưu Học Vấn
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
        // Disable end date when "currently studying" is checked
        document.getElementById('isCurrent').addEventListener('change', function() {
            const endDateInput = document.getElementById('endDate');
            if (this.checked) {
                endDateInput.value = '';
                endDateInput.disabled = true;
            } else {
                endDateInput.disabled = false;
            }
        });
        
        // GPA validation
        document.getElementById('gpa').addEventListener('input', function() {
            const maxGpaSelect = document.getElementById('maxGpa');
            const maxGpaValue = parseFloat(maxGpaSelect.value);
            const gpaValue = parseFloat(this.value);
            
            if (maxGpaValue && gpaValue > maxGpaValue) {
                this.setCustomValidity('GPA không được vượt quá thang điểm đã chọn');
            } else {
                this.setCustomValidity('');
            }
        });
        
        document.getElementById('maxGpa').addEventListener('change', function() {
            const gpaInput = document.getElementById('gpa');
            const maxGpaValue = parseFloat(this.value);
            
            if (maxGpaValue) {
                gpaInput.setAttribute('max', maxGpaValue);
            } else {
                gpaInput.removeAttribute('max');
            }
            
            // Trigger validation
            gpaInput.dispatchEvent(new Event('input'));
        });
    </script>
</body>
</html> 