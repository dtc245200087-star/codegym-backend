-- 1. Sử dụng CSDL classicmodels
USE classicmodels;

-- 2. Tạo View customer_views để lấy các cột customerNumber, customerName, phone
CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- Truy vấn dữ liệu từ bảng ảo (view) vừa tạo
SELECT * FROM customer_views;

-- 3. Cập nhật (Thay thế) View customer_views với các cột mới và điều kiện city = 'Nantes'
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Truy vấn dữ liệu từ view sau khi cập nhật
SELECT * FROM customer_views;

-- 4. Xóa View khi không còn sử dụng
DROP VIEW customer_views;