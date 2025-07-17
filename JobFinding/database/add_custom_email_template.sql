-- Thêm template cho Email tùy chỉnh
INSERT INTO Email_Templates (template_name, template_type, subject, body_html, body_text, variables, is_active, created_by, created_at, updated_at) 
VALUES (
    'Email tùy chỉnh',
    'custom',
    '{{subject}}',
    '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Email tùy chỉnh</title></head><body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;"><div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;"><h2 style="color: #6c757d; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>{{emailContent}}<p style="margin-top: 20px;">Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p></div></body></html>',
    'Xin chào {{candidateName}},\n\n{{emailContent}}\n\nTrân trọng,\n{{recruiterName}}\n{{companyName}}',
    '["candidateName", "jobTitle", "companyName", "subject", "emailContent", "recruiterName"]',
    1,
    1,
    GETDATE(),
    GETDATE()
); 