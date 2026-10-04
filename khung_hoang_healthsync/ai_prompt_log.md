# AI PROMPT LOG - DỰ ÁN HEALTHSYNC

## Prompt 1: Tìm hiểu Anti-pattern của cột is_active
* **User:** "Trong thiết kế cơ sở dữ liệu quan hệ, tại sao việc dùng một cột is_active (kiểu TINYINT/BOOLEAN) để theo dõi vòng đời của một Đơn hàng/Lịch hẹn lại là một thiết kế tồi (Anti-pattern)? Tôi nên thay thế bằng cấu trúc nào?"
* **AI Output:** Giải thích rằng `is_active` chỉ có 2 trạng thái true/false, không biểu diễn được quy trình nhiều bước (Pending, Completed, Cancelled...). Giải pháp đề xuất là dùng `ENUM` hoặc tạo bảng `Statuses` riêng.

## Prompt 2: Chọn kiểu dữ liệu cho tiền tệ
* **User:** "Khi thiết kế cột deposit_amount và penalty_fee trong MySQL phục vụ tính toán tài chính, tôi nên dùng kiểu dữ liệu FLOAT, DOUBLE hay DECIMAL? Tại sao?"
* **AI Output:** Phân tích rủi ro làm tròn số (Floating-point precision error) của FLOAT/DOUBLE. Khuyên dùng `DECIMAL(10,2)` cho dữ liệu tài chính để đảm bảo tính toán chính xác tuyệt đối.

## Prompt 3: Cú pháp cập nhật cột ENUM
* **User:** "Hãy cho tôi xem cú pháp chuẩn trong MySQL để thêm một cột status với kiểu dữ liệu ENUM chứa các giá trị ('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED') vào một bảng có sẵn."
* **AI Output:** Cung cấp lệnh `ALTER TABLE Appointments ADD COLUMN status ENUM(...) DEFAULT 'PENDING';`