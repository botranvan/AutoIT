#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.0
- Chức năng: Tự động cập nhật lại AutoIT v1.0
- Lưu ý: Làm tròn số thập phân
#ce ==========================================================

$Title = "72ls.net"

;~ Lấy 1 số thập phân
$A = InputBox($Title,"Nhập 1 số thập phân vào",7.2)

;~ Xuất kết quả
MsgBox(0,$Title,Round($A))
