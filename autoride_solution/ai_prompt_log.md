# AI PROMPT LOG - NHẬT KÝ TRAO ĐỔI KỸ THUẬT

### Prompt 1: Tìm hiểu kiểu dữ liệu tài chính
- **Câu hỏi:** "Trong MySQL, nên sử dụng kiểu dữ liệu DECIMAL hay FLOAT để lưu trữ tiền tệ như phí phạt và tiền cọc? Tại sao?"
- **Mục đích:** Đảm bảo chính xác số liệu tài chính, tránh sai số do số thực dấu phẩy động (`FLOAT`).
- **Kết quả:** Sử dụng `DECIMAL(12, 2)` để đảm bảo độ chính xác tuyệt đối cho các giao dịch tài chính.

### Prompt 2: Đánh giá thiết kế bảng Inspections
- **Câu hỏi:** "Tại sao nên tách Biên bản kiểm tra xe (Inspections) ra một bảng riêng thay vì lưu trực tiếp cột damage_description vào bảng Rentals?"
- **Mục đích:** Chuẩn hóa CSDL (Normalization) và chuẩn bị cho khả năng một hợp đồng có thể kiểm tra nhiều lần (lúc nhận xe và lúc trả xe).
- **Kết quả:** Tạo bảng riêng `Inspections` với khóa ngoại trỏ về `Rentals` theo quan hệ 1-N.