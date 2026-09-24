USE classicmodels;

-- ===================================================
-- 1. TRIỂN KHAI STORED PROCEDURE VỚI THAM SỐ IN
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

-- Gọi thử tham số IN
CALL getCusById(175);


-- ===================================================
-- 2. TRIỂN KHAI STORED PROCEDURE VỚI THAM SỐ OUT
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

-- Gọi thử tham số OUT
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total;


-- ===================================================
-- 3. TRIỂN KHAI STORED PROCEDURE VỚI THAM SỐ INOUT
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

-- Gọi thử tham số INOUT
SET @counter = 1;
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 5);
SELECT @counter;