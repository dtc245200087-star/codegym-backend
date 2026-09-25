# Nhật ký Tương tác AI (AI Prompt Log)

1. **Prompt 1 (Brainstorming - Phân tích lỗi Legacy Code):**
   - *User:* "Khi tôi cần một bố cục mà một phần tử con phải chiếm chính xác 2 hàng và 2 cột (span 2 rows, 2 columns) đan xen với các phần tử nhỏ khác, tôi nên chọn CSS Grid hay Flexbox? Tại sao Flexbox lại chật vật với yêu cầu này?"
   - *AI Feedback:* Đề xuất sử dụng CSS Grid vì quản lý bố cục đồng thời theo cả trục hoành và trục tung (2D), trong khi Flexbox chỉ tối ưu cho luồng dữ liệu 1 chiều (1D).

2. **Prompt 2 (Mentor - Cú pháp Bento Box):**
   - *User:* "Hãy cho tôi xem một cú pháp CSS Grid đơn giản (sử dụng grid-template-areas hoặc span) để tạo một layout dạng Bento Box: có 1 hình vuông lớn bên trái chiếm 2x2, và các hình vuông nhỏ xung quanh."
   - *AI Feedback:* Cung cấp mẫu sử dụng `grid-template-columns: repeat(3, 1fr)` kết hợp với `grid-column: span 2` và `grid-row: span 2`.

3. **Prompt 3 (Tối ưu Responsive Navbar):**
   - *User:* "Làm thế nào để sử dụng thuộc tính flex-wrap kết hợp với gap trong Flexbox để Navbar tự động đẩy các menu xuống dòng dưới mà không che khuất Logo?"
   - *AI Feedback:* Hướng dẫn kết hợp `flex-wrap: wrap` và khoảng cách `gap` để điều phối không gian tự động.