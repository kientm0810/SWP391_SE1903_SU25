# Form Cập Nhật Trạng Thái Ứng Tuyển

## Tổng quan
Form cập nhật trạng thái ứng tuyển là một trang JSP riêng biệt cho phép recruiter cập nhật trạng thái ứng tuyển và gửi email thông báo tự động cho job seeker.

## Tính năng

### 1. Hiển thị thông tin ứng viên
- **Thông tin cá nhân**: Tên, email, số điện thoại
- **Thông tin công việc**: Vị trí, công ty, ngày ứng tuyển
- **Trạng thái hiện tại**: Hiển thị trạng thái hiện tại với màu sắc phân biệt

### 2. Cập nhật trạng thái
- **Trạng thái mới**: Mới, Đã xem, Phỏng vấn, Mời nhận việc, Từ chối
- **Lý do từ chối**: Bắt buộc khi chọn trạng thái "Từ chối"
- **Chi tiết đề nghị**: Bắt buộc khi chọn trạng thái "Mời nhận việc"

### 3. Gửi email tự động
- **Email trực tiếp**: Gửi trực tiếp đến địa chỉ email của job seeker
- **Xem trước email**: Hiển thị nội dung email sẽ được gửi
- **Thông báo xác nhận**: Hiển thị địa chỉ email sẽ nhận thông báo

### 4. Giao diện thân thiện
- **Responsive design**: Hoạt động tốt trên desktop và mobile
- **Loading state**: Hiển thị trạng thái đang xử lý
- **Validation**: Kiểm tra dữ liệu trước khi gửi

## Cách sử dụng

### 1. Truy cập form
- Vào trang "Đơn ứng tuyển nhận được"
- Click nút "Cập Nhật Trạng Thái" trên ứng viên cần cập nhật
- Hoặc truy cập trực tiếp: `/show-update-status-form?applicationId={ID}`

### 2. Cập nhật trạng thái
1. **Chọn trạng thái mới** từ dropdown
2. **Nhập thông tin bổ sung** (nếu cần):
   - Lý do từ chối (cho trạng thái "Từ chối")
   - Chi tiết đề nghị (cho trạng thái "Mời nhận việc")
3. **Xem trước email** sẽ được gửi
4. **Xác nhận và gửi**

### 3. Kết quả
- **Thành công**: Hiển thị thông báo thành công và email đã gửi
- **Lỗi**: Hiển thị thông báo lỗi cụ thể

## Các trạng thái và email tương ứng

| Trạng thái | Loại email | Nội dung |
|------------|------------|----------|
| **Mới** | Không gửi | - |
| **Đã xem** | Thông báo đã xem | Thông báo hồ sơ đã được xem xét |
| **Phỏng vấn** | Cảm ơn phỏng vấn | Cảm ơn đã tham gia phỏng vấn |
| **Mời nhận việc** | Chấp nhận | Thông báo được mời nhận việc với chi tiết |
| **Từ chối** | Từ chối | Thông báo từ chối với lý do |

## Cấu trúc file

### Backend
- `src/java/controllers/ShowUpdateStatusFormController.java` - Controller hiển thị form
- `src/java/controllers/UpdateApplicationStatusController.java` - Controller xử lý cập nhật

### Frontend
- `web/update-application-status.jsp` - Form cập nhật trạng thái
- `web/recruiter-applications.jsp` - Trang danh sách (đã cập nhật)

## Bảo mật

### Kiểm tra quyền
- Chỉ recruiter mới có thể truy cập
- Kiểm tra quyền sở hữu application
- Validate dữ liệu đầu vào

### Validation
- Kiểm tra application ID hợp lệ
- Validate trạng thái được chọn
- Kiểm tra thông tin bắt buộc

## Lợi ích

### 1. Trải nghiệm người dùng
- **Giao diện rõ ràng**: Hiển thị đầy đủ thông tin
- **Xem trước email**: Biết trước nội dung sẽ gửi
- **Thông báo rõ ràng**: Hiển thị địa chỉ email cụ thể

### 2. Hiệu quả công việc
- **Tách biệt chức năng**: Form riêng cho cập nhật trạng thái
- **Gửi email tự động**: Không cần thao tác thêm
- **Lưu lịch sử**: Theo dõi được email đã gửi

### 3. Độ tin cậy
- **Gửi trực tiếp**: Email đến đúng địa chỉ
- **Xử lý lỗi**: Thông báo lỗi cụ thể
- **Validation**: Kiểm tra dữ liệu trước khi gửi

## Tương lai

### Tính năng có thể thêm
- **Template email tùy chỉnh**: Cho phép recruiter tùy chỉnh nội dung
- **Lịch sử cập nhật**: Theo dõi lịch sử thay đổi trạng thái
- **Thông báo real-time**: Thông báo cho job seeker qua webhook
- **Export dữ liệu**: Xuất báo cáo cập nhật trạng thái 