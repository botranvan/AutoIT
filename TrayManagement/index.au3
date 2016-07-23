; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>
#include <TrayConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

While True
	Sleep(10000)
WEnd

