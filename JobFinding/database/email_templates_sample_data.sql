-- Thêm dữ liệu mẫu cho Email_Templates
INSERT INTO Email_Templates (template_name, template_type, subject, body_html, body_text, variables, is_active, created_by, created_at, updated_at) VALUES
-- Template xác nhận nhận hồ sơ
(N'Xác nhận nhận hồ sơ', 'application_received', 
 N'[JobFinding] Xác nhận nhận được hồ sơ ứng tuyển - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận nhận hồ sơ</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #28a745; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Chúng tôi đã nhận được hồ sơ ứng tuyển của bạn cho vị trí <strong>{{jobTitle}}</strong> tại <strong>{{companyName}}</strong>.</p>
        <p>Thông tin ứng tuyển:</p>
        <ul>
            <li>Vị trí: {{jobTitle}}</li>
            <li>Công ty: {{companyName}}</li>
            <li>Ngày nộp: {{applicationDate}}</li>
        </ul>
        <p>Chúng tôi sẽ xem xét hồ sơ của bạn và liên hệ lại trong thời gian sớm nhất.</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Chúng tôi đã nhận được hồ sơ ứng tuyển của bạn cho vị trí {{jobTitle}} tại {{companyName}}.

Thông tin ứng tuyển:
- Vị trí: {{jobTitle}}
- Công ty: {{companyName}}
- Ngày nộp: {{applicationDate}}

Chúng tôi sẽ xem xét hồ sơ của bạn và liên hệ lại trong thời gian sớm nhất.

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "applicationDate", "recruiterName"]',
 1, 1, GETDATE(), GETDATE()),

-- Template lời mời phỏng vấn
(N'Lời mời phỏng vấn', 'interview_invitation',
 N'[JobFinding] Lời mời phỏng vấn - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lời mời phỏng vấn</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #007bff; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Chúng tôi rất vui mừng thông báo rằng hồ sơ của bạn đã được chọn để tham gia phỏng vấn cho vị trí <strong>{{jobTitle}}</strong>.</p>
        <div style="background-color: #e7f3ff; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h3 style="color: #0066cc; margin-top: 0;">Thông tin phỏng vấn:</h3>
            <ul>
                <li>Thời gian: {{interviewDate}} lúc {{interviewTime}}</li>
                <li>Địa điểm: {{location}}</li>
                <li>Người phỏng vấn: {{interviewerName}}</li>
                <li>Loại phỏng vấn: {{interviewType}}</li>
                <li>Thời gian dự kiến: {{duration}} phút</li>
            </ul>
        </div>
        <p>Vui lòng xác nhận tham gia phỏng vấn bằng cách trả lời email này.</p>
        <p>Nếu có bất kỳ câu hỏi nào, xin vui lòng liên hệ với chúng tôi.</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Chúng tôi rất vui mừng thông báo rằng hồ sơ của bạn đã được chọn để tham gia phỏng vấn cho vị trí {{jobTitle}}.

Thông tin phỏng vấn:
- Thời gian: {{interviewDate}} lúc {{interviewTime}}
- Địa điểm: {{location}}
- Người phỏng vấn: {{interviewerName}}
- Loại phỏng vấn: {{interviewType}}
- Thời gian dự kiến: {{duration}} phút

Vui lòng xác nhận tham gia phỏng vấn bằng cách trả lời email này.

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "interviewDate", "interviewTime", "location", "interviewerName", "interviewType", "duration", "recruiterName"]',
 1, 1, GETDATE(), GETDATE()),

-- Template nhắc nhở phỏng vấn
(N'Nhắc nhở phỏng vấn', 'interview_reminder',
 N'[JobFinding] Nhắc nhở phỏng vấn - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhắc nhở phỏng vấn</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #ffc107; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Đây là lời nhắc nhở về buổi phỏng vấn của bạn cho vị trí <strong>{{jobTitle}}</strong>.</p>
        <div style="background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h3 style="color: #856404; margin-top: 0;">Thông tin phỏng vấn:</h3>
            <ul>
                <li>Thời gian: {{interviewDate}} lúc {{interviewTime}}</li>
                <li>Địa điểm: {{location}}</li>
                <li>Người phỏng vấn: {{interviewerName}}</li>
            </ul>
        </div>
        <p>Vui lòng chuẩn bị đầy đủ và đến đúng giờ.</p>
        <p>Chúc bạn may mắn!</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Đây là lời nhắc nhở về buổi phỏng vấn của bạn cho vị trí {{jobTitle}}.

Thông tin phỏng vấn:
- Thời gian: {{interviewDate}} lúc {{interviewTime}}
- Địa điểm: {{location}}
- Người phỏng vấn: {{interviewerName}}

Vui lòng chuẩn bị đầy đủ và đến đúng giờ.

Chúc bạn may mắn!

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "interviewDate", "interviewTime", "location", "interviewerName", "recruiterName"]',
 1, 1, GETDATE(), GETDATE()),

-- Template từ chối
(N'Thư từ chối', 'rejection',
 N'[JobFinding] Thông báo kết quả ứng tuyển - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông báo kết quả ứng tuyển</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #dc3545; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Cảm ơn bạn đã quan tâm và ứng tuyển vào vị trí <strong>{{jobTitle}}</strong> tại {{companyName}}.</p>
        <p>Sau khi xem xét kỹ lưỡng, chúng tôi rất tiếc phải thông báo rằng hồ sơ của bạn không phù hợp với yêu cầu của vị trí này vào thời điểm hiện tại.</p>
       
        <div style="background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h4 style="color: #856404; margin-top: 0;">Lý do cụ thể:</h4>
            <p style="margin-bottom: 0;">{{rejectionReason}}</p>
        </div>
   
        <p>Chúng tôi đánh giá cao sự quan tâm của bạn và khuyến khích bạn tiếp tục theo dõi các cơ hội việc làm khác tại công ty.</p>
        <p>Chúc bạn thành công trong việc tìm kiếm công việc!</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Cảm ơn bạn đã quan tâm và ứng tuyển vào vị trí {{jobTitle}} tại {{companyName}}.

Sau khi xem xét kỹ lưỡng, chúng tôi rất tiếc phải thông báo rằng hồ sơ của bạn không phù hợp với yêu cầu của vị trí này vào thời điểm hiện tại.

Lý do cụ thể: {{rejectionReason}}

Chúng tôi đánh giá cao sự quan tâm của bạn và khuyến khích bạn tiếp tục theo dõi các cơ hội việc làm khác tại công ty.

Chúc bạn thành công trong việc tìm kiếm công việc!

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "rejectionReason", "recruiterName"]',
 1, 1, GETDATE(), GETDATE()),

-- Template lời mời làm việc
(N'Lời mời làm việc', 'offer',
 N'[JobFinding] Lời mời làm việc - {{jobTitle}}',
 N'<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lời mời làm việc</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
        <h2 style="color: #28a745; margin-bottom: 10px;">Xin chào {{candidateName}},</h2>
        <p>Chúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí <strong>{{jobTitle}}</strong> tại {{companyName}}.</p>
        <div style="background-color: #d4edda; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h3 style="color: #155724; margin-top: 0;">Chi tiết lời mời:</h3>
            <ul>
                <li>Vị trí: {{jobTitle}}</li>
                <li>Mức lương: {{salaryOffer}}</li>
                <li>Ngày bắt đầu: {{startDate}}</li>
                <li>Thời gian làm việc: {{workingTime}}</li>
                <li>Địa điểm: {{workLocation}}</li>
            </ul>
        </div>
        <p>Vui lòng xác nhận việc nhận lời mời này trong vòng {{responseDeadline}} ngày.</p>
        <p>Chúng tôi rất mong được làm việc cùng bạn!</p>
        <p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p>
    </div>
</body>
</html>',
 N'Xin chào {{candidateName}},

Chúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí {{jobTitle}} tại {{companyName}}.

Chi tiết lời mời:
- Vị trí: {{jobTitle}}
- Mức lương: {{salaryOffer}}
- Ngày bắt đầu: {{startDate}}
- Thời gian làm việc: {{workingTime}}
- Địa điểm: {{workLocation}}

Vui lòng xác nhận việc nhận lời mời này trong vòng {{responseDeadline}} ngày.

Chúng tôi rất mong được làm việc cùng bạn!

Trân trọng,
{{recruiterName}}
{{companyName}}',
 N'["candidateName", "jobTitle", "companyName", "salaryOffer", "startDate", "workingTime", "workLocation", "responseDeadline", "recruiterName"]',
 1, 1, GETDATE(), GETDATE());

PRINT 'Đã thêm thành công 5 templates mẫu vào bảng Email_Templates!'; 