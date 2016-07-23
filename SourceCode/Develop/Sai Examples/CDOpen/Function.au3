#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Chương trình đóng mở CD
#ce ==========================================================

;~ Thoát Chương Trình
HotKeySet("{ESC}","ExitTool")
Func ExitTool()
	Exit
EndFunc

;~ Dò tìm ổ CD Rom
Func ScanCDRom()
	Local $Rom = DriveGetDrive( "CDROM" )	
	If NOT @error Then
		Local $Out = $Rom[1]
		For $i = 2 to $Rom[0]
			$Out&= "|"&$Rom[$i]
		Next
		Return $Out
	Else
		MsgBox(0,"72ls.NET","Bạn không có CDRom")
		ExitTool()
	EndIf
EndFunc

Func ToogleCD($Mode)
	Local $Rom = GUICtrlRead($CDList)
	CDTray($Rom, $Mode)
EndFunc
