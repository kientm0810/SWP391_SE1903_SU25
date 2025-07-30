# Validation cho trường updated_at - Ngăn chặn ngày trong quá khứ

## Mô tả Thay đổi

Đã thêm validation để ngăn chặn việc tạo bài đăng với `updated_at < current date`. Hệ thống sẽ hiển thị thông báo lỗi khi người dùng chọn ngày trong quá khứ.

## Các File Đã Thay Đổi

### 1. PostController.java

**Thêm validation server-side:**
- Kiểm tra `updated_at < current date` trước khi tạo bài đăng
- Trả về thông báo lỗi JSON nếu validation thất bại
- Xử lý lỗi parse datetime format

**Logic validation:**
```java
java.util.Date updatedAtDate = sdf.parse(updatedAtStr);
java.util.Date currentDate = new java.util.Date();

if (updatedAtDate.before(currentDate)) {
    response.setContentType("application/json");
    response.getWriter().write("{\"success\":false,\"message\":\"Ngày cập nhật không được nhỏ hơn ngày hiện tại...\"}");
    return;
}
```

### 2. create-post.jsp

**Thêm validation client-side:**
- Set `min` attribute cho input datetime-local
- Thêm `onchange` event để validate real-time
- Hiển thị thông báo lỗi trực quan
- Scroll đến trường lỗi và focus

**JavaScript functions:**
- `setMinDateTime()`: Set giá trị tối thiểu cho input
- `validateUpdatedAt()`: Validate khi người dùng thay đổi giá trị
- Validation trong form submission

## Tính Năng Validation

### 1. Client-side Validation
- **Min attribute:** Ngăn chặn chọn ngày trong quá khứ
- **Real-time validation:** Kiểm tra ngay khi người dùng thay đổi
- **Visual feedback:** Hiển thị border đỏ và thông báo lỗi
- **Auto focus:** Tự động scroll đến trường lỗi

### 2. Server-side Validation
- **Double check:** Kiểm tra lại trên server
- **JSON response:** Trả về thông báo lỗi chi tiết
- **Error handling:** Xử lý lỗi parse datetime
- **Security:** Đảm bảo tính toàn vẹn dữ liệu

### 3. User Experience
- **Clear messages:** Thông báo lỗi rõ ràng, dễ hiểu
- **Guidance:** Hướng dẫn cách sửa lỗi
- **Flexibility:** Cho phép để trống để sử dụng thời gian hiện tại

## Thông Báo Lỗi

### Client-side Messages:
- "Ngày cập nhật không được nhỏ hơn ngày hiện tại. Vui lòng chọn ngày trong tương lai hoặc để trống để sử dụng thời gian hiện tại."

### Server-side Messages:
- "Ngày cập nhật không được nhỏ hơn ngày hiện tại. Vui lòng chọn ngày trong tương lai hoặc để trống để sử dụng thời gian hiện tại."
- "Định dạng ngày cập nhật không hợp lệ. Vui lòng chọn lại hoặc để trống để sử dụng thời gian hiện tại."

## Cách Hoạt Động

### 1. Khi trang load:
- Tự động set `min` attribute cho input datetime-local
- Giá trị min = thời gian hiện tại

### 2. Khi người dùng chọn ngày:
- Validate real-time khi `onchange` event
- Hiển thị lỗi ngay lập tức nếu chọn ngày quá khứ
- Remove lỗi khi chọn ngày hợp lệ

### 3. Khi submit form:
- Validate tất cả trường bắt buộc
- Validate trường `updated_at` nếu có giá trị
- Hiển thị alert nếu có lỗi
- Scroll đến trường lỗi đầu tiên

### 4. Server processing:
- Parse datetime string
- Kiểm tra `updated_at < current date`
- Trả về JSON response với thông báo lỗi
- Tạo bài đăng nếu validation pass

## Lợi Ích

1. **Ngăn chặn lỗi:** Không cho phép tạo bài đăng với ngày quá khứ
2. **User-friendly:** Thông báo lỗi rõ ràng, hướng dẫn sửa
3. **Real-time feedback:** Người dùng biết lỗi ngay lập tức
4. **Data integrity:** Đảm bảo tính nhất quán của dữ liệu
5. **Security:** Validation cả client và server side

## Cách Sử Dụng

### Đối với Recruiter:
1. **Chọn ngày hợp lệ:** Chỉ có thể chọn ngày hiện tại hoặc tương lai
2. **Để trống:** Nếu không chọn, sẽ sử dụng thời gian hiện tại
3. **Sửa lỗi:** Nếu chọn sai, sẽ có thông báo hướng dẫn sửa

### Đối với Developer:
- Validation hoạt động tự động
- Không cần thêm code xử lý
- Tương thích với hệ thống hiện có

## Lưu Ý Kỹ Thuật

- **Min attribute:** HTML5 datetime-local input
- **JavaScript Date:** Sử dụng native Date object
- **Server timezone:** Sử dụng server timezone cho validation
- **Error handling:** Graceful fallback cho các trường hợp lỗi
- **Performance:** Validation nhẹ, không ảnh hưởng performance 