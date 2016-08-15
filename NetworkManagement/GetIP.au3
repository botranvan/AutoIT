; #NoTrayIcon
#include <MsgBoxConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates


#include <Inet.au3>

Local $sPublicIP = _GetIP()
MsgBox($MB_SYSTEMMODAL, "", "Your external IP address is: " & $sPublicIP)