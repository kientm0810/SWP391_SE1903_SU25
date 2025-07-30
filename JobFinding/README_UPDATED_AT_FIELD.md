# Thêm trường updated_at vào form tạo bài đăng

## Mô tả Thay đổi

Đã thêm trường `updated_at` vào form tạo bài đăng để cho phép người dùng thiết lập thời gian cập nhật cho bài đăng mới.

## Các File Đã Thay Đổi

### 1. create-post.jsp

**Thêm trường updated_at:**
- Thêm input field `datetime-local` cho trường `updated_at`
- Đặt trong phần "Thông tin cơ bản" cùng với các trường khác
- Có ghi chú "Để trống để sử dụng thời gian hiện tại"

**Vị trí:** Sau trường "Thời gian làm việc"

### 2. PostController.java

**Cập nhật method createPost:**
- Thêm xử lý cho parameter `updatedAt` từ form
- Parse datetime string thành Timestamp
- Xử lý lỗi parse và fallback về thời gian hiện tại
- Set giá trị `updated_at` cho Posts object

**Logic xử lý:**
```java
String updatedAtStr = request.getParameter("updatedAt");
if (updatedAtStr != null && !updatedAtStr.trim().isEmpty()) {
    try {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        post.setUpdatedAt(new java.sql.Timestamp(sdf.parse(updatedAtStr).getTime()));
    } catch (ParseException e) {
        // Fallback to current time
        post.setUpdatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
    }
} else {
    // Use current time if empty
    post.setUpdatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
}
```

### 3. PostsDAO.java

**Cập nhật method createPost:**
- Thay đổi SQL query để sử dụng parameter cho `updated_at` thay vì `GETDATE()`
- Thêm xử lý để set Timestamp cho `updated_at`
- Xử lý trường hợp `updated_at` null

**Thay đổi SQL:**
```sql
-- Trước:
VALUES (..., GETDATE(), GETDATE(), ...)

-- Sau:
VALUES (..., GETDATE(), ?, ...)
```

## Tính Năng Mới

### 1. Form Input
- **Loại:** `datetime-local`
- **Tên:** `updatedAt`
- **Bắt buộc:** Không (optional)
- **Mặc định:** Thời gian hiện tại

### 2. Validation
- Parse datetime string với format `yyyy-MM-dd'T'HH:mm`
- Xử lý lỗi parse gracefully
- Fallback về thời gian hiện tại nếu có lỗi

### 3. Database Storage
- Lưu trữ dưới dạng `TIMESTAMP` trong database
- Tương thích với logic ẩn bài đăng cũ (`updated_at < current date`)

## Lợi Ích

1. **Kiểm soát thời gian:** Người dùng có thể thiết lập thời gian cập nhật cho bài đăng
2. **Quản lý nội dung:** Giúp quản lý bài đăng dựa trên thời gian cập nhật
3. **Tương thích:** Hoạt động với hệ thống ẩn bài đăng cũ
4. **Linh hoạt:** Có thể để trống để sử dụng thời gian hiện tại

## Cách Sử Dụng

### Đối với Recruiter:
1. Điền form tạo bài đăng như bình thường
2. Tùy chọn: Thiết lập thời gian cập nhật trong trường "Ngày cập nhật"
3. Nếu để trống: Sử dụng thời gian hiện tại
4. Submit form để tạo bài đăng

### Đối với Admin:
- Có thể sử dụng trường này để quản lý thời gian hiển thị bài đăng
- Tích hợp với hệ thống ẩn bài đăng cũ

## Lưu Ý Kỹ Thuật

- **Format datetime:** `yyyy-MM-dd'T'HH:mm` (HTML5 datetime-local format)
- **Database type:** `TIMESTAMP`
- **Null handling:** Fallback về thời gian hiện tại
- **Error handling:** Graceful fallback khi parse lỗi
- **Validation:** Client-side và server-side validation

## Tương Thích

- Hoạt động với hệ thống ẩn bài đăng cũ (`updated_at < current date`)
- Tương thích với tất cả các chức năng hiện có
- Không ảnh hưởng đến bài đăng đã tồn tại 