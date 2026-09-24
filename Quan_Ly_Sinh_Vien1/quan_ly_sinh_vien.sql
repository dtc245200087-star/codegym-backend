-- 1. Tạo cơ sở dữ liệu QuanLySinhVien
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;

-- 2. Chọn cơ sở dữ liệu để thao tác
USE QuanLySinhVien;

-- 3. Tạo bảng Class
CREATE TABLE IF NOT EXISTS Class (
    ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

-- 4. Tạo bảng Student
CREATE TABLE IF NOT EXISTS Student (
    StudentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassId INT NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

-- 5. Tạo bảng Subject
CREATE TABLE IF NOT EXISTS Subject (
    SubId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status BIT DEFAULT 1
);

-- 6. Tạo bảng Mark
CREATE TABLE IF NOT EXISTS Mark (
    MarkId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId INT NOT NULL,
    StudentId INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

-- ===================================================
-- THÊM DỮ LIỆU (INSERT INTO)
-- ===================================================

-- Thêm dữ liệu bảng Class
INSERT INTO Class VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class VALUES (3, 'B3', CURRENT_DATE, 0);

-- Thêm dữ liệu bảng Student
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);

INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

-- Thêm dữ liệu bảng Subject
INSERT INTO Subject VALUES 
(1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);

-- Thêm dữ liệu bảng Mark
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES 
(1, 1, 8, 1),
(1, 2, 10, 2),
(2, 1, 12, 1);
-- ===================================================
-- TRUY VẤN DỮ LIỆU (SELECT QUERY)
-- ===================================================

-- 1. Hiển thị danh sách tất cả các học viên
SELECT *
FROM Student;

-- 2. Hiển thị danh sách các học viên đang theo học (Status = true/1)
SELECT *
FROM Student
WHERE Status = true;

-- 3. Hiển thị danh sách các môn học có thời gian học (Credit) nhỏ hơn 10
SELECT *
FROM Subject
WHERE Credit < 10;

-- 4. Hiển thị danh sách học viên lớp A1
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S 
JOIN Class C ON S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

-- 5. Hiển thị điểm môn CF của các học viên
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';