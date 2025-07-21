# Hướng dẫn sử dụng chức năng Tìm kiếm việc làm

## Tổng quan

Hệ thống JobFinding đã được tích hợp chức năng **Tìm kiếm việc làm nâng cao** với các tính năng:

- ✅ Tìm kiếm theo từ khóa, địa điểm, ngành nghề, mức lương
- ✅ Gợi ý việc làm dựa trên lịch sử tìm kiếm
- ✅ Phân trang kết quả tìm kiếm
- ✅ Lưu lịch sử tìm kiếm
- ✅ Giao diện responsive và thân thiện

## Các thành phần đã triển khai

### 1. **Database & DAO**

#### SearchHistoryDAO
- `saveSearchHistory()` - Lưu lịch sử tìm kiếm
- `getSearchHistoryByJobSeeker()` - Lấy lịch sử tìm kiếm của job seeker
- `getPopularKeywords()` - Lấy từ khóa phổ biến
- `deleteOldSearchHistory()` - Xóa lịch sử cũ

#### PostsDAO (Cập nhật)
- `searchJobs()` - Tìm kiếm việc làm với nhiều điều kiện
- `countSearchResults()` - Đếm tổng số kết quả
- `getRelatedJobs()` - Lấy việc làm gợi ý
- `getFeaturedJobs()` - Lấy việc làm nổi bật
- `getPopularLocations()` - Lấy địa điểm phổ biến
- `getPopularIndustries()` - Lấy ngành nghề phổ biến

### 2. **Controllers**

#### SearchJobServlet (`/search-job`)
- Xử lý tìm kiếm việc làm
- Lưu lịch sử tìm kiếm
- Phân trang kết quả
- Trả về dữ liệu gợi ý

#### RelatedJobServlet (`/related-jobs`)
- Lấy việc làm gợi ý dựa trên lịch sử
- Hiển thị từ khóa phổ biến
- Hiển thị việc làm nổi bật

### 3. **Giao diện JSP**

#### searchJob.jsp
- Form tìm kiếm với các trường:
  - Từ khóa
  - Địa điểm
  - Loại công việc
  - Ngành nghề
  - Kinh nghiệm
  - Mức lương (min/max)
- Từ khóa và địa điểm phổ biến
- Thống kê tổng quan

#### jobResults.jsp
- Hiển thị danh sách việc làm tìm được
- Bộ lọc sidebar
- Phân trang
- Nút lưu việc làm
- Sắp xếp kết quả

#### relatedJobs.jsp
- Hiển thị việc làm gợi ý
- Điểm phù hợp (%)
- Từ khóa phổ biến
- Việc làm nổi bật

## Cách sử dụng

### 1. **Truy cập trang tìm kiếm**
```
URL: /searchJob.jsp
Hoặc click "Tìm kiếm" trong navigation
```

### 2. **Thực hiện tìm kiếm**
- **Tìm kiếm cơ bản**: Nhập từ khóa và địa điểm
- **Tìm kiếm nâng cao**: Sử dụng các bộ lọc
- **Từ khóa phổ biến**: Click vào tag để tìm kiếm nhanh

### 3. **Xem kết quả**
- Kết quả hiển thị tại `/jobResults.jsp`
- Sử dụng bộ lọc sidebar để lọc thêm
- Phân trang để xem nhiều kết quả hơn

### 4. **Xem gợi ý**
- Truy cập `/related-jobs` (chỉ job seeker)
- Dựa trên lịch sử tìm kiếm
- Hiển thị điểm phù hợp

## Các tính năng nổi bật

### 🔍 **Tìm kiếm thông minh**
- Tìm kiếm theo nhiều tiêu chí
- Tự động lưu lịch sử
- Gợi ý từ khóa phổ biến

### 📊 **Phân tích và gợi ý**
- Điểm phù hợp cho việc làm gợi ý
- Thống kê tìm kiếm
- Việc làm nổi bật

### 💾 **Lưu trữ và quản lý**
- Lưu lịch sử tìm kiếm
- Lưu việc làm yêu thích
- Quản lý bộ lọc

### 📱 **Giao diện responsive**
- Thiết kế mobile-friendly
- Animation mượt mà
- UX/UI hiện đại

## Cấu trúc database

### Bảng Search_History
```sql
- id (PK)
- job_seeker_id (FK)
- search_query (NVARCHAR)
- search_filters (NTEXT)
- search_date (DATETIME)
```

### Bảng Posts (Có sẵn)
```sql
- Các trường tìm kiếm: title, company_name, location, job_type, industry, salary, experience
- Các trường bổ sung: keywords, salary_min, salary_max, experience_years
```

## Tối ưu hóa hiệu suất

### 1. **Index Database**
```sql
-- Index cho tìm kiếm
CREATE INDEX idx_posts_search ON Posts (title, company_name, location, job_type, industry);
CREATE INDEX idx_posts_salary ON Posts (salary_min, salary_max);
CREATE INDEX idx_search_history_date ON Search_History (search_date);
```

### 2. **Caching**
- Cache kết quả tìm kiếm phổ biến
- Cache từ khóa phổ biến
- Cache việc làm nổi bật

### 3. **Pagination**
- Giới hạn 10 kết quả/trang
- Lazy loading cho kết quả lớn
- AJAX cho tải thêm kết quả

## Mở rộng tính năng

### 1. **Tìm kiếm nâng cao**
- Tìm kiếm theo kỹ năng
- Tìm kiếm theo công ty
- Tìm kiếm theo ngày đăng

### 2. **Gợi ý thông minh**
- Machine Learning cho gợi ý
- Phân tích hành vi người dùng
- Gợi ý dựa trên CV

### 3. **Thông báo**
- Job alerts theo tìm kiếm
- Email thông báo việc làm mới
- Push notification

## Troubleshooting

### Lỗi thường gặp

1. **Không tìm thấy kết quả**
   - Kiểm tra từ khóa tìm kiếm
   - Thử bỏ bớt bộ lọc
   - Kiểm tra dữ liệu trong database

2. **Lỗi phân trang**
   - Kiểm tra tham số page
   - Kiểm tra logic tính totalPages
   - Kiểm tra SQL query

3. **Lỗi lưu lịch sử**
   - Kiểm tra session user
   - Kiểm tra kết nối database
   - Kiểm tra quyền truy cập

### Debug

```java
// Log tìm kiếm
LOGGER.info("Search params: " + keyword + ", " + location + ", " + jobType);

// Log kết quả
LOGGER.info("Found " + searchResults.size() + " results");

// Log lịch sử
LOGGER.info("Saved search history for user: " + jobSeeker.getId());
```

## Kết luận

Chức năng tìm kiếm việc làm đã được triển khai đầy đủ với:

- ✅ **Tìm kiếm nâng cao** với nhiều tiêu chí
- ✅ **Gợi ý thông minh** dựa trên lịch sử
- ✅ **Giao diện hiện đại** và responsive
- ✅ **Hiệu suất tối ưu** với pagination và caching
- ✅ **Dễ dàng mở rộng** cho các tính năng mới

Hệ thống sẵn sàng cho việc sử dụng và có thể mở rộng thêm các tính năng nâng cao trong tương lai. 