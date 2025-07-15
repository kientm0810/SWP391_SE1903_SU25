<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Chứng Chỉ | JobFinding</title>
    
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
                    <h2 class="text-primary"><i class="fas fa-certificate me-2"></i>Thêm Chứng Chỉ</h2>
                    <p class="text-muted">Thêm thông tin về các chứng chỉ và giấy chứng nhận của bạn</p>
                </div>
                
                <!-- Certificate Form -->
                <div class="form-section">
                    <div class="section-header">
                        <i class="fas fa-certificate fa-lg"></i>
                        <h4 class="mb-0">Thông Tin Chứng Chỉ</h4>
                    </div>
                    
                    <div class="section-body">
                        <form method="post" action="profile" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="addCertificate">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="name" class="form-label">
                                        <i class="fas fa-award me-2 text-primary"></i>Tên chứng chỉ *
                                    </label>
                                    <input type="text" class="form-control" id="name" name="name" required
                                           placeholder="VD: AWS Certified Solutions Architect">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="organization" class="form-label">
                                        <i class="fas fa-building me-2 text-primary"></i>Tổ chức cấp *
                                    </label>
                                    <input type="text" class="form-control" id="organization" name="organization" required
                                           placeholder="VD: Amazon Web Services, Microsoft">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="issueDate" class="form-label">
                                        <i class="fas fa-calendar-alt me-2 text-primary"></i>Ngày cấp *
                                    </label>
                                    <input type="date" class="form-control" id="issueDate" name="issueDate" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="expiryDate" class="form-label">
                                        <i class="fas fa-calendar-times me-2 text-primary"></i>Ngày hết hạn
                                    </label>
                                    <input type="date" class="form-control" id="expiryDate" name="expiryDate">
                                    <div class="form-check mt-2">
                                        <input class="form-check-input" type="checkbox" id="noExpiry" name="noExpiry" value="true">
                                        <label class="form-check-label" for="noExpiry">
                                            Không có hạn sử dụng
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="credentialId" class="form-label">
                                    <i class="fas fa-id-card me-2 text-primary"></i>Mã chứng chỉ
                                </label>
                                <input type="text" class="form-control" id="credentialId" name="credentialId"
                                       placeholder="VD: ABC123456789">
                            </div>
                            
                            <div class="mb-3">
                                <label for="credentialUrl" class="form-label">
                                    <i class="fas fa-link me-2 text-primary"></i>URL xác thực
                                </label>
                                <input type="url" class="form-control" id="credentialUrl" name="credentialUrl"
                                       placeholder="https://www.credential.net/...">
                                <div class="form-text">Đường dẫn để xác thực chứng chỉ trực tuyến</div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="certificateImage" class="form-label">
                                    <i class="fas fa-image me-2 text-primary"></i>Hình ảnh chứng chỉ
                                </label>
                                <input type="file" class="form-control" id="certificateImage" name="certificateImage"
                                       accept="image/*">
                                <div class="form-text">Tải lên hình ảnh chứng chỉ (JPG, PNG, GIF - tối đa 5MB)</div>
                            </div>
                            
                            <!-- Action Buttons -->
                            <div class="d-flex gap-3 justify-content-center">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Lưu Chứng Chỉ
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
        // Disable expiry date when "no expiry" is checked
        document.getElementById('noExpiry').addEventListener('change', function() {
            const expiryDateInput = document.getElementById('expiryDate');
            if (this.checked) {
                expiryDateInput.value = '';
                expiryDateInput.disabled = true;
            } else {
                expiryDateInput.disabled = false;
            }
        });
        
        // File upload preview
        document.getElementById('certificateImage').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                if (file.size > 5 * 1024 * 1024) { // 5MB
                    alert('Kích thước file không được vượt quá 5MB');
                    this.value = '';
                    return;
                }
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    // You can add image preview here if needed
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html> 