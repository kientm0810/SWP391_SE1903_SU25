-- Database Update Script for CV Management Feature
-- This script ensures that the cv_templates table has the image_path column

USE project_SWP391;

-- Check if image_path column exists, if not add it
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'cv_templates' 
               AND COLUMN_NAME = 'image_path')
BEGIN
    ALTER TABLE cv_templates 
    ADD image_path VARCHAR(255) NULL;
    
    PRINT 'Added image_path column to cv_templates table';
END
ELSE
BEGIN
    PRINT 'image_path column already exists in cv_templates table';
END

-- Create uploads directory structure (this will be handled by the application)
-- The application will create:
-- - uploads/cvs/ directory for CV files

-- Update any existing CVs that might not have the image_path field
UPDATE cv_templates 
SET image_path = NULL 
WHERE image_path IS NULL;

PRINT 'Database update completed successfully';
PRINT 'CV Management feature is ready to use'; 