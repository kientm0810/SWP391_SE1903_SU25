# Sửa lỗi bài đăng đã ẩn vẫn có thể truy cập được

## Vấn đề

Khi bài đăng có `updated_at < current date` đã được ẩn khỏi danh sách, nhưng vẫn có thể truy cập được qua URL trực tiếp như `view?id=19`.

## Nguyên nhân

Có 2 controller xử lý việc xem bài đăng:

1. **ViewPostController** - URL pattern `/post/view` - sử dụng `PostDAO.getPostById()`
2. **PostController** - URL pattern `/post` với path `/view` - sử dụng `PostsDAO.getPostById()`

**Vấn đề:** `PostDAO.getPostById()` không có filter `updated_at`, trong khi `PostsDAO.getPostById()` có filter.

## Cách sửa

### 1. Thêm filter vào PostDAO.getPostById()

```java
// Trước
String query = "SELECT * FROM Posts WHERE id = ?";

// Sau  
String query = "SELECT * FROM Posts WHERE id = ? AND deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL)";
```

### 2. Loại bỏ conflict giữa 2 controller

Xóa phần xử lý `/view` trong `PostController` để chỉ sử dụng `ViewPostController`.

### 3. Thêm increment view count

Đảm bảo `ViewPostController` có logic tăng số lượt xem.

## Các file đã thay đổi

### 1. PostDAO.java
- **Thêm filter:** `AND deleted_at IS NULL AND (updated_at >= GETDATE() OR updated_at IS NULL)`
- **Method:** `getPostById(int postId)`

### 2. PostController.java  
- **Xóa path:** `/view` để tránh conflict
- **Giữ lại:** `/create`, `/edit`, `/delete`

### 3. ViewPostController.java
- **Thêm:** `postDAO.incrementViewCount(postId)` để tăng lượt xem
- **Sử dụng:** `PostDAO` với filter đã được cập nhật

## Kết quả

- ✅ Bài đăng có `updated_at < current date` sẽ không hiển thị trong danh sách
- ✅ Bài đăng có `updated_at < current date` sẽ không thể truy cập qua URL trực tiếp
- ✅ Chỉ hiển thị bài đăng "fresh" hoặc mới tạo
- ✅ Tăng số lượt xem khi người dùng xem bài đăng

## Lưu ý

- **Soft delete:** Bài đăng bị xóa mềm (`deleted_at IS NOT NULL`) cũng không hiển thị
- **Consistency:** Tất cả các query đều sử dụng cùng logic filter
- **Performance:** Filter được thực hiện ở database level, hiệu quả hơn 