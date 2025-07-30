-- Simple fix for Email_History table
-- Run this script in SQL Server Management Studio

-- Check if table exists
IF OBJECT_ID('Email_History', 'U') IS NULL
BEGIN
    PRINT 'Email_History table does not exist. Creating it...';
    
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
    
    PRINT 'Email_History table created successfully!';
END
ELSE
BEGIN
    PRINT 'Email_History table already exists. Checking columns...';
    
    -- Add recruiter_id if not exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'recruiter_id')
    BEGIN
        ALTER TABLE Email_History ADD recruiter_id INT NULL;
        PRINT 'Added recruiter_id column';
    END
    ELSE
    BEGIN
        PRINT 'recruiter_id column already exists';
    END
    
    -- Add template_name if not exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'template_name')
    BEGIN
        ALTER TABLE Email_History ADD template_name NVARCHAR(255) NULL;
        PRINT 'Added template_name column';
    END
    ELSE
    BEGIN
        PRINT 'template_name column already exists';
    END
    
    -- Add interview_schedule_id if not exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'interview_schedule_id')
    BEGIN
        ALTER TABLE Email_History ADD interview_schedule_id INT NULL;
        PRINT 'Added interview_schedule_id column';
    END
    ELSE
    BEGIN
        PRINT 'interview_schedule_id column already exists';
    END
    
    -- Add error_message if not exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'error_message')
    BEGIN
        ALTER TABLE Email_History ADD error_message NVARCHAR(MAX) NULL;
        PRINT 'Added error_message column';
    END
    ELSE
    BEGIN
        PRINT 'error_message column already exists';
    END
END

-- Show final table structure
PRINT 'Final Email_History table structure:';
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Email_History' 
ORDER BY ORDINAL_POSITION;

-- Show record count
SELECT COUNT(*) as TotalRecords FROM Email_History;
PRINT 'Email_History table is ready!'; 