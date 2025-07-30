# Hệ thống Phân loại Nội dung (Content Type System)

## Tổng quan

Hệ thống phân loại nội dung được thiết kế để quản lý và phân loại các loại bài đăng (Posts) và blog một cách có hệ thống. Điều này giúp cải thiện trải nghiệm người dùng, tối ưu hóa tìm kiếm và tăng hiệu quả quản lý nội dung.

## Cấu trúc Database

### 1. Bảng PostType
Quản lý các loại bài đăng khác nhau:

```sql
CREATE TABLE PostType (
    id INT PRIMARY KEY IDENTITY(1,1),
    type_code VARCHAR(50) NOT NULL UNIQUE,
    type_name NVARCHAR(100) NOT NULL,
    description NTEXT,
    category VARCHAR(50) NOT NULL,
    priority_level INT DEFAULT 1,
    is_active BIT DEFAULT 1,
    icon_class VARCHAR(100),
    color_code VARCHAR(7),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
```

**Categories:**
- `job_posting`: Các loại bài đăng tuyển dụng
- `content`: Nội dung thông thường
- `announcement`: Thông báo
- `event`: Sự kiện

### 2. Bảng BlogType
Quản lý các loại blog:

```sql
CREATE TABLE BlogType (
    id INT PRIMARY KEY IDENTITY(1,1),
    type_code VARCHAR(50) NOT NULL UNIQUE,
    type_name NVARCHAR(100) NOT NULL,
    description NTEXT,
    category VARCHAR(50) NOT NULL,
    target_audience VARCHAR(50) NOT NULL,
    content_format VARCHAR(50) DEFAULT 'article',
    is_active BIT DEFAULT 1,
    icon_class VARCHAR(100),
    color_code VARCHAR(7),
    seo_keywords NVARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
```

**Categories:**
- `career_advice`: Tư vấn nghề nghiệp
- `industry_news`: Tin tức ngành
- `company_culture`: Văn hóa công ty
- `job_search`: Tìm kiếm việc làm
- `interview_prep`: Chuẩn bị phỏng vấn
- `professional_development`: Phát triển chuyên môn

**Target Audiences:**
- `job_seekers`: Người tìm việc
- `recruiters`: Nhà tuyển dụng
- `students`: Sinh viên
- `professionals`: Chuyên gia
- `all`: Tất cả

## Các chức năng chính

### 1. Quản lý PostType

#### API Endpoints:
- `GET /content-type/api/post-types?action=get-all`: Lấy tất cả loại bài đăng
- `GET /content-type/api/post-types?action=get-by-category&category=job_posting`: Lấy theo category
- `GET /content-type/api/post-types?action=get-job-posting-types`: Lấy loại tuyển dụng

#### Quản lý Admin:
- `GET /content-type/post-types?action=list`: Danh sách loại bài đăng
- `GET /content-type/post-types?action=create`: Tạo mới
- `GET /content-type/post-types?action=edit&id=1`: Chỉnh sửa
- `POST /content-type/post-types?action=update`: Cập nhật
- `POST /content-type/post-types?action=delete&id=1`: Xóa

### 2. Quản lý BlogType

#### API Endpoints:
- `GET /content-type/api/blog-types?action=get-all`: Lấy tất cả loại blog
- `GET /content-type/api/blog-types?action=get-by-category&category=career_advice`: Lấy theo category
- `GET /content-type/api/blog-types?action=get-by-audience&audience=job_seekers`: Lấy theo đối tượng

#### Quản lý Admin:
- `GET /content-type/blog-types?action=list`: Danh sách loại blog
- `GET /content-type/blog-types?action=create`: Tạo mới
- `GET /content-type/blog-types?action=edit&id=1`: Chỉnh sửa
- `POST /content-type/blog-types?action=update`: Cập nhật
- `POST /content-type/blog-types?action=delete&id=1`: Xóa

## Cách sử dụng

### 1. Tích hợp vào form tạo bài đăng

```jsp
<!-- Trong form tạo bài đăng -->
<select name="postTypeId" class="form-control" required>
    <option value="">Chọn loại bài đăng</option>
    <c:forEach var="postType" items="${postTypes}">
        <option value="${postType.id}">${postType.typeName}</option>
    </c:forEach>
</select>
```

### 2. Hiển thị với icon và màu sắc

```jsp
<!-- Hiển thị loại bài đăng với styling -->
<span class="badge" style="background-color: ${post.postType.colorCode}">
    <i class="${post.postType.iconClass}"></i>
    ${post.postType.typeName}
</span>
```

### 3. Lọc nội dung theo loại

```javascript
// JavaScript để lọc bài đăng theo loại
function filterByPostType(typeId) {
    fetch(`/content-type/api/post-types?action=get-by-category&category=${typeId}`)
        .then(response => response.json())
        .then(data => {
            // Xử lý dữ liệu
            displayPosts(data);
        });
}
```

### 4. Tích hợp vào tìm kiếm nâng cao

```java
// Trong PostsDAO
public List<Posts> searchJobsWithType(String keyword, String location, 
                                     Integer postTypeId, int page, int pageSize) {
    StringBuilder sql = new StringBuilder();
    sql.append("SELECT p.*, pt.type_name, pt.icon_class, pt.color_code ");
    sql.append("FROM Posts p ");
    sql.append("LEFT JOIN PostType pt ON p.post_type_id = pt.id ");
    sql.append("WHERE p.post_type = 'post' AND p.status = 'active' ");
    
    if (postTypeId != null) {
        sql.append("AND p.post_type_id = ? ");
    }
    
    // Thêm các điều kiện tìm kiếm khác...
    
    return executeSearch(sql.toString(), params);
}
```

## Lợi ích của hệ thống

### 1. Cải thiện UX
- **Phân loại rõ ràng**: Người dùng dễ dàng tìm kiếm nội dung phù hợp
- **Visual cues**: Icon và màu sắc giúp nhận diện nhanh
- **Personalization**: Hiển thị nội dung theo sở thích

### 2. Tối ưu hóa SEO
- **Structured data**: Dữ liệu có cấu trúc tốt hơn
- **Keyword targeting**: Từ khóa SEO cho từng loại
- **Content categorization**: Phân loại nội dung tự động

### 3. Quản lý hiệu quả
- **Analytics**: Thống kê hiệu suất theo loại
- **Content strategy**: Chiến lược nội dung dựa trên dữ liệu
- **A/B testing**: Thử nghiệm các loại nội dung khác nhau

### 4. Monetization
- **Premium content**: Nội dung trả phí theo loại
- **Targeted advertising**: Quảng cáo theo đối tượng
- **Subscription models**: Gói đăng ký theo loại

## Các tính năng nâng cao

### 1. Hệ thống gợi ý thông minh
```java
// Gợi ý nội dung dựa trên lịch sử
public List<Posts> getRecommendedPosts(int userId, int limit) {
    // Phân tích hành vi người dùng
    // Gợi ý nội dung phù hợp
    return recommendedPosts;
}
```

### 2. Analytics Dashboard
```java
// Thống kê hiệu suất nội dung
public Map<String, Object> getContentAnalytics() {
    Map<String, Object> analytics = new HashMap<>();
    analytics.put("postTypeStats", postTypeDAO.getPostTypeStats());
    analytics.put("blogTypeStats", blogTypeDAO.getBlogTypeStats());
    analytics.put("engagementMetrics", getEngagementMetrics());
    return analytics;
}
```

### 3. Content Scheduling
```java
// Lên lịch đăng nội dung theo loại
public void scheduleContent(ContentSchedule schedule) {
    // Lên lịch đăng nội dung tự động
    // Tối ưu thời gian đăng theo loại
}
```

## Hướng dẫn triển khai

### 1. Cài đặt Database
```sql
-- Chạy script tạo bảng
source database/post_type_blog_type_tables.sql;
```

### 2. Cập nhật Models
- Thêm trường `postTypeId` vào model `Posts`
- Thêm trường `blogTypeId` vào model `Blog`

### 3. Cập nhật Controllers
- Tích hợp PostType và BlogType vào các controller hiện có
- Thêm logic phân loại nội dung

### 4. Cập nhật Views
- Thêm dropdown chọn loại nội dung
- Hiển thị icon và màu sắc
- Thêm bộ lọc theo loại

### 5. Testing
- Test các API endpoints
- Test form tạo/sửa nội dung
- Test tính năng tìm kiếm và lọc

## Kết luận

Hệ thống phân loại nội dung mang lại nhiều lợi ích cho cả người dùng và quản trị viên. Nó giúp tổ chức nội dung một cách có hệ thống, cải thiện trải nghiệm người dùng và tạo cơ hội tăng doanh thu thông qua các tính năng premium và quảng cáo có mục tiêu. 