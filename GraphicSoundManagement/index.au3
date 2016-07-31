; #NoTrayIcon
#include <MsgBoxConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

; Local  $count = 0

; Do 
; 	$count = $count + 2
; 	Beep(809, 500) ; Plays back a beep to the user.
; 	Sleep(100)
; Until $count > 10

; Local  $checksum = PixelChecksum(0, 0, 100, 100) ; Generates a checksum for a region of pixels

; While $checksum = PixelChecksum(0, 0, 100, 100)
; 	Sleep(100)
; WEnd

; MsgBox($MB_APPLMODAL, "", "Something in the region has changed")

