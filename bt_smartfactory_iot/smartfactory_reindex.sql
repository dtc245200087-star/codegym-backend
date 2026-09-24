-- =====================================================================
-- BƯỚC 1: TẠO CƠ SỞ DỮ LIỆU VÀ BẢNG SENSORLOGS (LEGACY)
-- =====================================================================
CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

DROP TABLE IF EXISTS SensorLogs;

CREATE TABLE SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20) -- 'NORMAL', 'WARNING', 'CRITICAL'
);

-- "FAT INDEX" GÂY THẢM HỌA DO KỸ SƯ CŨ TẠO
CREATE INDEX idx_fat_covering ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);


-- =====================================================================
-- BƯỚC 2: KIỂM TRA DUNG LƯỢNG VÀ THỰC THI EXPLAIN TRƯỚC KHI TỐI ƯU
-- =====================================================================
SHOW TABLE STATUS LIKE 'SensorLogs';

EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';


-- =====================================================================
-- BƯỚC 3: TIẾN HÀNH TỐI ƯU HÓA (XÓA INDEX PHÌNH TO, TẠO LEAN INDEX)
-- =====================================================================
-- Xóa bỏ "Fat Index" gây ngẽn luồng GHI (Write Bottleneck) và tốn đĩa
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;

-- Tạo "Lean Index" tinh gọn chỉ phục vụ lọc và sắp xếp (sensor_id, recorded_at)
CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);


-- =====================================================================
-- BƯỚC 4: VẬN HÀNH VÀ KIỂM TRA LẠI SAU KHI TỐI ƯU
-- =====================================================================
-- Kiểm tra lại dung lượng bảng và index
SHOW TABLE STATUS LIKE 'SensorLogs';

-- Chạy EXPLAIN để chứng minh hệ thống vẫn dùng Index nhưng đã nhẹ hơn rất nhiều
EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';