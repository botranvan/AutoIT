#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tạo 1 dòng chữ chạy hiện trong ToolTip
#ce ==========================================================

;Chuỗi mẫu
$String = "Forum AutoIT Việt "

;~ Tạo phím nóng để thoát
HotKeySet("{Esc}","ExitTool")
Func ExitTool()
	Exit
EndFunc

;~ Vòng lặp giữ chương trình hoạt động
While 1
	Sleep(270)
	$String = StringRight($String,1) & $String	;Lấy 1 ký tự bên phải bỏ vào bên trái
 	$String = StringLeft($String,StringLen($String)-1) ;Lấy toàn bộ bên trái, bỏ 1 ký tự bên phải
	tooltip($String,200,200)
WEnd
	
