# Debug Email History - Test 1 Failed

## Vấn đề
Test 1 "Saving Test Email" bị FAILED, có nghĩa là không thể lưu email history vào database.

## Nguyên nhân có thể

### 1. Database chưa được cập nhật
- Column `recruiter_id` chưa tồn tại trong bảng `Email_History`
- Column `template_name` chưa tồn tại

### 2. Foreign Key Constraint
- Foreign key `FK_EmailHistory_Recruiter` có thể bị lỗi
- Recruiter ID không tồn tại trong bảng `Recruiter`

### 3. Data Type Mismatch
- Data type của column không khớp với giá trị được insert

## Các bước debug

### Bước 1: Kiểm tra Database Structure
Truy cập: `http://localhost:8080/JobFinding/check-database`

Kiểm tra:
- Database connection có thành công không
- Bảng `Email_History` có column `recruiter_id` không
- Bảng `Email_History` có column `template_name` không
- Test insert có thành công không

### Bước 2: Chạy SQL Script
Nếu database chưa được cập nhật, chạy script:
```sql
-- Chạy file: database/update_email_history_complete.sql
```

### Bước 3: Kiểm tra Console Log
Kiểm tra console log của server để xem lỗi chi tiết:
- SQLException details
- Stack trace

### Bước 4: Kiểm tra Recruiter ID
Đảm bảo recruiter ID = 1 tồn tại trong bảng `Recruiter`:
```sql
SELECT * FROM Recruiter WHERE recruiter_id = 1;
```

## Giải pháp

### Nếu column chưa tồn tại:
1. Chạy SQL script `update_email_history_complete.sql`
2. Kiểm tra lại bằng `check-database`

### Nếu foreign key lỗi:
1. Kiểm tra recruiter ID có tồn tại không
2. Tạm thời disable foreign key constraint để test

### Nếu data type lỗi:
1. Kiểm tra data type của các column
2. Đảm bảo giá trị insert khớp với data type

## Test lại
Sau khi fix, test lại tại: `http://localhost:8080/JobFinding/email-history-test` 