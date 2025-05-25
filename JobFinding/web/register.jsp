<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #ffe6f0;
            font-family: 'Segoe UI', sans-serif;
        }
        .form-container {
            background: #fff0f5;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 0 20px rgba(255, 105, 180, 0.2);
        }
        h3 {
            color: #d63384;
        }
        .form-control, .form-select, textarea {
            border-radius: 12px;
            border: 1px solid #f5c2d7;
        }
        .form-control:focus, .form-select:focus, textarea:focus {
            box-shadow: 0 0 5px #ff99cc;
            border-color: #ff66b2;
        }
        .btn-primary {
            background-color: #ff69b4;
            border-color: #ff69b4;
            border-radius: 12px;
        }
        .btn-primary:hover {
            background-color: #ff1493;
            border-color: #ff1493;
        }
        .alert {
            border-radius: 12px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="mx-auto form-container" style="max-width: 600px;">
        <h3 class="mb-4 text-center">Đăng ký tài khoản</h3>
        <form method="post" action="register">
            <div class="mb-3">
                <input class="form-control" name="username" placeholder="Tên đăng nhập" required>
            </div>
            <div class="mb-3">
                <input class="form-control" type="password" name="password" placeholder="Mật khẩu" required>
            </div>
            <div class="mb-3">
                <input class="form-control" type="email" name="email" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input class="form-control" name="fullName" placeholder="Họ tên" required>
            </div>
            <div class="mb-3">
                <input class="form-control" name="phone" placeholder="Số điện thoại" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Ngày sinh</label>
                <input class="form-control" name="dob" type="date" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Giới tính</label>
                <select class="form-select" name="gender" required>
                    <option value="">-- Chọn giới tính --</option>
                    <option value="Nam">Nam</option>
                    <option value="Nữ">Nữ</option>
                    <option value="Khác">Khác</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Địa chỉ</label>
                <textarea class="form-control" name="address" placeholder="Địa chỉ" required></textarea>
            </div>
            
            <!-- Additional fields for recruiters -->
            <div id="recruiterFields" style="display: none;">
                <div class="mb-3">
                    <label class="form-label">Tên công ty</label>
                    <input class="form-control" name="companyName" placeholder="Tên công ty">
                </div>
                <div class="mb-3">
                    <label class="form-label">Mô tả công ty</label>
                    <textarea class="form-control" name="companyDescription" placeholder="Mô tả công ty"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Địa chỉ công ty</label>
                    <textarea class="form-control" name="companyAddress" placeholder="Địa chỉ công ty"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Quy mô công ty</label>
                    <input class="form-control" name="companySize" placeholder="Quy mô công ty">
                </div>
                <div class="mb-3">
                    <label class="form-label">Ngành nghề</label>
                    <input class="form-control" name="industry" placeholder="Ngành nghề">
                </div>
                <div class="mb-3">
                    <label class="form-label">Mã số thuế</label>
                    <input class="form-control" name="taxCode" placeholder="Mã số thuế">
                </div>
            </div>
            
            <!-- Additional fields for job seekers -->
            <div id="jobSeekerFields" style="display: none;">
                <div class="mb-3">
                    <label class="form-label">Kỹ năng</label>
                    <textarea class="form-control" name="skills" placeholder="Kỹ năng của bạn"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Số năm kinh nghiệm</label>
                    <input class="form-control" type="number" name="experienceYears" placeholder="Số năm kinh nghiệm">
                </div>
                <div class="mb-3">
                    <label class="form-label">Học vấn</label>
                    <textarea class="form-control" name="education" placeholder="Trình độ học vấn"></textarea>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Vai trò</label>
                <select class="form-select" name="role" id="roleSelect" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="job_seeker">Người tìm việc</option>
                    <option value="recruiter">Nhà tuyển dụng</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Đăng ký</button>

            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success mt-3">${message}</div>
            </c:if>
        </form>
    </div>
</div>

<script>
    // Show/hide additional fields based on role selection
    document.getElementById('roleSelect').addEventListener('change', function() {
        const role = this.value;
        document.getElementById('recruiterFields').style.display = role === 'recruiter' ? 'block' : 'none';
        document.getElementById('jobSeekerFields').style.display = role === 'job_seeker' ? 'block' : 'none';
    });
</script>
</body>
</html>