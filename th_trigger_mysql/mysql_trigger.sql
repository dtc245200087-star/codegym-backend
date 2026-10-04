-- 1. Tạo CSDL company và sử dụng CSDL đó
CREATE DATABASE IF NOT EXISTS company;
USE company;

-- 2. Tạo bảng employees
CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- 3. Tạo Trigger tự động cập nhật phòng ban dựa vào mức lương trước khi INSERT
DELIMITER //

DROP TRIGGER IF EXISTS update_department//

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
     IF NEW.salary >= 5000 THEN
          SET NEW.department = 'Management';
     ELSEIF NEW.salary >= 3000 THEN
          SET NEW.department = 'Sales';
     ELSE
          SET NEW.department = 'Support';
     END IF;
END //

DELIMITER ;

-- 4. Thêm dữ liệu mẫu để kiểm tra hoạt động của Trigger
INSERT INTO employees (name, department, salary)
VALUES ('John Doe', 'A', 3500),
       ('Jane Smith', 'A', 2000),
       ('David Johnson', 'A', 6000);

-- 5. Kiểm tra kết quả dữ liệu trong bảng employees
SELECT * FROM employees;