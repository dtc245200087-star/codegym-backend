# Nhật ký Tương tác AI (AI Prompt Log)

## Câu hỏi 1: Về cơ chế phân bổ dữ liệu của Clustered Index và Secondary Index
* **Prompt gửi AI:** "Hãy giải thích cách MySQL phân bổ dữ liệu trên Clustered Index (Khóa chính) và Secondary Index (Chỉ mục phụ) và tại sao việc đưa quá nhiều cột vào Secondary Index lại gây ra Write Penalty lớn?"
* **Tóm tắt phản hồi từ AI:** 
  * Clustered Index lưu trữ toàn bộ dữ liệu dòng (Data Rows) tại nút lá của khóa chính.
  * Secondary Index chỉ lưu giá trị của cột được định mục kèm theo con trỏ trỏ về khóa chính. Khi có quá nhiều cột bị đưa vào Secondary Index, kích thước cây B-Tree tăng lên, mỗi thao tác INSERT/UPDATE bắt buộc phải sắp xếp và cân bằng lại cấu trúc phức tạp này trên đĩa cứng, gây ra hiện tượng nghẽn luồng ghi (Write Penalty).

## Câu hỏi 2: Tính toán dung lượng Byte cho các kiểu dữ liệu
* **Prompt gửi AI:** "Hãy cho tôi biết cách tính dung lượng lưu trữ (Byte calculation) của các kiểu dữ liệu BIGINT, INT, DATETIME, DECIMAL và VARCHAR trong MySQL để phục vụ việc đánh giá chi phí lưu trữ Index."
* **Tóm tắt phản hồi từ AI:** 
  * `BIGINT` chiếm 8 bytes, `INT` chiếm 4 bytes, `DATETIME` chiếm 5 bytes, `DECIMAL(5,2)` chiếm khoảng 3-5 bytes. 
  * Khi nhân bản các giá trị này qua hàng triệu dòng trong một Index phình to, dung lượng cộng dồn sẽ chiếm tỷ trọng khổng lồ trên ổ cứng SSD.