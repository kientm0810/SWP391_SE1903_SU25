<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Giải Thưởng | JobFinding</title>
    
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
                    <h2 class="text-primary"><i class="fas fa-trophy me-2"></i>Thêm Giải Thưởng</h2>
                    <p class="text-muted">Thêm thông tin về các giải thưởng và thành tích của bạn</p>
                </div>
                
                <!-- Award Form -->
                <div class="form-section">
                    <div class="section-header">
                        <i class="fas fa-trophy fa-lg"></i>
                        <h4 class="mb-0">Thông Tin Giải Thưởng</h4>
                    </div>
                    
                    <div class="section-body">
                        <form method="post" action="profile">
                            <input type="hidden" name="action" value="addAward">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="name" class="form-label">
                                        <i class="fas fa-medal me-2 text-primary"></i>Tên giải thưởng *
                                    </label>
                                    <input type="text" class="form-control" id="name" name="name" required
                                           placeholder="VD: Giải nhất cuộc thi lập trình, Học sinh xuất sắc">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="organization" class="form-label">
                                        <i class="fas fa-building me-2 text-primary"></i>Tổ chức trao giải *
                                    </label>
                                    <input type="text" class="form-control" id="organization" name="organization" required
                                           placeholder="VD: Bộ Giáo dục và Đào tạo, FPT Software">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="awardDate" class="form-label">
                                        <i class="fas fa-calendar-alt me-2 text-primary"></i>Ngày nhận giải *
                                    </label>
                                    <input type="date" class="form-control" id="awardDate" name="awardDate" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="level" class="form-label">
                                        <i class="fas fa-layer-group me-2 text-primary"></i>Cấp độ giải thưởng
                                    </label>
                                    <select class="form-select" id="level" name="level">
                                        <option value="">Chọn cấp độ</option>
                                        <option value="Quốc tế">Quốc tế</option>
                                        <option value="Quốc gia">Quốc gia</option>
                                        <option value="Khu vực">Khu vực</option>
                                        <option value="Thành phố/Tỉnh">Thành phố/Tỉnh</option>
                                        <option value="Trường/Công ty">Trường/Công ty</option>
                                        <option value="Khác">Khác</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="rank" class="form-label">
                                        <i class="fas fa-ranking-star me-2 text-primary"></i>Hạng/Vị trí
                                    </label>
                                    <select class="form-select" id="rank" name="rank">
                                        <option value="">Chọn hạng</option>
                                        <option value="Giải nhất">Giải nhất</option>
                                        <option value="Giải nhì">Giải nhì</option>
                                        <option value="Giải ba">Giải ba</option>
                                        <option value="Giải khuyến khích">Giải khuyến khích</option>
                                        <option value="Giải đặc biệt">Giải đặc biệt</option>
                                        <option value="Xuất sắc">Xuất sắc</option>
                                        <option value="Khác">Khác</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="category" class="form-label">
                                        <i class="fas fa-tags me-2 text-primary"></i>Lĩnh vực
                                    </label>
                                    <input type="text" class="form-control" id="category" name="category"
                                           placeholder="VD: Công nghệ thông tin, Kinh doanh, Nghệ thuật">
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="description" class="form-label">
                                    <i class="fas fa-file-alt me-2 text-primary"></i>Mô tả chi tiết
                                </label>
                                <textarea class="form-control" id="description" name="description" rows="4"
                                          placeholder="Mô tả chi tiết về giải thưởng, điều kiện đạt giải, ý nghĩa của giải thưởng..."></textarea>
                            </div>
                            
                            <!-- Action Buttons -->
                            <div class="d-flex gap-3 justify-content-center">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Lưu Giải Thưởng
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
        // Set max date to today for award date
        document.getElementById('awardDate').setAttribute('max', new Date().toISOString().split('T')[0]);
        
        // Dynamic rank options based on common award levels
        document.getElementById('level').addEventListener('change', function() {
            const rankSelect = document.getElementById('rank');
            const selectedLevel = this.value;
            
            // Keep current selection if exists
            const currentRank = rankSelect.value;
            
            // Reset options
            rankSelect.innerHTML = '<option value="">Chọn hạng</option>';
            
            let options = [];
            switch(selectedLevel) {
                case 'Quốc tế':
                case 'Quốc gia':
                    options = ['Giải vàng', 'Giải bạc', 'Giải đồng', 'Giải đặc biệt', 'Xuất sắc'];
                    break;
                case 'Khu vực':
                case 'Thành phố/Tỉnh':
                    options = ['Giải nhất', 'Giải nhì', 'Giải ba', 'Giải khuyến khích', 'Xuất sắc'];
                    break;
                case 'Trường/Công ty':
                    options = ['Nhân viên xuất sắc', 'Sinh viên giỏi', 'Giải nhất', 'Giải nhì', 'Giải ba'];
                    break;
                default:
                    options = ['Giải nhất', 'Giải nhì', 'Giải ba', 'Giải khuyến khích', 'Giải đặc biệt', 'Xuất sắc'];
            }
            
            options.forEach(option => {
                const optElement = document.createElement('option');
                optElement.value = option;
                optElement.textContent = option;
                rankSelect.appendChild(optElement);
            });
            
            // Add "Khác" option
            const otherOption = document.createElement('option');
            otherOption.value = 'Khác';
            otherOption.textContent = 'Khác';
            rankSelect.appendChild(otherOption);
            
            // Restore previous selection if it exists in new options
            if (currentRank && Array.from(rankSelect.options).some(opt => opt.value === currentRank)) {
                rankSelect.value = currentRank;
            }
        });
    </script>
</body>
</html> 