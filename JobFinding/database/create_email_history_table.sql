-- Create Email_History table with all required fields
-- Run this script in SQL Server Management Studio

-- Drop table if exists (for testing)
IF OBJECT_ID('Email_History', 'U') IS NOT NULL
    DROP TABLE Email_History;

-- Create Email_History table
CREATE TABLE Email_History (
    id INT IDENTITY(1,1) PRIMARY KEY,
    application_id INT NULL,
    interview_schedule_id INT NULL,
    recruiter_id INT NULL,
    template_name NVARCHAR(255) NULL,
    recipient_email NVARCHAR(255) NOT NULL,
    subject NVARCHAR(500) NOT NULL,
    body_html NTEXT NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'pending',
    error_message NVARCHAR(MAX) NULL,
    sent_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE()
);

-- Add foreign key constraints
ALTER TABLE Email_History 
ADD CONSTRAINT FK_EmailHistory_Application 
FOREIGN KEY (application_id) REFERENCES Application(application_id);

ALTER TABLE Email_History 
ADD CONSTRAINT FK_EmailHistory_InterviewSchedule 
FOREIGN KEY (interview_schedule_id) REFERENCES Interview_Schedule(id);

ALTER TABLE Email_History 
ADD CONSTRAINT FK_EmailHistory_Recruiter 
FOREIGN KEY (recruiter_id) REFERENCES Recruiter(recruiter_id);

-- Add indexes for better performance
CREATE INDEX IX_EmailHistory_RecruiterId ON Email_History(recruiter_id);
CREATE INDEX IX_EmailHistory_Status ON Email_History(status);
CREATE INDEX IX_EmailHistory_CreatedAt ON Email_History(created_at);
CREATE INDEX IX_EmailHistory_RecipientEmail ON Email_History(recipient_email);

-- Show table structure
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Email_History' 
ORDER BY ORDINAL_POSITION;

-- Show table created successfully
PRINT 'Email_History table created successfully!'; 