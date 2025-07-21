create database project_SWP391;
Use project_SWP391;

-- 1. Admin
CREATE TABLE Admin (
    id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20), 
    date_of_birth DATE,
    gender VARCHAR(10),
    address NVARCHAR(255),
    profile_picture VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_active BIT DEFAULT 1,
    role VARCHAR(20) DEFAULT 'admin' CHECK (role IN ('admin', 'manager', 'saler'))
);

-- 2. Recruiter
CREATE TABLE Recruiter (
    id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20), 
    date_of_birth DATE,
    gender VARCHAR(10),
    address NVARCHAR(255),
    profile_picture VARCHAR(255),
    company_name NVARCHAR(100) NOT NULL,
    company_description NTEXT,
    logo VARCHAR(255),
    website VARCHAR(255),
    company_address NVARCHAR(255),
    company_size VARCHAR(50), 
    industry NVARCHAR(100), 
    tax_code VARCHAR(50), 
    loyalty_score DECIMAL(10, 2) DEFAULT 0.0,
    verification_status VARCHAR(20) DEFAULT 'pending' CHECK (verification_status IN ('pending', 'verified', 'rejected')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_active BIT DEFAULT 1
);

-- 3. Job_Seekers
CREATE TABLE Job_Seekers (
    id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    gender VARCHAR(10),
    address NVARCHAR(255),
    profile_picture VARCHAR(255),
    cv_file VARCHAR(255),
    skills TEXT,
    experience_years INT,
    education TEXT,
    desired_job_title NVARCHAR(100),
    desired_salary DECIMAL(15,2),
    job_category NVARCHAR(100),
    preferred_location NVARCHAR(100),
    career_level VARCHAR(50), 
    work_type NVARCHAR(50), 
    profile_summary NTEXT,
    portfolio_url VARCHAR(255),
    languages NTEXT, 
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_active BIT DEFAULT 1
);

-- 4. Job_Categories
CREATE TABLE Job_Categories (
    id INT PRIMARY KEY IDENTITY(1,1),
    category_name NVARCHAR(100) NOT NULL UNIQUE,
    description NTEXT,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- 5. Promotion_Programs
CREATE TABLE Promotion_Programs (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    cost DECIMAL(12, 2) NOT NULL,
    duration_days INT NOT NULL,
    description NTEXT,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    admin_id INT NULL,
    position_type VARCHAR(20) DEFAULT 'normal' CHECK (position_type IN ('normal', 'featured', 'premium')),
    quantity INT DEFAULT -1,
    FOREIGN KEY (admin_id) REFERENCES Admin(id)
);

-- Posts (Corrected)
CREATE TABLE Posts (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Added PRIMARY KEY
    user_id INT NOT NULL,
    user_type NVARCHAR(20) NOT NULL,
    parent_id INT NULL,
    post_type NVARCHAR(20) NOT NULL,
    title NVARCHAR(MAX) NULL,
    content NVARCHAR(MAX) NULL,
    status NVARCHAR(20) NULL,
    view_count INT NULL,
    like_count INT NULL,
    comment_count INT NULL,
    created_at DATETIME NULL,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    company_name NVARCHAR(255) NULL,
    company_logo VARCHAR(500) NULL,
    salary NVARCHAR(100) NULL,
    location NVARCHAR(255) NULL,
    job_type NVARCHAR(50) NULL,
    experience NVARCHAR(100) NULL,
    deadline DATE NULL,
    working_time NVARCHAR(200) NULL,
    job_description NVARCHAR(MAX) NULL,
    requirements NVARCHAR(MAX) NULL,
    benefits NVARCHAR(MAX) NULL,
    contact_address NVARCHAR(500) NULL,
    application_method NVARCHAR(MAX) NULL,
    quantity INT NULL,
    rank NVARCHAR(100) NULL,
    industry NVARCHAR(255) NULL,
    contact_person NVARCHAR(255) NULL,
    company_size NVARCHAR(100) NULL,
    company_website NVARCHAR(500) NULL,
    company_description NVARCHAR(MAX) NULL,
    keywords NVARCHAR(500) NULL,
    salary_min DECIMAL(12, 2) NULL,
    salary_max DECIMAL(12, 2) NULL,
    experience_years INT NULL,
    education_level NVARCHAR(100) NULL,
    skills_required NVARCHAR(MAX) NULL,
    languages_required NVARCHAR(500) NULL,
    work_environment NVARCHAR(100) NULL,
    job_level NVARCHAR(50) NULL,
    contract_type NVARCHAR(50) NULL,
    probation_period NVARCHAR(100) NULL,
    application_deadline DATETIME NULL,
    is_featured BIT NULL DEFAULT 0,
    is_urgent BIT NULL DEFAULT 0,
    search_priority INT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Recruiter(id)
);

-- Applications
CREATE TABLE Applications (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    job_seeker_id INT NOT NULL,
    cv_file VARCHAR(255),
    cover_letter NTEXT,
    status VARCHAR(20) DEFAULT 'new' CHECK (status IN ('new', 'reviewed', 'interviewed', 'offered', 'rejected')),
    applied_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Posts(id),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);
-- 8. Recruitment_Stages
CREATE TABLE Recruitment_Stages (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    stage_name VARCHAR(50) NOT NULL,
    order_num INT NOT NULL,
    description NTEXT,
    expected_duration INT,
    FOREIGN KEY (post_id) REFERENCES Posts(id)
);

-- 9. Application_Stages
CREATE TABLE Application_Stages (
    id INT PRIMARY KEY IDENTITY(1,1),
    application_id INT NOT NULL,
    stage_id INT NOT NULL,
    date_completed DATETIME,
    notes TEXT,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    FOREIGN KEY (application_id) REFERENCES Applications(id),
    FOREIGN KEY (stage_id) REFERENCES Recruitment_Stages(id)
);

-- 10. Financial_Transactions
CREATE TABLE Financial_Transactions (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruiter_id INT NOT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    transaction_type VARCHAR(20) NOT NULL CHECK (transaction_type IN ('normal', 'featured', 'premium', 'featured_job', 'advertising', 'subscription', 'cv_service', 'checkout', 'other', 'registration')),
    amount DECIMAL(12, 2) NOT NULL,
    description NTEXT,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    transaction_date DATETIME DEFAULT GETDATE(),
    payment_method NVARCHAR(50),
    transaction_code VARCHAR(100),
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(id)
);

-- 11. Featured_Jobs
CREATE TABLE Featured_Jobs (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    promotion_id INT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    transaction_id INT NULL,
    FOREIGN KEY (post_id) REFERENCES Posts(id),
    FOREIGN KEY (promotion_id) REFERENCES Promotion_Programs(id),
    FOREIGN KEY (transaction_id) REFERENCES Financial_Transactions(id)
);

-- 12. Notifications
CREATE TABLE Notifications (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('admin', 'recruiter', 'job_seeker')),
    title NVARCHAR(255) NOT NULL,
    redirect_url NVARCHAR(255),
    content NTEXT NOT NULL,
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);

-- 13. Job_SeekersNotification
CREATE TABLE Job_SeekersNotification (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    notification_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id),
    FOREIGN KEY (notification_id) REFERENCES Notifications(id)
);

-- 14. RecruiterNotification
CREATE TABLE RecruiterNotification (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    recruiter_id INT NOT NULL,
    notification_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(id),
    FOREIGN KEY (notification_id) REFERENCES Notifications(id)
);

-- 15. Search_History
CREATE TABLE Search_History (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    search_query NVARCHAR(255),
    search_filters NTEXT,
    search_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- 16. CV_Skills
CREATE TABLE CV_Skills (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    skill_name NVARCHAR(100) NOT NULL,
    proficiency_level NVARCHAR(20),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- 17. CV_Templates
CREATE TABLE cv_templates (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    job_position NVARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    address NVARCHAR(255),
    certificates TEXT,
    work_experience NTEXT,
    image_path VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- 18. Job_Seeker_CVs
CREATE TABLE Job_Seeker_CVs (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    cv_template_id INT,
    cv_content NTEXT,
    title NVARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_default BIT DEFAULT 0,
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id),
    FOREIGN KEY (cv_template_id) REFERENCES CV_Templates(id)
);

-- 19. Reports
CREATE TABLE Reports (
    id INT PRIMARY KEY IDENTITY(1,1),
    report_type VARCHAR(100) NOT NULL CHECK (report_type IN ('employer_list', 'revenue', 'loyalty', 'job_seeker_activity', 'job_application_stats')),
    generated_by INT NOT NULL,
    start_date DATETIME,
    end_date DATETIME,
    data NTEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (generated_by) REFERENCES Admin(id)
);

-- 20. Interviews
CREATE TABLE Interviews (
    id INT PRIMARY KEY IDENTITY(1,1),
    application_id INT NOT NULL,
    interview_time DATETIME NOT NULL,
    location NVARCHAR(255),
    interviewer NVARCHAR(100),
    result NVARCHAR(50),
    notes NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (application_id) REFERENCES Applications(id)
);

-- 21. Interview_Schedule
CREATE TABLE Interview_Schedule (
    id INT PRIMARY KEY IDENTITY(1,1),
    interview_id INT NOT NULL,
    application_id INT NOT NULL,
    scheduled_time DATETIME NOT NULL,
    location NVARCHAR(255),
    interviewer NVARCHAR(100),
    status VARCHAR(20) DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'completed', 'cancelled')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (interview_id) REFERENCES Interviews(id),
    FOREIGN KEY (application_id) REFERENCES Applications(id)
);

-- 22. Application_Status_History
CREATE TABLE Application_Status_History (
    id INT PRIMARY KEY IDENTITY(1,1),
    application_id INT NOT NULL,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    changed_by INT,
    changed_at DATETIME DEFAULT GETDATE(),
    notes NVARCHAR(MAX),
    FOREIGN KEY (application_id) REFERENCES Applications(id)
);

-- 23. Candidate_Evaluations
CREATE TABLE Candidate_Evaluations (
    id INT PRIMARY KEY IDENTITY(1,1),
    application_id INT NOT NULL,
    stage_id INT NOT NULL,
    evaluator_id INT NOT NULL,
    score INT,
    comments NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (application_id) REFERENCES Applications(id),
    FOREIGN KEY (stage_id) REFERENCES Recruitment_Stages(id)
);

-- 24. Saved_Jobs
CREATE TABLE Saved_Jobs (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NULL,
    recruiter_id INT NULL,
    post_id INT NOT NULL,
    saved_at DATETIME DEFAULT GETDATE(),
    UNIQUE (job_seeker_id, recruiter_id, post_id),
    CHECK (
        (job_seeker_id IS NOT NULL AND recruiter_id IS NULL)
        OR
        (job_seeker_id IS NULL AND recruiter_id IS NOT NULL)
    ),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id),
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(id),
    FOREIGN KEY (post_id) REFERENCES Posts(id)
);

-- 25. Post_Pricing
CREATE TABLE Post_Pricing (
    id INT PRIMARY KEY IDENTITY(1,1),
    position_name NVARCHAR(100) NOT NULL,
    position_code VARCHAR(50) NOT NULL UNIQUE,
    price DECIMAL(12, 2) NOT NULL,
    duration_days INT NOT NULL,
    description NVARCHAR(255),
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);

-- 26. Email
CREATE TABLE Email (
    id INT PRIMARY KEY IDENTITY(1,1),
    sender_id INT NOT NULL,
    sender_type VARCHAR(20) NOT NULL CHECK (sender_type IN ('admin', 'recruiter', 'job_seeker')),
    recipient_email VARCHAR(100) NOT NULL,
    subject NVARCHAR(255) NOT NULL,
    content NTEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'failed')),
    created_at DATETIME DEFAULT GETDATE(),
    sent_at DATETIME
);

CREATE TABLE Email_Templates (
    id INT IDENTITY(1,1) PRIMARY KEY,
    template_name NVARCHAR(255) NOT NULL,
    template_type NVARCHAR(100) NOT NULL, -- application_received, interview_invitation, interview_reminder, rejection, offer, custom
    subject NVARCHAR(500) NOT NULL,
    body_html NTEXT NOT NULL,
    body_text NTEXT NULL,
    variables NVARCHAR(MAX) NULL, -- JSON string chứa danh sách các biến có thể sử dụng
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    created_by INT NOT NULL, -- ID của user tạo template (admin/recruiter)
    
    CONSTRAINT FK_EmailTemplates_CreatedBy FOREIGN KEY (created_by) REFERENCES Admin(id)
);

-- Tạo bảng Email_History
CREATE TABLE Email_History (
    id INT IDENTITY(1,1) PRIMARY KEY,
    application_id INT NULL, -- ID của application (nếu liên quan)
    interview_schedule_id INT NULL, -- ID của interview schedule (nếu liên quan)
    template_id INT NULL, -- ID của template được sử dụng
    recipient_email NVARCHAR(255) NOT NULL,
    subject NVARCHAR(500) NOT NULL,
    body_html NTEXT NOT NULL,
    status NVARCHAR(50) DEFAULT 'pending', -- pending, sent, failed, bounced
    error_message NVARCHAR(MAX) NULL,
    sent_at DATETIME NULL,
    created_at DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_EmailHistory_Application FOREIGN KEY (application_id) REFERENCES Applications(id),
    CONSTRAINT FK_EmailHistory_InterviewSchedule FOREIGN KEY (interview_schedule_id) REFERENCES Interview_Schedule(id),
    CONSTRAINT FK_EmailHistory_Template FOREIGN KEY (template_id) REFERENCES Email_Templates(id)
);

-- Tạo index để tối ưu hiệu suất truy vấn
CREATE INDEX IX_EmailTemplates_Type ON Email_Templates(template_type);
CREATE INDEX IX_EmailTemplates_Active ON Email_Templates(is_active);
CREATE INDEX IX_EmailTemplates_CreatedBy ON Email_Templates(created_by);

CREATE INDEX IX_EmailHistory_Application ON Email_History(application_id);
CREATE INDEX IX_EmailHistory_Status ON Email_History(status);
CREATE INDEX IX_EmailHistory_Recipient ON Email_History(recipient_email);
CREATE INDEX IX_EmailHistory_CreatedAt ON Email_History(created_at);
CREATE INDEX IX_EmailHistory_Template ON Email_History(template_id);


-- 29. Job_Alerts
CREATE TABLE Job_Alerts (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    job_category NVARCHAR(100),
    keywords NVARCHAR(255),
    location NVARCHAR(255),
    salary_min DECIMAL(12, 2),
    salary_max DECIMAL(12, 2),
    job_type NVARCHAR(50),
    frequency VARCHAR(20) DEFAULT 'daily' CHECK (frequency IN ('daily', 'weekly', 'monthly')),
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- 30. Job_Listings
CREATE TABLE Job_Listings (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruiter_id INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    description NTEXT NOT NULL,
    location NVARCHAR(255),
    salary_min DECIMAL(12, 2),
    salary_max DECIMAL(12, 2),
    job_type NVARCHAR(50),
    experience_years INT,
    education_level NVARCHAR(100),
    status VARCHAR(20) DEFAULT 'open' CHECK (status IN ('open', 'closed', 'draft')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    application_deadline DATETIME,
    is_featured BIT DEFAULT 0,
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(id)
);

-- 31. Job_Searches
CREATE TABLE Job_Searches (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT,
    search_query NVARCHAR(255),
    location NVARCHAR(255),
    job_category NVARCHAR(100),
    salary_min DECIMAL(12, 2),
    salary_max DECIMAL(12, 2),
    job_type NVARCHAR(50),
    search_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- 32. Post_Skills
CREATE TABLE Post_Skills (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    skill_name NVARCHAR(100) NOT NULL,
    proficiency_level NVARCHAR(20),
    FOREIGN KEY (post_id) REFERENCES Posts(id)
);

-- 33. Recruitment_Process
CREATE TABLE Recruitment_Process (
    id INT PRIMARY KEY IDENTITY(1,1),
    application_id INT NOT NULL,
    current_stage VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    notes TEXT,
    assigned_hr_id INT NOT NULL,
    assigned_recruiter_id INT NOT NULL,
    FOREIGN KEY (application_id) REFERENCES Applications(id),
    FOREIGN KEY (assigned_recruiter_id) REFERENCES Recruiter(id)
);

-- 34. Screening_Results
CREATE TABLE Screening_Results (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruitment_process_id INT NOT NULL,
    screening_type VARCHAR(20) NOT NULL,
    result VARCHAR(20) NOT NULL,
    score INT NOT NULL,
    feedback NVARCHAR(MAX),
    reviewer_name VARCHAR(100) NOT NULL,
    reviewed_at DATETIME2 DEFAULT GETDATE(),
    criteria NVARCHAR(MAX),
    FOREIGN KEY (recruitment_process_id) REFERENCES Recruitment_Process(id)
);

-- 35. Search_Analytics
CREATE TABLE Search_Analytics (
    id INT PRIMARY KEY IDENTITY(1,1),
    search_query NVARCHAR(255),
    search_count INT DEFAULT 1,
    last_searched DATETIME DEFAULT GETDATE(),
    job_category NVARCHAR(100),
    location NVARCHAR(255)
);

-- 36. Search_Suggestions
CREATE TABLE Search_Suggestions (
    id INT PRIMARY KEY IDENTITY(1,1),
    suggestion_text NVARCHAR(255) NOT NULL,
    category NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- 37. Skills_Tests
CREATE TABLE Skills_Tests (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruitment_process_id INT NOT NULL,
    test_type VARCHAR(30) NOT NULL,
    test_name NVARCHAR(200) NOT NULL,
    test_url VARCHAR(500),
    scheduled_at DATETIME2 NOT NULL,
    deadline DATETIME2 NOT NULL,
    completed_at DATETIME2,
    status VARCHAR(20) NOT NULL,
    score INT,
    result VARCHAR(20),
    feedback NVARCHAR(MAX),
    test_instructions NVARCHAR(MAX),
    FOREIGN KEY (recruitment_process_id) REFERENCES Recruitment_Process(id)
);

-- 38. Blog
CREATE TABLE Blog (
    id INT PRIMARY KEY IDENTITY(1,1),
    admin_id INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    thumbnail NVARCHAR(MAX),
    status VARCHAR(20) DEFAULT 'draft' CHECK (status IN ('draft', 'published')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_admin_blog FOREIGN KEY (admin_id)
        REFERENCES Admin(id)
        ON DELETE CASCADE
);

-- 39. Banner
CREATE TABLE Banner (
    id INT PRIMARY KEY IDENTITY(1,1),
    admin_id INT NOT NULL,
    title NVARCHAR(255),
    image_url NVARCHAR(MAX),
    redirect_url NVARCHAR(MAX),
    position INT DEFAULT 0,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_admin_banner FOREIGN KEY (admin_id)
        REFERENCES Admin(id)
        ON DELETE CASCADE
);

-- Create Indexes for performance optimization
CREATE INDEX idx_skill_name ON CV_Skills(skill_name);
CREATE INDEX idx_applications_job_seeker_id ON Applications(job_seeker_id);
CREATE INDEX idx_posts_user ON Posts(user_id, user_type);
CREATE INDEX idx_posts_parent ON Posts(parent_id);
CREATE INDEX idx_posts_type ON Posts(post_type);
CREATE INDEX idx_posts_status ON Posts(status);
CREATE INDEX idx_posts_created_at ON Posts(created_at DESC);
CREATE INDEX idx_saved_jobs_job_seeker_post ON Saved_Jobs(job_seeker_id, post_id);
CREATE INDEX idx_saved_jobs_recruiter_post ON Saved_Jobs(recruiter_id, post_id);
CREATE INDEX idx_post_pricing_code ON Post_Pricing(position_code);
CREATE INDEX idx_financial_transactions_type ON Financial_Transactions(transaction_type, status);

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


-- Insert data into Admin table
INSERT INTO Admin (username, password, email, full_name, phone, date_of_birth, gender, address, profile_picture)
VALUES 
('admin1', 'admin1', 'admin1@topcv.com', 'Admin One', '0987654321', '1980-01-01', 'male', 'Hanoi, Vietnam', 'https://logodix.com/logo/1707102.png'),
('admin2', 'admin2', 'admin2@topcv.com', 'Admin Two', '0987654322', '1985-05-05', 'female', 'Ho Chi Minh City, Vietnam', 'https://logodix.com/logo/1707102.png');

-- Insert data into Recruiter table
INSERT INTO Recruiter (username, password, email, full_name, phone, date_of_birth, gender, address, profile_picture, 
                      company_name, company_description, logo, website, company_address, company_size, industry, tax_code, verification_status)
VALUES
('fpt_recruiter', 'password1', 'hr@fpt.com', 'Nguyen Van A', '0912345678', '1982-03-15', 'male', 'FPT Tower, Hanoi', 
 'https://th.bing.com/th/id/OIP.fqiB82T_QPRiIlcOD9YHjwHaEX?w=292&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
 'FPT Software', 'Leading IT services provider in Vietnam', 'https://th.bing.com/th/id/OIP.fqiB82T_QPRiIlcOD9YHjwHaEX?w=292&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', 
 'https://fptsoftware.com', 'FPT Tower, Duy Tan, Hanoi', '5000+', 'Information Technology', '0100109106', 'verified'),
 
('vng_recruiter', 'password2', 'tuyendung@vng.com.vn', 'Tran Thi B', '0912345679', '1988-07-20', 'female', 'VNG Campus, HCMC', 
 'https://th.bing.com/th/id/OIP.2MdNYtKn808uQodEF4FdxQAAAA?rs=1&pid=ImgDetMain',
 'VNG Corporation', 'Vietnams leading internet technology company', 'https://th.bing.com/th/id/OIP.2MdNYtKn808uQodEF4FdxQAAAA?rs=1&pid=ImgDetMain', 
 'https://vng.com.vn', 'VNG Campus, Tan Thuan, HCMC', '3000+', 'Internet Technology', '0303675399', 'verified'),
 
('tiki_hr', 'password3', 'hr@tiki.vn', 'Le Van C', '0912345680', '1985-11-30', 'male', 'Tiki Office, HCMC', 
 'https://th.bing.com/th/id/OIP.o47x8GzYi-Aes0zNIsw4hAHaES?w=295&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
 'Tiki Corporation', 'Vietnams leading e-commerce platform', 'https://th.bing.com/th/id/OIP.o47x8GzYi-Aes0zNIsw4hAHaES?w=295&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', 
 'https://tiki.vn', 'Tiki Office, District 7, HCMC', '1000+', 'E-commerce', '0312862646', 'verified');

-- Insert data into Job_Seekers table
INSERT INTO Job_Seekers (username, password, email, full_name, phone, date_of_birth, gender, address, profile_picture,
                        cv_file, skills, experience_years, education, desired_job_title, desired_salary, job_category, 
                        preferred_location, career_level, work_type, profile_summary, portfolio_url, languages)
VALUES
('nguyen_dev', 'password4', 'nguyen.dev@gmail.com', 'Nguyen Van D', '0912345681', '1995-05-15', 'male', 'Cau Giay, Hanoi', 
 'https://avatars.githubusercontent.com/u/10234503?v=4',
 'nguyen_dev_cv.pdf', 'Java, Spring Boot, SQL, AWS', 3, 'Bachelor in Computer Science, Hanoi University of Science and Technology', 
 'Backend Developer', 2000.00, 'Software Development', 'Hanoi', 'Mid-level', 'Full-time', 
 'Experienced Java developer with 3 years of experience in building scalable web applications', 
 'https://github.com/nguyendev', 'English: Fluent, Japanese: Intermediate'),
 
('linh_designer', 'password5', 'linh.designer@yahoo.com', 'Linh Thi E', '0912345682', '1998-08-25', 'male', 'Ba Dinh, Hanoi', 
 'https://mir-s3-cdn-cf.behance.net/user/230/e6186d10606155.584b69f9c0caf.jpeg',
 'linh_designer_cv.pdf', 'UI/UX Design, Figma, Adobe XD, Photoshop', 2, 'Bachelor in Graphic Design, Hanoi University of Industrial Fine Arts', 
 'UI/UX Designer', 1500.00, 'Design', 'Hanoi, Remote', 'Entry-level', 'Full-time', 
 'Creative designer with strong attention to detail and passion for user-centered design', 
 'https://behance.net/linhdesigner', 'English: Fluent, Vietnamese: Native'),
 
('hoang_ba', 'password6', 'hoang.ba@outlook.com', 'Hoang Van F', '0912345683', '1993-02-10', 'male', 'District 1, HCMC', 
 'https://cdn-new.topcv.vn/unsafe/https://static.topcv.vn/v4/image/cv-template/screenshots/thumbs/cv-template-thumbnails-v1.4/avatar-default/modern_6_v2.png?v=1.01',
 'hoang_ba_cv.pdf', 'Python, Data Analysis, Machine Learning, SQL', 5, 'Master in Data Science, University of Science HCMC', 
 'Data Scientist', 3000.00, 'Data Science', 'HCMC, Remote', 'Senior', 'Full-time', 
 'Data scientist with expertise in machine learning and big data technologies', 
 'https://github.com/hoangba-ds', 'English: Professional, Vietnamese: Native');

-- Insert data into Promotion_Programs table
INSERT INTO Promotion_Programs (name, cost, duration_days, description, is_active, admin_id, position_type)
VALUES
(N'Bài viết thường', 100000, 30, N'Hiển thị trong danh sách tìm kiếm', 1, 1, 'normal'),
(N'Bài viết nổi bật', 300000, 30, N'Hiển thị ở vị trí nổi bật', 1, 1, 'featured'),
(N'Bài viết Premium', 500000, 30, N'Hiển thị ở trang chủ và đầu danh sách', 1, 1, 'premium');

-- Insert sample pricing data
INSERT INTO Post_Pricing (position_name, position_code, price, duration_days, description) 
VALUES 
(N'Bài viết thường', 'normal', 100000, 30, N'Hiển thị trong danh sách tìm kiếm'),
(N'Bài viết nổi bật', 'featured', 300000, 30, N'Hiển thị ở vị trí nổi bật'),
(N'Bài viết Premium', 'premium', 500000, 30, N'Hiển thị ở trang chủ và đầu danh sách'),
(N'Phí đăng ký', 'registration', 50000, 0, N'Phí đăng ký tài khoản nhà tuyển dụng');


-- Insert data into Application_Stages table
INSERT INTO Application_Stages (application_id, stage_id, date_completed, notes, status)
VALUES
(1, 1, '2023-10-01', 'Strong technical background', 'completed'),
(1, 2, '2023-10-05', 'Passed with high score', 'completed'),
(1, 3, NULL, 'Scheduled for next week', 'pending'),
(2, 1, '2023-10-02', 'Impressive experience', 'completed'),
(2, 2, '2023-10-06', 'Excellent problem solving', 'completed'),
(3, 1, '2023-10-03', 'Good potential but limited experience', 'completed');

-- Insert data into Financial_Transactions table
INSERT INTO Financial_Transactions (recruiter_id, type, transaction_type, amount, description, status, payment_method)
VALUES
(1, 'income', 'featured_job', 500.00, 'Featured job listing for Senior Java Developer', 'completed', 'Credit Card'),
(2, 'income', 'featured_job', 500.00, 'Featured job listing for Product Manager', 'completed', 'Bank Transfer'),
(3, 'income', 'advertising', 300.00, 'Banner advertising for 1 month', 'completed', 'Credit Card'),
(1, 'income', 'cv_service', 200.00, 'Premium CV access package', 'completed', 'Bank Transfer');



-- Insert data into Search_History table
INSERT INTO Search_History (job_seeker_id, search_query, search_filters)
VALUES
(1, 'Java Developer', '{"location": "Hanoi", "salary_min": 1500, "job_type": "full_time"}'),
(2, 'UI Designer', '{"location": "Remote", "experience_level": "Entry-level"}'),
(3, 'Data Scientist', '{"location": "HCMC", "salary_min": 2500}'),
(1, 'Spring Boot jobs', '{"location": "Hanoi", "job_type": "full_time"}');



-- Insert data into CV_Templates table
INSERT INTO CV_Templates (job_seeker_id, full_name, job_position, phone, email, address, certificates, work_experience, image_path)
VALUES
(1, 'Nguyen Van D', 'Java Developer', '0912345681', 'nguyen.dev@gmail.com', 'Cau Giay, Hanoi', 
 'Java Certification, AWS Certified Developer', 'Backend Developer at FPT Software (2019-2022)', 'template1.jpg'),
(2, 'Linh Thi E', 'UI/UX Designer', '0912345682', 'linh.designer@yahoo.com', 'Ba Dinh, Hanoi', 
 'Figma Certification, Adobe XD Proficiency', 'UI Designer at Viettel (2020-2022)', 'template2.jpg'),
(3, 'Hoang Van F', 'Data Scientist', '0912345683', 'hoang.ba@outlook.com', 'District 1, HCMC', 
 'Python Certification, Machine Learning Specialization', 'Data Scientist at VinAI (2018-2023)', 'template3.jpg');



-- Insert data into Job_Seeker_CVs table
INSERT INTO Job_Seeker_CVs (job_seeker_id, cv_template_id, cv_content, title, is_default)
VALUES
(1, 1, '{"personal_info": {...}, "experience": [...], "education": [...]}', 'Nguyen Van D - Java Developer CV', 1),
(2, 3, '{"personal_info": {...}, "portfolio": [...], "skills": [...]}', 'Linh Thi E - Design Portfolio', 1),
(3, 2, '{"personal_info": {...}, "projects": [...], "publications": [...]}', 'Hoang Van F - Data Scientist CV', 1),
(1, 4, '{"personal_info": {...}, "experience": [...], "skills": [...]}', 'Nguyen Van D - Simplified CV', 0);


-- Insert data into Reports table
INSERT INTO Reports (report_type, generated_by, start_date, end_date, data)
VALUES
('revenue', 1, '2023-10-01', '2023-10-31', '{"total_income": 1500.00, "transactions": 4}'),
('job_application_stats', 1, '2023-10-01', '2023-10-15', '{"total_applications": 125, "average_per_job": 25}'),
('employer_list', 2, '2023-09-01', '2023-09-30', '{"active_employers": 42, "new_employers": 5}');




SET IDENTITY_INSERT Posts ON;

SET IDENTITY_INSERT Posts ON;
INSERT INTO Posts (
  id, user_id, user_type, parent_id, post_type, title, status, view_count, like_count, comment_count,
  created_at, updated_at, deleted_at, experience, deadline, working_time, job_description,
  requirements, benefits, contact_address, application_method, company_name, salary, location,
  job_type, company_logo, quantity, rank, industry, contact_person, company_size,
  company_website, company_description, keywords
) VALUES (
  19, 1, 'recruiter', NULL, 'post',
  N'Kiến Trúc Sư 3D [Hà Nội] - Lương Cơ Bản Upto 17Tr+++, Tối Thiểu 1 Năm Kinh Nghiệm',
  'active', 25, 0, 0,
  '2025-06-02 21:00:44.083', '2025-06-30 19:33:52.173', NULL,
  N'1 năm', '2025-07-04',
  N'Thứ 2 - Thứ 6 (từ 08:00 đến 17:00) Thứ 7 (từ 08:00 đến 12:00)',
  N'<ul><li>Lên ý tưởng Tổng mặt bằng, và hình khối theo yêu cầu chủ đầu tư</li>...</ul>',
  N'<ul><li>Tốt nghiệp Đại học chuyên ngành Kiến Trúc Công Trình</li>...</ul>',
  N'<ul><li>Mức lương upto 17 triệu...</li>...</ul>',
  N'Tầng 5, Tòa Nhà Báo Nông thôn ngày nay, Ngõ 68 Dương Đình Nghệ, Cầu Giấy, Hà Nội',
  N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>',
  N'Công ty cổ phần tư vấn và xây dựng KM Việt Nam',
  N'Tới 17 triệu', N'Hà Nội', N'Full-time',
  'uploads/company_logos/1751286832172_KMCC.webp',
  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
),

(20, 1, 'recruiter', NULL, 'post', N'Streamer Livestream Game TikTok ( Tuyển Nữ) Thu Nhập Cao Lương Cứng Upto 15Tr + Thưởng KPI Không Giới Hạn - Đào Tạo Từ Đầu Đi Làm Ngay', 'active', 48, 0, 0, '2025-06-02 21:01:21.823', '2025-06-30 19:33:37.880', NULL, N'Không yêu cầu', '2025-07-30', N'Thứ 2 - Thứ 6 (từ 09:00 đến 18:00) Thứ 7 9:00 đến 18:00 (làm việc cách tuần). (Livestream 4 – 5 tiếng mỗi ngày).Khi live cứng chỉ cần lên live từ 4-5 tiếng mỗi ngày.', N'<ul><li>Livestream chơi game trên nền tảng TikTok (không giới hạn thể loại game).</li><li>Tương tác trực tiếp với người xem trong suốt quá trình livestream, tạo nội dung hấp dẫn nhằm thu hút người theo dõi.</li><li>Hỗ trợ lên ý tưởng và cắt dựng video ngắn (clip highlight) từ các buổi livestream để đăng tải lên TikTok, Instagram hoặc Facebook.</li><li>Đảm bảo chất lượng hình ảnh, âm thanh và đường truyền ổn định xuyên suốt buổi phát sóng.</li><li>Thời gian đầu làm việc từ Thứ 2-6 từ 9:00 đến 18:00, T7 cách tuần (Livestream 4 – 5 tiếng mỗi ngày). Khi live cứng chỉ cần lên live từ 4-5 tiếng mỗi ngày.</li></ul>', N'<ul><li><strong>Giới tính: Nữ, độ tuổi từ 18 – 28</strong>, biết trang điểm cơ bản.</li><li>Tự tin, hoạt ngôn, biểu cảm tốt, giao tiếp linh hoạt, biết tương tác, trò chuyện cùng người xem.</li><li>Yêu thích và đam mê chơi game (mọi thể loại đều được).</li><li>Tác phong chuyên nghiệp, năng động, sáng tạo, có tinh thần trách nhiệm trong công việc.</li><li>Có kinh nghiệm livestream là một lợi thế, chưa có sẽ được đào tạo</li></ul>', N'<ul><li>Thu nhập ổn định: <strong>Lương cứng hàng tháng 12- 15 triệu</strong> + <strong>Thưởng KPI hấp dẫn từ 15%-30%</strong></li><li>Được đào tạo bài bản, phát triển kỹ năng livestream, xây dựng hình ảnh cá nhân.</li><li>Hỗ trợ đầy đủ thiết bị livestream chuyên nghiệp.</li><li>Môi trường làm việc trẻ trung, năng động, sẵn sàng hỗ trợ và đồng hành cùng bạn lâu dài.</li><li>Cơ hội thăng tiến trong ngành giải trí, nội dung số và livestream.</li></ul>', N'- Hồ Chí Minh: 117A Nguyễn Tất Thành Phường 13, Quận 4', N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>', N'CÔNG TY TNHH GAMETOK LIVE', N'Thoả thuận', N'Hồ Chí Minh', 'Full-time', 'uploads/company_logos/1751286817879_cty tnhh gametok live.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(115, 1, 'recruiter', NULL, 'post', N'Kỹ Sư Kỹ Thuật Xây Dựng/ Kết Cấu Công Trình Dân Dụng, Công Nghiệp/ Trắc Địa Bản Đồ', 'active', 32, 0, 0, '2025-06-03 20:01:44.007', '2025-06-30 19:33:18.950', NULL, N'1 năm', '2025-07-11', N'1. Thử việc: trong thời gian 60 ngày với mức lương thử việc – 10.000.000đ/tháng. 2. Chế độ công tác: - Đi công tác được nghỉ tại khách sạn với chi phí tối đa 1.100.000 đồng/ngày/phòng. - Mức công t', N'<p>- Tư vấn thiết kế công trình hạ tầng kỹ thuật viễn thông: Tuyến cáp đồng, quang, Cơ sở hạ tầng trạm thu phát sóng (cột anten, nhà trạm, tiếp đất chống sét..), công việc cụ thể:</p><p>- Chủ trì khảo sát địa hình/ Chủ trì thiết kế kết câu công trình hạ tầng kỹ thuật viễn thông.</p><p>- Khảo sát, lập báo cáo khảo sát phục vụ các bước thiết kế công trình hạ tầng kỹ thuật viễn thông.</p><p>- Thiết kế, Ascending, thẩm tra thiết kế cơ sở, thiết kế kỹ thuật, thiết kế bản vẽ thi công công trình hạ tầng kỹ thuật viễn thông.</p><p>- Lập, thẩm tra dự án, dự toán công trình hạ tầng kỹ thuật viễn thông.</p><p>- Giám sát thi công công trình hạ tầng kỹ thuật viễn thông.</p><p>- Kiểm tra cơ sở hạ tầng trạm thu phát sóng.</p><p>&nbsp;</p>', N'<p>-Độ tuổi : Từ 35 tuổi trở xuống</p><p>-Tốt nghiệp bằng khá trở lên chuyên ngành kỹ thuật xây dựng/Kết cấu công trình dân dụng, công nghiệp/Trắc địa, bản đồ</p><p>-Tốt nghiệp chính quy tại các trường sau:</p><p>1. Đại học xây dựng</p><p>2. Đại học Bách Khoa</p><p>3. Đại học Mỏ - địa chất</p><p>4. Đại học kiến trúc</p><p>5. Đại học giao thông vận tải</p><p>Hoặc các trường nước ngoài thuộc nhóm 1.000 trường đại học tốt nhất.</p><p>- Ưu tiên ứng viên có chứng chỉ hành nghề hoạt động xây dựng lĩnh vực thiết kế kết cấu công trình/ khảo sát địa hình (còn thời hạn tối thiểu sau ngày 30/06/2026).</p><p>&nbsp;</p><p>2. Về trình độ Tiếng Anh: trình độ tối thiểu đạt bậc 3/6 khung năng lực ngoại ngữ 6 bậc dùng cho Việt Nam (được quy định tại thông tư số 01/2014/TT-BGDĐT ngày 24/01/2014 của Bộ giáo dục và đào tạo) hoặc trình độ B, hoặc tương đương trình độ B1 khung tham chiếu chung Châu Âu (CEFR), ưu tiên các ứng viên có chứng chỉ tiếng anh quốc tế: Toeic, IELTS,... và các chứng chỉ quốc tế khác.</p>', N'<p><strong>LƯƠNG THƯỞNG: Mức thu nhập từ 250 triệu – 350 triệu/năm</strong></p><p><strong>CHẾ ĐỘ PHÚC LỢI:</strong></p><p>1. Được hưởng các khoản quà tặng 8/3, 20/10, gia đình Việt Nam cho cả nhân viên nam và nữ.</p><p>2. Thưởng lễ - Tết, ngày thành lập Trung tâm/Tổng công ty, thưởng hoàn thành kế hoạch sản xuất kinh doanh, được hỗ trợ ăn ca, điện thoại liên lạc, chế độ nghỉ mát, du xuân.</p><p>3. Tham gia chương trình bảo hiểm sức khỏe cho CBCNV và người thân của MobiFone với mức bảo hiểm lên đến 8.000.000đ/ngày.</p><p>4. Khám sức khỏe định kỳ 1 năm/lần.</p><p>5. Được hưởng chế độ thuê bao liên lạc nghiệp vụ.</p>', N'- Hà Nội: Tòa nhà Mobifone, 6 Phúc Lý, Phường Minh Khai, Quận, Bắc Từ Liêm', N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>', N'TRUNG TÂM CÔNG NGHIỆP CÔNG NGHỆ CAO MOBIFONE - CHI NHÁNH TỔNG CÔNG TY VIỄN THÔNG', N'20 -30 Triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286798949_mobifone.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 1, 'recruiter', NULL, 'post', N'Nhân Viên Số Hóa Dữ Liệu (Không Yêu Cầu Kinh Nghiệm - Đi Làm Ngay) Lương 7-10M/Tháng', 'active', 71, 0, 0, '2025-06-03 20:15:03.333', '2025-06-30 19:33:03.110', NULL, N'Không yêu cầu', '2025-07-01', N'Thứ 2 - Thứ 7 (từ 08:00 đến 17:00)', N'<p><i><strong>1. Tiếp nhận & phân loại tài liệu:</strong></i></p><p>- Nhận, kiểm tra và phân loại hồ sơ/tài liệu giấy theo đúng quy định</p><p>- Loại bỏ vật cản ảnh hưởng đến quá trình scan như ghim, kẹp...</p><p><i><strong>2. Scan tài liệu:</strong></i></p><p>- Vận hành máy scan (máy để bàn, máy công nghiệp...) để quét tài liệu</p><p>- Kiểm tra hình ảnh sau scan, đảm bảo chất lượng rõ nét, không mờ, thiếu trang</p><p><i><strong>3. Nhập liệu & kiểm tra dữ liệu:</strong></i></p><p>- Nhập thông tin từ tài liệu vào phần mềm theo biểu mẫu</p><p>- Đối chiếu, kiểm tra độ chính xác giữa dữ liệu gốc và dữ liệu nhập</p><p><i><strong>4. Hỗ trợ công việc khác:</strong></i></p><p>- Xử lý lỗi phát sinh trong quá trình scan/nhập liệu</p><p>- Báo cáo tiến độ, số lượng công việc hằng ngày cho quản lý</p>', N'<p>- Không yêu cầu kinh nghiệm – được đào tạo đầy đủ trước khi làm việc, ưu tiên sinh viên đã/sắp tốt nghiệp các ngành: <i>Công nghệ thông tin, Hệ thống thông tin, Kinh tế, Quản trị kinh doanh, Kế toán, Lưu trữ - Văn thư, Ngôn ngữ, Kỹ thuật...</i></p><p>- Cẩn thận, nhanh nhẹn, tỉ mỉ, trung thực và có trách nhiệm</p><p>- Sử dụng tin học văn phòng cơ bản, đặc biệt là Excel</p><p>- Có khả năng đánh máy ổn định</p><p>- Tuân thủ nội quy làm việc, bảo mật thông tin trong suốt thời gian làm việc</p>', N'<p><strong>- Thực tập với mức lương khởi điểm: 7.000.000 - 10.000.000VNĐ/tháng (fulltime), dựa theo mức độ hoàn thành KPI - thu nhập không giới hạn.</strong></p><p>- Được cấp <strong>Giấy chứng nhận tham gia Dự án Chuyển đổi số Quốc gia</strong>, ghi nhận đóng góp cá nhân cho công cuộc hiện đại hóa đất nước</p><p>- Hỗ trợ <strong>xác nhận thực tập</strong>.</p><p>- Tiếp cận quy trình số hóa chuyên nghiệp, công nghệ tiên tiến</p><p>- Được đào tạo kỹ năng nghiệp vụ bài bản, thử việc trong 2 tuần.</p><p>- Thưởng hiệu suất: Thưởng vượt định mức, hoàn thành sớm tiến độ.</p><p>- Cơ hội rèn luyện kỹ năng và phát triển trong lĩnh vực <strong>IT, Nhân viên Xử lý/Phân tích Dữ liệu, Nhân viên số hóa, Tester/QA...</strong></p>', N'- Hà Nội: Cầu Giấy - Hà Nội: Nam Từ Liêm - Hà Nội: Bắc Từ Liêm ...và 3 địa điểm khác', N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>', N'CÔNG TY CỔ PHẦN RIKKEI EDUCATION', N'7 - 10 triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286783108_rikkei.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(121, 1, 'recruiter', NULL, 'post', N'Nhân Viên Kinh Doanh/ Tư Vấn Giải Pháp Phần Mềm (Nghỉ T7, CN) Thu Nhập 10-30Tr', 'active', 42, 0, 0, '2025-06-04 08:14:19.310', '2025-06-30 19:32:37.770', NULL, N'1 năm', '2025-07-31', N'Thứ 2 - Thứ 6 (từ 08:00 đến 17:00) Thứ 7 (từ 08:00 đến 12:00)', N'<p>- Tiếp nhận nguồn DATA từ bộ phận Marketing, thực hiện gọi ra để tư vấn giải pháp phần mềm cho khách hàng bằng kịch bản có trước. (70%)<br>- Tự phát triển thêm nguồn data cá nhân để nâng cao doanh số. (30%)<br>- Đối tượng khách hàng: các CEO, chủ doanh nghiệp và cấp quản lý của các công ty.<br>- Tư vấn, hướng dẫn, chốt/triển khai hợp đồng với khách hàng qua điện thoại, email hoặc gặp trực tiếp khách hàng (trong trường hợp KH yêu cầu).<br>- Chăm sóc khách hàng trước & sau bán, chủ động thăm hỏi lại các khách hàng cũ.<br>- Thực hiện một số công việc khác theo yêu cầu của Trưởng nhóm Kinh doanh.<br>- Báo cáo công việc trực tiếp cho Trưởng nhóm Kinh doanh.</p>', N'<p>- Nam/Nữ, tuổi từ 20 - 30. Tốt nghiệp từ Cao đẳng trở lên.<br>- Giọng nói: lưu loát, không ngọng. Tự tin giao tiếp & thuyết trình trước khách hàng.<br>- Có kinh nghiệm làm sale, telesale, chăm sóc Khách hàng, hoặc BD (Business Development) hoặc BA (Business Analyst) từ tối thiểu 6 tháng.<br>- Ứng viên có thiết bị làm việc (laptop) và phương tiện cá nhân (xe máy/xe điện)<br>- Tư duy logic, có khả năng teamwork, có kỹ năng lập kế hoạch làm việc theo tuần/tháng/quý.<br>- Chăm chỉ, trung thực, có trách nhiệm trong công việc.<br>- Ưu tiên ứng viên tốt nghiệp các chuyên ngành Kinh tế, QTKD, MKT, CNTT, Kế toán,... hoặc có hiểu biết về lĩnh vực CNTT, phần mềm.<br>- Ứng viên đã có kinh nghiệm làm sales sản phẩm công nghệ, quản trị doanh nghiệp, phần mềm, CNTT là một lợi thế.<br>- Chân dung ứng viên mong muốn: Làm việc theo phương châm: Sáng tạo - Chủ động, Bền bỉ - Hiệu quả, Đồng đội - Biết ơn.</p><p>&nbsp;</p><h3>Thu nhập</h3><ul><li>Thu nhập khi đạt 100% KPI: 10 - 30 triệu VND</li><li>Thu nhập tính theo tỷ lệ đạt KPI</li><li>Lương cứng: 7 - 10 triệu VND</li><li>Lương cứng không phụ thuộc doanh số</li></ul>', N'<p>- Lương cơ bản theo cấp bậc: từ <strong>7.000.0000 - 10.000.000</strong> + phụ cấp (ăn trưa, xăng xe, con nhỏ) + Thưởng P3 (KPI) + thưởng doanh số (được hưởng ngay trong thời gian thử việc).</p><p>- Thu nhập trung bình: 10.000.000 - 20.000.000đ<br>- Thưởng Tháng, Quý, Cuối năm theo Chính sách Công ty.</p><p>- Thưởng Lễ, Tết, hỗ trợ hiếu hỉ, sinh nhật theo quy định Công ty.</p><p>- Tham gia chương trình team building, du lịch, khám sức khoẻ định kỳ (thâm niên >6 tháng)</p><p>- Thời gian thử việc tối đa 2 tháng.<br>- Khi thành nhân viên chính thức được tham gia bảo hiểm theo các chính sách theo Quy định của nhà nước.</p><p>- Được đào tạo về sản phẩm, kĩ năng bán hàng và xử lý tình huống.<br>- Có lộ trình thăng tiến rõ ràng theo bậc<br>- Thời gian làm việc: Từ thứ 2 - thứ 6 (8h - 17h30), nghỉ T7 & CN</p><p>&nbsp;</p><h3>Phụ cấp</h3><p>Ăn trưa, Xăng xe, Cước điện thoại</p><h3>Thiết bị làm việc</h3><p>Được cấp Điện thoại, Tai nghe</p><h3>Quyền lợi</h3><p>Bảo hiểm xã hội, Khám sức khỏe định kỳ, Team building, Du lịch hàng năm, Phụ cấp thâm niên, Thưởng tháng 13, Thưởng hiệu quả làm việc, Signing bonus</p>', N'- Hà Nội: Toà nhà Hoa Cương, số 18 ngõ 11 Thái Hà, Đống Đa - Hồ Chí Minh: 43D/9 Hồ Văn Huê, Phường 09, Phú Nhuận', N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>', N'CÔNG TY CỔ PHẦN CÔNG NGHỆ GETFLY VIỆT NAM', N'10 - 30 triệu', N'Hà Nội, Hồ Chí Minh', 'Full-time', 'uploads/company_logos/1751286757770_GetFly.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(132, 1, 'recruiter', NULL, 'post', N'Trưởng Phòng Vận Hành (Dĩ An - Bình Dương Lương 30 - 40 Triệu)', 'active', 32, 0, 0, '2025-06-11 21:57:45.490', '2025-06-30 19:37:17.200', NULL, N'Trên 5 năm', '2025-07-11', N'Thứ 2 - Thứ 6 (từ 08:30 đến 17:30) Thứ 7 cách tuần', N'<p>- Tổ chức, sắp xếp kế hoạch xe phục vụ nhu cầu của khách hàng.</p><p>- Đánh giá chất lượng dịch vụ, tham mưu cho ban lãnh đạo công ty phương án vận hành nhằm tối ưu hóa chi phí, và giảm thiểu phát sinh liên quan đến chất lượng dịch vụ.</p><p>- Phối hợp với phòng quản lý phương tiện để đảm bảo xe được quản lý và sử dụng với chất lượng tốt nhất.</p><p>- Lên kế hoạch phân công công việc cho nhân sự trong phòng, theo dõi đánh giá định kì từ đó có đề xuất phù hợp nhằm nâng cao hiệu suất trong công việc.</p><p>- Phối hợp cùng phòng mua hàng/kế toán lên kế hoạch phân bổ sắp xếp tuyến chạy hợp lý cho đội xe và xe của nhà thầu phụ.</p><p>- Đánh giá định kì để các nhà thầu phụ để nâng cao năng lực phục vụ và khả năng đáp ứng xe vào những đợt cao điểm, sale, các dự án lớn.</p><p>- Phối hợp cùng phòng Hành chính nhân sự tuyển dụng, đào tạo, sử dụng tài xế hiệu quả, duy trì theo nề nếp.</p><p>- Các công việc khác có liên quan theo sự phân công của Ban giám đốc.</p>', N'<p>- Nam có sức khỏe tốt, nhanh nhạy nhiệt tình trung thực, kỹ năng giao tiếp tốt, không ngại di chuyển.</p><p>- Kinh nghiệm: >5 năm trong ngành Vận tải/ Logistics, điều phối xe tải. Trong đó có ít nhất 2 năm kinh nghiệm Quản Lý Đội Xe Tải.</p><p>- Các ứng viên có kinh nghiệm về kỹ thuật xe tải, Có bằng lái xe từ B2 trở lên là lợi thế.</p><p>- Tin học văn phòng tốt.</p><p><strong>- Làm việc tại Số 7, Đại lộ Độc Lập, KCN Sóng Thần 1, Dĩ An, Bình Dương</strong></p>', N'<p>- Lương: 30-40 triệu/ tháng (theo năng lực) thử việc hưởng 90% lương.</p><p>- Phúc lợi:</p><p>+ Tham gia BHXH, BHYT, BHTN theo quy định sau 2 tháng thử việc.</p><p>+ Công ty xét tăng lương/ thăng tiến 1 lần/năm.</p><p>+ Team building/du lịch theo kế hoạch hàng năm của công ty.</p>', N'- Bình Dương: Số 7, Đại lộ Độc Lập, KCN Sóng Thần 1, Dĩ An - Hồ Chí Minh: Củ Chi', N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>', N'Công Ty TNHH A Sóc', N'30 - 40 triệu', N'Hồ Chí Minh', 'Full-time', 'uploads/company_logos/1751286737382_Asoc.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(133, 1, 'recruiter', NULL, 'post', N'Sales Representative – Đại Diện Kinh Doanh Tại Hà Nội, Ưu Tiên Nữ, Thu Nhập 20-30 Triệu Theo Năng Lực', 'active', 59, 0, 0, '2025-06-11 23:05:28.267', '2025-06-30 19:31:55.157', NULL, N'1 năm', '2025-07-12', N'Từ 8h30-17h30 các ngày thứ 2 đến thứ 6 – thứ 7 luân phiên', N'<p>- Phát triển và duy trì mối quan hệ tốt với khách hàng dựa trên danh sách khách hàng được công ty cung cấp</p><p>- Là cầu nối liên hệ trực tiếp với khách hàng trong tất cả các bước của việc bán hàng bao gồm nhưng không giới hạn:</p><p>+ Tìm hiểu nhu cầu/mong muốn thực sự của khách hàng</p><p>+ Giới thiệu sản phẩm và tư vấn các giải pháp phù hợp</p><p>+ Chào giá, thương lượng và ký hợp đồng mua bán</p><p>+ Theo dõi và thông báo khách hàng kế hoạch lắp đặt dự kiến</p><p>+ Chịu trách nhiệm thông báo và thu hồi các khoản thanh toán của khách hàng</p><p>+ Chăm sóc khách hàng sau bán hàng</p><p>- Kết hợp đội kỹ thuật khảo sát công trình/nhà ở thực tế</p><p>- Cập nhật tình trạng khách hàng trên hệ thống bán hàng của công ty</p><p>- Đạt doanh số bán hàng được chỉ định</p><p>- Đi công tác tại các tỉnh/thành khác</p>', N'<p>- Ưu tiên nữ từ 26 - 27 tuổi trở lên</p><p>- Tốt nghiệp Cao đẳng trở lên các ngành kinh tế, kinh doanh, ngoại ngữ...</p><p>- Có kinh nghiệm ở vị trí nhân viên kinh doanh (là một lợi thế)</p><p>- Mong muốn thu nhập tốt thông qua làm việc chăm chỉ và hướng đến mục tiêu cụ thể</p><p>- Thật sự yêu thích công việc bán hàng và tiếp xúc với khách hàng</p><p>- Ứng viên phải là người trung thực và khiêm tốn</p><p>- Tự tin, thoải mái/thân thiện trong giao tiếp</p><p>- Có ý thức chủ động và trách nhiệm công việc</p><p>- Thích nghi nhanh và chịu được áp lực công việc</p><p>- Có tinh thần cầu tiến với mong muốn ngày càng phát triển bản thân</p><p>- Hợp tác tốt với nhóm bán hàng và các phòng/ban khác của công ty</p><p>- Sử dụng thành thạo các ứng dụng Ms Office</p><p>- Tiếng Anh giao tiếp tốt (là một lợi thế)</p><p>- Thời gian làm việc: Từ 8h30-17h30 các ngày thứ 2 đến thứ 6 – thứ 7 luân phiên</p><p>- Làm việc ngoài giờ hoặc cuối tuần sẽ theo điều động của Giám đốc hoặc theo thực tế công việc yêu cầu.</p><p>&nbsp;</p><h3>Thu nhập</h3><ul><li>Thu nhập khi đạt 100% KPI: Thoả thuận</li><li>Thu nhập tính theo tỷ lệ đạt KPI</li><li>Lương cứng: Từ 10 triệu VND trở lên</li><li>Lương cứng không phụ thuộc doanh số</li></ul>', N'<p>- Làm việc tại Công ty của nước ngoài, môi trường chuyên nghiệp, có nhiều cơ hội thăng tiến</p><p>- Thu nhập lên đến: 20-30tr (tuỳ năng lực)</p><p>- BHYT, BHXH, BHTN, nghỉ phép năm... theo quy định của Luật Lao động Việt Nam</p><p>- Bảo hiểm sức khỏe nhân viên</p><p>- Du lịch trong nước và nước ngoài</p><p>- Tham gia chương trình đào tạo phát triển kỹ năng chuyên môn</p>', N'- Hà Nội: Tầng 03, P303, số 239 Xuân Thủy, P. Dịch Vọng Hậu, Cầu Giấy', N'Ứng viên nộp hồ sơ trực tuyến bằng cách bấm Ứng tuyển ngay dưới đây.', N'CÔNG TY TNHH CIBES LIFT VIỆT NAM', N'Thỏa Thuận', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286715148_cibes.webp', NULL, N'Nhân Viên', N'Kinh Doanh', 'HR', N'22 - 99 Nhân viên', 'https://cibeslift.com.vn/', NULL, N'Chuyên môn Sales Representative/Phát triển kinh doanh Direct Sales Telesales B2B B2C Có hỗ trợ Data Từ 26 tuổi trở lên'),
(134, 2, 'recruiter', NULL, 'post', N'Content Marketing/ Sáng Tạo Nội Dung - Kinh Nghiệm 2 Năm (Thu Nhập 12 -16 Triệu)', 'active', 113, 0, 0, '2025-06-12 14:43:27.637', '2025-06-30 19:36:25.213', NULL, N'2 năm', '2025-07-12', N'8h - 17h30 từ T2 đến hết sáng T7; nghỉ trưa: 12h00 – 13h30', N'<p>- Xây dựng kế hoạch sáng tạo nội dung để phát triển kênh Tiktok, Facebook chuyển đổi của công ty</p><p>- Booking KOC hàng tháng để sản xuất nội dung</p><p>- Liên tục cập nhập số liệu và insights của người dùng về sản phẩm để đề xuất những ý tưởng sáng tạo</p><p>- Báo cáo hiệu quả công việc theo campaign/ tuần/ tháng để đánh giá hiệu quả và có đề xuất phù hợp cho hệ thống Social</p>', N'<p>- Nam/ nữ từ 23 - 26 tuổi</p><p>- Tốt nghiệp Đại học chính quy, chuyên ngành Báo chí, Marketing, PR hoặc các chuyên ngành liên quan</p><p><strong>- Có kinh nghiệm từ 02 năm trở lên về vị trí Content Marketing hoặc các vị trí tương đương</strong></p><p>- Am hiểu sâu nghiệp vụ về Marketing, công cụ Marketing</p><p>- Có khả năng viết nội dung và giao tiếp tốt</p><p>- Thành thạo các phần mềm chỉnh sửa video như Capcut, Canva,...</p><p>- Có tinh thần cầu tiến, kiên trì, tâm huyết, đam mê, mong muốn phát triển bản thân.</p>', N'<p><strong>- Lương cứng: 7tr5 - 9 triệu + thưởng doanh số; Thu nhập 12-16 triệu</strong></p><p>- Hưởng 12 ngày nghỉ phép/năm; hưởng đầy đủ chế độ BHXH, BHYT, BHTN theo đúng Luật lao động Việt Nam hiện hành;</p><p>- Thưởng danh hiệu thi đua 1 lần/năm;</p><p>- Thưởng cuối năm theo kết quả kinh doanh của Công ty và hiệu quả làm việc của CBNV;</p><p>- Được hưởng các chính sách phúc lợi theo quy định của công ty: Sinh nhật; Du lịch 2 lần/năm; hoạt động Teambuilding;...</p><p>- Môi trường làm việc trẻ trung, năng động, được phát huy tối đa sức sáng tạo.</p><p>- Thời gian làm việc: 8h - 17h30 từ T2 đến hết sáng T7; nghỉ trưa: 12h00 – 13h30</p>', N'- Hà Nội: Tòa nhà AC Building, số 3, ngõ 78, Duy Tân, Dịch Vọng Hậu, Cầu Giấy', N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>', N'CÔNG TY CỔ PHẦN THƯƠNG MẠI VÀ ĐẦU TƯ BABY AND MOM GLOBAL', N'12 - 16 triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286985213_bmg.png', NULL, N'Nhân Viên', N'Create Content', 'HR', N'10-24 nhân viên', 'uni-techgroup.com', N'BABY AND MOM GLOBAL (viết tắt BMG) được thành lập với mục tiêu nghiên cứu và sản xuất các sản phẩm Mẹ & bé chất lượng vượt trội, giá thành hợp lý đáp ứng nhu cầu thị trường trong và ngoài nước. BMG hướng tới trở thành trung tâm phân phối các dòng sản phẩm mẹ và bé từ đa quốc gia trên toàn thế giới.', N'Chuyên môn Content Marketing'),
(178, 2, 'recruiter', NULL, 'post', N'Chuyên Viên Tư Vấn Môi Trường 2 Năm Kinh Nghiệm - Lương Upto 15tr - Tại Hà Nội', 'active', 100, 0, 0, '2025-06-18 20:42:56.277', '2025-06-30 19:36:10.060', NULL, N'2 năm', '2025-07-12', N'Làm việc từ Thứ hai đến Thứ sáu và 02 ngày thứ Bảy cách tuần (08h00 - 17h30)', N'<p>- Lập hồ sơ môi trường: Báo cáo đánh giá tác động môi trường, Báo cáo xin cấp Giấy phép môi trường, Báo cáo Vận hành thử nghiệm,...</p><p>- Thực hiện các công việc liên quan đến lĩnh vực môi trường.</p><p>- Hỗ trợ các phòng ban khác (khi có yêu cầu).</p><p>- Tư vấn cho khách hàng về các vấn đề thủ tục pháp lý và kỹ thuật liên quan đến môi trường.</p>', N'<p><strong>- Kinh nghiệm ở vị trí tương đương từ 02 năm trở lên (đã trực tiếp thực hiện Báo cáo ĐTM/Giấy phép môi trường/...).</strong></p><p>- Tốt nghiệp Đại học trở lên các chuyên ngành liên quan đến môi trường.</p><p>- Kỹ năng phân tích, tổng hợp dữ liệu tốt.</p><p>- Khả năng làm việc độc lập và làm việc nhóm.</p><p>- Kỹ năng làm việc logic, sắp xếp công việc, nhạy bén trong xử lý tình huống, trao đổi thông tin với khách hàng.</p><p>- Chịu được áp lực công việc cao.</p><p>- Thành thạo MS, sử dụng AutoCad cơ bản, đọc hiểu bản vẽ.</p><p>- Sẵn sàng đi công tác (khi cần thiết).</p>', N'<p>- Lương cơ bản: 10 - 15 triệu/tháng (chưa bao gồm Lương thưởng, phụ cấp).</p><p>- Lương thưởng: tháng thứ 13, thưởng dự án, thưởng hiệu suất công việc.</p><p>- Phụ cấp: Ăn trưa, xăng xe, công tác,...</p><p>- Chế độ phúc lợi: sinh nhật, các ngày lễ,...</p><p>- Tham gia BHXH, BHTN, BHYT đầy đủ theo Luật Lao động quy định.</p><p>- Xét duyệt tăng lương dựa trên năng lực, hiệu suất công việc.</p><p>- Du lịch hàng năm.</p><p>- Làm việc từ Thứ hai đến Thứ sáu và 02 ngày thứ Bảy cách tuần (08h00 - 17h30).</p>', N'- Hà Nội: Số 1, ngõ 37, phố Lê Thanh Nghị, phường Bách Khoa, Hai Bà Trưng', N'<p>Ứng viên nộp hồ sơ trực tuyến bằng cách bấm <strong>Ứng tuyển</strong> ngay dưới đây.</p>', N'CÔNG TY CỔ PHẦN TẬP ĐOÀN UNI-TECH', N'10 - 15 triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286970057_uni-tech.webp', NULL, N'Nhân Viên', N'Chuyên môn Kỹ sư môi trường', 'HR', N'10-24 nhân viên', 'uni-techgroup.com', NULL, N'Chuyên môn Kỹ sư môi trường'),
(180, 2, 'recruiter', NULL, 'post', N'Chuyên Viên ASO - Mobile App Marketing Tại Hà Nội Thu Nhập 18 - 25 Triệu', 'active', 1, 0, 0, '2025-06-21 21:00:35.980', '2025-06-21 21:00:35.980', '2025-06-21 21:00:45.647', N'2 năm', '2025-07-11', N'Thứ 2 - Thứ 6 (từ 08:30 đến 17:30) Thứ 7 cách tuần', N'<p>a</p>', N'<p>a</p>', N'<p>a</p>', N'- Hà Nội: Tâng 2B, Capital Building, Ngõ 36 Giang Văn Minh, Ba Đình', N'<p>a</p>', N'Công Ty Cổ Phần Công Nghệ Dịch Vụ Y Tế Medici', N'18 - 25 triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1750514435963_delasoi.png', NULL, N'Nhân Viên', N'Kinh Doanh', 'HR', N'22 - 99 Nhân viên', 'uni-techgroup.com', N'aaaa', N'Chuyên môn Content Marketing'),
(181, 2, 'recruiter', NULL, 'post', N'Nhân Viên Quảng Cáo/ Marketing ADs Đa Kênh (Facebook, Google, TikTok...) – Tối Thiểu 1 Năm Kinh Nghiệm - Tại Hà Nội', 'active', 36, 0, 0, '2025-06-23 21:44:41.260', '2025-06-30 19:35:57.680', NULL, N'1 năm', '2025-07-12', N'Thứ 2 - Thứ 7 (từ 08:30 đến 18:00)', N'<p><strong>• Lên kế hoạch & triển khai quảng cáo trên các nền tảng: Facebook, Instagram, Google, TikTok.</strong></p><p>• Quản lý ngân sách quảng cáo theo kế hoạch của công ty.</p><p>• Theo dõi, phân tích hiệu quả chiến dịch → đề xuất cải tiến.</p><p>• Phối hợp với phòng MKT để xây dựng nội dung, hình ảnh quảng cáo đẹp, chuẩn luxury.</p><p>• Báo cáo kết quả định kỳ cho quản lý.</p>', N'<p><strong>• Có kinh nghiệm chạy Ads tối thiểu 1 năm trong ngành FMCG / bán lẻ / luxury / e-commerce.</strong></p><p>• Biết tối ưu chi phí, hiểu về tệp khách hàng cao cấp là lợi thế.</p><p>• Có tư duy phân tích số liệu, biết đọc chỉ số Ads.</p><p>• Làm việc có trách nhiệm, chủ động, chịu được áp lực KPI.</p><p><strong>• Ưu tiên ứng viên từng làm trong các team nhỏ, làm trực tiếp cho brand.</strong></p>', N'<p><strong>• Lương thoả thuận theo năng lực + thưởng hiệu quả Ads.</strong></p><p><strong>• Được tiếp xúc & làm trong môi trường thương hiệu luxury cao cấp.</strong></p><p><strong>• Có cơ hội mở rộng tư duy & kỹ năng chạy Ads chuyên sâu.</strong></p><p><strong>• Môi trường làm việc nhanh - linh hoạt - minh bạch - ít phức tạp.</strong></p>', N'- Hà Nội: Văn phòng Omiyage Fruits & More Bắc Từ Liêm, gần Cầu Giấy (Shophouse 30 - H6 - Khu đô thị Starlake Tây Hồ Tây), Bắc Từ Liêm', N'Ứng viên nộp hồ sơ trực tuyến bằng cách bấm Ứng tuyển ngay dưới đây.', N'OMIYAGE FRUITS & MORE', N'Thỏa Thuận', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286957678_Fruits.webp', NULL, N'Nhân Viên', N'Kinh Doanh', 'HR', N'25 - 99 Nhân viên', 'https://www.omiyage.com.vn', N'Câu Chuyện Omiyage Và Văn Hóa Tặng Quà Của Nhật Bản Omiyage trong tiếng Nhật có nghĩa là "món quà". Không chỉ đại diện cho nền văn hóa "cho – nhận" của người Nhật, Omiyage còn thể hiện sự trân trọng giá trị con người. Với ý nghĩa đẹp đẽ này, Omiyage cam kết từng sản phẩm của chúng tôi đưa ra thị trường đều chỉn chu, hoàn mỹ, song hành cùng chất lượng cao, chứa đựng tâm huyết của đội ngũ cửa hàng lẫn tình cảm của người tặng và người nhận. Các sản phẩm của chúng tôi sẽ thay quý khách trao yêu thương đến những người bạn trân trọng để nhận lại hạnh phúc. Omiyage tự hào mang đến những loại trái cây nhập khẩu cao cấp nhất với chất lượng tuyệt hảo, phong phú lựa chọn và đa dạng theo mỗi mùa, mỗi đất nước. Trái cây thượng phẩm tại Omiyage không chỉ là thực phẩm ngon, tốt cho sức khỏe, mang đến những trải nghiệm nâng tầm vị giác cho quý khách và gia đình, đây còn là những sản phẩm siêu VIP được dùng để biếu tặng mang nhiều ý nghĩa về may mắn, tài lộc và phú quý.', N'Chuyên môn Marketing Tuổi 23 - 30'),
(182, 2, 'recruiter', NULL, 'post', N'Nhân Viên Thiết Kế Nội Thất (2D/3D) - Từ 1 Năm Kinh Nghiệm, Lương Cứng 10-15 Triệu', 'active', 2, 0, 0, '2025-06-23 22:10:10.500', '2025-06-30 19:35:40.947', NULL, N'1 năm', '2025-08-01', N'Thứ 2 - Thứ 7 (từ 08:30 đến 18:00)', N'<p>- Tham gia vào quá trình thiết kế nội thất cho các dự án nhà ở, văn phòng, khách sạn, nhà hàng, các Mô hình kinh doanh và không gian thương mại khác</p><p>- Triển khai phương án thiết kế 2D, 3D nội - ngoại thất</p><p>- Phối hợp với khách hàng để hiểu rõ nhu cầu và mong muốn của họ, đưa ra các đề xuất thiết kế phù hợp</p><p>- Lựa chọn và đề xuất vật liệu, màu sắc, đồ nội thất phù hợp với concept thiết kế</p><p>- Chuẩn bị các bản vẽ kỹ thuật và tài liệu cần thiết cho quá trình thi công</p><p>- Theo dõi và hỗ trợ bộ phận thi công để đảm bảo thi công thực hiện đúng theo thiết kế</p><p>- Cập nhật kiến thức về xu hướng thiết kế nội thất mới nhất và áp dụng vào các dự án</p>', N'<p><strong>- Tốt nghiệp Đại học/Cao đẳng trở lên chuyên ngành Kiến trúc; Nội thất;</strong></p><p><strong>- Tối thiểu 1-3 năm kinh nghiệm tại vị trí thiết kế nội thất</strong></p><p>- Kinh nghiệm sử dụng AutoCAD, Sketchup, Photoshop...</p><p>- Có kiến thức về các quy chuẩn, tiêu chuẩn thiết kế công trình.</p><p>- Kỹ năng thiết kế, lên mặt bằng phương án công năng.</p><p>- Có trách nhiệm trong công việc, khả năng chủ động xử lý trong công việc, có kỹ năng làm việc nhóm tốt.</p><p>- Năng động, trung thực, có khả năng làm việc độc lập, chịu được áp lực về tiến độ công việc, sẵn sàng làm thêm vào những thời điểm gấp của dự án.</p>', N'<p>- Lương cứng 10-15 triệu + % thưởng công trình: Thoả thuận theo năng lực</p><p>- Có cơ hội tiếp xúc với các công trình, dự án quy mô lớn để nâng cao năng lực.</p><p>- Được hưởng các chế độ theo quy định của Nhà nước.</p><p>- Thưởng các ngày lễ, tết theo quy định của nhà nước</p><p>- Môi trường rèn luyện bản thân tốt, năng động, sáng tạo</p>', N'- Hà Nội: C10-29 GELEXIMCO C – LÊ TRỌNG TẤN, Hà Đông', N'Ứng viên nộp hồ sơ trực tuyến bằng cách bấm Ứng tuyển ngay dưới đây.', N'CÔNG TY CỔ PHẦN THƯƠNG MẠI N - ONE VIỆT NAM', N'10 - 15 triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286940948_One vn.webp', NULL, N'Nhân Viên', N'Thiết kế / Kiến trúc', 'HR', N'25 - 99 Nhân viên', 'https://n-one.vn/', N'CÔNG TY KIẾN TRÚC & NỘI THẤT N-ONE VIỆT là đơn vị chuyển tư vấn, thiết kế thi công, sản xuất nội thất, xây dựng, kết cấu nhà thép. Thiết kế thi công các chuỗi mô hình kinh doanh, CLB Billiard, Nhà hàng, Khách sạn, Cafe, Bar Club, Các công trình biệt thự, nhà phố, căn hộ, chung cư và đặc biệt thiết kế trang trí văn phòng, showroom, bar vũ trường... Công ty gồm 80-100 nhân viên - với hệ thống chi nhánh 3 miền thành lập và phát triển trên 10 năm, Chúng tôi tự tin đem đến cho khách hàng những sản phẩm tốt nhất, Tạo ra những ưu thế và khắc phục những nhược điểm cân bằng chi phí trong thiết kế thi công hoàn thiện công trình.', N'Chuyên môn Marketing/PR/Quảng cáo khác Thực phẩm / Đồ uống Bán lẻ - Hàng tiêu dùng - FMCG Tiếng Anh Giao tiếp cơ bản Tuổi 23 - 30'),
(183, 2, 'recruiter', NULL, 'post', N'Nhân Viên IT / IT Helpdesk/ IT Support - Ngành Viễn Thông, Khu Vực Đồng Nai', 'active', 13, 0, 0, '2025-06-23 22:14:03.400', '2025-06-30 19:35:30.107', NULL, N'Không yêu cầu', '2025-07-16', N'- Giờ làm việc hành chính: từ 7h30-17h00.', N'<p>- Vận hành hệ thống máy tính, phần mềm, quản lý mạng internet tại văn phòng.</p><p>- Quản lý mạng internet cung cấp cho Khách hàng.</p><p>- Nghiên cứu các giải pháp công nghệ mới vô áp dụng phát triển công nghệ thông tin mới.</p>', N'<p><strong>- Yêu cầu giới tính: Nam, dưới 40 tuổi</strong></p><p>&nbsp;</p><p>- Kinh nghiệm: 3 năm trở lên vị trí tương đương</p><p>- Tốt nghiệp Cử nhân công nghệ thông tin</p><p><strong>- Ưu tiên kinh nghiệm làm việc trong môi trường Viễn thông, Lắp đặt Mạng - Truyền thông</strong></p>', N'<p>- Thu nhập: 8 triệu - 12 triệu thỏa thuận</p><p>- Giờ làm việc hành chính: từ 7h30-17h00.</p><p>- Được nghỉ 4 ngày / tháng.</p><p>- Được tham gia BHXH, BHYT, BHTN, 24/24.</p><p>- Chế độ phúc lợi: nghỉ mát hàng năm, thưởng các ngày lễ: 30/4, 2/9, tết dương lịch, tết nguyên đán,...</p><p>- Quà công đoàn: Sinh nhật, quốc tế thiếu nhi 1/6, trung thu, tết âm lịch,...</p><h3><strong>Thiết bị làm việc</strong></h3><p>Được cấp Máy tính</p><h3><strong>Quyền lợi</strong></h3><p>Bảo hiểm xã hội, Bảo hiểm sức khỏe, Team building, Thưởng tháng 13, Thưởng hiệu quả làm việc</p>', N'- Đồng Nai: Biên Hoà', N'Ứng viên nộp hồ sơ trực tuyến bằng cách bấm Ứng tuyển ngay dưới đây.', N'CHI NHÁNH CÔNG TY CỔ PHẦN CÔNG NGHỆ VIỆT THÀNH', N'8 - 15 triệu', N'Đồng Nai', 'Full-time', 'uploads/company_logos/1751286930106_Vtvcab.webp', NULL, N'Nhân Viên', N'Marketing / Truyền thông / Quảng cáo', 'HR', N'100-499 Nhân viên', NULL, N'Công ty Cổ Phần Công Nghệ Việt Thành được chuyển đổi từ Công ty TNHH Công Nghệ Việt Thành, theo giấy chứng nhận ĐKKD số 0302807495 cấp lần đầu vào ngày 13/12/2002, thay đổi lần thứ 15, ngày 19/12/2016 tại Sở Kế Hoạch Đầu tư TP.HCM. Trải qua hơn 15 năm hoạt động, tới nay Công ty đã liên tục tăng vốn để mở rộng quy mô hoạt động sản xuất kinh doanh, và đã đạt được nhiều thành quả trong quá trình kinh doanh dịch vụ truyền hình cáp. Hiện tại, Công ty đã có trên 250,000 thuê bao là các hộ gia đình với hàng triệu khán giả xem truyền hình; thực hiện tốt nghĩa vụ với ngân sách nhà nước và tạo công ăn việc làm cho gần 400 người lao động tại TPHCM và Đồng Nai. Ngày 3/6/2013, Ủy ban chứng khoán nhà nước đã có văn bản số 2212/UBCK-QLPH chấp thuận hồ sơ đăng ký công ty đại chúng của Công ty CP Công nghệ Việt Thành. Ngày 11/01/2017, Công ty CP Công nghệ Việt Thành đã được Cục Viễn Thông, Bộ Thông Tin Truyền Thông cấp Giấy phép THIẾT LẬP MẠNG VIỄN THÔNG CÔNG CỘNG.', N'Chuyên môn Marketing/PR/Quảng cáo khác Thực phẩm / Đồ uống Bán lẻ - Hàng tiêu dùng - FMCG Tiếng Anh Giao tiếp cơ bản Tuổi 23 - 30'),
(184, 2, 'recruiter', NULL, 'post', N'Nhân Viên Kinh Doanh Tư Vấn Quốc Tế - Sales Oversea/ Xuất Nhập Khẩu (Tiếng Anh/ TIếng Trung)', 'active', 19, 0, 0, '2025-06-23 22:17:49.453', '2025-06-30 19:34:58.920', NULL, N'1 năm', '2025-07-10', N'- Giờ làm việc hành chính: từ 7h30-17h00.', N'<p>- Dựa trên nền tảng dữ liệu Công ty cung cấp, tìm hiểu đối tác nước ngoài và đặt mối quan hệ hợp tác cung cấp chuỗi dịch vụ logistics đến khách hàng.</p><p>- Giới thiệu và chào bán tất cả các dịch vụ Logistics, cước Sea freight, Air freight, Container leasing, Warehouse, ...</p><p>- Tư vấn giải pháp tối ưu cho việc vận chuyển hàng hóa, tuyến đường, ...</p><p>- Quản lý danh sách khách hàng, các đơn hàng đã và đang sử dụng dịch vụ</p>', N'<p>- <strong>Sử dụng tiếng Anh hoặc Tiếng Trung cơ bản. Biết và thành thạo các thứ tiếng khác là một lợi thế.</strong></p><p>- Có 1 năm kinh nghiệm</p><p>- Tốt nghiệp các trường Đại Học/ Cao Đẳng có liên quan ngành nghề xuất nhập khẩu Logistics như Đại Học Ngoại thương, Thương Mại, Cao Đẳng Kinh tế đối ngoại, Kinh doanh quốc tế, ...</p><h3><strong>Thu nhập</strong></h3><ul><li>Thu nhập khi đạt 100% KPI: 15 - 50 triệu VND</li><li>Thu nhập tính theo tỷ lệ đạt KPI</li><li>Lương cứng: 6 - 20 triệu VND</li><li>Lương cứng phụ thuộc vào doanh số</li></ul>', N'<p><strong>- Thu Nhập từ 15 - 50 Triệu = LCB (6-16 Triệu) + Thưởng doanh số + Phụ Cấp</strong></p><p>- Có cơ hội đi công tác nước ngoài, mở rộng giao lưu các nền văn hóa, ...</p><p>- Có cơ hội được tham gia các lớp đào tạo nghiệp vụ ngắn hạn, đào tạo phát triển kỹ năng & làm việc với các đối tác uy tín, chuyên nghiệp.</p><p>- Môi trường làm việc chuyên nghiệp, năng động và thân thiện. Có nhiều cơ hội thăng tiến với những chế độ đãi ngộ hấp dẫn - lâu dài và ổn định.</p><p>- Được hưởng các chế độ phúc lợi theo quy định Nhà nước: BHXH, BHYT, BHTN, nghỉ phép, tháng lương 13, thưởng lễ tết, Sinh nhật Công ty, ...</p><p>- Các chế độ theo quy định của công ty: Du lịch hàng năm, tham gia hoạt động team building, dã ngoại, ... và nhiều chế độ đãi ngộ hấp dẫn khác.</p>', N'- Hà Nội: Cầu Giấy', N'Ứng viên nộp hồ sơ trực tuyến bằng cách bấm Ứng tuyển ngay dưới đây.', N'Công ty Cổ phần Quốc Tế TICO', N'15-50 triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286898919_TICO.webp', NULL, N'Nhân Viên', N'Logistics - Vận tải', 'HR', N'25 - 99 Nhân viên', 'https://ticog.com/', N'Công ty Cổ Phần Quốc tế TICO là Công ty hoạt động chuyên nghiệp về dịch vụ Logistics, được thành lập từ năm 2005, trụ sở tại Hà Nội và các Chi nhánh tại HCM, Hải Phòng và Đà Nẵng. Các hoạt động chủ yếu về vận tải quốc tế bằng đường biển, đường hàng không, đường bộ, thủ tục hải quan, kho vận, Depot, NVOCC ... Là thành thành viên của các hiệp hội vận tải quốc tế WCA, FNC, IGLA, JC TRANS, … Website chính thức của Công ty: www.ticog.com', N'Chuyên môn Sales Xuất nhập khẩu/Logistics khác'),
(185, 2, 'recruiter', NULL, 'post', N'Chuyên Viên Truyền Thông & Sự Kiện (Event Marketing) - Thu Nhập 18-20 Triệu - Tại Hà Nội', 'active', 48, 0, 0, '2025-06-23 22:22:24.863', '2025-06-30 19:34:43.003', NULL, N'3 năm', '2025-07-19', N'Thứ 2 - Thứ 6 (từ 08:00 đến 17:00)', N'<p><strong>1. Tổ chức sự kiện</strong></p><p>Xây dựng, cải tiến các quy trình, quy định về quản lý, tổ chức sự kiện, triển khai giám sát công tác tổ chức sự kiện đảm bảo tuân thủ theo quy định;</p><p>Tổng hợp thông tin, xây dựng, cập nhật, triển khai thực hiện kế hoạch sự kiện hàng năm, ngắn hạn của Công ty;</p><p>Chủ động chuẩn bị và triển khai sự kiện theo phân công, quy định. Phối hợp với các Bộ phận, đối tác khách hàng, nhà cung cấp triển khai sự kiện, đảm bảo an toàn, hiệu quả đúng kế hoạch và tiết kiệm, triển khai các thủ tục thanh toán liên quan;</p><p>Xây dựng và nâng cấp, cập nhật thông tin, cơ sở dữ liệu liên quan đến sự kiện, nhà cung cấp, đối tác;</p><p>Tham mưu, nghiên cứu, đề xuất hình thức tổ chức sự kiện một cách khoa học, tiên tiên, hợp lý, trang trọng, hiệu quả và tiết kiệm</p><p><strong>2. Truyền thông nội bộ</strong></p><p>Xây dựng kế hoạch Truyền thông nội bộ của công ty hằng tháng, quý, năm</p><p>Xây dựng và quản lý nội dung, hình ảnh các kênh Truyền thông nội bộ của công ty</p><p>Chủ trì xây dựng và phát triển, sản xuất các ấn phẩm nội bộ của công ty. Thường xuyên cập nhật xu hướng để phát triển nội dung sáng tạo, thu hút.</p><p>Đề xuất các kế hoạch xây dựng, phát triển văn hóa doanh nghiệp.</p><p><strong>3. Hoạt động PR Báo chí</strong></p><p>Thực hiện Thông cáo báo chí, đón tiếp báo chí tại sự kiện</p><p>Phối hợp sản xuất tin bài truyền thông;</p><p>Booking và làm việc với báo chí sản xuất tin bài, phóng sự;</p><p>Tham gia xử lý khủng hoảng truyền thông;</p><p>Xây dựng và phát triển thương hiệu, thực hiện kế hoạch truyền thông theo yêu cầu;</p><p>Thực hiện đánh giá báo cáo, triển khai các hoạt động đo lường hiệu quả MKT, PR theo yêu cầu</p><p><strong>4. Marketing tổng hợp (30%)</strong></p><p>Nghiên cứu các sản phẩm, nhãn hàng, ngành hàng của Phan Nguyễn;</p><p>Lên các nội dung chi tiết về sản phẩm, nhãn hàng và trình bày trên Slide sao cho cô đọng, nổi bật, dễ hiểu;</p><p>Đào tạo nội bộ, đối tác theo các nội dung đã chuẩn bị;</p><p>Tham gia lập các kế hoạch Marketing nhãn hàng;</p><p>Các công việc khác về Marketing theo yêu cầu.</p><p><strong>5. Phối hợp với các phòng ban liên quan và thực hiện các nhiệm vụ khác theo phân công.</strong></p>', N'<ul><li>Tốt nghiệp Đại học trở lên chuyên ngành Kinh tế, Quản trị kinh doanh, Marketing.</li><li>Kinh nghiệm: tối thiểu 03 năm kinh nghiệm về Marketing. Có tối thiểu 01 năm làm việc với vị trí Chuyên viên PR – Marketing hoặc vị trí tương đương. Ưu tiên có kinh nghiệm tại các công ty sản xuất/phân phối hàng gia dụng/tiêu dùng nhanh/mẹ và bé.</li><li>Có quan hệ với các bên báo chí, Agency, truyền hình</li><li>Tin học: thành thạo tin học văn phòng (Word, Excel, Power Point, Outlook...)</li><li>Am hiểu kiến thức chuyên môn về Marketing</li><li>Kiến thức và kinh nghiệm về truyền thông, báo chí, sự kiện</li><li>Hiểu biết về ngành hàng liên quan</li><li>Kỹ năng:</li><li>Giải quyết vấn đề</li><li>Giao tiếp tốt</li><li>Làm việc nhóm và làm độc lập việc hiệu quả</li><li>Quản lý thời gian</li></ul>', N'<p><strong>- Tổng thu nhập: 18- 20 triệu (Lương CB từ 17-19 triệu + Thưởng KPI + Phụ cấp ăn trưa + Thưởng chuyên cần).</strong></p><p><strong>Thử việc tháng đầu hưởng 85% lương, tháng thứ 2 hưởng 100% lương.</strong></p><p>- Các chính sách thưởng, phúc lợi theo quy định của Công ty: Lương tháng 13, Thường ngày lễ. Quà các ngày (Sinh nhật, tết thiếu nhi, tết trung thu, Quốc tế phụ nữ, Phụ nữ Việt Nam).</p><p>- Được hưởng phép năm sau khi hoàn thành thử việc: 01 ngày / tháng</p><p>- Tham gia Team Building, Du lịch, sự kiện hàng năm do Công ty tổ chức.</p><p>- Người lao động được tham gia BHXH, BHYT, BHTN theo quy định của Công ty.</p><p>- Tăng lương định kỳ (tháng 01 hàng năm). Xét duyệt tăng trước thời hạn khi có thành tích xuất sắc.</p><p>- Môi trường làm việc năng động, thân thiện, cơ hội thăng tiến.</p>', N'- Hà Nội: 671 Hoàng Hoa Thám, Ba Đình', N'Ứng viên nộp hồ sơ trực tuyến bằng cách bấm Ứng tuyển ngay dưới đây.', N'CÔNG TY CP ĐẦU TƯ VÀ THƯƠNG MẠI QUỐC TẾ PHAN NGUYỄN', N'18 - 20 triệu', N'Hà Nội', 'Full-time', 'uploads/company_logos/1751286883003_TTMQT.webp', NULL, N'Nhân Viên', NULL, 'HR', N'100-499 Nhân viên', 'https://pncom.vn', N'CÔNG TY CP ĐẦU TƯ VÀ THƯƠNG MẠI QUỐC TẾ PHAN NGUYỄN là đơn vị tiên phong nhập khẩu và phân phối hàng Organic có chứng nhận quốc tế. Với hơn 3000 đại lý lớn nhỏ trải dài từ Bắc vào Nam, Phan Nguyễn là doanh nghiệp hàng đầu tại Việt Nam hoạt động trong lĩnh vực F&B và FMCG với thế mạnh là các sản phẩm hữu cơ, góp phần tạo ra xu hướng sống xanh, sống khoẻ. 1. TẦM NHÌN: Trở thành doanh nghiệp uy tín hàng đầu phân phối các sản phẩm hữu cơ, các sản phẩm dinh dưỡng và sức khỏe tại Việt Nam. 2. SỨ MỆNH: Góp phần thay đổi nhận thức, thói quen cho cộng đồng trong việc tiêu dùng các sản phẩm chất lượng, tạo dựng một thế hệ khỏe mạnh, một môi trường sống xanh và sạch. 3. TÍN: Phan Nguyễn luôn đặt chữ TÍN lên hàng đầu, luôn đảm bảo các cam kết của mình với khách hàng, đối tác. Mọi sản phẩm hữu cơ đều được lựa chọn kỹ càng, có chứng nhận rõ ràng từ những tổ chức uy tín hàng đầu thế giới. 4. TÂM: Chữ TÂM là nền tảng triết lý kinh doanh của Phan Nguyễn. Khách hàng luôn được đặt lên vị trí hàng đầu', N'Chuyên môn Event Marketing Báo chí');


-- Thêm dữ liệu mẫu cho Email_Templates
INSERT INTO Email_Templates (template_name, template_type, subject, body_html, body_text, variables, is_active, created_by) VALUES
-- Template xác nhận nhận hồ sơ
(N'Xác nhận nhận hồ sơ', 'application_received', 
 N'[JobFinding] Xác nhận nhận được hồ sơ ứng tuyển - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận nhận hồ sơ</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #28a745; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Chúng tôi đã nhận được hồ sơ ứng tuyển của bạn cho vị trí <strong>{{jobTitle}}</strong> tại <strong>{{companyName}}</strong>.</p>
        <p>Thông tin ứng tuyển:</p>
        <ul>
            <li>Vị trí: {{jobTitle}}</li>
            <li>Công ty: {{companyName}}</li>
            <li>Ngày nộp: {{applicationDate}}</li>
        </ul>
        <p>Chúng tôi sẽ xem xét hồ sơ của bạn và liên hệ lại trong thời gian sớm nhất.</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Chúng tôi đã nhận được hồ sơ ứng tuyển của bạn cho vị trí {{jobTitle}} tại {{companyName}}.

Thông tin ứng tuyển:
- Vị trí: {{jobTitle}}
- Công ty: {{companyName}}
- Ngày nộp: {{applicationDate}}

Chúng tôi sẽ xem xét hồ sơ của bạn và liên hệ lại trong thời gian sớm nhất.

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "applicationDate", "recruiterName"]',
 1, 1),

-- Template lời mời phỏng vấn
(N'Lời mời phỏng vấn', 'interview_invitation',
 N'[JobFinding] Lời mời phỏng vấn - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lời mời phỏng vấn</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #007bff; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Chúng tôi rất vui mừng thông báo rằng hồ sơ của bạn đã được chọn để tham gia phỏng vấn cho vị trí <strong>{{jobTitle}}</strong>.</p>
        <div style="background-color: #e7f3ff; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h3 style="color: #0066cc; margin-top: 0;">Thông tin phỏng vấn:</h3>
            <ul>
                <li>Thời gian: {{interviewDate}} lúc {{interviewTime}}</li>
                <li>Địa điểm: {{location}}</li>
                <li>Người phỏng vấn: {{interviewerName}}</li>
                <li>Loại phỏng vấn: {{interviewType}}</li>
                <li>Thời gian dự kiến: {{duration}} phút</li>
            </ul>
        </div>
        <p>Vui lòng xác nhận tham gia phỏng vấn bằng cách trả lời email này.</p>
        <p>Nếu có bất kỳ câu hỏi nào, xin vui lòng liên hệ với chúng tôi.</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Chúng tôi rất vui mừng thông báo rằng hồ sơ của bạn đã được chọn để tham gia phỏng vấn cho vị trí {{jobTitle}}.

Thông tin phỏng vấn:
- Thời gian: {{interviewDate}} lúc {{interviewTime}}
- Địa điểm: {{location}}
- Người phỏng vấn: {{interviewerName}}
- Loại phỏng vấn: {{interviewType}}
- Thời gian dự kiến: {{duration}} phút

Vui lòng xác nhận tham gia phỏng vấn bằng cách trả lời email này.

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "interviewDate", "interviewTime", "location", "interviewerName", "interviewType", "duration", "recruiterName"]',
 1, 1),

-- Template nhắc nhở phỏng vấn
(N'Nhắc nhở phỏng vấn', 'interview_reminder',
 N'[JobFinding] Nhắc nhở phỏng vấn - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhắc nhở phỏng vấn</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #ffc107; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Đây là lời nhắc nhở về buổi phỏng vấn của bạn cho vị trí <strong>{{jobTitle}}</strong>.</p>
        <div style="background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h3 style="color: #856404; margin-top: 0;">Thông tin phỏng vấn:</h3>
            <ul>
                <li>Thời gian: {{interviewDate}} lúc {{interviewTime}}</li>
                <li>Địa điểm: {{location}}</li>
                <li>Người phỏng vấn: {{interviewerName}}</li>
            </ul>
        </div>
        <p>Vui lòng chuẩn bị đầy đủ và đến đúng giờ.</p>
        <p>Chúc bạn may mắn!</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Đây là lời nhắc nhở về buổi phỏng vấn của bạn cho vị trí {{jobTitle}}.

Thông tin phỏng vấn:
- Thời gian: {{interviewDate}} lúc {{interviewTime}}
- Địa điểm: {{location}}
- Người phỏng vấn: {{interviewerName}}

Vui lòng chuẩn bị đầy đủ và đến đúng giờ.

Chúc bạn may mắn!

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "interviewDate", "interviewTime", "location", "interviewerName", "recruiterName"]',
 1, 1),

-- Template từ chối
(N'Thư từ chối', 'rejection',
 N'[JobFinding] Thông báo kết quả ứng tuyển - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông báo kết quả ứng tuyển</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #dc3545; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Cảm ơn bạn đã quan tâm và ứng tuyển vào vị trí <strong>{{jobTitle}}</strong> tại {{companyName}}.</p>
        <p>Sau khi xem xét kỹ lưỡng, chúng tôi rất tiếc phải thông báo rằng hồ sơ của bạn không phù hợp với yêu cầu của vị trí này vào thời điểm hiện tại.</p>
       
        <div style="background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h4 style="color: #856404; margin-top: 0;">Lý do cụ thể:</h4>
            <p style="margin-bottom: 0;">{{rejectionReason}}</p>
        </div>
   
        <p>Chúng tôi đánh giá cao sự quan tâm của bạn và khuyến khích bạn tiếp tục theo dõi các cơ hội việc làm khác tại công ty.</p>
        <p>Chúc bạn thành công trong việc tìm kiếm công việc!</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Cảm ơn bạn đã quan tâm và ứng tuyển vào vị trí {{jobTitle}} tại {{companyName}}.

Sau khi xem xét kỹ lưỡng, chúng tôi rất tiếc phải thông báo rằng hồ sơ của bạn không phù hợp với yêu cầu của vị trí này vào thời điểm hiện tại.


Lý do cụ thể: {{rejectionReason}}
{{/if}}

Chúng tôi đánh giá cao sự quan tâm của bạn và khuyến khích bạn tiếp tục theo dõi các cơ hội việc làm khác tại công ty.

Chúc bạn thành công trong việc tìm kiếm công việc!

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "rejectionReason", "recruiterName"]',
 1, 1),

-- Template lời mời làm việc
(N'Lời mời làm việc', 'offer',
 N'[JobFinding] Lời mời làm việc - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lời mời làm việc</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #28a745; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Chúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí <strong>{{jobTitle}}</strong> tại {{companyName}}.</p>
        <div style="background-color: #d4edda; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h3 style="color: #155724; margin-top: 0;">Chi tiết lời mời:</h3>
            <ul>
                <li>Vị trí: {{jobTitle}}</li>
                <li>Mức lương: {{salaryOffer}}</li>
                <li>Ngày bắt đầu: {{startDate}}</li>
                <li>Thời gian làm việc: {{workingTime}}</li>
                <li>Địa điểm: {{workLocation}}</li>
            </ul>
        </div>
        <p>Vui lòng xác nhận việc nhận lời mời này trong vòng {{responseDeadline}} ngày.</p>
        <p>Chúng tôi rất mong được làm việc cùng bạn!</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Chúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí {{jobTitle}} tại {{companyName}}.

Chi tiết lời mời:
- Vị trí: {{jobTitle}}
- Mức lương: {{salaryOffer}}
- Ngày bắt đầu: {{startDate}}
- Thời gian làm việc: {{workingTime}}
- Địa điểm: {{workLocation}}

Vui lòng xác nhận việc nhận lời mời này trong vòng {{responseDeadline}} ngày.

Chúng tôi rất mong được làm việc cùng bạn!

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "salaryOffer", "startDate", "workingTime", "workLocation", "responseDeadline", "recruiterName"]',
 1, 1);

-- Thêm comment cho các bảng
EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Bảng lưu trữ các template email', 
    @level0type = N'SCHEMA', @level0name = N'dbo', 
    @level1type = N'TABLE', @level1name = N'Email_Templates';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Bảng lưu trữ lịch sử gửi email', 
    @level0type = N'SCHEMA', @level0name = N'dbo', 
    @level1type = N'TABLE', @level1name = N'Email_History';