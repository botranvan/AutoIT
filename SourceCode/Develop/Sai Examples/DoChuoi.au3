#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Do chiền dài của 1 chuỗi
#ce ==========================================================

;~ Lấy giá trị từ bàn phím
$String = InputBox("72ls.NET","Nhập chuỗi bất kỳ","AutoIT Việt")

MsgBox(0,"72ls.NET","Chiều dài của chuỗi vừa nhập là: "&StringLen($String))
