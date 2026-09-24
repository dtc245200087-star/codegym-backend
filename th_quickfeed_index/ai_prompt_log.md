# Nhật ký Tương tác AI (AI Prompt Log)

## Câu hỏi 1: Về độ phân giải dữ liệu (Cardinality) và kiểu dữ liệu Boolean
* **Prompt gửi AI:** "Trong MySQL, nếu tôi tạo Index trên một cột chứa văn bản dài (TEXT) và một cột kiểu BOOLEAN (0 và 1), thì điều này gây hại như thế nào đến bộ nhớ RAM, dung lượng Disk và bộ tối ưu hóa (Query Optimizer)?"
* **Tóm tắt phản hồi từ AI:** 
  * Cột `TEXT` tạo index qua prefix (`content(255)`) sẽ làm tốn kém dung lượng chuỗi index lưu trữ vì bản chất chuỗi text dài không mang tính chất định danh cao cho B-Tree.
  * Cột `BOOLEAN` có Cardinality cực thấp (chỉ có 2 giá trị). Khi tỷ lệ một giá trị chiếm đa số (ví dụ 99% là `1`), MySQL Optimizer sẽ thông minh nhận ra việc quét toàn bảng (`Full Table Scan`) nhanh hơn là đi qua cây Index rồi mới quay lại bảng gốc (Table Lookup), khiến Index đó vô dụng nhưng vẫn ngốn tài nguyên để duy trì.

## Câu hỏi 2: Truy vấn thông tin dung lượng từ bảng hệ thống
* **Prompt gửi AI:** "Hãy cho tôi xem truy vấn SQL sử dụng bảng information_schema.TABLES để in ra kích thước Data và kích thước Index của bảng 'Posts' tính theo đơn vị Megabyte (MB)."
* **Tóm tắt phản hồi từ AI:** Hướng dẫn sử dụng các cột `data_length` và `index_length` bên trong `information_schema.TABLES`, kết hợp chia cho `1024 / 1024` và hàm `ROUND` để ra kết quả theo đơn vị MB dễ theo dõi.

## Câu hỏi 3: Giải pháp tối ưu tìm kiếm văn bản dài
* **Prompt gửi AI:** "Nếu muốn tìm kiếm từ khóa bên trong cột content (kiểu TEXT) mà không bị tốn quá nhiều dung lượng như B-Tree Index, tôi nên sử dụng cơ chế nào của MySQL?"
* **Tóm tắt phản hồi từ AI:** Đề xuất sử dụng **FULLTEXT Index** thay cho B-Tree Index thông thường khi có nhu cầu tìm kiếm chuỗi văn bản/từ khóa phức tạp trong các cột kiểu `TEXT` hoặc `VARCHAR` dài.