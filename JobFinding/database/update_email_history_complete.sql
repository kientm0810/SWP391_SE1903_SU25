-- Complete update script for Email_History table
-- Run this script in SQL Server Management Studio

-- 1. Add template_name column if not exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'template_name')
BEGIN
    ALTER TABLE Email_History ADD template_name NVARCHAR(255) NULL;
    PRINT 'Added template_name column';
END
ELSE
BEGIN
    PRINT 'template_name column already exists';
END

-- 2. Add recruiter_id column if not exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'recruiter_id')
BEGIN
    ALTER TABLE Email_History ADD recruiter_id INT NULL;
    PRINT 'Added recruiter_id column';
END
ELSE
BEGIN
    PRINT 'recruiter_id column already exists';
END

-- 3. Add foreign key constraint if not exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_EmailHistory_Recruiter')
BEGIN
    ALTER TABLE Email_History ADD CONSTRAINT FK_EmailHistory_Recruiter 
    FOREIGN KEY (recruiter_id) REFERENCES Recruiter(recruiter_id);
    PRINT 'Added foreign key constraint';
END
ELSE
BEGIN
    PRINT 'Foreign key constraint already exists';
END

-- 4. Update existing records to have default template name
UPDATE Email_History SET template_name = 'Custom Email' WHERE template_name IS NULL;
PRINT 'Updated existing records with default template name';

-- 5. Update existing records to set recruiter_id based on application
UPDATE eh 
SET eh.recruiter_id = p.recruiter_id
FROM Email_History eh
LEFT JOIN Application a ON eh.application_id = a.application_id
LEFT JOIN Post p ON a.post_id = p.post_id
WHERE eh.recruiter_id IS NULL AND p.recruiter_id IS NOT NULL;
PRINT 'Updated existing records with recruiter_id';

-- 6. Show current table structure
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Email_History' 
ORDER BY ORDINAL_POSITION;

-- 7. Show current record count
SELECT COUNT(*) as TotalRecords FROM Email_History; 