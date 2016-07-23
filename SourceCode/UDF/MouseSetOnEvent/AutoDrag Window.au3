#include <MouseSetOnEvent_UDF.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)

$Form1 = GUICreate("Form1", 431, 37, 193, 125)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

$Label1 = GUICtrlCreateLabel("Label1", 8, 8, 452, 22)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")

GUISetState(@SW_SHOW)

_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "_Downleft", "", "", $Form1, -1)
_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "_Upleft", "", "", $Form1, -1)

While 1
	Sleep(10)
WEnd

Func _Exit()
	Exit
EndFunc

Func _Downleft()
	GUICtrlSetData($Label1, "Mouse Left Down")
	
	Return 0 ;Do not Block the default processing
EndFunc

Func _Upleft()
	GUICtrlSetData($Label1, "Mouse Left Up - Drag the window and press ENTER")
	
	Return 1 ;Block the default processing
EndFunc
