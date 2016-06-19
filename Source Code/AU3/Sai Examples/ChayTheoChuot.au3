#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tạo 1 dòng chữ chạy hiện trong ToolTip chạy theo chuột
#ce ==========================================================

;Chuỗi mẫu
$String = "Forum AutoIT Việt "

;~ Tạo phím nóng để thoát
HotKeySet("{Esc}","ExitTool")
Func ExitTool()
	Exit
EndFunc

;~ Khởi động thời gian chạy chữ
$Stat = TimerInit()

;~ Vòng lặp giữ chương trình hoạt động
While 1
	Sleep(9)
	
	If TimerDiff($Stat) > 270 Then
		$String = StringRight($String,1) & $String	;Lấy 1 ký tự bên phải bỏ vào bên trái
		$String = StringLeft($String,StringLen($String)-1) ;Lấy toàn bộ bên trái, bỏ 1 ký tự bên phải
		$Stat = TimerInit()
	EndIf
	
	$Mouse = MouseGetPos()
	tooltip($String,$Mouse[0]+16,$Mouse[1]+16)
WEnd
	
