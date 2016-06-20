#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Do chiền dài của 1 chuỗi rồi lưu kết quả xuống file
#ce ==========================================================

$File = FileOpen("DoChuoi.txt",2 + 128)

;~ Lấy giá trị từ bàn phím
$String = InputBox("72ls.NET","Nhập chuỗi bất kỳ","AutoIT Việt")

;~ Ghi chuỗi được nhập xuống file
FileWrite($File,@CRLF&"Người dùng đã nhập chuỗi: "&$String)

;~ Xuất kết quản đo được
MsgBox(0,"72ls.NET","Chiều dài của chuỗi vừa nhập là: "&StringLen($String))

;~ Ghi chuỗi được nhập xuống file
FileWrite($File,@CRLF&"Độ dài của chuỗi là : "&StringLen($String))

FileClose($File)
