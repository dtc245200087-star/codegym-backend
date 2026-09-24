-- 1. Tạo CSDL QuanLyBanHang
CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

-- 2. Tạo bảng Customer (Khách hàng)
CREATE TABLE Customer (
    cID INT AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(50) NOT NULL,
    cAge TINYINT CHECK (cAge > 0)
);

-- 3. Tạo bảng Product (Sản phẩm)
CREATE TABLE Product (
    pID INT AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(100) NOT NULL,
    pPrice DECIMAL(10, 2) NOT NULL CHECK (pPrice >= 0)
);

-- 4. Tạo bảng Order (Hóa đơn)
CREATE TABLE `Order` (
    oID INT AUTO_INCREMENT PRIMARY KEY,
    cID INT NOT NULL,
    oDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    oTotalPrice DECIMAL(10, 2),
    FOREIGN KEY (cID) REFERENCES Customer(cID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Tạo bảng OrderDetail (Chi tiết hóa đơn - Bảng trung gian giữa Order và Product)
CREATE TABLE OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL CHECK (odQTY > 0),
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pID) REFERENCES Product(pID) ON DELETE CASCADE ON UPDATE CASCADE
);