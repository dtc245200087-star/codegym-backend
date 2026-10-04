-- 1. Sử dụng CSDL classicmodels
USE classicmodels;

-- 2. Tạo Stored Procedure findAllCustomers lấy tất cả thông tin khách hàng
DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END //

DELIMITER ;

-- Gọi thử Stored Procedure vừa tạo
CALL findAllCustomers();

-- 3. Xóa và cập nhật lại Stored Procedure với điều kiện mới (lấy khách hàng có customerNumber = 175)
DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers WHERE customerNumber = 175;
END //

DELIMITER ;

-- Gọi lại Stored Procedure sau khi đã cập nhật
CALL findAllCustomers();