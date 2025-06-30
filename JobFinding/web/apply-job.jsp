<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Ứng tuyển việc làm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>

<body>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-3">
            <div class="modal-header">
                <h5 class="modal-title">Ứng tuyển 
                    <c:out value="${jobTitle != null ? jobTitle : 'Công việc'}" />
                </h5>
            </div>
            <form action="${pageContext.request.contextPath}/apply" method="post" enctype="multipart/form-data" id="applyForm">
                <div class="modal-body">
                    <!-- Chọn CV -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">Chọn CV để ứng tuyển</label>
                        <input type="file" class="form-control" name="cvFile" accept=".pdf,.doc,.docx" required>
                        <div class="form-text">Hỗ trợ định dạng .doc, .docx, .pdf (dưới 5MB)</div>
                    </div>
                    <!-- Họ tên, Email, SĐT -->
                    <div class="mb-3">
                        <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="fullName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="phone" required>
                    </div>
                    <!-- Thư giới thiệu -->
                    <div class="mb-3">
                        <label class="form-label">Thư giới thiệu</label>
                        <textarea class="form-control" name="coverLetter" rows="3"
                            placeholder="Một thư giới thiệu ngắn gọn, chuyên nghiệp sẽ giúp bạn nổi bật hơn"></textarea>
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
