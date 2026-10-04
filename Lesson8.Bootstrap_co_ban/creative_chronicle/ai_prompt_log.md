# Nhật ký Tương tác AI (AI Prompt Log)

1. **Tra cứu Grid Template Areas & Span:**
   - *Query:* Cách sử dụng CSS Grid để tạo layout mosaic 1 ảnh lớn bên trái chiếm 2 hàng và 2 ảnh nhỏ bên phải mà không dùng position absolute.
   - *Result:* Sử dụng `display: grid; grid-template-columns: 2fr 1fr;` kết hợp `grid-row: span 2` cho phần tử chính.

2. **Tra cứu Bootstrap Spacing & Grid Utilities:**
   - *Query:* Các class khoảng cách và lưới của Bootstrap 5 để thay thế cho float width 23% của danh sách thẻ bài viết.
   - *Result:* Sử dụng `<div class="row g-4">` kết hợp với cột phản hồi `<div class="col-12 col-md-6 col-lg-3">` và component `card`.