; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

