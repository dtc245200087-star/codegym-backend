# Báo cáo Phân tích và Tái cấu trúc Layout (Layout Refactoring Report)

## Tác hại của Position: Absolute đối với Responsive Design
Thuộc tính `position: absolute` khiến phần tử bị tách hoàn toàn khỏi luồng tài liệu (document flow), dẫn đến việc phần tử cha không thể tự động co giãn chiều cao theo nội dung bên trong (gây ra tình trạng sập chiều cao - height collapse). Khi hiển thị trên các thiết bị di động có màn hình nhỏ, các lớp ảnh tuyệt đối này cố định kích thước hoặc đè lấn thảm họa lên văn bản phía dưới, phá vỡ hoàn toàn tính năng đáp ứng (Responsive Design).

## Lý do CSS Grid là giải pháp cứu cánh cho Mosaic Gallery
CSS Grid cho phép thiết lập bố cục không gian 2 chiều (cả hàng và cột) một cách đồng bộ mà không cần gán cứng chiều cao pixel hay tính toán phần trăm phức tạp. Bằng cách sử dụng `grid-template-columns` kết hợp thuộc tính `span` (`grid-row: span 2`), bố cục bất đối xứng được duy trì mượt mà, tự động điều chỉnh tỷ lệ và co giãn hoàn hảo trên mọi kích thước màn hình mà không sợ đè lấn nội dung.