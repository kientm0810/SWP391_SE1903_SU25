# Hướng dẫn Test Form Gửi Email

## Các lỗi đã được sửa

### 1. **Lỗi EL Expression trong recruiter-applications.jsp**
- **Vấn đề**: JavaScript template literal sử dụng `${}` bên trong JSP
- **Giải pháp**: Thay đổi từ template literal sang string concatenation
- **Trước**:
```javascript
const sendEmailUrl = `send-custom-email?recipientEmail=${encodeURIComponent(this.dataset.email)}&...`;
```
- **Sau**:
```javascript
const sendEmailUrl = 'send-custom-email?recipientEmail=' + encodeURIComponent(this.dataset.email) + '&...';
```

### 2. **Lỗi EL Expression trong send-email.jsp**
- **Vấn đề**: Sử dụng `${param.xxx}` thay vì request attributes
- **Giải pháp**: Thay đổi từ `param` sang `requestScope`
- **Trước**:
```jsp
<span><strong>Tên:</strong> ${param.candidateName}</span>
```
- **Sau**:
```jsp
<span><strong>Tên:</strong> ${requestScope.candidateName}</span>
```

## Cách test form gửi email

### 1. **Test truy cập form**
1. Đăng nhập với tài khoản Recruiter
2. Vào trang "Đơn ứng tuyển nhận được"
3. Click "Xem Chi Tiết" trên một ứng viên
4. Trong modal, click nút "Gửi Email" (màu xanh dương)
5. **Kết quả mong đợi**: Chuyển đến form gửi email với thông tin đã điền sẵn

### 2. **Test thông tin người nhận**
- **Kiểm tra**: Thông tin ứng viên hiển thị đúng
  - Tên ứng viên
  - Email
  - Vị trí công việc
  - Tên công ty
- **Kết quả mong đợi**: Tất cả thông tin hiển thị chính xác

### 3. **Test email tùy chỉnh**
1. Chọn "Email tùy chỉnh" trong dropdown
2. Nhập tiêu đề email
3. Nhập nội dung email (có thể sử dụng TinyMCE)
4. Click "Gửi Email"
- **Kết quả mong đợi**: Email được gửi thành công

### 4. **Test email template**
1. Chọn một loại template (ví dụ: "Thông báo đã xem hồ sơ")
2. Click "Gửi Email"
- **Kết quả mong đợi**: Email template được gửi với nội dung đã format

### 5. **Test validation**
1. Không chọn loại email → Click "Gửi Email"
2. Chọn "Email tùy chỉnh" nhưng không nhập tiêu đề → Click "Gửi Email"
3. Chọn "Email tùy chỉnh" nhưng không nhập nội dung → Click "Gửi Email"
- **Kết quả mong đợi**: Hiển thị thông báo lỗi phù hợp

### 6. **Test preview**
1. Nhập tiêu đề và nội dung email
2. **Kết quả mong đợi**: Preview section hiển thị nội dung email sẽ gửi

## Kiểm tra lỗi thường gặp

### 1. **Lỗi 404 - Page not found**
- **Nguyên nhân**: URL mapping không đúng
- **Kiểm tra**: 
  - `SendCustomEmailController` có annotation `@WebServlet("/send-custom-email")`
  - File `send-email.jsp` tồn tại trong thư mục `web`

### 2. **Lỗi EL Expression**
- **Nguyên nhân**: Sử dụng `${param.xxx}` thay vì `${requestScope.xxx}`
- **Kiểm tra**: Tất cả EL expressions trong `send-email.jsp` sử dụng `requestScope`

### 3. **Lỗi JavaScript**
- **Nguyên nhân**: Template literal trong JSP
- **Kiểm tra**: Tất cả JavaScript sử dụng string concatenation thay vì template literal

### 4. **Lỗi email không gửi được**
- **Nguyên nhân**: Cấu hình SMTP sai
- **Kiểm tra**:
  - `Constants.java` có cấu hình SMTP đúng
  - `JavaMail.java` hoạt động bình thường
  - Kết nối internet ổn định

### 5. **Lỗi template không load**
- **Nguyên nhân**: Database không có templates
- **Kiểm tra**:
  - Chạy script `database/email_templates.sql`
  - Bảng `Email_Templates` có dữ liệu
  - `EmailTemplateDAO` hoạt động bình thường

## Log kiểm tra

### 1. **Server logs**
```bash
# Kiểm tra log lỗi
tail -f /path/to/server/logs/error.log

# Kiểm tra log ứng dụng
tail -f /path/to/server/logs/application.log
```

### 2. **Browser console**
```javascript
// Mở Developer Tools (F12)
// Kiểm tra Console tab
// Tìm các lỗi JavaScript
```

### 3. **Network tab**
```javascript
// Mở Developer Tools (F12)
// Kiểm tra Network tab
// Xem request/response của form submission
```

## Test cases chi tiết

### Test Case 1: Truy cập form thành công
**Steps**:
1. Login Recruiter
2. Vào recruiter-applications
3. Click "Xem Chi Tiết"
4. Click "Gửi Email"

**Expected Result**:
- Chuyển đến `/send-custom-email`
- Form hiển thị với thông tin ứng viên
- Không có lỗi JavaScript

### Test Case 2: Gửi email tùy chỉnh
**Steps**:
1. Chọn "Email tùy chỉnh"
2. Nhập tiêu đề: "Test Email"
3. Nhập nội dung: "Đây là email test"
4. Click "Gửi Email"

**Expected Result**:
- Email được gửi thành công
- Redirect về trang applications
- Hiển thị thông báo thành công

### Test Case 3: Gửi email template
**Steps**:
1. Chọn "Thông báo đã xem hồ sơ"
2. Click "Gửi Email"

**Expected Result**:
- Email template được gửi
- Nội dung có variables được thay thế
- Redirect về trang applications

### Test Case 4: Validation lỗi
**Steps**:
1. Không chọn loại email
2. Click "Gửi Email"

**Expected Result**:
- Hiển thị thông báo lỗi
- Form không submit
- Ở lại trang gửi email

## Troubleshooting

### Nếu form không load
1. Kiểm tra URL mapping trong `web.xml`
2. Kiểm tra `SendCustomEmailController` có được compile
3. Kiểm tra log server

### Nếu email không gửi được
1. Kiểm tra cấu hình SMTP
2. Kiểm tra kết nối internet
3. Kiểm tra log email trong database

### Nếu thông tin không hiển thị
1. Kiểm tra request attributes trong controller
2. Kiểm tra EL expressions trong JSP
3. Kiểm tra JavaScript console

## Kết luận

Sau khi sửa các lỗi EL expression, form gửi email sẽ hoạt động bình thường. Các lỗi chính đã được khắc phục:

1. ✅ Template literal trong JSP → String concatenation
2. ✅ `${param.xxx}` → `${requestScope.xxx}`
3. ✅ JavaScript không conflict với JSP EL

Form gửi email đã sẵn sàng để test và sử dụng! 🎉 