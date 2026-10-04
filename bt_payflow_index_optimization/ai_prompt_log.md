# AI Prompt Log - Kỹ Thuật Tối Ưu Index & SARGable

## Prompt 1
**User:** Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng, nhưng trong mệnh đề WHERE tôi lại viết WHERE YEAR(col) = 2026, tại sao MySQL lại từ chối sử dụng Index và phải quét toàn bộ bảng (Full Table Scan)?

**AI Response:** Khi bạn bọc một cột trong một hàm như `YEAR()`, MySQL phải tính toán giá trị của hàm đó cho từng dòng một trong bảng trước khi so sánh với `2026`. Việc này phá vỡ cấu trúc sắp xếp sẵn của B-Tree Index, làm truy vấn trở thành Non-SARGable và buộc MySQL chuyển sang Full Table Scan.

## Prompt 2
**User:** Khi thiết kế một Composite Index trong MySQL cho cột (transaction_type, created_at), thứ tự các cột trong Index có quan trọng không? Tôi nên đặt cột nào đứng trước?

**AI Response:** Thứ tự rất quan trọng theo nguyên tắc Leftmost Prefix. Bạn nên đặt cột lọc theo điều kiện chính xác (`=`) là `transaction_type` đứng trước, và cột lọc theo phạm vi (Range `>=`, `<`) là `created_at` đứng sau để tối ưu hóa khả năng duyệt cây B-Tree.

## Prompt 3
**User:** Trong kết quả EXPLAIN, cột 'Extra' hiện chữ 'Using index condition' khác gì với 'Using index' (Covering Index)?

**AI Response:** 
- `Using index condition` (Index Condition Pushdown - ICP): MySQL lọc dữ liệu trực tiếp tại tầng Storage Engine bằng Index trước khi trả về SQL Layer.
- `Using index`: Chỉ truy vấn lấy các cột nằm hoàn toàn trong Index mà không cần đọc dữ liệu từ bảng chính (Covering Index).