# BÁO CÁO: CHUYỂN ĐỔI SƠ ĐỒ ERD SANG MÔ HÌNH QUAN HỆ

## Bước 1: Xác định các thực thể và thuộc tính đơn
- **PHIEUXUAT**: SoPX (PK), NgayXuat
- **VATTU**: MaVTU (PK), TenVTU
- **PHIEUNHAP**: SoPN (PK), NgayNhap
- **DONDH**: SoDH (PK), NgayDH
- **NHACC**: MaNCC (PK), TenNCC, DiaChi

## Bước 2: Xác định và xử lý các mối quan hệ
1. **PHIEUXUAT (N) - (N) VATTU**: Mối quan hệ Nhiều - Nhiều -> Tạo bảng trung gian `CHITIETPHIEUXUAT` gồm (`SoPX`, `MaVTU`, `DGXuat`, `SLXuat`).
2. **PHIEUNHAP (N) - (N) VATTU**: Mối quan hệ Nhiều - Nhiều -> Tạo bảng trung gian `CHITIETPHIEUNHAP` gồm (`SoPN`, `MaVTU`, `DGNhap`, `SLNhap`).
3. **DONDH (N) - (N) VATTU**: Mối quan hệ Nhiều - Nhiều -> Tạo bảng trung gian `CHITIETDONDATHANG` gồm (`SoDH`, `MaVTU`).
4. **DONDH (N) - (1) NHACC**: Mối quan hệ Một - Nhiều -> Thêm khóa ngoại `MaNCC` vào bảng `DONDH`.

## Bước 3: Xác định và xử lý thuộc tính đa trị
- Thuộc tính `SĐT` của thực thể `NHACC` có nét vẽ kép (đa trị) -> Tách thành bảng riêng `NHACC_SDT` gồm (`MaNCC`, `SDT`).

## Bước 4: Danh sách các bảng thu được (Mô hình quan hệ)
1. **PHIEUXUAT** (**SoPX**, NgayXuat)
2. **VATTU** (**MaVTU**, TenVTU)
3. **PHIEUNHAP** (**SoPN**, NgayNhap)
4. **NHACC** (**MaNCC**, TenNCC, DiaChi)
5. **NHACC_SDT** (**MaNCC**, **SDT**) *(MaNCC là FK trỏ về NHACC)*
6. **DONDH** (**SoDH**, NgayDH, *MaNCC*) *(MaNCC là FK trỏ về NHACC)*
7. **CHITIETPHIEUXUAT** (**SoPX**, **MaVTU**, DGXuat, SLXuat)
8. **CHITIETPHIEUNHAP** (**SoPN**, **MaVTU**, DGNhap, SLNhap)
9. **CHITIETDONDATHANG** (**SoDH**, **MaVTU**)