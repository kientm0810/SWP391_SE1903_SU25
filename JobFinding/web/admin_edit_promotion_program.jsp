<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa chương trình khuyến mãi - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <jsp:include page="admin-common-styles.jsp" />
    <style>
        .edit-form-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #4caf50;
        }
        
        .form-header h2 {
            color: #2e7d32;
            margin-bottom: 10px;
        }
        
        .program-info-banner {
            background: linear-gradient(135deg, #4caf50 0%, #2e7d32 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .program-info-banner h3 {
            color: white;
            margin-bottom: 10px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            font-weight: bold;
            color: #2e7d32;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #4caf50;
            box-shadow: 0 0 0 3px rgba(76,175,80,0.1);
        }
        
        .form-group .input-group {
            position: relative;
        }
        
        .form-group .input-addon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 14px;
        }
        
        .form-group input.has-addon {
            padding-right: 50px;
        }
        
        .help-text {
            font-size: 13px;
            color: #666;
            margin-top: 5px;
        }
        
        .warning-text {
            font-size: 13px;
            color: #ff9800;
            margin-top: 5px;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }
        
        .btn-save {
            background: #4caf50;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-save:hover {
            background: #45a049;
        }
        
        .btn-cancel {
            background: #6c757d;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-cancel:hover {
            background: #5a6268;
            color: white;
            text-decoration: none;
        }
        
        .error-message {
            background: #ffebee;
            border: 1px solid #f44336;
            color: #c62828;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        
        .success-message {
            background: #e8f5e8;
            border: 1px solid #4caf50;
            color: #2e7d32;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <jsp:include page="sidebar.jsp" />
        
        <div class="main-content">
            <div class="page-header">
                <h1>Chỉnh sửa chương trình khuyến mãi</h1>
                <div class="header-actions">
                    <a href="AdminPromotionController" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại
                    </a>
                </div>
            </div>
            
            <div class="edit-form-container">
                <div class="form-header">
                    <h2>Chỉnh sửa thông tin chương trình</h2>
                    <p>Chỉ có thể thay đổi giá, thời hạn và số lượng</p>
                </div>
                
                <!-- Thông tin chương trình hiện tại -->
                <div class="program-info-banner">
                    <h3>${program.name}</h3>
                    <p>${program.description}</p>
                    <small>Loại: ${program.positionTypeDisplay}</small>
                </div>
                
                <!-- Hiển thị thông báo lỗi/thành công -->
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${errorMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty successMessage}">
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i>
                        ${successMessage}
                    </div>
                </c:if>
                
                <!-- Form chỉnh sửa -->
                <form action="AdminPromotionController" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="service" value="update">
                    <input type="hidden" name="id" value="${program.id}">
                    
                    <div class="form-group">
                        <label for="cost">Giá chương trình (VNĐ) *</label>
                        <div class="input-group">
                            <input type="number" id="cost" name="cost" value="${program.cost}" 
                                   min="0" step="1000" required class="has-addon">
                            <span class="input-addon">VNĐ</span>
                        </div>
                        <div class="help-text">Giá tối thiểu: 0 VNĐ</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="durationDays">Thời hạn (ngày) *</label>
                        <div class="input-group">
                            <input type="number" id="durationDays" name="durationDays" value="${program.durationDays}" 
                                   min="1" max="365" required class="has-addon">
                            <span class="input-addon">ngày</span>
                        </div>
                        <div class="help-text">Từ 1 đến 365 ngày</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="quantity">Số lượng *</label>
                        <input type="number" id="quantity" name="quantity" value="${program.quantity}" 
                               min="-1" required>
                        <div class="help-text">
                            Nhập -1 để không giới hạn số lượng<br>
                            Nhập số dương để giới hạn số lượng
                        </div>
                        <div class="warning-text">
                            <i class="fas fa-warning"></i>
                            Không thể giảm số lượng xuống dưới -1
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-save">
                            <i class="fas fa-save"></i>
                            Lưu thay đổi
                        </button>
                        <a href="AdminPromotionController" class="btn-cancel">
                            <i class="fas fa-times"></i>
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        function validateForm() {
            const cost = document.getElementById('cost').value;
            const durationDays = document.getElementById('durationDays').value;
            const quantity = document.getElementById('quantity').value;
            
            // Validate cost
            if (cost < 0) {
                alert('Giá chương trình không thể âm!');
                return false;
            }
            
            // Validate duration
            if (durationDays < 1 || durationDays > 365) {
                alert('Thời hạn phải từ 1 đến 365 ngày!');
                return false;
            }
            
            // Validate quantity
            if (quantity < -1) {
                alert('Số lượng không thể nhỏ hơn -1!');
                return false;
            }
            
            return confirm('Bạn có chắc chắn muốn lưu các thay đổi này không?');
        }
        
        // Format number input
        document.getElementById('cost').addEventListener('input', function(e) {
            let value = e.target.value.replace(/[^\d]/g, '');
            e.target.value = value;
        });
    </script>
</body>
</html>