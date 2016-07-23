; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

GUICreate("", 320, 320, -1, -1, $WS_OVERLAPPEDWINDOW)
GUISetBkColor(0x00E0FFFF)
GUICtrlCreateLabel("Slider", 5, 10)
Local  $controlSlider = GUICtrlCreateSlider(5, 30, 310, 20, $TBS_AUTOTICKS)
GUICtrlSetLimit($controlSlider, 100, 0)
GUICtrlCreateLabel("Updown", 5, 50)
Local $controlInput = GUICtrlCreateInput("3", 5, 70)
Local $controlUpdown = GUICtrlCreateUpdown($controlInput, $UDS_ARROWKEYS)
GUICtrlSetLimit($controlUpdown, 100, 0)
GUISetState(@SW_SHOW)
While True
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd