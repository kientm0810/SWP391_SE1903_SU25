# Cập nhật Hiển thị Bài đăng với updated_at < current date

## Mô tả Thay đổi

Đã cập nhật hệ thống để chỉ hiển thị các bài đăng có `updated_at < current date` (tức là các bài đăng chưa được cập nhật gần đây) thay vì hiển thị tất cả bài đăng.

## Các File Đã Thay Đổi

### 1. PostsDAO.java

**Các method đã được cập nhật:**
- `getAllPosts()` - Hiển thị tất cả bài đăng
- `getPostsByUserId()` - Hiển thị bài đăng của user cụ thể
- `getPostById()` - Lấy chi tiết bài đăng
- `getTotalPosts()` - Đếm tổng số bài đăng
- `getPostsByPage()` - Phân trang bài đăng
- `getTotalPostsWithSearch()` - Đếm kết quả tìm kiếm
- `getPostsByPageWithSearch()` - Tìm kiếm và phân trang
- `getPostsByUserIdWithPaging()` - Phân trang bài đăng của user
- `getLatestPosts()` - Bài đăng mới nhất
- `getRelatedPostsByRecruiter()` - Bài đăng liên quan cùng recruiter
- `getRelatedPostsFromOtherRecruiters()` - Bài đăng từ recruiter khác

**Thay đổi query:**
```sql
-- Trước:
WHERE deleted_at IS NULL AND (updated_at >= created_at OR updated_at IS NULL)

-- Sau:
WHERE deleted_at IS NULL AND (updated_at < GETDATE() OR updated_at IS NULL)
```

### 2. PostController.java

**Thêm logic hiển thị thông tin updated_at:**
- Thêm `request.setAttribute("showUpdateInfo", true)` để bật hiển thị thông tin cập nhật

### 3. posts.jsp

**Thêm hiển thị thông tin updated_at:**
- Hiển thị ngày cập nhật nếu bài đăng có `updated_at`
- Hiển thị "Tin mới" nếu bài đăng chưa có `updated_at`
- Sử dụng icon và màu sắc khác nhau để phân biệt

### 4. Posts.css

**Thêm CSS cho các tag mới:**
- `.update-tag` - Tag hiển thị ngày cập nhật (màu xanh dương)
- `.new-tag` - Tag hiển thị tin mới (màu xanh lá)

## Ý Nghĩa Thay Đổi

### Trước khi thay đổi:
- Hiển thị tất cả bài đăng không bị xóa
- Chỉ kiểm tra logic `updated_at >= created_at`

### Sau khi thay đổi:
- Chỉ hiển thị bài đăng có `updated_at < current date` hoặc `updated_at IS NULL`
- Giúp người dùng thấy được bài đăng nào đã được cập nhật gần đây
- Hiển thị rõ ràng thông tin về thời gian cập nhật

## Lợi Ích

1. **Tăng tính minh bạch**: Người dùng biết được bài đăng nào mới được cập nhật
2. **Cải thiện UX**: Hiển thị thông tin trực quan về trạng thái bài đăng
3. **Quản lý nội dung tốt hơn**: Recruiter có thể thấy được bài đăng nào cần cập nhật
4. **Tối ưu hiệu suất**: Giảm số lượng bài đăng hiển thị không cần thiết

## Cách Sử Dụng

1. **Đối với Job Seeker:**
   - Xem được bài đăng nào mới được cập nhật
   - Biết được bài đăng nào là tin mới

2. **Đối với Recruiter:**
   - Quản lý bài đăng của mình tốt hơn
   - Thấy được bài đăng nào cần cập nhật

3. **Đối với Admin:**
   - Kiểm soát chất lượng nội dung
   - Theo dõi hoạt động cập nhật bài đăng

## Lưu Ý Kỹ Thuật

- Sử dụng `GETDATE()` trong SQL Server để lấy ngày hiện tại
- Logic `OR updated_at IS NULL` đảm bảo bài đăng mới tạo vẫn được hiển thị
- CSS responsive cho các tag mới
- Tương thích với hệ thống phân trang và tìm kiếm hiện có 