# Báo cáo Phân tích Tối ưu hóa Tài nguyên và Hiệu năng - QuickFeed

## 1. Đánh giá nguyên nhân thảm họa quá tải
Việc lập trình viên cũ tạo Index bừa bãi trên toàn bộ các cột (đặc biệt là cột kiểu `TEXT` và các cột có độ phân giải dữ liệu - **Cardinality** cực thấp như `is_visible` chỉ có 2 giá trị 0/1 hay `post_type` chỉ có 3 giá trị) đã dẫn đến hai hệ lụy nghiêm trọng ở tầng vật lý:
* **Nghẽn tiến trình GHI (Write Amplification):** Mỗi khi có một thao tác `INSERT` bài viết mới xảy ra, hệ quản trị cơ sở dữ liệu (InnoDB) không chỉ ghi một dòng vào bảng chính mà phải đồng thời cập nhật cấu trúc cây B-Tree cho cả 5 Index phụ. Điều này làm tăng vọt số vòng lặp thao tác đĩa cứng, gây ra hiện tượng Timeout 5-10 giây cho người dùng.
* **Cạn kiệt Disk Space:** Cây B-Tree của các Index không cần thiết phình to vượt trội so với dữ liệu thực tế, làm lãng phí không gian lưu trữ RAM và ổ cứng máy chủ.

## 2. Giải pháp và Kết quả tối ưu
* **Giữ lại:** `idx_user_id` và `idx_created_at` (do tính phân biệt cao, phục vụ tốt cho việc truy vấn trang cá nhân và sắp xếp dòng thời gian newsfeed).
* **Loại bỏ:** `idx_content`, `idx_post_type`, và `idx_is_visible`.

**Số liệu so sánh ước tính (trên hệ thống thực tế):**
* **Dung lượng Index (Index Length):** Giảm mạnh tới ~60% - 70% sau khi loại bỏ các Index có Cardinality thấp và cột `TEXT` lớn.
* **Hiệu năng GHI (INSERT):** Giảm tải đáng kể các tác vụ cập nhật cây B-Tree ngầm, đưa thời gian phản hồi lệnh đăng bài trở về ngưỡng mili-giây, giải quyết dứt điểm lỗi Timeout.