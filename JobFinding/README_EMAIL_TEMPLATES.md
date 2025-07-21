# Hướng dẫn sử dụng Email Templates

## Tổng quan
Hệ thống JobFinding đã được tích hợp tính năng gửi email tự động sử dụng templates có sẵn từ database. Tính năng này cho phép recruiter gửi email thông báo cho ứng viên một cách nhanh chóng và chuyên nghiệp.

## Các loại Email Templates

### 1. Xác nhận nhận hồ sơ (application_received)
- **Mục đích**: Thông báo cho ứng viên biết hồ sơ đã được nhận
- **Biến sử dụng**: `{{candidateName}}`, `{{jobTitle}}`, `{{companyName}}`, `{{applicationDate}}`, `{{recruiterName}}`

### 2. Lời mời phỏng vấn (interview_invitation)
- **Mục đích**: Mời ứng viên tham gia buổi phỏng vấn
- **Biến sử dụng**: `{{candidateName}}`, `{{jobTitle}}`, `{{companyName}}`, `{{interviewDate}}`, `{{interviewTime}}`, `{{location}}`, `{{interviewerName}}`, `{{interviewType}}`, `{{duration}}`, `{{recruiterName}}`

### 3. Nhắc nhở phỏng vấn (interview_reminder)
- **Mục đích**: Nhắc nhở ứng viên về buổi phỏng vấn sắp tới
- **Biến sử dụng**: `{{candidateName}}`, `{{jobTitle}}`, `{{companyName}}`, `{{interviewDate}}`, `{{interviewTime}}`, `{{location}}`, `{{interviewerName}}`, `{{recruiterName}}`

### 4. Thư từ chối (rejection)
- **Mục đích**: Thông báo từ chối ứng viên với lý do cụ thể
- **Biến sử dụng**: `{{candidateName}}`, `{{jobTitle}}`, `{{companyName}}`, `{{rejectionReason}}`, `{{recruiterName}}`

### 5. Lời mời làm việc (offer)
- **Mục đích**: Gửi lời mời làm việc với chi tiết đề nghị
- **Biến sử dụng**: `{{candidateName}}`, `{{jobTitle}}`, `{{companyName}}`, `{{salaryOffer}}`, `{{startDate}}`, `{{workingTime}}`, `{{workLocation}}`, `{{responseDeadline}}`, `{{recruiterName}}`

## Cách sử dụng

### 1. Từ trang Applications
1. Vào trang quản lý applications của recruiter
2. Chọn ứng viên cần gửi email
3. Nhấn nút "Send Email" trong modal
4. Chọn loại email từ dropdown
5. Nếu chọn template, hệ thống sẽ hiển thị danh sách templates có sẵn
6. Chọn template và xem trước nội dung
7. Nhấn "Gửi Email"

### 2. Từ form Send Email
1. Truy cập trực tiếp form gửi email
2. Chọn loại email
3. Chọn template từ danh sách
4. Xem trước và chỉnh sửa nếu cần
5. Gửi email

## Cấu trúc Database

### Bảng Email_Templates
```sql
CREATE TABLE Email_Templates (
    template_id INT PRIMARY KEY IDENTITY(1,1),
    template_name NVARCHAR(255) NOT NULL UNIQUE,
    template_type VARCHAR(50) NOT NULL,
    subject NVARCHAR(500) NOT NULL,
    body_html NTEXT NOT NULL,
    body_text NTEXT,
    variables NVARCHAR(1000),
    is_active BIT DEFAULT 1,
    created_by INT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
```

### Bảng Email_History
```sql
CREATE TABLE Email_History (
    id INT PRIMARY KEY IDENTITY(1,1),
    application_id INT,
    interview_schedule_id INT,
    template_name NVARCHAR(255),
    recipient_email NVARCHAR(255) NOT NULL,
    subject NVARCHAR(500) NOT NULL,
    body_html NTEXT,
    status VARCHAR(50) DEFAULT 'pending',
    error_message NTEXT,
    sent_at DATETIME,
    created_at DATETIME DEFAULT GETDATE()
);
```

### Lưu ý về Template Name
- `template_name` phải là duy nhất trong hệ thống
- Hệ thống sử dụng `template_name` để tìm kiếm và xác định template
- Không nên thay đổi `template_name` sau khi đã được sử dụng để tránh ảnh hưởng đến email history

### Cập nhật Database
Hệ thống đã được cập nhật để chỉ sử dụng `template_name` thay vì `template_id`. Nếu bạn đang sử dụng phiên bản cũ, hãy chạy script SQL sau để cập nhật cấu trúc database:

```sql
-- Chạy file: database/add_template_name_to_email_history.sql
```

**Lưu ý quan trọng:**
- Hệ thống giờ đây chỉ lưu trữ `template_name` trong bảng `Email_History`
- Cột `template_id` đã được loại bỏ để tránh lỗi "Invalid column name"
- Tất cả email history sẽ sử dụng tên template thay vì ID

### Dữ liệu mẫu
Hệ thống đã được cài đặt sẵn 5 templates mẫu:
- Xác nhận nhận hồ sơ
- Lời mời phỏng vấn
- Nhắc nhở phỏng vấn
- Thư từ chối
- Lời mời làm việc

## Tùy chỉnh Templates

### Thêm template mới
1. Thêm dữ liệu vào bảng `Email_Templates`
2. Đảm bảo `template_type` khớp với các loại đã định nghĩa
3. Đảm bảo `template_name` là duy nhất
4. Sử dụng các biến có sẵn trong `variables` field

### Chỉnh sửa template
1. Cập nhật nội dung trong database
2. Template sẽ tự động được cập nhật trong hệ thống

### Vô hiệu hóa template
- Set `is_active = 0` để ẩn template khỏi danh sách

## Biến Template

### Biến cơ bản
- `{{candidateName}}`: Tên ứng viên
- `{{jobTitle}}`: Tên công việc
- `{{companyName}}`: Tên công ty
- `{{recruiterName}}`: Tên recruiter
- `{{applicationDate}}`: Ngày nộp hồ sơ

### Biến phỏng vấn
- `{{interviewDate}}`: Ngày phỏng vấn
- `{{interviewTime}}`: Giờ phỏng vấn
- `{{location}}`: Địa điểm phỏng vấn
- `{{interviewerName}}`: Tên người phỏng vấn
- `{{interviewType}}`: Loại phỏng vấn
- `{{duration}}`: Thời gian dự kiến

### Biến từ chối
- `{{rejectionReason}}`: Lý do từ chối

### Biến offer
- `{{salaryOffer}}`: Mức lương đề nghị
- `{{startDate}}`: Ngày bắt đầu
- `{{workingTime}}`: Thời gian làm việc
- `{{workLocation}}`: Địa điểm làm việc
- `{{responseDeadline}}`: Thời hạn phản hồi

## Troubleshooting

### Lỗi không tải được templates
1. Kiểm tra kết nối database
2. Đảm bảo bảng `Email_Templates` tồn tại
3. Kiểm tra quyền truy cập database

### Lỗi gửi email
1. Kiểm tra cấu hình SMTP trong `Constants.java`
2. Đảm bảo email và password SMTP chính xác
3. Kiểm tra log lỗi trong console

### Template không hiển thị
1. Kiểm tra `is_active = 1` trong database
2. Đảm bảo `template_type` khớp với loại email đã chọn
3. Đảm bảo `template_name` không bị trùng lặp
4. Kiểm tra console browser để xem lỗi JavaScript

### Lỗi "Invalid column name 'template_id'"
1. Chạy script SQL để cập nhật cấu trúc database: `database/add_template_name_to_email_history.sql`
2. Đảm bảo bảng `Email_History` có cột `template_name` và không có cột `template_id`
3. Restart ứng dụng sau khi cập nhật database
4. Hệ thống giờ đây chỉ sử dụng `template_name` thay vì `template_id`

## Tính năng nâng cao

### Email History
- Tất cả email được gửi đều được lưu vào bảng `Email_History`
- Có thể xem lại lịch sử email đã gửi
- Theo dõi trạng thái gửi email

### Preview Email
- Xem trước nội dung email trước khi gửi
- Hỗ trợ HTML formatting
- Hiển thị đầy đủ thông tin người nhận

### Custom Email
- Gửi email tùy chỉnh không theo template
- Sử dụng TinyMCE editor cho nội dung phong phú
- Lưu vào email history

## Liên hệ hỗ trợ
Nếu gặp vấn đề với tính năng email templates, vui lòng liên hệ team phát triển hoặc tạo issue trên repository. 