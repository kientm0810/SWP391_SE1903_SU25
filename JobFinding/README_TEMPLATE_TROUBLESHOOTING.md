# Hướng dẫn Troubleshooting Email Templates

## Lỗi "Lỗi khi tải templates. Vui lòng thử lại."

### 1. Kiểm tra Database

#### Bước 1: Kiểm tra bảng Email_Templates
```sql
-- Kiểm tra bảng có tồn tại không
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Email_Templates';

-- Kiểm tra dữ liệu trong bảng
SELECT * FROM Email_Templates;

-- Kiểm tra templates theo type
SELECT * FROM Email_Templates WHERE template_type = 'application_received' AND is_active = 1;
```

#### Bước 2: Kiểm tra cấu trúc bảng
```sql
-- Kiểm tra cấu trúc bảng
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Email_Templates'
ORDER BY ORDINAL_POSITION;
```

### 2. Kiểm tra API Endpoint

#### Bước 1: Test trực tiếp API
Truy cập URL: `http://localhost:8080/JobFinding/load-email-templates?emailType=application_received`

Kết quả mong đợi:
```json
[
  {
    "templateId": 1,
    "templateName": "Xác nhận nhận hồ sơ",
    "templateType": "application_received",
    "subject": "[JobFinding] Xác nhận nhận được hồ sơ ứng tuyển - {{jobTitle}}",
    "bodyHtml": "<!DOCTYPE html>...",
    "bodyText": "Xin chào {{candidateName}}...",
    "variables": "[\"candidateName\", \"jobTitle\", \"companyName\", \"applicationDate\", \"recruiterName\"]",
    "isActive": true,
    "createdBy": 1
  }
]
```

#### Bước 2: Test với controller debug
Truy cập URL: `http://localhost:8080/JobFinding/test-email-templates`

### 3. Kiểm tra Console Browser

#### Bước 1: Mở Developer Tools
- Nhấn F12 hoặc Ctrl+Shift+I
- Chuyển sang tab Console

#### Bước 2: Test API connection
Trong console, chạy:
```javascript
// Test API connection
fetch('load-email-templates?emailType=application_received')
    .then(response => {
        console.log('Status:', response.status);
        return response.text();
    })
    .then(text => {
        console.log('Response:', text);
    })
    .catch(error => {
        console.error('Error:', error);
    });
```

### 4. Các lỗi thường gặp

#### Lỗi 1: "Table 'Email_Templates' doesn't exist"
**Nguyên nhân**: Bảng chưa được tạo
**Giải pháp**: Chạy script tạo bảng Email_Templates

#### Lỗi 2: "No templates found"
**Nguyên nhân**: Không có dữ liệu hoặc `is_active = 0`
**Giải pháp**: 
```sql
-- Kiểm tra dữ liệu
SELECT * FROM Email_Templates WHERE is_active = 1;

-- Nếu không có dữ liệu, thêm dữ liệu mẫu
INSERT INTO Email_Templates (template_name, template_type, subject, body_html, body_text, variables, is_active, created_by) 
VALUES ('Xác nhận nhận hồ sơ', 'application_received', 'Test Subject', 'Test Body', 'Test Text', '[]', 1, 1);
```

#### Lỗi 3: "HTTP 404: Not Found"
**Nguyên nhân**: Controller không được map đúng
**Giải pháp**: 
- Kiểm tra annotation `@WebServlet` trong `EmailTemplateController`
- Restart server
- Kiểm tra web.xml

#### Lỗi 4: "HTTP 500: Internal Server Error"
**Nguyên nhân**: Lỗi trong controller hoặc DAO
**Giải pháp**:
- Kiểm tra log server
- Kiểm tra kết nối database
- Kiểm tra SQL query

### 5. Debug Steps

#### Step 1: Kiểm tra Database Connection
```java
// Thêm vào EmailTemplateController để debug
try {
    EmailTemplateDAO templateDAO = new EmailTemplateDAO();
    List<EmailTemplate> templates = templateDAO.getTemplatesByType(emailType);
    System.out.println("Found " + templates.size() + " templates for type: " + emailType);
} catch (Exception e) {
    e.printStackTrace();
    // Log chi tiết lỗi
}
```

#### Step 2: Kiểm tra JSON Response
```java
// Thêm vào EmailTemplateController
String jsonResponse = convertTemplatesToJson(templates);
System.out.println("JSON Response: " + jsonResponse);
```

#### Step 3: Kiểm tra Frontend
```javascript
// Thêm vào send-email.jsp
function debugLoadTemplates(emailType) {
    console.log('Loading templates for type:', emailType);
    fetch('load-email-templates?emailType=' + encodeURIComponent(emailType))
        .then(response => {
            console.log('Response status:', response.status);
            console.log('Response headers:', response.headers);
            return response.text();
        })
        .then(text => {
            console.log('Raw response:', text);
            return JSON.parse(text);
        })
        .then(json => {
            console.log('Parsed JSON:', json);
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
```

### 6. Các Email Types được hỗ trợ

- `application_received` - Xác nhận nhận hồ sơ
- `interview_invitation` - Lời mời phỏng vấn
- `interview_reminder` - Nhắc nhở phỏng vấn
- `rejection` - Thư từ chối
- `offer` - Lời mời làm việc

### 7. Kiểm tra nhanh

1. **Database**: `SELECT COUNT(*) FROM Email_Templates WHERE is_active = 1;`
2. **API**: Truy cập `/test-email-templates`
3. **Frontend**: Mở console và test API
4. **Server Log**: Kiểm tra log lỗi trong server

### 8. Liên hệ hỗ trợ

Nếu vẫn gặp vấn đề, vui lòng cung cấp:
- Screenshot lỗi từ console browser
- Log lỗi từ server
- Kết quả từ `/test-email-templates`
- Thông tin database (số lượng records, cấu trúc bảng) 