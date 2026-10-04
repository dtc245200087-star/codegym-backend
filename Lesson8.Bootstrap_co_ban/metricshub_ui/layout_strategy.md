# Báo cáo Giải pháp Kiến trúc Layout (Layout Strategy)

CSS Grid sinh ra để làm Layout tổng thể (2D), trong khi Flexbox sinh ra để làm Component chi tiết (1D). 

- **Navbar**: Chuyển sang **Flexbox** giúp các mục tự động co giãn theo nội dung thực tế (Content-first), giải quyết triệt để lỗi tràn chữ khi đổi ngôn ngữ dài.
- **Dashboard**: Chuyển sang **CSS Grid** giúp loại bỏ hoàn toàn các thẻ `<div>` lồng nhau rườm rà (Div Soup). Các widget lớn được sắp xếp gọn gàng theo dạng Bento Box thông qua thuộc tính `span`.
- **Pricing**: Tận dụng hệ thống lưới 12 cột của **Bootstrap** (`row` / `col-md-4`) để tự động phân bổ đều 3 cột trên Desktop và xếp chồng dọc trên Mobile mà không cần tự viết thủ công các Media Queries phức tạp.