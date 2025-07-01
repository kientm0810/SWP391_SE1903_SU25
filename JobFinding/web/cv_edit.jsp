<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa CV | JobFinding</title>

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
    
    <style>
        .file-upload-area {
            border: 2px dashed #dee2e6;
            border-radius: 5px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            background: #f8f9fa;
        }
        
        .file-upload-area:hover {
            border-color: #007bff;
            background: #f0f8ff;
        }
        
        .current-file {
            background: #d4edda;
            border: 2px solid #28a745;
            color: #155724;
        }
        
        .required-field::after {
            content: " *";
            color: #dc3545;
        }
    </style>
</head>

<body>
    <div class="container py-5">
        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${sessionScope.errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">
                                    <i class="fas fa-edit text-primary me-2"></i>
                                    Chỉnh sửa CV
                                </h4>
                                <small class="text-muted">
                                    Tạo: <fmt:formatDate value="${cv.createdAt}" pattern="dd/MM/yyyy HH:mm" /> |
                                    Cập nhật: <fmt:formatDate value="${cv.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
                                </small>
                            </div>
                            <a href="profile" class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                            </a>
                        </div>
                    </div>

                    <div class="card-body">
                        <form id="cvEditForm" method="post" action="cv-edit" enctype="multipart/form-data">
                            <input type="hidden" name="cvId" value="${cv.id}">
                            
                            <!-- Personal Information Section -->
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-user me-2"></i>Thông tin cá nhân
                            </h5>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label required-field">Họ và tên</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" 
                                           value="${cv.fullName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label required-field">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${cv.email}" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="phone" class="form-label required-field">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${cv.phone}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="jobPosition" class="form-label required-field">Vị trí ứng tuyển</label>
                                    <input type="text" class="form-control" id="jobPosition" name="jobPosition" 
                                           value="${cv.jobPosition}" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" id="address" name="address" 
                                       value="${cv.address}"
                                       placeholder="Nhập địa chỉ hiện tại">
                            </div>

                            <!-- Experience & Qualifications Section -->
                            <h5 class="text-primary mb-3 mt-4">
                                <i class="fas fa-briefcase me-2"></i>Kinh nghiệm & Trình độ
                            </h5>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="education" class="form-label">Học vấn</label>
                                    <select class="form-select" id="education" name="education">
                                        <option value="">Chọn trình độ học vấn</option>
                                        <option value="Trung học phổ thông" ${cv.education == 'Trung học phổ thông' ? 'selected' : ''}>Trung học phổ thông</option>
                                        <option value="Cao đẳng" ${cv.education == 'Cao đẳng' ? 'selected' : ''}>Cao đẳng</option>
                                        <option value="Đại học" ${cv.education == 'Đại học' ? 'selected' : ''}>Đại học</option>
                                        <option value="Thạc sĩ" ${cv.education == 'Thạc sĩ' ? 'selected' : ''}>Thạc sĩ</option>
                                        <option value="Tiến sĩ" ${cv.education == 'Tiến sĩ' ? 'selected' : ''}>Tiến sĩ</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="experienceYears" class="form-label">Kinh nghiệm (năm)</label>
                                    <select class="form-select" id="experienceYears" name="experienceYears">
                                        <option value="">Chọn số năm kinh nghiệm</option>
                                        <option value="0" ${cv.experienceYears == 0 ? 'selected' : ''}>Sinh viên mới tốt nghiệp</option>
                                        <option value="1" ${cv.experienceYears == 1 ? 'selected' : ''}>1 năm</option>
                                        <option value="2" ${cv.experienceYears == 2 ? 'selected' : ''}>2 năm</option>
                                        <option value="3" ${cv.experienceYears == 3 ? 'selected' : ''}>3 năm</option>
                                        <option value="4" ${cv.experienceYears == 4 ? 'selected' : ''}>4 năm</option>
                                        <option value="5" ${cv.experienceYears == 5 ? 'selected' : ''}>5 năm</option>
                                        <option value="6" ${cv.experienceYears == 6 ? 'selected' : ''}>Trên 5 năm</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="skills" class="form-label">Kỹ năng</label>
                                <textarea class="form-control" id="skills" name="skills" rows="3"
                                          placeholder="VD: Java, Spring Boot, MySQL, HTML/CSS...">${cv.skills}</textarea>
                                <small class="form-text text-muted">Nhập các kỹ năng, cách nhau bằng dấu phẩy</small>
                            </div>

                            <div class="mb-3">
                                <label for="workExperience" class="form-label">Kinh nghiệm làm việc</label>
                                <textarea class="form-control" id="workExperience" name="workExperience" rows="4"
                                          placeholder="Mô tả về kinh nghiệm làm việc của bạn...">${cv.workExperience}</textarea>
                            </div>

                            <!-- CV File Update Section -->
                            <h5 class="text-primary mb-3 mt-4">
                                <i class="fas fa-upload me-2"></i>Cập nhật file CV (PDF)
                            </h5>

                            <!-- Current File Display -->
                            <c:if test="${not empty cv.pdfFilePath}">
                                <div class="mb-3">
                                    <div class="current-file file-upload-area">
                                        <i class="fas fa-file-pdf fa-2x mb-2"></i>
                                        <p class="mb-2"><strong>File hiện tại:</strong> CV_${cv.jobPosition}.pdf</p>
                                        <div class="d-flex gap-2 justify-content-center">
                                            <a href="${cv.pdfFilePath}" target="_blank" class="btn btn-success btn-sm">
                                                <i class="fas fa-download me-2"></i>Tải xuống
                                            </a>
                                            <button type="button" class="btn btn-warning btn-sm" onclick="showFileUpload()">
                                                <i class="fas fa-edit me-2"></i>Thay đổi file
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- File Upload Area -->
                            <div class="mb-3" id="fileUploadContainer" style="${not empty cv.pdfFilePath ? 'display: none;' : ''}">
                                <div class="file-upload-area" id="fileUploadArea">
                                    <i class="fas fa-cloud-upload-alt fa-2x text-muted mb-2"></i>
                                    <p class="mb-2">Kéo thả file PDF mới vào đây hoặc click để chọn</p>
                                    <small class="text-muted">Chỉ chấp nhận file PDF, tối đa 10MB</small>
                                    <input type="file" class="d-none" id="pdfFile" name="pdfFile" 
                                           accept=".pdf" onchange="handleFileSelect(this)">
                                </div>
                                <div id="selectedFile" class="mt-2 d-none">
                                    <div class="alert alert-success d-flex align-items-center">
                                        <i class="fas fa-file-pdf me-2"></i>
                                        <span id="fileName"></span>
                                        <button type="button" class="btn-close ms-auto" onclick="removeFile()"></button>
                                    </div>
                                </div>
                            </div>

                            <div class="alert alert-info">
                                <small>
                                    <i class="fas fa-info-circle me-2"></i>
                                    <strong>Lưu ý:</strong> Nếu bạn tải lên file PDF mới, file cũ sẽ được thay thế.
                                </small>
                            </div>

                            <!-- Submit Buttons -->
                            <div class="d-flex gap-2 justify-content-end mt-4">
                                <a href="profile" class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-2"></i>Hủy
                                </a>
                                <button type="submit" class="btn btn-primary" id="submitBtn">
                                    <i class="fas fa-save me-2"></i>Cập nhật CV
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // File upload handling
        const fileUploadArea = document.getElementById('fileUploadArea');
        const fileInput = document.getElementById('pdfFile');
        const selectedFileDiv = document.getElementById('selectedFile');
        const fileNameSpan = document.getElementById('fileName');

        fileUploadArea.addEventListener('click', () => fileInput.click());

        fileUploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            fileUploadArea.classList.add('dragover');
        });

        fileUploadArea.addEventListener('dragleave', () => {
            fileUploadArea.classList.remove('dragover');
        });

        fileUploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            fileUploadArea.classList.remove('dragover');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                const file = files[0];
                if (file.type === 'application/pdf') {
                    fileInput.files = files;
                    handleFileSelect(fileInput);
                } else {
                    alert('Chỉ chấp nhận file PDF!');
                }
            }
        });

        function handleFileSelect(input) {
            const file = input.files[0];
            if (file) {
                if (file.type !== 'application/pdf') {
                    alert('Chỉ chấp nhận file PDF!');
                    input.value = '';
                    return;
                }
                
                if (file.size > 10 * 1024 * 1024) { // 10MB
                    alert('File không được vượt quá 10MB!');
                    input.value = '';
                    return;
                }
                
                fileNameSpan.textContent = file.name;
                selectedFileDiv.classList.remove('d-none');
                fileUploadArea.style.display = 'none';
            }
        }

        function removeFile() {
            fileInput.value = '';
            selectedFileDiv.classList.add('d-none');
            fileUploadArea.style.display = 'block';
        }

        function showFileUpload() {
            document.getElementById('fileUploadContainer').style.display = 'block';
        }

        // Form validation
        document.getElementById('cvEditForm').addEventListener('submit', function(e) {
            // Basic validation
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                } else {
                    field.classList.remove('is-invalid');
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                return;
            }
            
            // Show loading state
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang cập nhật...';
            submitBtn.disabled = true;
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert-dismissible');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>

</html> 