;~ Các ví dụ về Run CMD
#include <GUIConstantsEx.au3>

;~ Phím nóng thoát chương trình
HotKeySet("{ESC}","ExitAuto")
Func ExitAuto()
	Exit
EndFunc

;~ Tạo 1 GUI 
$MainGUI = GUICreate("Tray Icon")
$Input = GUICtrlCreateInput("127.0.0.1",7,7)
$Button = GUICtrlCreateButton("Ping",77,34)
GUISetState()

While 1
	Sleep(7)
    $msg = GUIGetMsg()

	If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	If $msg = $Button Then PingCMD()
WEnd

Func PingCMD()
	$cmd = "ping "&GUICtrlRead($Input)
	Run("CMD.exe")
	Sleep(777)
	Send($cmd)
	send("{Enter}")
EndFunc