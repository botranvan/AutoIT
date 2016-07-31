; #NoTrayIcon
#include <MsgBoxConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates


Local  $getData = ClipGet() ; Retrieves text from the clipboard
; Local  $setData = ClipPut(value) ; Write text to the cilipboard
	; MsgBox($MB_APPLMODAL, "", $getData)

Local  $varEnv = EnvGet("PATH") ; Retrieves an env var
; Local  $setEnv = EnvSet(envvariable, "[value]") ; Write an env var
; EnvUpdate() ; Refresh the OS env after write an anv var
	; MsgBox($MB_APPLMODAL, "", $varEnv)

Local  $memEnable = MemGetStats() ;Retrieves memory related information
	#comments-start
	Returns a seven-element array containing the memory information:
	$aArray[0] = Memory Load (Percentage of memory in use)
	$aArray[1] = Total physical RAM
	$aArray[2] = Available physical RAM
	$aArray[3] = Total Pagefile
	$aArray[4] = Available Pagefile
	$aArray[5] = Total virtual
	$aArray[6] = Available virtual

	All memory sizes are in kilobytes
	#comments-end
MsgBox($MB_APPLMODAL, "", $memEnable[5])