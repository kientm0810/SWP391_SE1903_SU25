DROP DATABASE IF EXISTS project_SWP391;
CREATE DATABASE project_SWP391;

USE project_SWP391;



-- Admin Table
CREATE TABLE Admin (
    id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20), 
    date_of_birth DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    profile_picture VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_active BIT DEFAULT 1
);





-- Recruiter Table
CREATE TABLE Recruiter (
    id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20), 
    date_of_birth DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    profile_picture VARCHAR(255),
    company_name VARCHAR(100) NOT NULL,
    company_description TEXT,
    logo VARCHAR(255),
    website VARCHAR(255),
    company_address VARCHAR(255),
    company_size VARCHAR(50), 
    industry VARCHAR(100), 
    tax_code VARCHAR(50), 
    loyalty_score DECIMAL(10, 2) DEFAULT 0.0,
    verification_status VARCHAR(20) DEFAULT 'pending' CHECK (verification_status IN ('pending', 'verified', 'rejected')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_active BIT DEFAULT 1
);

-- Job_Seekers Table
CREATE TABLE Job_Seekers (
    id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    profile_picture VARCHAR(255),
    cv_file VARCHAR(255),
    skills TEXT,
    experience_years INT,
    education TEXT,
    desired_job_title VARCHAR(100),
    desired_salary DECIMAL(15,2),
    job_category VARCHAR(100),
    preferred_location VARCHAR(100),
    career_level VARCHAR(50), 
    work_type VARCHAR(50), 
    profile_summary TEXT,
    portfolio_url VARCHAR(255),
    languages TEXT, 
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    is_active BIT DEFAULT 1
);

-- Email Table
CREATE TABLE Email (
    id INT PRIMARY KEY IDENTITY(1,1),
    sender_id INT NOT NULL,
    sender_type VARCHAR(20) NOT NULL CHECK (sender_type IN ('admin', 'recruiter', 'job_seeker')),
    recipient_id INT NOT NULL,
    recipient_type VARCHAR(20) NOT NULL CHECK (recipient_type IN ('admin', 'recruiter', 'job_seeker')),
    subject VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    is_read BIT DEFAULT 0,
    sent_at DATETIME DEFAULT GETDATE(),
    attachments VARCHAR(255)
);

-- Notifications Table
CREATE TABLE Notifications (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('admin', 'recruiter', 'job_seeker')),
    type VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);

-- Promotion_Programs Table
CREATE TABLE Promotion_Programs (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    cost DECIMAL(12, 2) NOT NULL,
    duration_days INT NOT NULL,
    description TEXT,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng Financial_Transactions đã gộp Checkout vào
CREATE TABLE Financial_Transactions (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruiter_id INT NOT NULL,
    promotion_id INT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    transaction_type VARCHAR(20) NOT NULL CHECK (transaction_type IN ('featured_job', 'advertising', 'subscription', 'cv_service', 'checkout', 'other')),
    amount DECIMAL(12, 2) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    transaction_date DATETIME DEFAULT GETDATE(),
    payment_method VARCHAR(50),
    transaction_code VARCHAR(100), -- tương đương transaction_id trong Checkout
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(id),
    FOREIGN KEY (promotion_id) REFERENCES Promotion_Programs(id)
);

-- Job_Listings Table
CREATE TABLE Job_Listings (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruiter_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    requirements TEXT,
    location VARCHAR(100),
    salary_min DECIMAL(12, 2),
    salary_max DECIMAL(12, 2),
    job_type VARCHAR(20) NOT NULL CHECK (job_type IN ('full_time', 'part_time', 'freelance', 'internship', 'contract')),
    experience_level VARCHAR(50),
    is_featured BIT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'paused', 'filled', 'expired')),
    application_deadline DATETIME,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    expires_at DATETIME,
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(id)
);

-- Applications Table
CREATE TABLE Applications (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_listing_id INT NOT NULL,
    job_seeker_id INT NOT NULL,
    cv_file VARCHAR(255),
    cover_letter TEXT,
    status VARCHAR(20) DEFAULT 'new' CHECK (status IN ('new', 'reviewed', 'interviewed', 'offered', 'rejected')),
    applied_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_listing_id) REFERENCES Job_Listings(id),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- Recruitment_Stages Table
CREATE TABLE Recruitment_Stages (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_listing_id INT NOT NULL,
    stage_name VARCHAR(50) NOT NULL,
    order_num INT NOT NULL,
    description TEXT,
    expected_duration INT,
    FOREIGN KEY (job_listing_id) REFERENCES Job_Listings(id)
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
    job_listing_id INT NOT NULL,
    promotion_id INT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    FOREIGN KEY (job_listing_id) REFERENCES Job_Listings(id),
    FOREIGN KEY (promotion_id) REFERENCES Promotion_Programs(id)
);

-- Search_History Table
CREATE TABLE Search_History (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    search_query VARCHAR(255),
    search_filters TEXT,
    search_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

-- CV_Skills Table
CREATE TABLE CV_Skills (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    proficiency_level VARCHAR(20),
    FOREIGN KEY (job_seeker_id) REFERENCES Job_Seekers(id)
);

CREATE INDEX idx_skill_name ON CV_Skills(skill_name);

-- CV_Templates Table
CREATE TABLE CV_Templates (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    template_file VARCHAR(255) NOT NULL,
    category VARCHAR(50),
    description TEXT,
    is_premium BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);

-- Job_Seeker_CVs Table
CREATE TABLE Job_Seeker_CVs (
    id INT PRIMARY KEY IDENTITY(1,1),
    job_seeker_id INT NOT NULL,
    cv_template_id INT,
    cv_content TEXT,
    title VARCHAR(100) NOT NULL,
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
    data TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (generated_by) REFERENCES Admin(id)
);

-- Indexes for performance
CREATE INDEX idx_job_listings_recruiter_id ON Job_Listings(recruiter_id);
CREATE INDEX idx_applications_job_listing_id ON Applications(job_listing_id);
CREATE INDEX idx_applications_job_seeker_id ON Applications(job_seeker_id);


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
INSERT INTO Promotion_Programs (name, cost, duration_days, description, is_active)
VALUES
('Basic Featured Job', 300.00, 14, 'Standard featured job listing', 1),
('Premium Featured Job', 500.00, 30, 'Premium featured job with top placement', 1),
('Homepage Banner', 1000.00, 7, 'Banner advertisement on homepage', 1),
('CV Access Package', 200.00, 30, 'Access to premium CV database', 1);

-- Insert data into Job_Listings table
INSERT INTO Job_Listings (recruiter_id, title, description, requirements, location, salary_min, salary_max, 
                         job_type, experience_level, is_featured, status, application_deadline, expires_at)
VALUES
(1, 'Senior Java Developer', 'We are looking for an experienced Java developer to join our team working on enterprise solutions.', 
 '3+ years Java experience, Spring Framework, Microservices', 'Hanoi', 2000.00, 3000.00, 'full_time', 'Senior', 1, 'active', '2023-12-31', '2023-12-31'),
 
(1, 'React Native Developer', 'Join our mobile development team to build cross-platform applications.', 
 '2+ years React Native, JavaScript, Redux', 'Hanoi, Remote', 1500.00, 2500.00, 'full_time', 'Mid-level', 0, 'active', '2023-11-30', '2023-11-30'),
 
(2, 'Product Manager', 'Lead product development for our gaming platform.', 
 '5+ years product management, Agile methodology', 'HCMC', 2500.00, 4000.00, 'full_time', 'Senior', 1, 'active', '2023-12-15', '2023-12-15'),
 
(3, 'E-commerce Specialist', 'Manage online sales and marketing campaigns for our platform.', 
 '2+ years e-commerce, digital marketing', 'HCMC', 1000.00, 1500.00, 'full_time', 'Entry-level', 0, 'active', '2023-11-20', '2023-11-20'),
 
(2, 'DevOps Engineer', 'Implement and maintain CI/CD pipelines for our cloud infrastructure.', 
 '3+ years DevOps, AWS, Kubernetes', 'HCMC, Remote', 1800.00, 3000.00, 'full_time', 'Mid-level', 0, 'active', '2023-12-10', '2023-12-10');

-- Insert data into Applications table
INSERT INTO Applications (job_listing_id, job_seeker_id, cv_file, cover_letter, status)
VALUES
(1, 1, 'nguyen_dev_cv.pdf', 'Dear Hiring Manager, I am excited to apply for the Senior Java Developer position...', 'reviewed'),
(3, 3, 'hoang_ba_cv.pdf', 'Dear VNG Team, With my 5 years of experience in data science...', 'interviewed'),
(2, 2, 'linh_designer_cv.pdf', 'Dear FPT Recruitment, Although my main expertise is design...', 'new'),
(1, 3, 'hoang_ba_cv.pdf', 'Dear FPT, I believe my backend development experience...', 'rejected'),
(4, 2, 'linh_designer_cv.pdf', 'Dear Tiki Team, I am interested in combining my design skills...', 'reviewed');

-- Insert data into Recruitment_Stages table
INSERT INTO Recruitment_Stages (job_listing_id, stage_name, order_num, description, expected_duration)
VALUES
(1, 'CV Screening', 1, 'Initial CV review by HR', 3),
(1, 'Technical Test', 2, 'Online coding assessment', 5),
(1, 'Technical Interview', 3, 'Interview with technical team lead', 7),
(1, 'Final Interview', 4, 'Interview with department manager', 10),
(2, 'CV Screening', 1, 'Initial CV review', 2),
(2, 'Portfolio Review', 2, 'Design portfolio evaluation', 4),
(2, 'Design Challenge', 3, 'Practical design assignment', 5);

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

-- Insert data into Featured_Jobs table
INSERT INTO Featured_Jobs (job_listing_id, promotion_id, start_date, end_date)
VALUES
(1, 2, '2023-10-01', '2023-10-31'),
(3, 2, '2023-10-01', '2023-10-31');

-- Insert data into Search_History table
INSERT INTO Search_History (job_seeker_id, search_query, search_filters)
VALUES
(1, 'Java Developer', '{"location": "Hanoi", "salary_min": 1500, "job_type": "full_time"}'),
(2, 'UI Designer', '{"location": "Remote", "experience_level": "Entry-level"}'),
(3, 'Data Scientist', '{"location": "HCMC", "salary_min": 2500}'),
(1, 'Spring Boot jobs', '{"location": "Hanoi", "job_type": "full_time"}');

-- Insert data into CV_Skills table
INSERT INTO CV_Skills (job_seeker_id, skill_name, proficiency_level)
VALUES
(1, 'Java', 'Advanced'),
(1, 'Spring Boot', 'Advanced'),
(1, 'SQL', 'Intermediate'),
(1, 'AWS', 'Intermediate'),
(2, 'UI/UX Design', 'Intermediate'),
(2, 'Figma', 'Advanced'),
(2, 'Adobe XD', 'Intermediate'),
(3, 'Python', 'Advanced'),
(3, 'Machine Learning', 'Advanced'),
(3, 'Data Analysis', 'Advanced');

-- Insert data into CV_Templates table
INSERT INTO CV_Templates (name, template_file, category, description, is_premium)
VALUES
('Professional Blue', 'template1.docx', 'Professional', 'Clean and professional design with blue accents', 0),
('Modern Red', 'template2.docx', 'Modern', 'Contemporary design with red highlights', 1),
('Creative', 'template3.docx', 'Creative', 'Unique layout for creative professionals', 1),
('Simple Elegant', 'template4.docx', 'Professional', 'Minimalist elegant design', 0);

-- Insert data into Job_Seeker_CVs table
INSERT INTO Job_Seeker_CVs (job_seeker_id, cv_template_id, cv_content, title, is_default)
VALUES
(1, 1, '{"personal_info": {...}, "experience": [...], "education": [...]}', 'Nguyen Van D - Java Developer CV', 1),
(2, 3, '{"personal_info": {...}, "portfolio": [...], "skills": [...]}', 'Linh Thi E - Design Portfolio', 1),
(3, 2, '{"personal_info": {...}, "projects": [...], "publications": [...]}', 'Hoang Van F - Data Scientist CV', 1),
(1, 4, '{"personal_info": {...}, "experience": [...], "skills": [...]}', 'Nguyen Van D - Simplified CV', 0);

-- Insert data into Notifications table
INSERT INTO Notifications (user_id, user_type, type, content, is_read)
VALUES
(1, 'job_seeker', 'application_status', 'Your application for Senior Java Developer at FPT Software has been reviewed', 1),
(3, 'job_seeker', 'application_status', 'Your application for Product Manager at VNG Corporation has been moved to interview stage', 0),
(2, 'job_seeker', 'job_recommendation', 'New UI Designer position at Viettel may interest you', 0),
(1, 'job_seeker', 'message', 'You have a new message from FPT recruiter', 1);

-- Insert data into Reports table
INSERT INTO Reports (report_type, generated_by, start_date, end_date, data)
VALUES
('revenue', 1, '2023-10-01', '2023-10-31', '{"total_income": 1500.00, "transactions": 4}'),
('job_application_stats', 1, '2023-10-01', '2023-10-15', '{"total_applications": 125, "average_per_job": 25}'),
('employer_list', 2, '2023-09-01', '2023-09-30', '{"active_employers": 42, "new_employers": 5}');

-- Insert data into Email table
INSERT INTO Email (sender_id, sender_type, recipient_id, recipient_type, subject, body, is_read, attachments)
VALUES
(1, 'recruiter', 1, 'job_seeker', 'Interview Invitation', 'Dear Nguyen, We would like to invite you for an interview...', 1, NULL),
(1, 'job_seeker', 1, 'recruiter', 'Follow-up on Application', 'Dear Mr. Nguyen, I would like to follow up on my application...', 0, 'follow_up.pdf'),
(1, 'admin', 1, 'recruiter', 'Account Verification', 'Your account has been successfully verified', 1, NULL);




INSERT INTO Job_Seeker_CVs (job_seeker_id, cv_template_id, cv_content, title, is_default)
VALUES
(1, 1, 
'{
    "personal_info": {
        "full_name": "Nguyen Van D",
        "email": "nguyen.dev@gmail.com",
        "phone": "0912345681",
        "address": "Cau Giay, Hanoi"
    },
    "experience": [
        {
            "position": "Backend Developer",
            "company": "FPT Software",
            "duration": "2019 - 2022",
            "description": "Developed and maintained microservices using Java and Spring Boot"
        }
    ],
    "education": [
        {
            "degree": "Bachelor in Computer Science",
            "school": "Hanoi University of Science and Technology",
            "year": "2013 - 2017"
        }
    ]
}', 
'Nguyen Van D - Java Developer CV', 
1);
