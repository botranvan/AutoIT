#pragma compile(Compatibility, win81)
#pragma compile(Compression, 9)
#pragma compile(ExecLevel,highestAvailable)
#pragma compile(Fileversion, 1.0.0.1)
#pragma compile(FileDescription, No Virus)
#pragma compile(Icon, source/icons/script.ico)
#pragma compile(LegalCopyright, Researcher)
#pragma compile(OriginalFilename, Constructor)
#pragma compile(ProductName, Beta.Version)
#pragma compile(ProductVersion, 1.0)
; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

Local  $guiHandle = GUICreate("AutoIT", 320, 320, Default, Default, $WS_CAPTION, $WS_EX_TRANSPARENT)
Local  $comboDay = GUICtrlCreateCombo("Day", 5, 20, 50, 20, $CBS_DROPDOWN + $WS_VSCROLL, $WS_EX_CLIENTEDGE)
; Add additional items to the combobox

; GUICtrlSetData($comboDay, "01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31", "Day")

GUICtrlSetData($comboDay, "1|2|3|4|5|6|7|8|9|10", "Day")
GUICtrlSetData($comboDay, "11|12|13|14|15|16|17|18|19|20", "Day")
GUICtrlSetData($comboDay, "21|22|23|24|25|26|27|28|29|30", "Day")
GUICtrlSetData($comboDay, "31", "Day")


GUISetState(@SW_SHOW, $guiHandle)
While True
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

; For $i = 1 To 31
; 	If Mod($i, 10) == 0 Then
; 		ConsoleWrite($i & @CRLF)
; 	Else
; 		ConsoleWrite($i & "|")
; 	EndIf
; Next