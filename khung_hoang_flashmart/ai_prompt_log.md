# Nhật Ký Hỏi Đáp Lý Thuyết SQL Với AI

### Prompt 1:
*Người hỏi:* "Trong cơ sở dữ liệu MySQL, mặc định từ khóa JOIN (khi không ghi rõ LEFT hay RIGHT) sẽ hoạt động như thế nào? Nó sẽ bỏ qua hay giữ lại các bản ghi không có sự trùng khớp ở cả hai bảng?"
*AI trả lời:* Mặc định từ khóa `JOIN` hoạt động như `INNER JOIN`. Nó chỉ trả về các bản ghi có sự trùng khớp (khớp điều kiện ON) ở cả hai bảng. Các bản ghi không trùng khớp ở bảng bên trái hoặc bên phải đều sẽ bị loại bỏ hoàn toàn.

---

### Prompt 2:
*Người hỏi:* "Khi tôi sử dụng LEFT JOIN và đếm số lượng đơn hàng bằng hàm COUNT, tôi nên dùng COUNT(*) hay COUNT(tên_cột_khóa_chính_bảng_order)? Sự khác biệt khi kết quả trả về NULL là gì?"
*AI trả lời:* Nên sử dụng `COUNT(o.order_id)`. Dùng `COUNT(*)` sẽ đếm toàn bộ dòng dữ liệu (kể cả dòng có chứa NULL từ LEFT JOIN), dẫn đến khách hàng chưa từng mua hàng vẫn bị tính là có 1 đơn. Trong khi đó, `COUNT(o.order_id)` tự động bỏ qua các giá trị `NULL`, giúp trả về số lượng đơn bằng 0 đúng thực tế.

---

### Prompt 3:
*Người hỏi:* "Hãy phân tích hiệu năng (Performance) của việc dùng LEFT JOIN kết hợp IS NULL so với việc dùng subquery NOT IN khi muốn tìm kiếm các bản ghi không tồn tại trong bảng khác."
*AI trả lời:* Kỹ thuật `LEFT JOIN ... WHERE IS NULL` (Anti-Join) thường có hiệu năng tốt hơn `NOT IN` trên tập dữ liệu lớn. Lý do là MySQL Optimizer xử lý JOIN rất tối ưu, còn `NOT IN` có thể dẫn đến quét toàn bộ bảng (Full Table Scan) hoặc bị lỗi logic bất ngờ nếu tập subquery chứa giá trị `NULL`.