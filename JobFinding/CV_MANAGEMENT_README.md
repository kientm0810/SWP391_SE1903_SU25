# CV Management System - Documentation

## 📋 Tổng quan

Hệ thống quản lý CV mới cho phép người tìm việc (Job Seeker) tạo, chỉnh sửa, xóa và quản lý CV của họ một cách dễ dàng với giao diện thân thiện và hiện đại.

## ✨ Tính năng chính

### 1. Đăng nhập và Chuyển hướng
- Sau khi đăng nhập, Job Seeker sẽ được chuyển hướng đến trang `/profile` thay vì `/home`
- Trang profile hiển thị thông tin cá nhân và danh sách CV

### 2. Quản lý CV
- **Xem danh sách CV**: Hiển thị tất cả CV với thông tin tóm tắt
- **Tìm kiếm CV**: Tìm kiếm theo tên hoặc vị trí công việc
- **Phân trang**: Hiển thị 5 CV mỗi trang
- **Tạo CV mới**: Form tạo CV với đầy đủ thông tin và upload file PDF
- **Chỉnh sửa CV**: Cập nhật thông tin CV và thay đổi file PDF
- **Xóa CV**: Xóa CV với xác nhận

### 3. Upload File PDF
- Hỗ trợ upload file PDF tối đa 10MB
- Lưu trữ file local trong thư mục `uploads/cvs/`
- Tự động tạo tên file unique để tránh trùng lặp
- Hiển thị link download file PDF

## 🏗️ Cấu trúc hệ thống

### Controllers
1. **ProfileController** (`/profile`)
   - Hiển thị trang profile với danh sách CV
   - Xử lý phân trang và tìm kiếm
   - Xử lý xóa CV

2. **CVUploadController** (`/cv-upload`)
   - Hiển thị form tạo CV mới
   - Xử lý upload file PDF và lưu thông tin CV

3. **CVEditController** (`/cv-edit`)
   - Hiển thị form chỉnh sửa CV
   - Cập nhật thông tin CV và file PDF

### Models
- **CVTemplate**: Model chính cho CV với các field:
  - `id`: ID duy nhất
  - `jobSeekerId`: ID của người tìm việc
  - `fullName`: Họ tên
  - `jobPosition`: Vị trí ứng tuyển
  - `email`: Email
  - `phone`: Số điện thoại
  - `address`: Địa chỉ
  - `workExperience`: Kinh nghiệm làm việc
  - `certificates`: Chứng chỉ và bằng cấp
  - `pdfFilePath`: Đường dẫn file PDF
  - `createdAt`: Thời gian tạo
  - `updatedAt`: Thời gian cập nhật

### Database
- **Table**: `cv_templates`
- **Key columns**: `image_path` VARCHAR(255) - lưu đường dẫn file PDF

### JSP Pages
1. **profile.jsp**: Trang profile với danh sách CV
2. **cv_upload.jsp**: Form tạo CV mới
3. **cv_edit.jsp**: Form chỉnh sửa CV

## 🚀 Cách sử dụng

### Đối với Job Seeker:

1. **Đăng nhập**
   - Sử dụng tài khoản Job Seeker
   - Tự động chuyển hướng đến trang profile

2. **Tạo CV mới**
   - Click "Tạo CV mới" từ trang profile
   - Điền thông tin cá nhân (bắt buộc: Họ tên, Vị trí, Email)
   - Điền kinh nghiệm và chứng chỉ (tùy chọn)
   - Upload file PDF CV (tùy chọn, tối đa 10MB)
   - Click "Lưu CV"

3. **Chỉnh sửa CV**
   - Click nút "Chỉnh sửa" trên CV muốn sửa
   - Cập nhật thông tin cần thiết
   - Thay đổi file PDF nếu muốn
   - Click "Cập nhật CV"

4. **Xóa CV**
   - Click nút "Xóa" trên CV muốn xóa
   - Xác nhận xóa trong popup

5. **Tìm kiếm CV**
   - Sử dụng ô tìm kiếm trên trang profile
   - Tìm theo tên hoặc vị trí công việc

## 🛠️ Setup và Deployment

### Yêu cầu hệ thống:
- Java 17+
- Maven 3.6+
- SQL Server
- Jakarta EE 10
- Bootstrap 5.3.2

### Cài đặt:

1. **Database Setup**
   ```sql
   -- Chạy script database chính
   USE project_SWP391;
   -- Đảm bảo bảng cv_templates có column image_path
   ```

2. **Tạo thư mục upload**
   ```
   JobFinding/web/uploads/cvs/
   ```

3. **Compile và Deploy**
   ```bash
   mvn clean compile
   mvn package
   # Deploy job-finding.war lên server
   ```

### Cấu hình:

1. **Upload Directory**: Application sẽ tự động tạo thư mục `uploads/cvs/` trong web directory

2. **File Size Limits**:
   - Max file size: 10MB
   - File type: PDF only
   - File storage: Local server

## 🎨 UI/UX Features

### Design principles:
- **Modern & Clean**: Giao diện hiện đại với gradient và shadow effects
- **Responsive**: Tương thích tất cả thiết bị (mobile, tablet, desktop)
- **User Friendly**: Dễ sử dụng với icons và thông báo rõ ràng
- **Interactive**: Hover effects, loading states, drag & drop

### Key UI elements:
- Gradient header với thông tin user
- Card-based CV display với actions
- Modern form với validation
- Drag & drop file upload
- Pagination với Bootstrap
- Modal confirmations
- Toast notifications

## 🔒 Bảo mật

### File Upload Security:
- Kiểm tra file type (chỉ PDF)
- Giới hạn file size (10MB)
- Tạo unique filename để tránh conflict
- Lưu trữ trong thư mục bảo mật

### Access Control:
- Chỉ Job Seeker đã đăng nhập mới có thể truy cập
- User chỉ có thể xem/sửa/xóa CV của chính họ
- Session-based authentication

## 📱 Responsive Design

- **Desktop**: Full layout với sidebar và grid
- **Tablet**: Responsive grid với 2 columns
- **Mobile**: Single column với touch-friendly buttons

## ⚡ Performance

### Optimizations:
- Lazy loading cho large lists
- Client-side search với debounce
- Optimized SQL queries với pagination
- CSS/JS minification ready

## 🐛 Troubleshooting

### Common Issues:

1. **File upload không hoạt động**
   - Kiểm tra thư mục `uploads/cvs/` có tồn tại
   - Đảm bảo server có quyền write
   - Kiểm tra file size < 10MB

2. **CV không hiển thị**
   - Kiểm tra database connection
   - Verify `cv_templates` table structure

3. **Login redirect không đúng**
   - Kiểm tra `LoginController.redirectToHomePage()`
   - Verify role = "job-seeker"

## 📈 Future Enhancements

Những tính năng có thể mở rộng trong tương lai:

1. **CV Templates**: Thêm các template CV có sẵn
2. **CV Builder**: Tool tạo CV online
3. **CV Analytics**: Thống kê lượt xem CV
4. **CV Sharing**: Chia sẻ CV với employer
5. **Multiple File Types**: Hỗ trợ Word, Image files
6. **Cloud Storage**: Tích hợp AWS S3, Google Drive
7. **CV Rating**: Đánh giá CV từ recruiter
8. **Export Options**: Export CV sang nhiều định dạng

## 💡 Best Practices

### Cho Developers:
- Luôn validate input từ client
- Sử dụng prepared statements để tránh SQL injection
- Log các hoạt động quan trọng
- Test trên nhiều browsers
- Optimize database queries

### Cho Users:
- Sử dụng tên file PDF có ý nghĩa
- Cập nhật CV thường xuyên
- Backup CV quan trọng
- Sử dụng email professional

---

## 📞 Support

Nếu có vấn đề gì, vui lòng contact team development hoặc tạo issue trong repository.

**Happy job hunting! 🎯** 