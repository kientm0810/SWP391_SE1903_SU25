# Hướng dẫn sử dụng chức năng Email Tự động

## Tổng quan

Hệ thống JobFinding đã được tích hợp chức năng **Email Tự động** để Recruiter có thể tự động gửi email thông báo cho Job Seeker dựa trên trạng thái CV của họ.

## Các tính năng đã hoàn thiện

### ✅ 1. EmailScheduler - Lập lịch gửi email tự động
- **Khởi động tự động**: Scheduler sẽ tự động khởi động khi ứng dụng start
- **Gửi email nhắc nhở phỏng vấn**: Hàng giờ kiểm tra và gửi nhắc nhở cho các buổi phỏng vấn sắp tới
- **Gửi email thông báo việc làm**: Gửi job alerts theo tần suất (daily/weekly/monthly)
- **Dọn dẹp lịch sử**: Tự động xóa email history cũ hơn 90 ngày

### ✅ 2. Email tự động khi cập nhật trạng thái CV
Khi Recruiter cập nhật trạng thái CV của Job Seeker, hệ thống sẽ **tự động gửi email** tương ứng:

| Trạng thái | Email được gửi | Nội dung |
|------------|----------------|----------|
| **Đã xem** | ✅ `application_reviewed` | Thông báo hồ sơ đã được xem xét |
| **Phỏng vấn** | ✅ `interview_completed` | Cảm ơn đã tham gia phỏng vấn |
| **Từ chối** | ✅ `application_rejection` | Thông báo từ chối với lý do |
| **Mời nhận việc** | ✅ `application_acceptance` | Chúc mừng với chi tiết đề nghị |

### ✅ 3. Email Templates đầy đủ
- 10+ email templates chuyên nghiệp
- Hỗ trợ biến động (variables) như tên ứng viên, tên công ty, vị trí...
- Giao diện HTML đẹp mắt và responsive

## Cách sử dụng

### 1. Khởi động hệ thống
```bash
# Deploy ứng dụng lên server
# EmailScheduler sẽ tự động khởi động khi ứng dụng start
```

### 2. Cập nhật trạng thái CV (Recruiter)
1. Đăng nhập với tài khoản Recruiter
2. Vào trang "Quản lý ứng tuyển"
3. Click "Xem Chi Tiết" trên ứng viên
4. Chọn trạng thái mới:
   - **Đã xem**: Gửi email thông báo đã xem hồ sơ
   - **Phỏng vấn**: Gửi email cảm ơn tham gia phỏng vấn
   - **Từ chối**: Nhập lý do → Gửi email từ chối
   - **Mời nhận việc**: Nhập chi tiết đề nghị → Gửi email chấp nhận
5. Click "Cập nhật trạng thái"
6. **Email sẽ được gửi tự động** cho Job Seeker

### 3. Theo dõi lịch sử email
- Admin có thể xem lịch sử email tại `/admin/email-history`
- Thống kê email đã gửi/thất bại
- Xem chi tiết nội dung email đã gửi

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

### Thêm Email Templates mới
1. Chạy script `database/email_templates.sql`
2. Hoặc thêm trực tiếp vào bảng `Email_Templates`:
```sql
INSERT INTO Email_Templates (template_type, subject, body_html) VALUES 
('template_name', 'Subject', '<html>Body</html>');
```

## Các file quan trọng

### Backend
- `src/java/listeners/ApplicationStartupListener.java` - Khởi động EmailScheduler ✅
- `src/java/utils/EmailScheduler.java` - Lập lịch gửi email tự động ✅
- `src/java/utils/EmailService.java` - Service gửi email ✅
- `src/java/controllers/UpdateApplicationStatusController.java` - Cập nhật trạng thái + gửi email ✅
- `src/java/controllers/AdminEmailHistoryController.java` - Admin xem lịch sử email ✅

### Database
- `database/email_templates.sql` - Script tạo email templates ✅
- Bảng `Email_Templates` - Lưu trữ templates ✅
- Bảng `Email_History` - Lưu lịch sử email ✅

### Frontend
- `web/recruiter-applications.jsp` - Giao diện cập nhật trạng thái ✅
- `web/admin_email_history.jsp` - Admin xem lịch sử email ✅

### Configuration
- `web/WEB-INF/web.xml` - Đăng ký ApplicationStartupListener ✅

## Troubleshooting

### Email không gửi được
1. Kiểm tra cấu hình SMTP trong `Constants.java`
2. Kiểm tra log lỗi trong console
3. Xác nhận email templates đã được tạo trong database

### EmailScheduler không khởi động
1. Kiểm tra `ApplicationStartupListener` đã được đăng ký
2. Kiểm tra log startup trong console
3. Restart ứng dụng

### Email template không tìm thấy
1. Chạy script `email_templates.sql`
2. Kiểm tra bảng `Email_Templates` có dữ liệu
3. Xác nhận `template_type` khớp với code

## Tính năng nâng cao

### 1. Tùy chỉnh tần suất gửi email
```java
// EmailScheduler.java - Thay đổi interval
scheduler.scheduleAtFixedRate(() -> {
    // Task
}, 0, 30, TimeUnit.MINUTES); // Gửi mỗi 30 phút thay vì 1 giờ
```

### 2. Thêm email template mới
```java
// EmailService.java
public boolean sendCustomEmail(int applicationId, String templateType) {
    // Implementation
}
```

### 3. Tích hợp với notification system
```java
// Gửi email + notification
emailService.sendRejectionEmail(applicationId, reason);
notificationService.sendNotification(jobSeekerId, "application_rejected");
```

## Kết luận

Chức năng **Email Tự động** đã được **HOÀN THIỆN 100%** và sẵn sàng sử dụng!

### ✅ **Tính năng đã hoàn thành:**

1. **EmailScheduler** - Lập lịch gửi email tự động
   - Gửi nhắc nhở phỏng vấn mỗi giờ
   - Gửi job alerts mỗi 6 giờ  
   - Dọn dẹp lịch sử email cũ mỗi ngày lúc 2:00 AM

2. **ApplicationStartupListener** - Khởi động tự động
   - Tự động khởi động EmailScheduler khi ứng dụng start
   - Đăng ký trong web.xml

3. **Admin Email History** - Giao diện quản lý
   - Xem lịch sử email đã gửi
   - Thống kê email thành công/thất bại
   - Lọc theo trạng thái và email người nhận
   - Phân trang và tìm kiếm

4. **Tự động gửi email** khi cập nhật trạng thái CV
   - Đã xem → Email thông báo đã xem hồ sơ
   - Phỏng vấn → Email cảm ơn tham gia phỏng vấn
   - Từ chối → Email từ chối với lý do
   - Mời nhận việc → Email chấp nhận với chi tiết đề nghị

### 🚀 **Cách sử dụng:**

1. **Deploy ứng dụng** - EmailScheduler sẽ tự động khởi động
2. **Recruiter cập nhật trạng thái** - Email tự động gửi cho Job Seeker
3. **Admin xem lịch sử** - Truy cập `/admin/email-history`
4. **Hệ thống tự động** - Gửi nhắc nhở phỏng vấn và job alerts

**Hệ thống đảm bảo Job Seeker luôn được thông báo kịp thời về tình trạng hồ sơ ứng tuyển của mình!** 🎉 