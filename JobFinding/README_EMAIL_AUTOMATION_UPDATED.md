# Chức năng Email Tự động - Cập nhật Trạng thái Ứng tuyển

## Tổng quan
Chức năng email tự động đã được tích hợp vào trang `recruiter-applications.jsp` để tự động gửi email thông báo cho Job Seeker khi Recruiter cập nhật trạng thái ứng tuyển.

## Cách sử dụng

### 1. Truy cập trang Quản lý Ứng tuyển
- Đăng nhập với tài khoản Recruiter
- Vào trang "Đơn ứng tuyển nhận được" (`/recruiter-applications`)

### 2. Cập nhật trạng thái và gửi email
1. Click "Xem Chi Tiết" trên ứng viên cần cập nhật
2. Trong modal, chọn trạng thái mới:
   - **Mới**: Không gửi email
   - **Đã xem**: Gửi email thông báo đã xem hồ sơ
   - **Phỏng vấn**: Gửi email cảm ơn tham gia phỏng vấn
   - **Từ chối**: Nhập lý do → Gửi email từ chối
   - **Mời nhận việc**: Nhập chi tiết đề nghị → Gửi email chấp nhận
3. Click "Cập nhật trạng thái"
4. **Email sẽ được gửi tự động** cho Job Seeker

### 3. Các loại email được gửi

#### Email "Đã xem hồ sơ" (status = reviewed)
- **Template**: `application_reviewed`
- **Nội dung**: Thông báo hồ sơ đã được xem xét
- **Gửi khi**: Recruiter chọn trạng thái "Đã xem"

#### Email "Cảm ơn phỏng vấn" (status = interviewed)
- **Template**: `interview_completed`
- **Nội dung**: Cảm ơn ứng viên đã tham gia phỏng vấn
- **Gửi khi**: Recruiter chọn trạng thái "Phỏng vấn"

#### Email "Từ chối" (status = rejected)
- **Template**: `application_rejection`
- **Nội dung**: Thông báo từ chối với lý do cụ thể
- **Gửi khi**: Recruiter chọn trạng thái "Từ chối" + nhập lý do

#### Email "Chấp nhận" (status = offered)
- **Template**: `application_acceptance`
- **Nội dung**: Thông báo chấp nhận với chi tiết đề nghị
- **Gửi khi**: Recruiter chọn trạng thái "Mời nhận việc" + nhập chi tiết

## Tính năng mới

### 1. Giao diện cải tiến
- **Modal thông tin ứng viên**: Hiển thị đầy đủ thông tin ứng viên
- **Form cập nhật trạng thái**: Giao diện thân thiện với validation
- **Trường nhập liệu động**: Hiển thị/ẩn trường nhập theo trạng thái

### 2. Validation thông minh
- **Bắt buộc nhập lý do**: Khi chọn "Từ chối"
- **Bắt buộc nhập chi tiết**: Khi chọn "Mời nhận việc"
- **Validation real-time**: Kiểm tra ngay khi submit

### 3. Thông báo chi tiết
- **Thông báo thành công**: Bao gồm thông tin email đã gửi
- **Thông báo lỗi**: Chi tiết lỗi nếu có
- **Xác nhận trước khi gửi**: Hiển thị thông tin email sẽ gửi

### 4. Lưu trữ lịch sử
- **Email History**: Lưu trữ tất cả email đã gửi
- **Trạng thái email**: Theo dõi email thành công/thất bại
- **Chi tiết email**: Lưu nội dung và người nhận

## Cấu hình Email

### SMTP Settings (đã cấu hình sẵn)
```java
// Constants.java
SMTP_HOST = "smtp.gmail.com"
SMTP_PORT = 587
EMAIL_FROM = "longrpk200313@gmail.com"
EMAIL_USERNAME = "longrpk200313@gmail.com"
EMAIL_PASSWORD = "gphi fyvo kxdf pgfr"
```

### Email Templates
Tất cả templates đã được tạo sẵn trong database:
- `application_reviewed` - Email đã xem hồ sơ
- `interview_completed` - Email cảm ơn phỏng vấn
- `application_rejection` - Email từ chối
- `application_acceptance` - Email chấp nhận

## Các file đã cập nhật

### Backend
- `src/java/controllers/UpdateApplicationStatusController.java` ✅
  - Tích hợp EmailService
  - Gửi email tự động theo trạng thái
  - Validation và xử lý lỗi

### Frontend
- `web/recruiter-applications.jsp` ✅
  - Modal thông tin ứng viên
  - Form cập nhật trạng thái với validation
  - JavaScript xử lý giao diện động
  - Thông báo thành công/lỗi

### Database
- `database/email_templates.sql` ✅ (đã có sẵn)
- Bảng `Email_Templates` - Templates email
- Bảng `Email_History` - Lịch sử email

## Luồng hoạt động

1. **Recruiter mở modal**: Click "Xem Chi Tiết"
2. **Chọn trạng thái**: Dropdown với 5 lựa chọn
3. **Nhập thông tin bổ sung**: Lý do từ chối hoặc chi tiết đề nghị
4. **Validation**: Kiểm tra dữ liệu trước khi submit
5. **Xác nhận**: Hiển thị thông tin email sẽ gửi
6. **Cập nhật database**: Lưu trạng thái mới
7. **Gửi email**: Tự động gửi email theo template
8. **Lưu lịch sử**: Ghi lại email vào Email_History
9. **Thông báo**: Hiển thị kết quả cho Recruiter

## Lợi ích

### Cho Recruiter
- **Tiết kiệm thời gian**: Không cần gửi email thủ công
- **Chuyên nghiệp**: Email template chuẩn, đẹp
- **Theo dõi**: Lịch sử email đầy đủ
- **Tự động hóa**: Quy trình hoàn toàn tự động

### Cho Job Seeker
- **Phản hồi nhanh**: Nhận email ngay lập tức
- **Thông tin rõ ràng**: Nội dung email chi tiết
- **Chuyên nghiệp**: Email từ công ty thực tế
- **Trải nghiệm tốt**: Cảm giác được quan tâm

## Troubleshooting

### Email không gửi được
1. Kiểm tra cấu hình SMTP trong `Constants.java`
2. Kiểm tra kết nối internet
3. Xem log lỗi trong console server
4. Kiểm tra bảng `Email_History` để xem trạng thái

### Template không tìm thấy
1. Chạy script `database/email_templates.sql`
2. Kiểm tra bảng `Email_Templates` có dữ liệu
3. Kiểm tra `template_type` có đúng không

### Validation lỗi
1. Kiểm tra JavaScript console
2. Đảm bảo đã nhập đầy đủ thông tin bắt buộc
3. Kiểm tra format dữ liệu

## Tương lai

### Tính năng có thể mở rộng
- **Email đa ngôn ngữ**: Hỗ trợ tiếng Anh
- **Template tùy chỉnh**: Recruiter tự tạo template
- **Lập lịch email**: Gửi email theo thời gian
- **Thống kê email**: Dashboard thống kê
- **Webhook**: Tích hợp với hệ thống khác 