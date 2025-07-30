-- Check and add missing columns to Email_History table
-- Run this script in SQL Server Management Studio

-- Check if table exists
IF OBJECT_ID('Email_History', 'U') IS NULL
BEGIN
    PRINT 'Email_History table does not exist. Please run create_email_history_table.sql first.';
    RETURN;
END

PRINT 'Checking Email_History table structure...';

-- 1. Check and add recruiter_id column
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'recruiter_id')
BEGIN
    ALTER TABLE Email_History ADD recruiter_id INT NULL;
    PRINT 'Added recruiter_id column';
END
ELSE
BEGIN
    PRINT 'recruiter_id column already exists';
END

-- 2. Check and add template_name column
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'template_name')
BEGIN
    ALTER TABLE Email_History ADD template_name NVARCHAR(255) NULL;
    PRINT 'Added template_name column';
END
ELSE
BEGIN
    PRINT 'template_name column already exists';
END

-- 3. Check and add interview_schedule_id column
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'interview_schedule_id')
BEGIN
    ALTER TABLE Email_History ADD interview_schedule_id INT NULL;
    PRINT 'Added interview_schedule_id column';
END
ELSE
BEGIN
    PRINT 'interview_schedule_id column already exists';
END

-- 4. Check and add error_message column
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'error_message')
BEGIN
    ALTER TABLE Email_History ADD error_message NVARCHAR(MAX) NULL;
    PRINT 'Added error_message column';
END
ELSE
BEGIN
    PRINT 'error_message column already exists';
END

-- 5. Add foreign key constraints if they don't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_EmailHistory_Recruiter')
BEGIN
    ALTER TABLE Email_History ADD CONSTRAINT FK_EmailHistory_Recruiter 
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(recruiter_id);
    PRINT 'Added FK_EmailHistory_Recruiter constraint';
END
ELSE
BEGIN
    PRINT 'FK_EmailHistory_Recruiter constraint already exists';
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_EmailHistory_Application')
BEGIN
    ALTER TABLE Email_History ADD CONSTRAINT FK_EmailHistory_Application 
    FOREIGN KEY (application_id) REFERENCES Application(application_id);
    PRINT 'Added FK_EmailHistory_Application constraint';
END
ELSE
BEGIN
    PRINT 'FK_EmailHistory_Application constraint already exists';
END

-- 6. Show final table structure
PRINT 'Final Email_History table structure:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Email_History' 
ORDER BY ORDINAL_POSITION;

-- 7. Show current record count
SELECT COUNT(*) as TotalRecords FROM Email_History;
PRINT 'Email_History table is ready for use!'; 