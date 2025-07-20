-- =====================================================
-- TẠO BẢNG CHO CÁC PHẦN TRONG PROFILE CỦA JOB SEEKER
-- =====================================================

-- 1. Bảng kinh nghiệm làm việc
CREATE TABLE Job_Seeker_Experiences (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    position NVARCHAR(100) NOT NULL,
    company_name NVARCHAR(100) NOT NULL,
    company_logo VARCHAR(255),
    location NVARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE NULL, -- NULL nếu đang làm việc
    is_current BIT DEFAULT 0,
    description NTEXT,
    achievements NTEXT,
    skills_used NVARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id) ON DELETE CASCADE
);

-- 2. Bảng chứng chỉ
CREATE TABLE Job_Seeker_Certificates (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    certificate_name NVARCHAR(200) NOT NULL,
    issuing_organization NVARCHAR(200) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NULL,
    credential_id VARCHAR(100),
    credential_url VARCHAR(500),
    description NTEXT,
    image_path VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id) ON DELETE CASCADE
);

-- 3. Bảng học vấn
CREATE TABLE Job_Seeker_Educations (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    degree NVARCHAR(100) NOT NULL,
    field_of_study NVARCHAR(100),
    institution_name NVARCHAR(200) NOT NULL,
    location NVARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE NULL,
    is_current BIT DEFAULT 0,
    gpa DECIMAL(3,2),
    grade NVARCHAR(20),
    activities NTEXT,
    description NTEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id) ON DELETE CASCADE
);

-- 4. Bảng giải thưởng
CREATE TABLE Job_Seeker_Awards (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    award_name NVARCHAR(200) NOT NULL,
    issuing_organization NVARCHAR(200) NOT NULL,
    date_received DATE NOT NULL,
    description NTEXT,
    image_path VARCHAR(255),
    certificate_url VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id) ON DELETE CASCADE
);

-- =====================================================
-- TẠO INDEXES CHO HIỆU SUẤT
-- =====================================================

-- Indexes cho Experiences
CREATE INDEX idx_experiences_job_seeker ON Job_Seeker_Experiences(job_seeker_id);
CREATE INDEX idx_experiences_current ON Job_Seeker_Experiences(is_current);
CREATE INDEX idx_experiences_start_date ON Job_Seeker_Experiences(start_date DESC);

-- Indexes cho Certificates
CREATE INDEX idx_certificates_job_seeker ON Job_Seeker_Certificates(job_seeker_id);
CREATE INDEX idx_certificates_issue_date ON Job_Seeker_Certificates(issue_date DESC);

-- Indexes cho Education
CREATE INDEX idx_education_job_seeker ON Job_Seeker_Educations(job_seeker_id);
CREATE INDEX idx_education_current ON Job_Seeker_Educations(is_current);
CREATE INDEX idx_education_start_date ON Job_Seeker_Educations(start_date DESC);

-- Indexes cho Awards
CREATE INDEX idx_awards_job_seeker ON Job_Seeker_Awards(job_seeker_id);
CREATE INDEX idx_awards_date_received ON Job_Seeker_Awards(date_received DESC);

-- =====================================================
-- DỮ LIỆU MẪU ĐỂ TEST
-- =====================================================

-- Sample experiences
INSERT INTO Job_Seeker_Experiences (job_seeker_id, position, company_name, location, start_date, end_date, is_current, description, skills_used) VALUES
(1, N'Backend Developer', N'FPT Software', N'Hà Nội', '2020-01-01', '2023-06-30', 0, N'Phát triển và bảo trì các ứng dụng web sử dụng Java Spring Boot', N'Java, Spring Boot, MySQL, AWS'),
(1, N'Senior Java Developer', N'TechViet Solutions', N'Hà Nội', '2023-07-01', NULL, 1, N'Dẫn dắt team phát triển các dự án enterprise', N'Java, Microservices, Docker, Kubernetes'),
(2, N'UI/UX Designer', N'Creative Agency', N'Hà Nội', '2021-03-15', '2023-08-31', 0, N'Thiết kế giao diện người dùng cho các ứng dụng mobile và web', N'Figma, Adobe XD, Photoshop, Sketch'),
(3, N'Data Scientist', N'VinAI Research', N'TP.HCM', '2019-09-01', NULL, 1, N'Nghiên cứu và phát triển các mô hình machine learning', N'Python, TensorFlow, PyTorch, SQL');

-- Sample certificates
INSERT INTO Job_Seeker_Certificates (job_seeker_id, certificate_name, issuing_organization, issue_date, credential_id, description) VALUES
(1, N'Oracle Java SE 11 Certified Professional', N'Oracle', '2022-03-15', 'OCP-JAVA-2022-001', N'Chứng chỉ chuyên nghiệp Java SE 11'),
(1, N'AWS Certified Developer', N'Amazon Web Services', '2023-01-20', 'AWS-DEV-2023-001', N'Chứng chỉ phát triển ứng dụng trên AWS'),
(2, N'Adobe Certified Expert - Photoshop', N'Adobe', '2022-11-10', 'ACE-PS-2022-001', N'Chứng chỉ chuyên gia Adobe Photoshop'),
(3, N'Google Cloud Professional Data Engineer', N'Google', '2023-05-30', 'GCP-DE-2023-001', N'Chứng chỉ kỹ sư dữ liệu Google Cloud');

-- Sample education
INSERT INTO Job_Seeker_Educations (job_seeker_id, degree, field_of_study, institution_name, location, start_date, end_date, gpa) VALUES
(1, N'Cử nhân', N'Khoa học Máy tính', N'Đại học Bách khoa Hà Nội', N'Hà Nội', '2016-09-01', '2020-06-30', 3.5),
(2, N'Cử nhân', N'Thiết kế Đồ họa', N'Đại học Mỹ thuật Công nghiệp Hà Nội', N'Hà Nội', '2017-09-01', '2021-06-30', 3.8),
(3, N'Thạc sĩ', N'Khoa học Dữ liệu', N'Đại học Khoa học Tự nhiên TP.HCM', N'TP.HCM', '2017-09-01', '2019-06-30', 3.9);

-- Sample awards
INSERT INTO Job_Seeker_Awards (job_seeker_id, award_name, issuing_organization, date_received, description) VALUES
(1, N'Employee of the Year 2022', N'FPT Software', '2022-12-31', N'Nhân viên xuất sắc nhất năm 2022'),
(2, N'Best UI Design Award', N'Vietnam Design Awards', '2023-04-15', N'Giải thưởng thiết kế UI xuất sắc nhất'),
(3, N'Best Research Paper', N'RIVF Conference 2023', '2023-12-10', N'Bài báo nghiên cứu xuất sắc nhất tại hội nghị RIVF');

PRINT 'Job Seeker Profile tables created successfully';
PRINT 'Sample data inserted for testing'; 