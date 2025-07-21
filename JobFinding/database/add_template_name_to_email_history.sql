-- Script để cập nhật bảng Email_History chỉ sử dụng template_name
-- Chạy script này để cập nhật cấu trúc database

-- Thêm cột template_name nếu chưa có
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Email_History' AND COLUMN_NAME = 'template_name')
BEGIN
    ALTER TABLE Email_History 
    ADD template_name NVARCHAR(255) NULL;
    
    PRINT 'Đã thêm cột template_name vào bảng Email_History';
END

-- Cập nhật comment cho cột template_name
IF NOT EXISTS (SELECT * FROM sys.extended_properties WHERE major_id = OBJECT_ID('Email_History') AND name = 'MS_Description' AND minor_id = (SELECT column_id FROM sys.columns WHERE object_id = OBJECT_ID('Email_History') AND name = 'template_name'))
BEGIN
    EXEC sp_addextendedproperty 
        @name = N'MS_Description', 
        @value = N'Tên template email được sử dụng', 
        @level0type = N'SCHEMA', @level0name = N'dbo', 
        @level1type = N'TABLE', @level1name = N'Email_History', 
        @level2type = N'COLUMN', @level2name = N'template_name';
END

-- Tạo index cho cột template_name để tối ưu hiệu suất tìm kiếm
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Email_History_Template_Name')
BEGIN
    CREATE INDEX IX_Email_History_Template_Name 
    ON Email_History (template_name);
    
    PRINT 'Đã tạo index cho cột template_name';
END

-- Xóa cột template_id nếu có (tùy chọn - chỉ chạy nếu muốn loại bỏ hoàn toàn)
-- ALTER TABLE Email_History DROP COLUMN template_id;

PRINT 'Cập nhật bảng Email_History thành công!';
PRINT 'Hệ thống giờ đây chỉ sử dụng template_name thay vì template_id'; 