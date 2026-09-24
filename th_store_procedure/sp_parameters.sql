-- 1. Sử dụng CSDL classicmodels
USE classicmodels;

-- ===================================================
-- 2. THAM SỐ LOẠI IN
-- ===================================================
DELIMITER //

DROP PROCEDURE IF EXISTS `getCusById`//

CREATE PROCEDURE getCusById(
    IN cusNum INT
)
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi Stored Procedure loại IN
CALL getCusById(175);


-- ===================================================
-- 3. THAM SỐ LOẠI OUT
-- ===================================================
DELIMITER //

DROP PROCEDURE IF EXISTS `GetCustomersCountByCity`//

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi Stored Procedure loại OUT và kiểm tra kết quả
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS TotalCustomersInLyon;


-- ===================================================
-- 4. THAM SỐ LOẠI INOUT
-- ===================================================
DELIMITER //

DROP PROCEDURE IF EXISTS `SetCounter`//

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Gọi Stored Procedure loại INOUT
SET @counter = 1;
CALL SetCounter(@counter, 1); -- Tăng lên 2
CALL SetCounter(@counter, 1); -- Tăng lên 3
CALL SetCounter(@counter, 5); -- Tăng lên 8

-- Hiển thị kết quả của biến @counter
SELECT @counter AS FinalCounter;