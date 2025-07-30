-- Add recruiter_id column to Email_History table
ALTER TABLE Email_History ADD recruiter_id INT NULL;

-- Add foreign key constraint
ALTER TABLE Email_History ADD CONSTRAINT FK_EmailHistory_Recruiter 
FOREIGN KEY (recruiter_id) REFERENCES Recruiter(recruiter_id);

-- Update existing records to set recruiter_id based on application
UPDATE eh 
SET eh.recruiter_id = p.recruiter_id
FROM Email_History eh
LEFT JOIN Application a ON eh.application_id = a.application_id
LEFT JOIN Post p ON a.post_id = p.post_id
WHERE eh.recruiter_id IS NULL AND p.recruiter_id IS NOT NULL; 