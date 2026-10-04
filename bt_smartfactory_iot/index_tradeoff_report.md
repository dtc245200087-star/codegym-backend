# Báo cáo Đánh đổi Hiệu năng và Tài nguyên - SmartFactory IoT

## 1. Vấn đề "Fat Index" (Covering Index quá khổ)
Việc nhồi nhét toàn bộ các cột liên tục thay đổi như `temperature`, `humidity`, và `status` vào một Composite Index (`idx_fat_covering`) gây ra hiện tượng **Write Penalty** nghiêm trọng. Mỗi khi cảm biến gửi dữ liệu về, hệ thống mất quá nhiều thời gian để cập nhật cây B-Tree, dẫn đến lỗi rớt dữ liệu (Data Loss) và làm dung lượng ổ cứng phình to phi mã.

## 2. Giải pháp chuyển đổi sang "Lean Index"
* **Giải pháp:** Xóa bỏ `idx_fat_covering` và thay thế bằng `idx_lean_search` chỉ bao gồm `(sensor_id, recorded_at)`.
* **Sự đánh đổi:** 
  * *Tốc độ Đọc (SELECT):* Chấp nhận mất đi cơ chế "Using index" tuyệt đối (trên kết quả EXPLAIN, MySQL sẽ thực hiện thêm bước Table Lookup để lấy dữ liệu cột nhiệt độ/độ ẩm). Tuy nhiên, độ trễ tăng thêm chỉ là vài phần nghìn giây - hoàn toàn nằm trong ngưỡng chấp nhận được của người dùng Dashboard.
  * *Tốc độ Ghi (INSERT) & Lưu trữ (Storage):* Giải phóng hàng chục Gigabyte dung lượng đĩa SSD, loại bỏ hoàn toàn hiện tượng nghẽn cổ chai, giúp hệ thống IoT tiếp nhận mượt mà hàng chục nghìn bản ghi mỗi giây mà không bị timeout.