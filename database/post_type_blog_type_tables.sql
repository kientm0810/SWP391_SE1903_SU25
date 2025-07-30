-- Tạo bảng PostType để phân loại các loại bài đăng
CREATE TABLE PostType (
    id INT PRIMARY KEY IDENTITY(1,1),
    type_code VARCHAR(50) NOT NULL UNIQUE,
    type_name NVARCHAR(100) NOT NULL,
    description NTEXT,
    category VARCHAR(50) NOT NULL CHECK (category IN ('job_posting', 'content', 'announcement', 'event')),
    priority_level INT DEFAULT 1,
    is_active BIT DEFAULT 1,
    icon_class VARCHAR(100),
    color_code VARCHAR(7),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Tạo bảng BlogType để phân loại các loại blog
CREATE TABLE BlogType (
    id INT PRIMARY KEY IDENTITY(1,1),
    type_code VARCHAR(50) NOT NULL UNIQUE,
    type_name NVARCHAR(100) NOT NULL,
    description NTEXT,
    category VARCHAR(50) NOT NULL CHECK (category IN ('career_advice', 'industry_news', 'company_culture', 'job_search', 'interview_prep', 'professional_development')),
    target_audience VARCHAR(50) NOT NULL CHECK (target_audience IN ('job_seekers', 'recruiters', 'students', 'professionals', 'all')),
    content_format VARCHAR(50) DEFAULT 'article' CHECK (content_format IN ('article', 'video', 'infographic', 'case_study', 'interview', 'podcast')),
    is_active BIT DEFAULT 1,
    icon_class VARCHAR(100),
    color_code VARCHAR(7),
    seo_keywords NVARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Thêm cột post_type_id và blog_type_id vào bảng Posts và Blog
ALTER TABLE Posts ADD post_type_id INT NULL;
ALTER TABLE Blog ADD blog_type_id INT NULL;

-- Thêm foreign key constraints
ALTER TABLE Posts ADD CONSTRAINT fk_posts_post_type FOREIGN KEY (post_type_id) REFERENCES PostType(id);
ALTER TABLE Blog ADD CONSTRAINT fk_blog_blog_type FOREIGN KEY (blog_type_id) REFERENCES BlogType(id);

-- Insert sample data cho PostType
INSERT INTO PostType (type_code, type_name, description, category, priority_level, icon_class, color_code) VALUES
('full_time', N'Toàn thời gian', N'Công việc toàn thời gian 40+ giờ/tuần', 'job_posting', 1, 'fas fa-clock', '#28a745'),
('part_time', N'Bán thời gian', N'Công việc bán thời gian < 40 giờ/tuần', 'job_posting', 2, 'fas fa-hourglass-half', '#ffc107'),
('contract', N'Hợp đồng', N'Công việc theo hợp đồng có thời hạn', 'job_posting', 3, 'fas fa-file-contract', '#17a2b8'),
('internship', N'Thực tập', N'Vị trí thực tập cho sinh viên', 'job_posting', 4, 'fas fa-graduation-cap', '#6f42c1'),
('freelance', N'Freelance', N'Công việc tự do, dự án ngắn hạn', 'job_posting', 5, 'fas fa-user-tie', '#fd7e14'),
('remote', N'Làm việc từ xa', N'Công việc có thể làm từ xa', 'job_posting', 1, 'fas fa-home', '#20c997'),
('hybrid', N'Làm việc kết hợp', N'Kết hợp làm việc tại văn phòng và từ xa', 'job_posting', 2, 'fas fa-laptop-house', '#6c757d'),
('urgent', N'Khẩn cấp', N'Vị trí cần tuyển gấp', 'job_posting', 1, 'fas fa-exclamation-triangle', '#dc3545'),
('featured', N'Nổi bật', N'Bài đăng được ưu tiên hiển thị', 'content', 1, 'fas fa-star', '#ffc107'),
('premium', N'Premium', N'Nội dung cao cấp, trả phí', 'content', 1, 'fas fa-crown', '#ffd700'),
('article', N'Bài viết', N'Bài viết thông thường', 'content', 3, 'fas fa-newspaper', '#007bff'),
('news', N'Tin tức', N'Tin tức mới nhất', 'content', 2, 'fas fa-rss', '#28a745'),
('announcement', N'Thông báo', N'Thông báo quan trọng', 'announcement', 1, 'fas fa-bullhorn', '#dc3545'),
('event', N'Sự kiện', N'Thông tin về sự kiện', 'event', 2, 'fas fa-calendar-alt', '#17a2b8');

-- Insert sample data cho BlogType
INSERT INTO BlogType (type_code, type_name, description, category, target_audience, content_format, icon_class, color_code, seo_keywords) VALUES
('career_advice', N'Tư vấn nghề nghiệp', N'Lời khuyên về phát triển sự nghiệp', 'career_advice', 'professionals', 'article', 'fas fa-lightbulb', '#28a745', 'career advice, professional development, career growth'),
('interview_tips', N'Mẹo phỏng vấn', N'Kỹ năng và mẹo phỏng vấn hiệu quả', 'interview_prep', 'job_seekers', 'article', 'fas fa-handshake', '#007bff', 'interview tips, job interview, interview preparation'),
('resume_writing', N'Viết CV', N'Hướng dẫn viết CV chuyên nghiệp', 'job_search', 'job_seekers', 'article', 'fas fa-file-alt', '#17a2b8', 'resume writing, CV tips, job application'),
('industry_trends', N'Xu hướng ngành', N'Phân tích xu hướng ngành nghề', 'industry_news', 'all', 'article', 'fas fa-chart-line', '#ffc107', 'industry trends, market analysis, career outlook'),
('company_culture', N'Văn hóa công ty', N'Văn hóa và môi trường làm việc', 'company_culture', 'job_seekers', 'article', 'fas fa-users', '#6f42c1', 'company culture, workplace culture, employee experience'),
('salary_negotiation', N'Đàm phán lương', N'Kỹ năng đàm phán mức lương', 'career_advice', 'professionals', 'article', 'fas fa-dollar-sign', '#28a745', 'salary negotiation, compensation, salary tips'),
('remote_work', N'Làm việc từ xa', N'Kinh nghiệm và tips làm việc từ xa', 'professional_development', 'professionals', 'article', 'fas fa-laptop', '#20c997', 'remote work, work from home, telecommuting'),
('job_search_strategy', N'Chiến lược tìm việc', N'Chiến lược tìm kiếm việc làm hiệu quả', 'job_search', 'job_seekers', 'article', 'fas fa-search', '#fd7e14', 'job search strategy, job hunting, career planning'),
('leadership_skills', N'Kỹ năng lãnh đạo', N'Phát triển kỹ năng lãnh đạo', 'professional_development', 'professionals', 'article', 'fas fa-crown', '#ffd700', 'leadership skills, management, team building'),
('tech_skills', N'Kỹ năng công nghệ', N'Phát triển kỹ năng công nghệ', 'professional_development', 'professionals', 'article', 'fas fa-code', '#6c757d', 'tech skills, programming, digital skills'),
('work_life_balance', N'Cân bằng cuộc sống', N'Cân bằng giữa công việc và cuộc sống', 'career_advice', 'all', 'article', 'fas fa-balance-scale', '#28a745', 'work life balance, wellness, productivity');

-- Tạo bảng UserPreferences để lưu sở thích của user
CREATE TABLE UserPreferences (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('job_seeker', 'recruiter', 'admin')),
    post_type_id INT NULL,
    blog_type_id INT NULL,
    preference_level INT DEFAULT 1 CHECK (preference_level BETWEEN 1 AND 5),
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_type_id) REFERENCES PostType(id),
    FOREIGN KEY (blog_type_id) REFERENCES BlogType(id)
);

-- Tạo bảng ContentAnalytics để thống kê hiệu suất nội dung
CREATE TABLE ContentAnalytics (
    id INT PRIMARY KEY IDENTITY(1,1),
    content_id INT NOT NULL,
    content_type VARCHAR(20) NOT NULL CHECK (content_type IN ('post', 'blog')),
    post_type_id INT NULL,
    blog_type_id INT NULL,
    view_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    share_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    click_count INT DEFAULT 0,
    conversion_rate DECIMAL(5,2) DEFAULT 0.00,
    engagement_score DECIMAL(5,2) DEFAULT 0.00,
    date_recorded DATE DEFAULT GETDATE(),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_type_id) REFERENCES PostType(id),
    FOREIGN KEY (blog_type_id) REFERENCES BlogType(id)
);

-- Tạo indexes cho performance
CREATE INDEX idx_posts_post_type ON Posts(post_type_id, status);
CREATE INDEX idx_blog_blog_type ON Blog(blog_type_id, status);
CREATE INDEX idx_user_preferences ON UserPreferences(user_id, user_type, is_active);
CREATE INDEX idx_content_analytics ON ContentAnalytics(content_id, content_type, date_recorded);

-- Tạo view để thống kê nội dung theo loại
GO
CREATE VIEW v_ContentTypeStats AS
SELECT 
    'post' as content_type,
    pt.type_name,
    pt.type_code,
    COUNT(p.id) as total_count,
    COUNT(CASE WHEN p.status = 'active' THEN 1 END) as active_count,
    AVG(CAST(p.view_count AS FLOAT)) as avg_views,
    AVG(CAST(p.like_count AS FLOAT)) as avg_likes
FROM PostType pt
LEFT JOIN Posts p ON pt.id = p.post_type_id
GROUP BY pt.id, pt.type_name, pt.type_code

UNION ALL

SELECT 
    'blog' as content_type,
    bt.type_name,
    bt.type_code,
    COUNT(b.id) as total_count,
    COUNT(CASE WHEN b.status = 'published' THEN 1 END) as active_count,
    0 as avg_views,
    0 as avg_likes
FROM BlogType bt
LEFT JOIN Blog b ON bt.id = b.blog_type_id
GROUP BY bt.id, bt.type_name, bt.type_code;
GO

-- Tạo stored procedure để lấy nội dung theo sở thích user
GO
CREATE PROCEDURE sp_GetPersonalizedContent
    @user_id INT,
    @user_type VARCHAR(20),
    @content_type VARCHAR(20) = 'post',
    @limit INT = 10
AS
BEGIN
    IF @content_type = 'post'
    BEGIN
        SELECT TOP(@limit) p.*, pt.type_name, pt.icon_class, pt.color_code
        FROM Posts p
        INNER JOIN PostType pt ON p.post_type_id = pt.id
        INNER JOIN UserPreferences up ON pt.id = up.post_type_id
        WHERE up.user_id = @user_id 
        AND up.user_type = @user_type
        AND up.is_active = 1
        AND p.status = 'active'
        ORDER BY up.preference_level DESC, p.created_at DESC
    END
    ELSE IF @content_type = 'blog'
    BEGIN
        SELECT TOP(@limit) b.*, bt.type_name, bt.icon_class, bt.color_code
        FROM Blog b
        INNER JOIN BlogType bt ON b.blog_type_id = bt.id
        INNER JOIN UserPreferences up ON bt.id = up.blog_type_id
        WHERE up.user_id = @user_id 
        AND up.user_type = @user_type
        AND up.is_active = 1
        AND b.status = 'published'
        ORDER BY up.preference_level DESC, b.created_at DESC
    END
END;
GO 