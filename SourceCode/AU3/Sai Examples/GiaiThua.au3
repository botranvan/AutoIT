#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.4.0
- Chức năng: Thực hiện tính giai thừa của một số
#ce ==========================================================

;~ Các Include
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

;~ Các phím nóng
HotKeySet("{ESC}", 'ExitAuto')
$GiaThua = 1

;~ Các biến toàn cục
Global $Title = "72ls.net"

;~ Lấy chuỗi với 4 ký tự
$Number = Number(InputBox($Title,"Hãy nhập 1 số bất kỳ vào",20,' M2', 200, 100))

;~ Tính giai thừa khi số lớn hơn 0
If $Number Then
	For $i = 1 To $Number Step 1
		$GiaThua*=$i
	Next
EndIf

;~ Xuất kết quả
MsgBox(0,$Title,"Bạn đã nhập: "&$Number&@LF&"Giai thừa của nó là: "&$GiaThua)

;~ Thoát Chương Trình
Func ExitAuto()
	Exit
EndFunc