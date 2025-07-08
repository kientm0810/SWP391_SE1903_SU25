-- =====================================================
-- TẠO BẢNG SAVED_JOBS CHO CHỨC NĂNG LƯU TIN
-- =====================================================

-- Bảng lưu tin tuyển dụng của người dùng
CREATE TABLE Saved_Jobs (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Đảm bảo mỗi user chỉ lưu mỗi post một lần
    CONSTRAINT unique_user_post UNIQUE (user_id, post_id)
);

-- =====================================================
-- TẠO INDEXES CHO HIỆU SUẤT
-- =====================================================

-- Index cho user_id để tìm nhanh tin đã lưu của user
CREATE INDEX idx_saved_jobs_user ON Saved_Jobs(user_id);

-- Index cho post_id để tìm nhanh user đã lưu tin
CREATE INDEX idx_saved_jobs_post ON Saved_Jobs(post_id);

-- Index cho saved_at để sắp xếp theo thời gian lưu
CREATE INDEX idx_saved_jobs_saved_at ON Saved_Jobs(saved_at);

-- =====================================================
-- DỮ LIỆU MẪU ĐỂ TEST (TÙY CHỌN)
-- =====================================================

-- Insert sample saved jobs (thay đổi user_id và post_id theo dữ liệu thực tế)
-- INSERT INTO Saved_Jobs (user_id, post_id) VALUES
-- (1, 1),
-- (1, 3),
-- (2, 1),
-- (2, 5),
-- (3, 2),
-- (3, 4); 