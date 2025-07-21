# Form Gửi Email - Hướng dẫn sử dụng

## Tổng quan
Form gửi email cho phép Recruiter gửi email tùy chỉnh hoặc sử dụng template có sẵn để liên lạc với Job Seeker.

## Cách truy cập

### 1. Từ trang Quản lý Ứng tuyển
1. Đăng nhập với tài khoản Recruiter
2. Vào trang "Đơn ứng tuyển nhận được" (`/recruiter-applications`)
3. Click "Xem Chi Tiết" trên ứng viên cần gửi email
4. Trong modal, click nút "Gửi Email" (màu xanh dương)
5. Hệ thống sẽ chuyển đến form gửi email với thông tin ứng viên đã được điền sẵn

### 2. Truy cập trực tiếp
```
/send-custom-email?recipientEmail=email@example.com&candidateName=Nguyen Van A&jobTitle=Developer&companyName=ABC Company&applicationId=123
```

## Tính năng chính

### 1. Thông tin người nhận
Form tự động hiển thị thông tin ứng viên:
- **Tên ứng viên**: Lấy từ database
- **Email**: Địa chỉ email sẽ nhận
- **Vị trí**: Tên công việc ứng tuyển
- **Công ty**: Tên công ty đăng tin

### 2. Loại email

#### A. Email tùy chỉnh
- **Chọn**: "Email tùy chỉnh" trong dropdown
- **Nhập**: Tiêu đề và nội dung tùy ý
- **Sử dụng**: TinyMCE editor với đầy đủ tính năng format

#### B. Email template
- **Chọn**: Loại template từ dropdown
- **Templates có sẵn**:
  - `application_reviewed` - Thông báo đã xem hồ sơ
  - `interview_invitation` - Mời phỏng vấn
  - `interview_completed` - Cảm ơn tham gia phỏng vấn
  - `application_rejection` - Thông báo từ chối
  - `application_acceptance` - Thông báo chấp nhận

### 3. Xem trước email
- **Tự động**: Hiển thị preview khi nhập nội dung
- **Real-time**: Cập nhật ngay khi thay đổi
- **Format**: Hiển thị đúng như email sẽ gửi

### 4. Gửi email
- **Validation**: Kiểm tra đầy đủ thông tin trước khi gửi
- **Loading**: Hiển thị spinner khi đang gửi
- **Kết quả**: Thông báo thành công/thất bại
- **Lịch sử**: Lưu vào Email_History

## Giao diện

### 1. Header
- **Tiêu đề**: "Gửi Email"
- **Mô tả**: "Gửi email thông báo tùy chỉnh cho ứng viên"
- **Gradient**: Màu xanh tím đẹp mắt

### 2. Thông tin người nhận
- **Background**: Màu xanh nhạt
- **Layout**: Flexbox responsive
- **Icons**: Font Awesome cho từng thông tin

### 3. Form chính
- **Loại email**: Dropdown với validation
- **Template section**: Hiển thị/ẩn theo loại email
- **Custom fields**: Subject và Content với TinyMCE
- **Buttons**: Quay lại và Gửi Email

### 4. Preview section
- **Background**: Màu xám nhạt
- **Content**: Hiển thị email sẽ gửi
- **Real-time**: Cập nhật khi thay đổi

## Các file liên quan

### Frontend
- `web/send-email.jsp` - Giao diện form gửi email
- `web/recruiter-applications.jsp` - Nút "Gửi Email" trong modal

### Backend
- `src/java/controllers/SendCustomEmailController.java` - Xử lý logic gửi email
- `src/java/daos/EmailTemplateDAO.java` - Quản lý email templates
- `src/java/daos/EmailHistoryDAO.java` - Lưu lịch sử email
- `src/java/utils/JavaMail.java` - Gửi email thực tế

### Database
- `Email_Templates` - Bảng chứa templates
- `Email_History` - Bảng lưu lịch sử email

## Luồng hoạt động

### 1. Truy cập form
```
Recruiter click "Gửi Email" → SendCustomEmailController.doGet() → send-email.jsp
```

### 2. Chọn loại email
```
User chọn loại email → JavaScript hiển thị/ẩn fields → Load templates (nếu cần)
```

### 3. Nhập nội dung
```
User nhập subject/content → TinyMCE format → Real-time preview
```

### 4. Gửi email
```
User click "Gửi Email" → SendCustomEmailController.doPost() → Validation → Send email → Save history → Redirect
```

## Tính năng nâng cao

### 1. TinyMCE Editor
- **Rich text**: Bold, italic, lists, links, images
- **HTML**: Hỗ trợ HTML tags
- **Auto-save**: Tự động lưu draft
- **Preview**: Xem trước real-time

### 2. Template System
- **Variables**: {{candidate_name}}, {{job_title}}, {{company_name}}
- **Auto-replace**: Tự động thay thế variables
- **Database**: Templates lưu trong database
- **Dynamic**: Load templates theo loại email

### 3. Validation
- **Client-side**: JavaScript validation
- **Server-side**: Java validation
- **Required fields**: Kiểm tra bắt buộc
- **Email format**: Validate email address

### 4. Error Handling
- **User-friendly**: Thông báo lỗi dễ hiểu
- **Logging**: Log lỗi chi tiết
- **Fallback**: Xử lý lỗi gracefully
- **Recovery**: Hướng dẫn khắc phục

## Cấu hình

### 1. SMTP Settings
```java
// Constants.java
SMTP_HOST = "smtp.gmail.com"
SMTP_PORT = 587
EMAIL_FROM = "longrpk200313@gmail.com"
EMAIL_USERNAME = "longrpk200313@gmail.com"
EMAIL_PASSWORD = "gphi fyvo kxdf pgfr"
```

### 2. TinyMCE Configuration
```javascript
tinymce.init({
    selector: '#emailContent',
    height: 400,
    plugins: ['advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview'],
    toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright | bullist numlist',
    content_style: 'body { font-family: Arial, sans-serif; font-size: 14px; }'
});
```

## Troubleshooting

### Email không gửi được
1. Kiểm tra cấu hình SMTP
2. Kiểm tra kết nối internet
3. Xem log lỗi trong console
4. Kiểm tra email address có đúng format

### Template không load
1. Kiểm tra database có templates
2. Kiểm tra template_type có đúng
3. Xem log lỗi trong console
4. Refresh page và thử lại

### TinyMCE không hoạt động
1. Kiểm tra file tinymce.min.js có tồn tại
2. Kiểm tra console có lỗi JavaScript
3. Kiểm tra selector có đúng
4. Refresh page và thử lại

## Tương lai

### Tính năng có thể mở rộng
- **Email scheduling**: Lập lịch gửi email
- **Bulk email**: Gửi email hàng loạt
- **Email tracking**: Theo dõi email đã đọc
- **Attachment**: Đính kèm file
- **Signature**: Chữ ký email tự động
- **Auto-save**: Tự động lưu draft
- **Email templates**: Quản lý templates
- **Email analytics**: Thống kê email

## Lợi ích

### Cho Recruiter
- **Linh hoạt**: Gửi email tùy chỉnh hoặc dùng template
- **Tiết kiệm thời gian**: Form tự động điền thông tin
- **Chuyên nghiệp**: Giao diện đẹp, dễ sử dụng
- **Theo dõi**: Lịch sử email đầy đủ

### Cho Job Seeker
- **Phản hồi nhanh**: Nhận email ngay lập tức
- **Thông tin rõ ràng**: Nội dung email chi tiết
- **Chuyên nghiệp**: Email format đẹp
- **Trải nghiệm tốt**: Cảm giác được quan tâm 