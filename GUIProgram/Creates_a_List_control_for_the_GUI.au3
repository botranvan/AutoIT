; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

local $guiHandle = GUICreate("", 320, 320, Default, Default, -1, $WS_EX_TRANSPARENT)
GUISetIcon("icons/ico500.ico", $guiHandle)
Local  $controlList = GUICtrlCreateList("", 5, 10, 310, 240, $LBS_NOSEL + $LBS_STANDARD)
GUICtrlSetLimit($controlList, -1, 200)
GUICtrlSetData($controlList, "This is control List")
GUICtrlSetData($controlList, "This is control List")
GUICtrlSetData($controlList, "This is control List")
GUICtrlSetData($controlList, "This is examples")
GUISetState(@SW_SHOW, $guiHandle)
While True
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd