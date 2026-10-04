-- ===================================================
-- AUTORIDE DATABASE OPTIMIZATION SCRIPT
-- ===================================================

CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- 1. Bảng Cars
CREATE TABLE IF NOT EXISTS Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

-- 2. Bảng Rentals
CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') DEFAULT 'BOOKED',
    security_deposit DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    late_fee DECIMAL(12, 2) DEFAULT 0.00,
    damage_fee DECIMAL(12, 2) DEFAULT 0.00,
    FOREIGN KEY (car_id) REFERENCES Cars(car_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. Bảng Inspections
CREATE TABLE IF NOT EXISTS Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ===================================================
-- MÔ PHỎNG KỊCH BẢN NGHIỆP VỤ (DML)
-- ===================================================

-- Thêm xe thử nghiệm
INSERT INTO Cars (model_name, license_plate) 
VALUES ('Toyota Camry', '30A-123.45');

-- Khách hàng "Nguyen Van A" thuê xe, cọc 10,000,000 VNĐ, trạng thái ACTIVE
INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit)
VALUES (1, 'Nguyen Van A', NOW(), 'ACTIVE', 10000000.00);

-- Khách trả xe, nhân viên kiểm tra ghi nhận vỡ đèn pha
INSERT INTO Inspections (rental_id, damage_description, inspector_name)
VALUES (1, 'Vỡ đèn pha trái', 'Nhan Vien B');

-- Cập nhật đơn thuê: Trạng thái COMPLETED, damage_fee = 2,000,000 VNĐ, late_fee = 0
UPDATE Rentals
SET return_date = NOW(),
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = 1;

-- Truy vấn tính số tiền thực tế hoàn trả cho khách hàng
SELECT 
    rental_id,
    customer_name,
    security_deposit,
    late_fee,
    damage_fee,
    (security_deposit - late_fee - damage_fee) AS actual_refund_amount
FROM Rentals
WHERE rental_id = 1;