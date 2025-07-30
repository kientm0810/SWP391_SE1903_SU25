-- Add template_name column to Email_History table
ALTER TABLE Email_History ADD template_name NVARCHAR(255) NULL;

-- Update existing records to have a default template name
UPDATE Email_History SET template_name = 'Custom Email' WHERE template_name IS NULL; 