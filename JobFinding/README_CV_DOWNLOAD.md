# Chức Năng Tải CV

## Tổng quan
Chức năng tải CV đã được cải thiện để đảm bảo bảo mật và hoạt động ổn định. Thay vì truy cập trực tiếp file CV từ URL, hệ thống sử dụng controller để kiểm tra quyền truy cập và stream file một cách an toàn.

## Vấn đề đã được giải quyết

### 1. **Lỗi truy cập trực tiếp file**
- **Vấn đề**: Truy cập trực tiếp URL file CV gây lỗi "Something went wrong"
- **Nguyên nhân**: Server không cho phép truy cập trực tiếp file trong thư mục uploads
- **Giải pháp**: Sử dụng controller để xử lý việc tải file

### 2. **Bảo mật**
- **Vấn đề**: File CV có thể bị truy cập bởi bất kỳ ai biết URL
- **Giải pháp**: Kiểm tra quyền truy cập dựa trên role và ownership

## Cách hoạt động mới

### 1. **Controller DownloadCVController**
- **URL**: `/download-cv?applicationId={ID}`
- **Chức năng**: 
  - Kiểm tra đăng nhập và quyền truy cập
  - Validate application ID
  - Stream file CV an toàn
  - Đặt tên file theo tên ứng viên

### 2. **Kiểm tra quyền truy cập**

#### **Cho Recruiter:**
- Chỉ có thể tải CV của ứng viên đã ứng tuyển vào vị trí của mình
- Kiểm tra application thuộc về recruiter

#### **Cho Job Seeker:**
- Chỉ có thể tải CV của chính mình
- Kiểm tra application thuộc về job seeker

### 3. **Xử lý file**
- **Đường dẫn**: Lấy từ `application.getCvFile()`
- **Tên file**: `{Tên_Ứng_Viên}_CV.pdf`
- **Content-Type**: `application/pdf`
- **Headers**: 
  - `Content-Disposition: attachment`
  - `Cache-Control: no-cache`

## Các trang đã được cập nhật

### 1. **recruiter-applications.jsp**
- **Nút tải CV trên card**: `download-cv?applicationId=${app.applicationId}`
- **Nút tải CV trong modal**: Cùng URL như trên
- **Hiển thị**: Luôn hiển thị nút, disabled nếu không có CV

### 2. **update-application-status.jsp**
- **Nút tải CV**: `download-cv?applicationId=${application.applicationId}`
- **Vị trí**: Trong phần thông tin công việc

### 3. **applications.jsp**
- **Link tải CV**: `download-cv?applicationId=${app.id}`
- **Vị trí**: Trong cột "CV đã nộp"

## Lợi ích

### 1. **Bảo mật**
- ✅ Kiểm tra quyền truy cập
- ✅ Không lộ đường dẫn file thật
- ✅ Validate dữ liệu đầu vào

### 2. **Ổn định**
- ✅ Không còn lỗi "Something went wrong"
- ✅ Xử lý lỗi rõ ràng
- ✅ Stream file hiệu quả

### 3. **Trải nghiệm người dùng**
- ✅ Tải file với tên có ý nghĩa
- ✅ Thông báo lỗi rõ ràng
- ✅ Hoạt động trên mọi trình duyệt

## Xử lý lỗi

### 1. **Lỗi thường gặp**
- **401 Unauthorized**: Chưa đăng nhập
- **403 Forbidden**: Không có quyền truy cập
- **404 Not Found**: CV không tồn tại
- **500 Internal Server Error**: Lỗi server

### 2. **Thông báo lỗi**
- Tất cả thông báo lỗi đều bằng tiếng Việt
- Hiển thị nguyên nhân cụ thể
- Hướng dẫn khắc phục

## Cấu trúc file

### Backend
- `src/java/controllers/DownloadCVController.java` - Controller xử lý tải CV

### Frontend
- `web/recruiter-applications.jsp` - Trang recruiter (đã cập nhật)
- `web/update-application-status.jsp` - Form cập nhật (đã cập nhật)
- `web/applications.jsp` - Trang job seeker (đã cập nhật)

## Testing

### 1. **Test quyền truy cập**
- Recruiter tải CV của ứng viên khác → 403 Forbidden
- Job seeker tải CV của người khác → 403 Forbidden
- Chưa đăng nhập → 401 Unauthorized

### 2. **Test tải file**
- CV tồn tại → Tải thành công
- CV không tồn tại → 404 Not Found
- Application ID không hợp lệ → 400 Bad Request

### 3. **Test tên file**
- Tên file: `{Tên_Ứng_Viên}_CV.pdf`
- Loại bỏ ký tự đặc biệt
- Encoding UTF-8

## Tương lai

### Tính năng có thể thêm
- **Preview CV**: Xem trước CV trong browser
- **Multiple formats**: Hỗ trợ nhiều định dạng file
- **Compression**: Nén file để tải nhanh hơn
- **Tracking**: Theo dõi lượt tải CV
- **Watermark**: Thêm watermark cho CV 