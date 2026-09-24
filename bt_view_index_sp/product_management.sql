-- =====================================================================
-- BƯỚC 1 & 2: TẠO CƠ SỞ DỮ LIỆU, BẢNG PRODUCTS VÀ CHÈN DỮ LIỆU MẪU
-- =====================================================================
CREATE DATABASE IF NOT EXISTS demo;
USE demo;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription TEXT,
    productStatus VARCHAR(50)
);

-- Chèn dữ liệu mẫu
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus) VALUES
('P001', 'Laptop Dell Inspiron', 1500.00, 10, 'Core i5, RAM 8GB, SSD 256GB', 'Active'),
('P002', 'iPhone 13 Pro', 900.00, 25, 'Apple A15 Bionic, 128GB', 'Active'),
('P003', 'Samsung Galaxy S21', 800.00, 15, 'Exynos 2100, 128GB', 'Active'),
('P004', 'AirPods Pro', 200.00, 50, 'Active Noise Cancellation', 'Out of Stock');


-- =====================================================================
-- BƯỚC 3: TẠO INDEX VÀ SỬ DỤNG LỆNH EXPLAIN
-- =====================================================================
-- Tạo Unique Index trên cột productCode
CREATE UNIQUE INDEX idx_productCode ON Products(productCode);

-- Tạo Composite Index trên 2 cột productName và productPrice
CREATE INDEX idx_name_price ON Products(productName, productPrice);

-- Sử dụng EXPLAIN để kiểm tra hiệu năng truy vấn trước/sau khi có Index
EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';
EXPLAIN SELECT * FROM Products WHERE productName = 'iPhone 13 Pro' AND productPrice = 900.00;


-- =====================================================================
-- BƯỚC 4: TẠO, SỬA ĐỔI VÀ XOÁ VIEW
-- =====================================================================
-- Tạo View lấy thông tin productCode, productName, productPrice, productStatus
CREATE VIEW view_products AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Truy vấn thử View
SELECT * FROM view_products;

-- Tiến hành sửa đổi View (Cập nhật thêm điều kiện hoặc cột)
CREATE OR REPLACE VIEW view_products AS
SELECT productCode, productName, productPrice, productStatus, productAmount
FROM Products
WHERE productStatus = 'Active';

-- Tiến hành xoá View
DROP VIEW view_products;


-- =====================================================================
-- BƯỚC 5: TẠO CÁC STORE PROCEDURES
-- =====================================================================

-- 1. Store procedure lấy tất cả thông tin của tất cả sản phẩm
DELIMITER //
DROP PROCEDURE IF EXISTS GetAllProducts //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;

-- Gọi thử thủ tục
CALL GetAllProducts();


-- 2. Store procedure thêm một sản phẩm mới
DELIMITER //
DROP PROCEDURE IF EXISTS InsertProduct //
CREATE PROCEDURE InsertProduct(
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_description TEXT,
    IN p_status VARCHAR(50)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_description, p_status);
END //
DELIMITER ;

-- Gọi thử thủ tục thêm sản phẩm
CALL InsertProduct('P005', 'MacBook Air M2', 1200.00, 8, 'Apple Silicon M2', 'Active');


-- 3. Store procedure sửa thông tin sản phẩm theo id
DELIMITER //
DROP PROCEDURE IF EXISTS UpdateProductById //
CREATE PROCEDURE UpdateProductById(
    IN p_id INT,
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_description TEXT,
    IN p_status VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET productCode = p_code,
        productName = p_name,
        productPrice = p_price,
        productAmount = p_amount,
        productDescription = p_description,
        productStatus = p_status
    WHERE Id = p_id;
END //
DELIMITER ;

-- Gọi thử thủ tục sửa sản phẩm có ID = 1
CALL UpdateProductById(1, 'P001', 'Laptop Dell Inspiron 15', 1550.00, 12, 'Core i5, RAM 16GB', 'Active');


-- 4. Store procedure xoá sản phẩm theo id
DELIMITER //
DROP PROCEDURE IF EXISTS DeleteProductById //
CREATE PROCEDURE DeleteProductById(
    IN p_id INT
)
BEGIN
    DELETE FROM Products WHERE Id = p_id;
END //
DELIMITER ;

-- Gọi thử thủ tục xoá sản phẩm có ID = 4
CALL DeleteProductById(4);