-- =====================================================================
-- BƯỚC 1: TẠO LẠI CƠ SỞ DỮ LIỆU VÀ BẢNG QUICKFEED (LEGACY)
-- =====================================================================
CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

DROP TABLE IF EXISTS Posts;

CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    post_type VARCHAR(10), 
    is_visible BOOLEAN DEFAULT 1, 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Môi trường ban đầu bị lạm dụng Index (Over-indexing)
CREATE INDEX idx_user_id ON Posts(user_id);
CREATE INDEX idx_content ON Posts(content(255)); 
CREATE INDEX idx_post_type ON Posts(post_type); 
CREATE INDEX idx_is_visible ON Posts(is_visible); 
CREATE INDEX idx_created_at ON Posts(created_at);

-- =====================================================================
-- BƯỚC 2: KIỂM TRA DUNG LƯỢNG TRƯỚC KHI TỐI ƯU (DÙNG INFORMATION_SCHEMA)
-- =====================================================================
SELECT 
    table_name AS `Table`,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS `Total Size (MB)`,
    ROUND((data_length / 1024 / 1024), 2) AS `Data Size (MB)`,
    ROUND((index_length / 1024 / 1024), 2) AS `Index Size (MB)`
FROM information_schema.TABLES
WHERE table_schema = 'quickfeed_db' 
  AND table_name = 'Posts';


-- =====================================================================
-- BƯỚC 3: TIẾN HÀNH "PHẪU THUẬT" - XÓA CÁC INDEX VÔ DỤNG (LOW CARDINALITY)
-- =====================================================================
-- Giữ lại idx_user_id và idx_created_at vì tính phân biệt cao và phục vụ sort newsfeed.
-- Loại bỏ 3 Index gây nghẽn tiến trình GHI (INSERT) và phình to ổ cứng:
ALTER TABLE Posts DROP INDEX idx_content;
ALTER TABLE Posts DROP INDEX idx_post_type;
ALTER TABLE Posts DROP INDEX idx_is_visible;


-- =====================================================================
-- BƯỚC 4: KIỂM TRA LẠI DUNG LƯỢNG SAU KHI TỐI ƯU
-- =====================================================================
SELECT 
    table_name AS `Table`,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS `Total Size (MB)`,
    ROUND((data_length / 1024 / 1024), 2) AS `Data Size (MB)`,
    ROUND((index_length / 1024 / 1024), 2) AS `Index Size (MB)`
FROM information_schema.TABLES
WHERE table_schema = 'quickfeed_db' 
  AND table_name = 'Posts';