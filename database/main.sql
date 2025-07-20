DROP DATABASE IF EXISTS project_SWP391;
CREATE DATABASE project_SWP391;

USE project_SWP391;

-- Admin Table
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

-- Blog Table
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

-- Banner Table
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

-- Recruiter Table
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

-- Notifications Table
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

-- Job_Seekers Table
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

-- Promotion_Programs Table
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
    quantity INT DEFAULT -1, -- -1 means unlimited
	FOREIGN KEY (admin_id) REFERENCES Admin(id)
);

-- Financial_Transactions Table
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
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(id),
);

-- Posts Table
CREATE TABLE Posts (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('admin', 'recruiter', 'job_seeker')),
    parent_id INT NULL,
    post_type VARCHAR(20) NOT NULL CHECK (post_type IN ('post', 'comment', 'like')),
    title NVARCHAR(MAX) NULL,
    content NVARCHAR(MAX),
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'deleted')),
    view_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    deleted_at DATETIME NULL,
    company_name NVARCHAR(255),
    company_logo VARCHAR(500),
    salary NVARCHAR(100),
    location NVARCHAR(255),
    job_type NVARCHAR(50),
    experience VARCHAR(100),
    deadline DATE,
    working_time NVARCHAR(200),
    job_description TEXT,
    requirements TEXT,
    benefits TEXT,
    contact_address NVARCHAR(500),
    application_method TEXT,
    quantity INT NULL,
    rank NVARCHAR(100) NULL,
    industry NVARCHAR(255) NULL,
    contact_person NVARCHAR(255) NULL,
    company_size NVARCHAR(100) NULL,
    company_website VARCHAR(500) NULL,
    company_description NVARCHAR(MAX) NULL,
    keywords NVARCHAR(500) NULL,
    FOREIGN KEY (user_id) REFERENCES Recruiter(id)
);

-- Applications Table
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

-- Recruitment_Stages Table
CREATE TABLE Recruitment_Stages (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    stage_name VARCHAR(50) NOT NULL,
    order_num INT NOT NULL,
    description NTEXT,
    expected_duration INT,
    FOREIGN KEY (post_id) REFERENCES Posts(id)
);

-- Application_Stages Table
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

-- Featured_Jobs Table
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

-- Search_History Table
CREATE TABLE Search_History (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    search_query NVARCHAR(255),
    search_filters NTEXT,
    search_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- CV_Skills Table
CREATE TABLE CV_Skills (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    skill_name NVARCHAR(100) NOT NULL,
    proficiency_level NVARCHAR(20),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- CV_Templates Table
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

-- Job_Seeker_CVs Table
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

-- Reports Table
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

-- Interviews Table
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

-- Application_Status_History Table
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

-- Candidate_Evaluations Table
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

-- Saved_Jobs Table
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

-- 1. Create Post_Pricing table
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

-- Insert sample pricing data
INSERT INTO Post_Pricing (position_name, position_code, price, duration_days, description) 
VALUES 
(N'Bài viết thường', 'normal', 100000, 30, N'Hiển thị trong danh sách tìm kiếm'),
(N'Bài viết nổi bật', 'featured', 300000, 30, N'Hiển thị ở vị trí nổi bật'),
(N'Bài viết Premium', 'premium', 500000, 30, N'Hiển thị ở trang chủ và đầu danh sách'),
(N'Phí đăng ký', 'registration', 50000, 0, N'Phí đăng ký tài khoản nhà tuyển dụng');

-- Insert data into Promotion_Programs table
INSERT INTO Promotion_Programs (name, cost, duration_days, description, is_active, admin_id, position_type)
VALUES
(N'Bài viết thường', 100000, 30, N'Hiển thị trong danh sách tìm kiếm', 1, 1, 'normal'),
(N'Bài viết nổi bật', 300000, 30, N'Hiển thị ở vị trí nổi bật', 1, 1, 'featured'),
(N'Bài viết Premium', 500000, 30, N'Hiển thị ở trang chủ và đầu danh sách', 1, 1, 'premium');