# Giải Trình Kỹ Thuật: Sử Dụng COUNT(o.order_id) Thay Vì COUNT(*)

Trong câu truy vấn Báo cáo Marketing kết hợp LEFT JOIN:

1. **Sự khác biệt về cơ chế:**
   - `COUNT(*)` đếm tất cả các dòng dữ liệu được trả về trong tập kết quả sau khi JOIN, không quan tâm dòng đó có chứa giá trị `NULL` hay không.
   - `COUNT(o.order_id)` chỉ đếm các giá trị **khác NULL** tại cột `order_id` của bảng `Orders`.

2. **Tác động đến kết quả:**
   - Khách hàng chưa mua hàng (như Charlie) khi `LEFT JOIN` với `Orders` sẽ sinh ra 1 dòng dữ liệu mà các cột từ bảng `Orders` mang giá trị `NULL`.
   - Nếu dùng `COUNT(*)`, hệ thống đếm dòng đó và trả về `1` (sai thực tế vì Charlie chưa mua đơn nào).
   - Nếu dùng `COUNT(o.order_id)`, giá trị `NULL` ở `order_id` bị bỏ qua, trả về chính xác `0` đơn hàng.