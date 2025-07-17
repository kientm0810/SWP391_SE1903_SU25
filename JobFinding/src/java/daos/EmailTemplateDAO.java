package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import models.EmailTemplate;

public class EmailTemplateDAO {

    public List<EmailTemplate> getTemplatesByType(String templateType) throws Exception {
        List<EmailTemplate> templates = new ArrayList<>();
        String sql = "SELECT id, template_name, template_type, subject, body_html, body_text, variables, is_active, created_by, created_at, updated_at " +
                     "FROM Email_Templates " +
                     "WHERE template_type = ? AND is_active = 1 " +
                     "ORDER BY template_name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, templateType);
            
            try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                    EmailTemplate template = new EmailTemplate();
                    template.setId(rs.getInt("id"));
                    template.setTemplateName(rs.getString("template_name"));
                    template.setTemplateType(rs.getString("template_type"));
                    template.setSubject(rs.getString("subject"));
                    template.setBodyHtml(rs.getString("body_html"));
                    template.setBodyText(rs.getString("body_text"));
                    template.setVariables(rs.getString("variables"));
                    template.setActive(rs.getBoolean("is_active"));
                    template.setCreatedBy(rs.getInt("created_by"));
                    template.setCreatedAt(rs.getTimestamp("created_at"));
                    template.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                templates.add(template);
            }
            }
        } catch (Exception e) {
            System.err.println("Error in getTemplatesByType for type: " + templateType);
            e.printStackTrace();
            throw e;
        }
        
        System.out.println("Found " + templates.size() + " templates for type: " + templateType);
        return templates;
    }

    public EmailTemplate getTemplateByName(String templateName) throws Exception {
        String sql = "SELECT id, template_name, template_type, subject, body_html, body_text, variables, is_active, created_by, created_at, updated_at " +
                     "FROM Email_Templates " +
                     "WHERE template_name = ? AND is_active = 1";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, templateName);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EmailTemplate template = new EmailTemplate();
                    template.setId(rs.getInt("id"));
                    template.setTemplateName(rs.getString("template_name"));
                    template.setTemplateType(rs.getString("template_type"));
                    template.setSubject(rs.getString("subject"));
                    template.setBodyHtml(rs.getString("body_html"));
                    template.setBodyText(rs.getString("body_text"));
                    template.setVariables(rs.getString("variables"));
                    template.setActive(rs.getBoolean("is_active"));
                    template.setCreatedBy(rs.getInt("created_by"));
                    template.setCreatedAt(rs.getTimestamp("created_at"));
                    template.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    return template;
                }
            }
        }
        
        return null;
    }

    public EmailTemplate getTemplateByType(String templateType) throws Exception {
        List<EmailTemplate> templates = getTemplatesByType(templateType);
        if (!templates.isEmpty()) {
            return templates.get(0); // Return the first template of this type
        }
        return null;
    }

    public List<EmailTemplate> getAllActiveTemplates() throws Exception {
        List<EmailTemplate> templates = new ArrayList<>();
        String sql = "SELECT id, template_name, template_type, subject, body_html, body_text, variables, is_active, created_by, created_at, updated_at " +
                     "FROM Email_Templates " +
                     "WHERE is_active = 1 " +
                     "ORDER BY template_type, template_name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                EmailTemplate template = new EmailTemplate();
                template.setId(rs.getInt("id"));
                template.setTemplateName(rs.getString("template_name"));
                template.setTemplateType(rs.getString("template_type"));
                template.setSubject(rs.getString("subject"));
                template.setBodyHtml(rs.getString("body_html"));
                template.setBodyText(rs.getString("body_text"));
                template.setVariables(rs.getString("variables"));
                template.setActive(rs.getBoolean("is_active"));
                template.setCreatedBy(rs.getInt("created_by"));
                template.setCreatedAt(rs.getTimestamp("created_at"));
                template.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                templates.add(template);
            }
        }
        
        return templates;
    }

    /**
     * Kiểm tra và tạo dữ liệu mẫu nếu bảng trống
     */
    public void checkAndCreateSampleData() throws Exception {
        List<EmailTemplate> existingTemplates = getAllActiveTemplates();
        
        if (existingTemplates.isEmpty()) {
            System.out.println("No templates found. Creating sample data...");
            createSampleTemplates();
        } else {
            System.out.println("Found " + existingTemplates.size() + " existing templates");
        }
    }

    /**
     * Tạo dữ liệu mẫu cho Email_Templates
     */
    private void createSampleTemplates() throws Exception {
        String sql = "INSERT INTO Email_Templates (template_name, template_type, subject, body_html, body_text, variables, is_active, created_by, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Template 1: Xác nhận nhận hồ sơ
            ps.setString(1, "Xác nhận nhận hồ sơ");
            ps.setString(2, "application_received");
            ps.setString(3, "[JobFinding] Xác nhận nhận được hồ sơ ứng tuyển - {{jobTitle}}");
            ps.setString(4, "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Xác nhận nhận hồ sơ</title></head><body style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;\"><div style=\"background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;\"><h2 style=\"color: #28a745; margin-bottom: 10px;\">Xin chào {{candidateName}},</h2><p>Chúng tôi đã nhận được hồ sơ ứng tuyển của bạn cho vị trí <strong>{{jobTitle}}</strong> tại <strong>{{companyName}}</strong>.</p><p>Thông tin ứng tuyển:</p><ul><li>Vị trí: {{jobTitle}}</li><li>Công ty: {{companyName}}</li><li>Ngày nộp: {{applicationDate}}</li></ul><p>Chúng tôi sẽ xem xét hồ sơ của bạn và liên hệ lại trong thời gian sớm nhất.</p><p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p></div></body></html>");
            ps.setString(5, "Xin chào {{candidateName}},\n\nChúng tôi đã nhận được hồ sơ ứng tuyển của bạn cho vị trí {{jobTitle}} tại {{companyName}}.\n\nThông tin ứng tuyển:\n- Vị trí: {{jobTitle}}\n- Công ty: {{companyName}}\n- Ngày nộp: {{applicationDate}}\n\nChúng tôi sẽ xem xét hồ sơ của bạn và liên hệ lại trong thời gian sớm nhất.\n\nTrân trọng,\n{{recruiterName}}\n{{companyName}}");
            ps.setString(6, "[\"candidateName\", \"jobTitle\", \"companyName\", \"applicationDate\", \"recruiterName\"]");
            ps.setBoolean(7, true);
            ps.setInt(8, 1);
            ps.executeUpdate();
            
            // Template 2: Lời mời phỏng vấn
            ps.setString(1, "Lời mời phỏng vấn");
            ps.setString(2, "interview_invitation");
            ps.setString(3, "[JobFinding] Lời mời phỏng vấn - {{jobTitle}}");
            ps.setString(4, "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Lời mời phỏng vấn</title></head><body style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;\"><div style=\"background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;\"><h2 style=\"color: #007bff; margin-bottom: 10px;\">Xin chào {{candidateName}},</h2><p>Chúng tôi rất vui mừng thông báo rằng hồ sơ của bạn đã được chọn để tham gia phỏng vấn cho vị trí <strong>{{jobTitle}}</strong>.</p><div style=\"background-color: #e7f3ff; padding: 15px; border-radius: 5px; margin: 20px 0;\"><h3 style=\"color: #0066cc; margin-top: 0;\">Thông tin phỏng vấn:</h3><ul><li>Thời gian: {{interviewDate}} lúc {{interviewTime}}</li><li>Địa điểm: {{location}}</li><li>Người phỏng vấn: {{interviewerName}}</li><li>Loại phỏng vấn: {{interviewType}}</li><li>Thời gian dự kiến: {{duration}} phút</li></ul></div><p>Vui lòng xác nhận tham gia phỏng vấn bằng cách trả lời email này.</p><p>Nếu có bất kỳ câu hỏi nào, xin vui lòng liên hệ với chúng tôi.</p><p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p></div></body></html>");
            ps.setString(5, "Xin chào {{candidateName}},\n\nChúng tôi rất vui mừng thông báo rằng hồ sơ của bạn đã được chọn để tham gia phỏng vấn cho vị trí {{jobTitle}}.\n\nThông tin phỏng vấn:\n- Thời gian: {{interviewDate}} lúc {{interviewTime}}\n- Địa điểm: {{location}}\n- Người phỏng vấn: {{interviewerName}}\n- Loại phỏng vấn: {{interviewType}}\n- Thời gian dự kiến: {{duration}} phút\n\nVui lòng xác nhận tham gia phỏng vấn bằng cách trả lời email này.\n\nTrân trọng,\n{{recruiterName}}\n{{companyName}}");
            ps.setString(6, "[\"candidateName\", \"jobTitle\", \"companyName\", \"interviewDate\", \"interviewTime\", \"location\", \"interviewerName\", \"interviewType\", \"duration\", \"recruiterName\"]");
            ps.setBoolean(7, true);
            ps.setInt(8, 1);
            ps.executeUpdate();
            
            // Template 3: Nhắc nhở phỏng vấn
            ps.setString(1, "Nhắc nhở phỏng vấn");
            ps.setString(2, "interview_reminder");
            ps.setString(3, "[JobFinding] Nhắc nhở phỏng vấn - {{jobTitle}}");
            ps.setString(4, "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Nhắc nhở phỏng vấn</title></head><body style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;\"><div style=\"background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;\"><h2 style=\"color: #ffc107; margin-bottom: 10px;\">Xin chào {{candidateName}},</h2><p>Đây là lời nhắc nhở về buổi phỏng vấn của bạn cho vị trí <strong>{{jobTitle}}</strong>.</p><div style=\"background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;\"><h3 style=\"color: #856404; margin-top: 0;\">Thông tin phỏng vấn:</h3><ul><li>Thời gian: {{interviewDate}} lúc {{interviewTime}}</li><li>Địa điểm: {{location}}</li><li>Người phỏng vấn: {{interviewerName}}</li></ul></div><p>Vui lòng chuẩn bị đầy đủ và đến đúng giờ.</p><p>Chúc bạn may mắn!</p><p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p></div></body></html>");
            ps.setString(5, "Xin chào {{candidateName}},\n\nĐây là lời nhắc nhở về buổi phỏng vấn của bạn cho vị trí {{jobTitle}}.\n\nThông tin phỏng vấn:\n- Thời gian: {{interviewDate}} lúc {{interviewTime}}\n- Địa điểm: {{location}}\n- Người phỏng vấn: {{interviewerName}}\n\nVui lòng chuẩn bị đầy đủ và đến đúng giờ.\n\nChúc bạn may mắn!\n\nTrân trọng,\n{{recruiterName}}\n{{companyName}}");
            ps.setString(6, "[\"candidateName\", \"jobTitle\", \"companyName\", \"interviewDate\", \"interviewTime\", \"location\", \"interviewerName\", \"recruiterName\"]");
            ps.setBoolean(7, true);
            ps.setInt(8, 1);
            ps.executeUpdate();
            
            // Template 4: Thư từ chối
            ps.setString(1, "Thư từ chối");
            ps.setString(2, "rejection");
            ps.setString(3, "[JobFinding] Thông báo kết quả ứng tuyển - {{jobTitle}}");
            ps.setString(4, "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Thông báo kết quả ứng tuyển</title></head><body style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;\"><div style=\"background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;\"><h2 style=\"color: #dc3545; margin-bottom: 10px;\">Xin chào {{candidateName}},</h2><p>Cảm ơn bạn đã quan tâm và ứng tuyển vào vị trí <strong>{{jobTitle}}</strong> tại {{companyName}}.</p><p>Sau khi xem xét kỹ lưỡng, chúng tôi rất tiếc phải thông báo rằng hồ sơ của bạn không phù hợp với yêu cầu của vị trí này vào thời điểm hiện tại.</p><div style=\"background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;\"><h4 style=\"color: #856404; margin-top: 0;\">Lý do cụ thể:</h4><p style=\"margin-bottom: 0;\">{{rejectionReason}}</p></div><p>Chúng tôi đánh giá cao sự quan tâm của bạn và khuyến khích bạn tiếp tục theo dõi các cơ hội việc làm khác tại công ty.</p><p>Chúc bạn thành công trong việc tìm kiếm công việc!</p><p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p></div></body></html>");
            ps.setString(5, "Xin chào {{candidateName}},\n\nCảm ơn bạn đã quan tâm và ứng tuyển vào vị trí {{jobTitle}} tại {{companyName}}.\n\nSau khi xem xét kỹ lưỡng, chúng tôi rất tiếc phải thông báo rằng hồ sơ của bạn không phù hợp với yêu cầu của vị trí này vào thời điểm hiện tại.\n\nLý do cụ thể: {{rejectionReason}}\n\nChúng tôi đánh giá cao sự quan tâm của bạn và khuyến khích bạn tiếp tục theo dõi các cơ hội việc làm khác tại công ty.\n\nChúc bạn thành công trong việc tìm kiếm công việc!\n\nTrân trọng,\n{{recruiterName}}\n{{companyName}}");
            ps.setString(6, "[\"candidateName\", \"jobTitle\", \"companyName\", \"rejectionReason\", \"recruiterName\"]");
            ps.setBoolean(7, true);
            ps.setInt(8, 1);
            ps.executeUpdate();
            
            // Template 5: Lời mời làm việc
            ps.setString(1, "Lời mời làm việc");
            ps.setString(2, "offer");
            ps.setString(3, "[JobFinding] Lời mời làm việc - {{jobTitle}}");
            ps.setString(4, "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Lời mời làm việc</title></head><body style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;\"><div style=\"background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;\"><h2 style=\"color: #28a745; margin-bottom: 10px;\">Xin chào {{candidateName}},</h2><p>Chúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí <strong>{{jobTitle}}</strong> tại {{companyName}}.</p><div style=\"background-color: #d4edda; padding: 15px; border-radius: 5px; margin: 20px 0;\"><h3 style=\"color: #155724; margin-top: 0;\">Chi tiết lời mời:</h3><ul><li>Vị trí: {{jobTitle}}</li><li>Mức lương: {{salaryOffer}}</li><li>Ngày bắt đầu: {{startDate}}</li><li>Thời gian làm việc: {{workingTime}}</li><li>Địa điểm: {{workLocation}}</li></ul></div><p>Vui lòng xác nhận việc nhận lời mời này trong vòng {{responseDeadline}} ngày.</p><p>Chúng tôi rất mong được làm việc cùng bạn!</p><p>Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p></div></body></html>");
            ps.setString(5, "Xin chào {{candidateName}},\n\nChúng tôi rất vui mừng thông báo rằng bạn đã được chọn cho vị trí {{jobTitle}} tại {{companyName}}.\n\nChi tiết lời mời:\n- Vị trí: {{jobTitle}}\n- Mức lương: {{salaryOffer}}\n- Ngày bắt đầu: {{startDate}}\n- Thời gian làm việc: {{workingTime}}\n- Địa điểm: {{workLocation}}\n\nVui lòng xác nhận việc nhận lời mời này trong vòng {{responseDeadline}} ngày.\n\nChúng tôi rất mong được làm việc cùng bạn!\n\nTrân trọng,\n{{recruiterName}}\n{{companyName}}");
            ps.setString(6, "[\"candidateName\", \"jobTitle\", \"companyName\", \"salaryOffer\", \"startDate\", \"workingTime\", \"workLocation\", \"responseDeadline\", \"recruiterName\"]");
            ps.setBoolean(7, true);
            ps.setInt(8, 1);
            ps.executeUpdate();
            
            // Template 6: Email tùy chỉnh
            ps.setString(1, "Email tùy chỉnh");
            ps.setString(2, "custom");
            ps.setString(3, "{{subject}}");
            ps.setString(4, "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Email tùy chỉnh</title></head><body style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;\"><div style=\"background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;\"><h2 style=\"color: #6c757d; margin-bottom: 10px;\">Xin chào {{candidateName}},</h2>{{emailContent}}<p style=\"margin-top: 20px;\">Trân trọng,<br>{{recruiterName}}<br>{{companyName}}</p></div></body></html>");
            ps.setString(5, "Xin chào {{candidateName}},\n\n{{emailContent}}\n\nTrân trọng,\n{{recruiterName}}\n{{companyName}}");
            ps.setString(6, "[\"candidateName\", \"jobTitle\", \"companyName\", \"subject\", \"emailContent\", \"recruiterName\"]");
            ps.setBoolean(7, true);
            ps.setInt(8, 1);
            ps.executeUpdate();
            
            System.out.println("Sample templates created successfully!");
        }
    }
} 