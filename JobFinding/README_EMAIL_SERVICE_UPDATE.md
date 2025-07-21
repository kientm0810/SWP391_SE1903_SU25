# Email Service Update - Database Field Alignment

## Overview
Updated the EmailService and related files to match the correct database schema and model field names.

## Changes Made

### 1. EmailTemplateDAO.java
- ✅ Updated all `setTemplateId()` calls to `setId()` to match EmailTemplate model
- ✅ Added missing `getTemplateByType()` method
- ✅ Fixed database column mapping from `template_id` to `id`

### 2. EmailService.java
- ✅ Fixed all `setTemplateId()` calls to `setTemplateName()` to match EmailHistory model
- ✅ Updated template type names to match database:
  - `application_confirmation` → `application_received`
  - `application_rejection` → `rejection`
  - `application_acceptance` → `offer`
- ✅ Fixed all EmailHistory creation to use `templateName` instead of `templateId`

### 3. EmailTemplateController.java
- ✅ Updated JSON response to use `template.getId()` instead of `template.getTemplateId()`

### 4. EmailTemplate.java (Model)
- ✅ Already correctly uses `Id` field and `getId()`/`setId()` methods

### 5. EmailHistory.java (Model)
- ✅ Already correctly uses `templateName` field and `setTemplateName()` method

## Database Schema Alignment

### Email_Templates Table
```sql
CREATE TABLE Email_Templates (
    id INT PRIMARY KEY IDENTITY(1,1),           -- ✅ Used in DAO
    template_name NVARCHAR(255) NOT NULL,      -- ✅ Used in EmailHistory
    template_type VARCHAR(50) NOT NULL,        -- ✅ Used for filtering
    subject NVARCHAR(500) NOT NULL,
    body_html NTEXT NOT NULL,
    body_text NTEXT,
    variables NVARCHAR(1000),
    is_active BIT DEFAULT 1,
    created_by INT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
```

### Email_History Table
```sql
CREATE TABLE Email_History (
    id INT PRIMARY KEY IDENTITY(1,1),
    application_id INT,
    interview_schedule_id INT,
    template_name NVARCHAR(255),               -- ✅ Used instead of template_id
    recipient_email NVARCHAR(255),
    subject NVARCHAR(500),
    body_html NTEXT,
    status VARCHAR(50),
    error_message NVARCHAR(1000),
    sent_at DATETIME,
    created_at DATETIME DEFAULT GETDATE()
);
```

## Template Types Supported
The system now supports these template types:
- `application_received` - Xác nhận nhận hồ sơ
- `interview_invitation` - Lời mời phỏng vấn
- `interview_reminder` - Nhắc nhở phỏng vấn
- `rejection` - Thư từ chối
- `offer` - Lời mời làm việc
- `job_alert` - Thông báo việc làm
- `interview_completed` - Hoàn thành phỏng vấn
- `application_reviewed` - Đã xem xét hồ sơ
- `verification_*` - Xác thực tài khoản

## Testing

### 1. Test Database Connection
Visit: `http://localhost:8080/JobFinding/test-email-templates`

### 2. Test Email Form
Visit: `http://localhost:8080/JobFinding/send-email.jsp`

### 3. Test Email Service Methods
The EmailService now provides these methods:
- `sendApplicationConfirmationEmail(applicationId)`
- `sendInterviewInvitationEmail(applicationId, interviewScheduleId)`
- `sendRejectionEmail(applicationId, rejectionReason)`
- `sendAcceptanceEmail(applicationId, offerDetails)`
- `sendInterviewReminderEmail(interviewScheduleId)`
- `sendJobAlertEmail(jobAlertId, matchingJobs)`
- `sendInterviewCompletedEmail(applicationId)`
- `sendApplicationReviewedEmail(applicationId)`
- `sendAccountVerificationEmail(recruiterId, verificationStatus)`

## Files Modified
- `src/java/daos/EmailTemplateDAO.java`
- `src/java/utils/EmailService.java`
- `src/java/controllers/EmailTemplateController.java`

## Notes
- All template types now match the database schema
- EmailHistory uses `templateName` instead of `templateId`
- EmailTemplate uses `Id` field with `getId()`/`setId()` methods
- Sample data is automatically created if no templates exist
- All email sending methods now work correctly with the database structure 