#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.4.0
- Chức năng: Tìm 1 ký tự
#ce ==========================================================

;~ Các biến toàn cục
Global $Title = "72ls.net"
Global $String = "Cộng đồng AutoIT Việt"

;~ Tạo tin nhắn hướng dẫn
$Text1 = "Chuỗi sẵn có là: "&@LF
$Text1&= 	@TAB&$String&@LF&@LF
$Text1&= "Hãy nhập từ cần tìm"

;~ Lấy 1 ký tự cần tìm
$Char = InputBox($Title,$Text1,Default," M1",Default,170)
If @error Then Exit ;Thoát luôn nến Cancel

;~ Cắt chuỗi thành từ ký tự
$String = StringSplit($String,"")

;~ Bắt đầu dò từng ký tự
For $i = 1 To $String[0] Step 1
	If $String[$i] = $Char Then 
		MsgBox(0,$Title,"Đã tìm thấy tại vị trí: "&$i)
		Exit
	EndIf
Next

;~ Nếu hết For mà không có thì tức là không có ký tự cần tìm
MsgBox(0,$Title,"Không tìm thấy ký tự "&$Char)