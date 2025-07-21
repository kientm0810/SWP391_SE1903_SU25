-- Script tạo bảng Email_Templates
-- Chạy script này nếu bảng chưa tồn tại

-- Kiểm tra và tạo bảng Email_Templates
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Email_Templates')
BEGIN
    CREATE TABLE Email_Templates (
        id INT PRIMARY KEY IDENTITY(1,1),
        template_name NVARCHAR(255) NOT NULL UNIQUE,
        template_type VARCHAR(50) NOT NULL,
        subject NVARCHAR(500) NOT NULL,
        body_html NTEXT NOT NULL,
        body_text NTEXT,
        variables NVARCHAR(1000),
        is_active BIT DEFAULT 1,
        created_by INT,
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT GETDATE()
    );
    
    PRINT 'Đã tạo bảng Email_Templates thành công!';
END
ELSE
BEGIN
    PRINT 'Bảng Email_Templates đã tồn tại.';
END

-- Thêm comment cho bảng
IF NOT EXISTS (SELECT * FROM sys.extended_properties WHERE major_id = OBJECT_ID('Email_Templates') AND name = 'MS_Description')
BEGIN
    EXEC sp_addextendedproperty 
        @name = N'MS_Description', 
        @value = N'Bảng lưu trữ các template email', 
        @level0type = N'SCHEMA', @level0name = N'dbo', 
        @level1type = N'TABLE', @level1name = N'Email_Templates';
END

-- Tạo index cho template_type để tối ưu hiệu suất tìm kiếm
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Email_Templates_Type')
BEGIN
    CREATE INDEX IX_Email_Templates_Type 
    ON Email_Templates (template_type, is_active);
    
    PRINT 'Đã tạo index cho template_type';
END

-- Tạo index cho template_name
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Email_Templates_Name')
BEGIN
    CREATE INDEX IX_Email_Templates_Name 
    ON Email_Templates (template_name);
    
    PRINT 'Đã tạo index cho template_name';
END

PRINT 'Hoàn thành tạo bảng Email_Templates!'; 