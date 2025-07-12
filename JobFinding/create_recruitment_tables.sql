-- =====================================================
-- 0. XÓA CÁC BẢNG NẾU ĐÃ TỒN TẠI
-- =====================================================
IF OBJECT_ID('dbo.Skills_Tests','U') IS NOT NULL 
    DROP TABLE dbo.Skills_Tests;
IF OBJECT_ID('dbo.Screening_Results','U') IS NOT NULL 
    DROP TABLE dbo.Screening_Results;
IF OBJECT_ID('dbo.Recruitment_Process','U') IS NOT NULL 
    DROP TABLE dbo.Recruitment_Process;
GO

-- =====================================================
-- 1. TẠO BẢNG Recruitment_Process
-- =====================================================
CREATE TABLE dbo.Recruitment_Process (
    id                   INT IDENTITY(1,1) PRIMARY KEY,
    applicationId        INT             NOT NULL,
    currentStage         VARCHAR(50)     NOT NULL,  -- initial_screening, phone_interview, …
    status               VARCHAR(20)     NOT NULL,  -- in_progress, completed, rejected, hired
    createdAt            DATETIME2(0)    NOT NULL 
                         CONSTRAINT DF_Recruitment_Process_CreatedAt 
                         DEFAULT SYSUTCDATETIME(),
    updatedAt            DATETIME2(0)    NOT NULL 
                         CONSTRAINT DF_Recruitment_Process_UpdatedAt 
                         DEFAULT SYSUTCDATETIME(),
    notes                TEXT            NULL,
    assignedHrId         INT             NOT NULL,
    assignedRecruiterId  INT             NOT NULL
);
GO

-- =====================================================
-- 2. TẠO TRIGGER TỰ ĐỘNG CẬP NHẬT updatedAt
-- =====================================================
CREATE TRIGGER trg_Recruitment_Process_Update
ON dbo.Recruitment_Process
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE RP
    SET    updatedAt = SYSUTCDATETIME()
    FROM   dbo.Recruitment_Process RP
    JOIN   inserted i ON RP.id = i.id;
END;
GO

-- =====================================================
-- 3. TẠO BẢNG Screening_Results
-- =====================================================
CREATE TABLE dbo.Screening_Results (
    id                   INT IDENTITY(1,1) PRIMARY KEY,
    recruitmentProcessId INT             NOT NULL,
    screeningType        VARCHAR(20)     NOT NULL,  -- automated, manual
    result               VARCHAR(20)     NOT NULL,  -- pass, fail, shortlist
    score                INT             NOT NULL,  -- 1-10
    feedback             TEXT            NULL,
    reviewerName         VARCHAR(100)    NOT NULL,
    reviewedAt           DATETIME2(0)    NOT NULL 
                         CONSTRAINT DF_Screening_Results_ReviewedAt 
                         DEFAULT SYSUTCDATETIME(),
    criteria             NVARCHAR(MAX)   NULL,       -- JSON string

    CONSTRAINT FK_Screening_Process
      FOREIGN KEY (recruitmentProcessId)
      REFERENCES dbo.Recruitment_Process(id)
      ON DELETE CASCADE
);
GO

-- =====================================================
-- 4. TẠO BẢNG Skills_Tests
-- =====================================================
CREATE TABLE dbo.Skills_Tests (
    id                   INT IDENTITY(1,1) PRIMARY KEY,
    recruitmentProcessId INT             NOT NULL,
    testType             VARCHAR(30)     NOT NULL,  -- technical, soft_skills, personality, language
    testName             VARCHAR(200)    NOT NULL,
    testUrl              VARCHAR(500)    NULL,
    scheduledAt          DATETIME2(0)    NOT NULL 
                         CONSTRAINT DF_Skills_Tests_ScheduledAt 
                         DEFAULT SYSUTCDATETIME(),
    deadline             DATETIME2(0)    NOT NULL,
    completedAt          DATETIME2(0)    NULL,
    status               VARCHAR(20)     NOT NULL 
                         CONSTRAINT DF_Skills_Tests_Status 
                         DEFAULT 'scheduled',  -- scheduled, in_progress, completed, expired
    score                INT             NULL,       -- 0-100
    result               VARCHAR(20)     NULL,       -- pass, fail
    feedback             TEXT            NULL,
    testInstructions     TEXT            NULL,

    CONSTRAINT FK_Skills_Process
      FOREIGN KEY (recruitmentProcessId)
      REFERENCES dbo.Recruitment_Process(id)
      ON DELETE CASCADE
);
GO

-- =====================================================
-- 5. TẠO INDEXES CHO HIỆU SUẤT
-- =====================================================
CREATE INDEX idx_recruitment_application 
    ON dbo.Recruitment_Process(applicationId);
CREATE INDEX idx_recruitment_stage       
    ON dbo.Recruitment_Process(currentStage);
CREATE INDEX idx_recruitment_status      
    ON dbo.Recruitment_Process(status);
CREATE INDEX idx_recruitment_hr          
    ON dbo.Recruitment_Process(assignedHrId);
CREATE INDEX idx_recruitment_updated     
    ON dbo.Recruitment_Process(updatedAt);

CREATE INDEX idx_screening_process 
    ON dbo.Screening_Results(recruitmentProcessId);
CREATE INDEX idx_screening_type    
    ON dbo.Screening_Results(screeningType);
CREATE INDEX idx_screening_result  
    ON dbo.Screening_Results(result);
CREATE INDEX idx_screening_review  
    ON dbo.Screening_Results(reviewedAt);

CREATE INDEX idx_skills_process   
    ON dbo.Skills_Tests(recruitmentProcessId);
CREATE INDEX idx_skills_type      
    ON dbo.Skills_Tests(testType);
CREATE INDEX idx_skills_status    
    ON dbo.Skills_Tests(status);
CREATE INDEX idx_skills_deadline  
    ON dbo.Skills_Tests(deadline);
CREATE INDEX idx_skills_scheduled 
    ON dbo.Skills_Tests(scheduledAt);
GO

-- =====================================================
-- 6. CHÈN DỮ LIỆU MẪU ĐỂ TEST
-- =====================================================
INSERT INTO dbo.Recruitment_Process 
    (applicationId, currentStage, status, assignedHrId, assignedRecruiterId, notes) VALUES
(1, 'initial_screening','in_progress',1,2,'Quy trình tuyển dụng được khởi tạo'),
(2, 'phone_interview', 'in_progress',1,2,'Đã pass screening, chuyển sang phỏng vấn điện thoại'),
(3, 'skills_test',     'in_progress',1,2,'Đã pass phone interview, cần làm test kỹ năng'),
(4, 'final_interview', 'in_progress',1,2,'Đã pass skills test, chuyển sang phỏng vấn cuối'),
(5, 'decision',        'in_progress',1,2,'Đã hoàn thành phỏng vấn cuối, chờ quyết định'),
(6, 'offer',           'in_progress',1,2,'Đã quyết định tuyển, chuẩn bị gửi offer'),
(7, 'completed',       'hired',      1,2,'Ứng viên đã nhận offer và gia nhập công ty'),
(8, 'rejected',        'rejected',   1,2,'Ứng viên không đáp ứng yêu cầu');
GO

INSERT INTO dbo.Screening_Results 
    (recruitmentProcessId, screeningType, result, score, feedback, reviewerName, criteria) VALUES
(1,'automated','pass',8,'Đáp ứng yêu cầu cơ bản về kinh nghiệm và kỹ năng','System','{"experience":"3+ years","skills":["Java","Spring"],"education":"Bachelor"}'),
(1,'manual',   'pass',9,'Hồ sơ tốt, có kinh nghiệm phù hợp, văn hóa công ty phù hợp','HR Manager','{"culture_fit":"high","communication":"good","motivation":"high"}'),
(2,'automated','pass',7,'Đáp ứng yêu cầu tối thiểu','System','{"experience":"2+ years","skills":["JavaScript","React"],"education":"Bachelor"}'),
(2,'manual',   'pass',8,'Kinh nghiệm phù hợp, cần phỏng vấn để đánh giá kỹ hơn','HR Specialist','{"culture_fit":"medium","communication":"good","motivation":"high"}'),
(8,'automated','fail',3,'Không đáp ứng yêu cầu về kinh nghiệm','System','{"experience":"0 years","skills":["Basic HTML"],"education":"High School"}'),
(8,'manual',   'fail',2,'Kinh nghiệm không đủ, kỹ năng còn yếu','HR Manager','{"culture_fit":"low","communication":"poor","motivation":"low"}');
GO

INSERT INTO dbo.Skills_Tests 
    (recruitmentProcessId, testType, testName, testUrl, deadline, status, testInstructions) VALUES
(3,'technical','Java Programming Test','https://testplatform.com/java-test-001',
    DATEADD(day,3,SYSUTCDATETIME()),'scheduled','Hoàn thành bài test Java trong 60 phút.'),
(3,'personality','Culture Fit Assessment','https://testplatform.com/personality-test-001',
    DATEADD(day,2,SYSUTCDATETIME()),'scheduled','Bài test đánh giá tính cách và phù hợp văn hóa.'),
(4,'technical','System Design Test','https://testplatform.com/design-test-001',
    DATEADD(day,5,SYSUTCDATETIME()),'completed','Thiết kế hệ thống e-commerce.'),
(4,'language','English Proficiency Test','https://testplatform.com/english-test-001',
    DATEADD(day,2,SYSUTCDATETIME()),'completed','Bài test tiếng Anh: reading, writing, speaking.');
GO

-- CẬP NHẬT KẾT QUẢ CHO Skills_Tests
UPDATE dbo.Skills_Tests
SET    score = 85, result = 'pass', feedback = 'Java tốt, hiểu OOP và Spring.', 
       completedAt = SYSUTCDATETIME(), status = 'completed'
WHERE  id = 1;

UPDATE dbo.Skills_Tests
SET    score = 90, result = 'pass', feedback = 'Tinh thần teamwork tốt.', 
       completedAt = SYSUTCDATETIME(), status = 'completed'
WHERE  id = 2;

UPDATE dbo.Skills_Tests
SET    score = 78, result = 'pass', feedback = 'Thiết kế tốt, cải thiện performance.', 
       completedAt = SYSUTCDATETIME(), status = 'completed'
WHERE  id = 3;

UPDATE dbo.Skills_Tests
SET    score = 92, result = 'pass', feedback = 'Tiếng Anh rất tốt.', 
       completedAt = SYSUTCDATETIME(), status = 'completed'
WHERE  id = 4;
GO
