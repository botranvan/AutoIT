#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.4.0
- Chức năng: Thực hiện đảo chuỗi ký tự
#ce ==========================================================

;~ Các Include
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

;~ Các phím nóng
HotKeySet("{ESC}", 'ExitAuto')

;~ Các biến toàn cục
Global $Title = "72ls.net"

;~ Lấy chuỗi
$String = InputBox($Title,"Hãy nhập 1 chuỗi ký tự vào",Default,'', 200, 100)

;~ Lấy chiều dài của ký tự
$Length = StringLen($String)

;~ Duyệt chuỗi từ phải qua trái
$NewString = ""
For $i = $Length To 1 Step -1
	$NewString&= StringMid($String,$i,1)
Next

;~ Xuất kết quả
MsgBox(0,$Title,"Chuỗi gốc: "&$String&@LF&"Đã đảo lại: "&$NewString)

;~ Thoát Chương Trình
Func ExitAuto()
	Exit
EndFunc