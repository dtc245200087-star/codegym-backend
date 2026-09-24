-- HỆ THỐNG PAYFLOW (TỐI ƯU HÓA BÁO CÁO TỬ THẦN)
CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

-- 1. Tạo bảng Transactions
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20), -- 'DEPOSIT', 'WITHDRAW', 'TRANSFER'
    created_at DATETIME
);

-- ========================================================
-- CÂU LỆNH CŨ (LEGACY SQL - NON-SARGable - FULL TABLE SCAN)
-- ========================================================
-- EXPLAIN 
-- SELECT SUM(amount) AS total_deposit
-- FROM Transactions
-- WHERE transaction_type = 'DEPOSIT' 
--   AND YEAR(created_at) = 2026 
--   AND MONTH(created_at) = 6;

-- ========================================================
-- GIẢI PHÁP TỐI ƯU HÓA
-- ========================================================

-- Bước 1: Tạo Composite Index cho cột (transaction_type, created_at)
-- Đặt transaction_type đằng trước vì là điều kiện bằng (=), created_at phía sau vì là điều kiện khoảng (Range)
CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);

-- Bước 2: Tái cấu trúc truy vấn dạng SARGable (Sử dụng Range cho created_at)
EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT' 
  AND created_at >= '2026-06-01 00:00:00' 
  AND created_at < '2026-07-01 00:00:00';