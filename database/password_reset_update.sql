-- Add reset token columns to Admin table
ALTER TABLE Admin
ADD reset_token NVARCHAR(255) NULL,
    reset_token_expiry DATETIME NULL;

-- Add reset token columns to Recruiter table
ALTER TABLE Recruiter
ADD reset_token NVARCHAR(255) NULL,
    reset_token_expiry DATETIME NULL;

-- Add reset token columns to Job_Seekers table
ALTER TABLE Job_Seekers
ADD reset_token NVARCHAR(255) NULL,
    reset_token_expiry DATETIME NULL; 