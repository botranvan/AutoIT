; #NoTrayIcon
#include <MsgBoxConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates


HotKeySet("a", "_SendKey")
Func _SendKey()
	While True
		Send("f")
	WEnd
EndFunc

Func Wait()
	While True
		Sleep(100)
	WEnd
EndFunc

Wait()