# Luồng Hoạt Động Email History

## Tổng quan
Khi recruiter gửi email thành công, email sẽ được lưu vào database và hiển thị trong trang `recruiter-email-history.jsp`.

## Luồng hoạt động

### 1. Gửi Email từ SendCustomEmailController
```
1. Recruiter gửi email từ trang Applications
2. SendCustomEmailController nhận request
3. Gửi email qua JavaMail.sendEmail()
4. Lưu email history với status "sent" hoặc "failed"
5. Redirect về trang Applications
```

### 2. Lưu Email History
```java
// Trong SendCustomEmailController.saveEmailHistory()
EmailHistory emailHistory = new EmailHistory();
emailHistory.setApplicationId(applicationId);
emailHistory.setRecruiterId(recruiter.getId()); // Lấy từ session
emailHistory.setTemplateName(templateName);
emailHistory.setRecipientEmail(recipientEmail);
emailHistory.setSubject(subject);
emailHistory.setBodyHtml(content);
emailHistory.setStatus(status); // "sent" hoặc "failed"
emailHistory.setSentAt(new Timestamp(System.currentTimeMillis()));
emailHistory.setCreatedAt(new Timestamp(System.currentTimeMillis()));

emailHistoryDAO.saveEmailHistory(emailHistory);
```

### 3. Hiển thị Email History
```
1. Recruiter truy cập /recruiter-email-history
2. RecruiterEmailHistoryController lấy email history
3. Hiển thị trong recruiter-email-history.jsp
```

## Các bước kiểm tra

### Bước 1: Chạy SQL Script
```sql
-- Chạy file: database/update_email_history_complete.sql
```

### Bước 2: Test Email History
Truy cập: `http://localhost:8080/JobFinding/email-history-test`

### Bước 3: Gửi Email Thực Tế
1. Đăng nhập với tài khoản recruiter
2. Vào trang Applications
3. Gửi email cho ứng viên
4. Kiểm tra email history

### Bước 4: Xem Email History
Truy cập: `http://localhost:8080/JobFinding/recruiter-email-history`

## Các file quan trọng

1. **SendCustomEmailController.java** - Xử lý gửi email và lưu history
2. **EmailHistoryDAO.java** - Truy vấn database
3. **RecruiterEmailHistoryController.java** - Hiển thị email history
4. **recruiter-email-history.jsp** - Giao diện hiển thị
5. **EmailHistory.java** - Model email history

## Troubleshooting

### Nếu email không được lưu:
1. Kiểm tra database có column recruiter_id không
2. Kiểm tra session có lưu recruiter không
3. Kiểm tra console log lỗi

### Nếu email không hiển thị:
1. Kiểm tra recruiter_id có đúng không
2. Kiểm tra SQL query trong EmailHistoryDAO
3. Chạy test để debug 