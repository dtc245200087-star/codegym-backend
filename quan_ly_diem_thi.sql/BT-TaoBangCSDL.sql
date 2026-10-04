-- 1. Tạo cơ sở dữ liệu QuanLyDiemThi
CREATE DATABASE IF NOT EXISTS QuanLyDiemThi;

-- 2. Chọn CSDL QuanLyDiemThi để làm việc
USE QuanLyDiemThi;

-- 3. Tạo bảng Học sinh
CREATE TABLE HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50),
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
);

-- 4. Tạo bảng Giáo viên
CREATE TABLE GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50),
    SDT VARCHAR(10)
);

-- 5. Tạo bảng Môn học
CREATE TABLE MonHoc (
    MaMH VARCHAR(20) PRIMARY KEY,
    TenMH VARCHAR(50),
    MaGV VARCHAR(20),
    CONSTRAINT FK_MaGV FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV)
);

-- 6. Tạo bảng Bảng điểm (Bảng trung gian kết nối HocSinh và MonHoc)
CREATE TABLE BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(20),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);