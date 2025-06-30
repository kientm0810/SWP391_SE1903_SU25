-- =====================================================
-- TẠO BẢNG CHO HỆ THỐNG RECRUITMENT
-- =====================================================

-- 1. Bảng quản lý quy trình tuyển dụng
CREATE TABLE Recruitment_Process (
    id INT PRIMARY KEY IDENTITY(1,1),
    applicationId INT NOT NULL,
    currentStage VARCHAR(50) NOT NULL, -- initial_screening, phone_interview, skills_test, final_interview, decision, offer
    status VARCHAR(20) NOT NULL, -- in_progress, completed, rejected, hired
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    assignedHrId INT NOT NULL,
    assignedRecruiterId INT NOT NULL
);

-- 2. Bảng kết quả sàng lọc hồ sơ
CREATE TABLE Screening_Results (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruitmentProcessId INT NOT NULL,
    screeningType VARCHAR(20) NOT NULL, -- automated, manual
    result VARCHAR(20) NOT NULL, -- pass, fail, shortlist
    score INT NOT NULL, -- 1-10
    feedback TEXT,
    reviewerName VARCHAR(100) NOT NULL,
    reviewedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    criteria TEXT, -- JSON string for criteria details
    
    FOREIGN KEY (recruitmentProcessId) REFERENCES Recruitment_Process(id) ON DELETE CASCADE
);

-- 3. Bảng quản lý bài test kỹ năng
CREATE TABLE Skills_Tests (
    id INT PRIMARY KEY IDENTITY(1,1),
    recruitmentProcessId INT NOT NULL,
    testType VARCHAR(30) NOT NULL, -- technical, soft_skills, personality, language
    testName VARCHAR(200) NOT NULL,
    testUrl VARCHAR(500),
    scheduledAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deadline TIMESTAMP NOT NULL,
    completedAt TIMESTAMP NULL,
    status VARCHAR(20) DEFAULT 'scheduled', -- scheduled, in_progress, completed, expired
    score INT NULL, -- 0-100
    result VARCHAR(20) NULL, -- pass, fail
    feedback TEXT,
    testInstructions TEXT,
    
    FOREIGN KEY (recruitmentProcessId) REFERENCES Recruitment_Process(id) ON DELETE CASCADE
);

-- =====================================================
-- TẠO INDEXES CHO HIỆU SUẤT
-- =====================================================

-- Indexes cho Recruitment_Process
CREATE INDEX idx_recruitment_application ON Recruitment_Process(applicationId);
CREATE INDEX idx_recruitment_stage ON Recruitment_Process(currentStage);
CREATE INDEX idx_recruitment_status ON Recruitment_Process(status);
CREATE INDEX idx_recruitment_hr ON Recruitment_Process(assignedHrId);
CREATE INDEX idx_recruitment_updated ON Recruitment_Process(updatedAt);

-- Indexes cho Screening_Results
CREATE INDEX idx_screening_process ON Screening_Results(recruitmentProcessId);
CREATE INDEX idx_screening_type ON Screening_Results(screeningType);
CREATE INDEX idx_screening_result ON Screening_Results(result);
CREATE INDEX idx_screening_reviewed ON Screening_Results(reviewedAt);

-- Indexes cho Skills_Tests
CREATE INDEX idx_skills_process ON Skills_Tests(recruitmentProcessId);
CREATE INDEX idx_skills_type ON Skills_Tests(testType);
CREATE INDEX idx_skills_status ON Skills_Tests(status);
CREATE INDEX idx_skills_deadline ON Skills_Tests(deadline);
CREATE INDEX idx_skills_scheduled ON Skills_Tests(scheduledAt);

-- =====================================================
-- DỮ LIỆU MẪU ĐỂ TEST
-- =====================================================

-- Insert sample recruitment processes
INSERT INTO Recruitment_Process (applicationId, currentStage, status, assignedHrId, assignedRecruiterId, notes) VALUES
(1, 'initial_screening', 'in_progress', 1, 2, 'Quy trình tuyển dụng được khởi tạo'),
(2, 'phone_interview', 'in_progress', 1, 2, 'Đã pass screening, chuyển sang phỏng vấn điện thoại'),
(3, 'skills_test', 'in_progress', 1, 2, 'Đã pass phone interview, cần làm test kỹ năng'),
(4, 'final_interview', 'in_progress', 1, 2, 'Đã pass skills test, chuyển sang phỏng vấn cuối'),
(5, 'decision', 'in_progress', 1, 2, 'Đã hoàn thành phỏng vấn cuối, chờ quyết định'),
(6, 'offer', 'in_progress', 1, 2, 'Đã quyết định tuyển, chuẩn bị gửi offer'),
(7, 'completed', 'hired', 1, 2, 'Ứng viên đã nhận offer và gia nhập công ty'),
(8, 'rejected', 'rejected', 1, 2, 'Ứng viên không đáp ứng yêu cầu');

-- Insert sample screening results
INSERT INTO Screening_Results (recruitmentProcessId, screeningType, result, score, feedback, reviewerName, criteria) VALUES
(1, 'automated', 'pass', 8, 'Đáp ứng yêu cầu cơ bản về kinh nghiệm và kỹ năng', 'System', '{"experience": "3+ years", "skills": ["Java", "Spring"], "education": "Bachelor"}'),
(1, 'manual', 'pass', 9, 'Hồ sơ tốt, có kinh nghiệm phù hợp, văn hóa công ty phù hợp', 'HR Manager', '{"culture_fit": "high", "communication": "good", "motivation": "high"}'),
(2, 'automated', 'pass', 7, 'Đáp ứng yêu cầu tối thiểu', 'System', '{"experience": "2+ years", "skills": ["JavaScript", "React"], "education": "Bachelor"}'),
(2, 'manual', 'pass', 8, 'Kinh nghiệm phù hợp, cần phỏng vấn để đánh giá kỹ hơn', 'HR Specialist', '{"culture_fit": "medium", "communication": "good", "motivation": "high"}'),
(8, 'automated', 'fail', 3, 'Không đáp ứng yêu cầu về kinh nghiệm', 'System', '{"experience": "0 years", "skills": ["Basic HTML"], "education": "High School"}'),
(8, 'manual', 'fail', 2, 'Kinh nghiệm không đủ, kỹ năng còn yếu', 'HR Manager', '{"culture_fit": "low", "communication": "poor", "motivation": "low"}');

-- Insert sample skills tests
INSERT INTO Skills_Tests (recruitmentProcessId, testType, testName, testUrl, deadline, status, testInstructions) VALUES
(3, 'technical', 'Java Programming Test', 'https://testplatform.com/java-test-001', DATEADD(day, 3, CURRENT_TIMESTAMP), 'scheduled', 'Hoàn thành bài test Java trong 60 phút. Bao gồm các câu hỏi về OOP, Collections, và Spring Framework.'),
(3, 'personality', 'Culture Fit Assessment', 'https://testplatform.com/personality-test-001', DATEADD(day, 2, CURRENT_TIMESTAMP), 'scheduled', 'Bài test đánh giá tính cách và sự phù hợp với văn hóa công ty. Thời gian: 30 phút.'),
(4, 'technical', 'System Design Test', 'https://testplatform.com/design-test-001', DATEADD(day, 5, CURRENT_TIMESTAMP), 'completed', 'Thiết kế hệ thống e-commerce với yêu cầu về scalability và performance.'),
(4, 'language', 'English Proficiency Test', 'https://testplatform.com/english-test-001', DATEADD(day, 2, CURRENT_TIMESTAMP), 'completed', 'Bài test tiếng Anh bao gồm reading, writing, và speaking. Thời gian: 45 phút.');

-- Update some skills tests with results
UPDATE Skills_Tests SET 
    score = 85, 
    result = 'pass', 
    feedback = 'Kỹ năng Java tốt, hiểu rõ về OOP và Spring Framework',
    completedAt = CURRENT_TIMESTAMP,
    status = 'completed'
WHERE id = 1;

UPDATE Skills_Tests SET 
    score = 90, 
    result = 'pass', 
    feedback = 'Tính cách phù hợp với văn hóa công ty, có tinh thần teamwork tốt',
    completedAt = CURRENT_TIMESTAMP,
    status = 'completed'
WHERE id = 2;

UPDATE Skills_Tests SET 
    score = 78, 
    result = 'pass', 
    feedback = 'Có khả năng thiết kế hệ thống, cần cải thiện về performance optimization',
    completedAt = CURRENT_TIMESTAMP,
    status = 'completed'
WHERE id = 3;

UPDATE Skills_Tests SET 
    score = 92, 
    result = 'pass', 
    feedback = 'Tiếng Anh rất tốt, có thể giao tiếp hiệu quả trong môi trường quốc tế',
    completedAt = CURRENT_TIMESTAMP,
    status = 'completed'
WHERE id = 4; 