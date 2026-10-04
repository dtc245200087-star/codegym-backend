# BÁO CÁO PHÂN TÍCH: TẦM QUAN TRỌNG CỦA CỘT DAMAGE_FEE

Trong quy trình nghiệp vụ trả xe tại AutoRide (Activity Diagram), khi kiểm tra phát hiện hư hỏng, hệ thống bắt buộc phải tính Phí sửa chữa (`damage_fee`) để trừ vào Tiền cọc (`security_deposit`).

Cột `damage_fee` là bắt buộc vì các lý do sau:

1. **Tính toàn vẹn dữ liệu tài chính:** Không có `damage_fee`, công thức tính tiền hoàn trả (`Refund = Deposit - Late Fee - Damage Fee`) bị đứt gãy, dẫn đến việc phải tính toán thủ công ngoài sổ sách và thất thoát doanh thu nghiêm trọng.
2. **Minh bạch tài chính & Đối soát:** Cung cấp bằng chứng giao dịch chính xác trên hệ thống cho kế toán và khách hàng, thay vì lưu ghi chú không chuẩn hóa.
3. **Tuân thủ quy trình UML:** Đảm bảo nhánh rẽ "Xe bị hư hỏng" trong quy trình được thể hiện và lưu trữ trực tiếp dưới cơ sở dữ liệu.