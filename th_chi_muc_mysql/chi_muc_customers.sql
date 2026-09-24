-- 1. Sử dụng CSDL classicmodels
USE classicmodels;

-- 2. Phân tích câu truy vấn khi CHƯA tạo chỉ mục (Full Table Scan)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 3. Tạo chỉ mục (Index) cho cột customerName
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- 4. Phân tích lại câu truy vấn sau khi ĐÃ tạo chỉ mục idx_customerName
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 5. Tạo chỉ mục phức hợp (Composite Index) cho 2 cột contactFirstName và contactLastName
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- 6. Phân tích truy vấn sử dụng chỉ mục phức hợp
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- 7. Xóa chỉ mục phức hợp idx_full_name
ALTER TABLE customers DROP INDEX idx_full_name;