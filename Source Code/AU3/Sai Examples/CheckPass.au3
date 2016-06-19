#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.4.0
- Chức năng: Kiểm tra Mật Khẩu để không bị Restart
#ce ==========================================================

;~ Các Include
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

;~ Các phím nóng
HotKeySet("{ESC}", 'ExitAuto')

;~ Các biến toàn cục
$Title = "72ls.net"


;~ Vòng lặp để đợi người dùng nhập mật khẩu
$Count = 7
While 1
	;~ Lấy chuỗi với 2 ký tự
	$Pass = InputBox($Title,"Hãy nhập mật khẩu vào","",'*', 200, 100)
	If $Pass = $Title Then
		ExitLoop
	Else
		$Count-=1
		If Not $Count Then
			Run('shutdown -r -f -t 9 -c "                                                                                               Bye bye"')
			Exit
		EndIf

		;~ Thông báo mật khẩu sai
		$Text = "Bạn đã nhập: "&$Pass&@LF& _
				"Mật Khẩu không đúng"&@LF& _
				"Bạn còn "&$Count&" lần nhập nữa"
		MsgBox(0,$Title,$Text)
	EndIf
WEnd

;~ Xuất kết quả
MsgBox(0,$Title,"Bạn đã nhập: "&$Pass&@LF&"Xác nhận Mật Khẩu đúng"&@LF&"Ngưng quá trình khởi động lại")

;~ Thoát Chương Trình
Func ExitAuto()
	Exit
EndFunc