# Báo Cáo Phân Tích Hiệu Năng EXPLAIN - PayFlow System

## 1. Trước khi tối ưu (Legacy Query)
- **Truy vấn:** Sử dụng hàm `YEAR(created_at) = 2026 AND MONTH(created_at) = 6` (Non-SARGable).
- **Cột `type`:** `ALL` (Full Table Scan - Quét toàn bộ 5,000,000 dòng dữ liệu).
- **Cột `possible_keys` / `key`:** `NULL` (Không thể dùng Index dù có đánh Index trên `created_at`).
- **Cột `rows`:** ~5,000,000 dòng.
- **Nguyên nhân:** Bọc hàm xung quanh cột khiến B-Tree Index không thể thực hiện tìm kiếm nhị phân (Index Seek).

## 2. Sau khi tối ưu (Optimized Query)
- **Giải pháp:** 
  1. Tạo Composite Index `idx_type_date(transaction_type, created_at)`.
  2. Viết lại mệnh đề WHERE dạng Range SARGable: `created_at >= '2026-06-01 00:00:00' AND created_at < '2026-07-01 00:00:00'`.
- **Cột `type`:** `range` / `ref` (Chỉ tìm kiếm trên phạm vi dữ liệu khớp điều kiện).
- **Cột `key`:** `idx_type_date`.
- **Cột `rows`:** Giảm từ 5,000,000 xuống còn khoảng vài nghìn dòng.
- **Kết quả:** Thời gian thực thi giảm từ 45 giây xuống dưới vài miligiây, loại bỏ hoàn toàn CPU 100% và Table Lock.