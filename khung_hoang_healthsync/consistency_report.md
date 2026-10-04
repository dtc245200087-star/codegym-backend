# BÁO CÁO ĐỐI CHIẾU NGHIỆP VỤ VÀ CƠ SỞ DỮ LIỆU HEALTHSYNC

Sau khi đối chiếu giữa UML Activity Diagram của bộ phận BA và bản SQL Legacy, tôi phát hiện 3 điểm "vênh" nghiêm trọng khiến hệ thống không thể vận hành:

1. **Sai lệch về theo dõi vòng đời lịch hẹn (Lifecycle Status):**
   Bản thiết kế cũ dùng cột `is_active` kiểu `BOOLEAN` (chỉ có 2 giá trị true/false). Cấu trúc này không thể thể hiện được 5 trạng thái chuyển tiếp trong Activity Diagram (`PENDING` -> `CONFIRMED` -> `CHECKED_IN` -> `COMPLETED` / `CANCELLED`).

2. **Thiếu hoàn toàn dữ liệu quản lý tài chính và hủy lịch:**
   Activity Diagram yêu cầu ghi nhận tiền cọc (`deposit_amount`), phí phạt hủy lịch (`penalty_fee`) và lý do hủy (`cancel_reason`). Việc thiếu các trường này khiến phòng khám không thể xử lý phạt cọc khi bệnh nhân hủy sau khi đã xác nhận.

3. **Vắng mặt bảng lưu trữ Đơn thuốc (Prescriptions):**
   Khi trạng thái chuyển sang `COMPLETED`, bác sĩ phải kê đơn thuốc. CSDL cũ không có bảng `Prescriptions` và quan hệ khóa ngoại nối với `Appointments`, dẫn đến mất mát hoàn toàn thông tin khám chữa bệnh.