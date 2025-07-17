-- Email Templates cho chức năng email tự động
-- Chạy script này để thêm các template cần thiết

-- Template cho xác nhận nhận hồ sơ
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('application_confirmation', 
 'Xác nhận nhận hồ sơ ứng tuyển - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #2c3e50;">Xác nhận nhận hồ sơ ứng tuyển</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Chúng tôi đã nhận được hồ sơ ứng tuyển của bạn cho vị trí <strong>{{job_title}}</strong> tại <strong>{{company_name}}</strong>.</p>
    <p><strong>Thông tin ứng tuyển:</strong></p>
    <ul>
        <li>Vị trí: {{job_title}}</li>
        <li>Công ty: {{company_name}}</li>
        <li>Ngày ứng tuyển: {{application_date}}</li>
        <li>Mã ứng tuyển: {{application_id}}</li>
    </ul>
    <p>Hồ sơ của bạn sẽ được xem xét trong thời gian sớm nhất. Chúng tôi sẽ liên hệ với bạn qua email hoặc điện thoại để thông báo kết quả.</p>
    <p>Cảm ơn bạn đã quan tâm đến cơ hội việc làm tại {{company_name}}!</p>
    <p>Trân trọng,<br>Đội ngũ tuyển dụng {{company_name}}</p>
</div>', 
 GETDATE());

-- Template cho từ chối ứng tuyển
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('application_rejection', 
 'Thông báo kết quả ứng tuyển - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #e74c3c;">Thông báo kết quả ứng tuyển</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Cảm ơn bạn đã quan tâm đến vị trí <strong>{{job_title}}</strong> tại <strong>{{company_name}}</strong>.</p>
    <p>Sau khi xem xét kỹ lưỡng hồ sơ của bạn, chúng tôi rất tiếc phải thông báo rằng chúng tôi không thể tiến hành với đơn ứng tuyển của bạn cho vị trí này.</p>
    <p><strong>Lý do:</strong> {{rejection_reason}}</p>
    <p>Chúng tôi đánh giá cao sự quan tâm của bạn và mong rằng bạn sẽ tiếp tục theo dõi các cơ hội việc làm khác tại {{company_name}} trong tương lai.</p>
    <p>Chúc bạn thành công trong sự nghiệp!</p>
    <p>Trân trọng,<br>Đội ngũ tuyển dụng {{company_name}}</p>
</div>', 
 GETDATE());

-- Template cho chấp nhận ứng tuyển
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('application_acceptance', 
 'Chúc mừng! Bạn đã được chọn - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #27ae60;">Chúc mừng! Bạn đã được chọn</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Chúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí <strong>{{job_title}}</strong> tại <strong>{{company_name}}</strong>!</p>
    <p><strong>Chi tiết đề nghị:</strong></p>
    <p>{{offer_details}}</p>
    <p>Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để thảo luận chi tiết về hợp đồng lao động và các bước tiếp theo.</p>
    <p>Chúc mừng bạn và chào mừng bạn đến với đội ngũ {{company_name}}!</p>
    <p>Trân trọng,<br>Đội ngũ tuyển dụng {{company_name}}</p>
</div>', 
 GETDATE());

-- Template cho mời phỏng vấn
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('interview_invitation', 
 'Mời phỏng vấn - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #3498db;">Mời phỏng vấn</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Chúng tôi rất vui mừng mời bạn tham gia buổi phỏng vấn cho vị trí <strong>{{job_title}}</strong> tại <strong>{{company_name}}</strong>.</p>
    <p><strong>Thông tin phỏng vấn:</strong></p>
    <ul>
        <li>Ngày: {{interview_date}}</li>
        <li>Thời gian: {{interview_time}}</li>
        <li>Địa điểm: {{interview_location}}</li>
        <li>Thời lượng: {{duration_minutes}} phút</li>
    </ul>
    <p><strong>Ghi chú:</strong> {{notes}}</p>
    <p>Vui lòng xác nhận tham gia bằng cách trả lời email này hoặc liên hệ với chúng tôi qua số điện thoại đã cung cấp.</p>
    <p>Chúng tôi mong đợi được gặp bạn!</p>
    <p>Trân trọng,<br>Đội ngũ tuyển dụng {{company_name}}</p>
</div>', 
 GETDATE());

-- Template cho nhắc nhở phỏng vấn
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('interview_reminder', 
 'Nhắc nhở: Buổi phỏng vấn ngày mai - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #f39c12;">Nhắc nhở phỏng vấn</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Đây là email nhắc nhở về buổi phỏng vấn cho vị trí <strong>{{job_title}}</strong> tại <strong>{{company_name}}</strong> vào ngày mai.</p>
    <p><strong>Thông tin phỏng vấn:</strong></p>
    <ul>
        <li>Ngày: {{interview_date}}</li>
        <li>Thời gian: {{interview_time}}</li>
        <li>Địa điểm: {{interview_location}}</li>
        <li>Thời lượng: {{duration_minutes}} phút</li>
    </ul>
    <p>Vui lòng đến sớm 10-15 phút trước giờ hẹn và mang theo các giấy tờ cần thiết.</p>
    <p>Chúc bạn may mắn!</p>
    <p>Trân trọng,<br>Đội ngũ tuyển dụng {{company_name}}</p>
</div>', 
 GETDATE());

-- Template cho thông báo đã xem hồ sơ
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('application_reviewed', 
 'Hồ sơ của bạn đã được xem xét - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #2c3e50;">Hồ sơ đã được xem xét</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Chúng tôi muốn thông báo rằng hồ sơ ứng tuyển của bạn cho vị trí <strong>{{job_title}}</strong> tại <strong>{{company_name}}</strong> đã được xem xét.</p>
    <p>Đội ngũ tuyển dụng của chúng tôi đang đánh giá hồ sơ của bạn và sẽ sớm đưa ra quyết định. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.</p>
    <p>Cảm ơn bạn đã kiên nhẫn chờ đợi!</p>
    <p>Trân trọng,<br>Đội ngũ tuyển dụng {{company_name}}</p>
</div>', 
 GETDATE());

-- Template cho thông báo hoàn thành phỏng vấn
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('interview_completed', 
 'Cảm ơn bạn đã tham gia phỏng vấn - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #2c3e50;">Cảm ơn bạn đã tham gia phỏng vấn</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Cảm ơn bạn đã dành thời gian tham gia buổi phỏng vấn cho vị trí <strong>{{job_title}}</strong> tại <strong>{{company_name}}</strong>.</p>
    <p>Chúng tôi đánh giá cao sự chuẩn bị và sự quan tâm của bạn. Đội ngũ tuyển dụng sẽ xem xét kỹ lưỡng thông tin từ buổi phỏng vấn và sẽ thông báo kết quả cho bạn trong thời gian sớm nhất.</p>
    <p>Nếu bạn có bất kỳ câu hỏi nào, đừng ngần ngại liên hệ với chúng tôi.</p>
    <p>Trân trọng,<br>Đội ngũ tuyển dụng {{company_name}}</p>
</div>', 
 GETDATE());

-- Template cho thông báo việc làm phù hợp
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('job_alert', 
 'Việc làm phù hợp với bạn - {{alert_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #27ae60;">Việc làm phù hợp với bạn</h2>
    <p>Xin chào <strong>{{candidate_name}}</strong>,</p>
    <p>Dựa trên thông tin tìm kiếm việc làm của bạn ({{alert_name}}), chúng tôi đã tìm thấy <strong>{{job_count}}</strong> vị trí phù hợp:</p>
    
    <div style="margin: 20px 0;">
        {{job_list}}
    </div>
    
    <p>Hãy truy cập website của chúng tôi để xem chi tiết và ứng tuyển ngay!</p>
    <p>Chúc bạn tìm được công việc phù hợp!</p>
    <p>Trân trọng,<br>Đội ngũ JobFinding</p>
</div>', 
 GETDATE());

-- Template cho xác minh tài khoản recruiter
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('verification_verified', 
 'Tài khoản đã được xác minh - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #27ae60;">Tài khoản đã được xác minh</h2>
    <p>Xin chào <strong>{{recruiter_name}}</strong>,</p>
    <p>Chúc mừng! Tài khoản recruiter của bạn tại <strong>{{company_name}}</strong> đã được xác minh thành công.</p>
    <p>Bây giờ bạn có thể:</p>
    <ul>
        <li>Đăng tin tuyển dụng</li>
        <li>Xem và quản lý hồ sơ ứng tuyển</li>
        <li>Sử dụng tất cả tính năng dành cho recruiter</li>
    </ul>
    <p>Cảm ơn bạn đã chọn JobFinding!</p>
    <p>Trân trọng,<br>Đội ngũ JobFinding</p>
</div>', 
 GETDATE());

-- Template cho từ chối xác minh tài khoản recruiter
INSERT INTO Email_Templates (template_type, subject, body_html, created_at) VALUES 
('verification_rejected', 
 'Thông báo về tài khoản recruiter - {{company_name}}', 
 '<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
    <h2 style="color: #e74c3c;">Thông báo về tài khoản</h2>
    <p>Xin chào <strong>{{recruiter_name}}</strong>,</p>
    <p>Chúng tôi rất tiếc phải thông báo rằng đơn đăng ký tài khoản recruiter của bạn tại <strong>{{company_name}}</strong> chưa được chấp thuận.</p>
    <p>Lý do có thể bao gồm:</p>
    <ul>
        <li>Thông tin công ty không đầy đủ hoặc không chính xác</li>
        <li>Thiếu giấy phép kinh doanh hoặc tài liệu cần thiết</li>
        <li>Thông tin liên hệ không hợp lệ</li>
    </ul>
    <p>Vui lòng liên hệ với chúng tôi để được hỗ trợ thêm thông tin.</p>
    <p>Trân trọng,<br>Đội ngũ JobFinding</p>
</div>', 
 GETDATE()); 