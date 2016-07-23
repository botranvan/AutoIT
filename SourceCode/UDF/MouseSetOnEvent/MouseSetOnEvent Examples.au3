#include <MouseSetOnEvent_UDF.au3>
#include <GuiConstants.au3>

_Example_Intro()
_Example_Limit_Window()

Func _Example_Limit_Window()
	Local $hGUI = GUICreate("MouseSetOnEvent_UDF Example - Limit on specific window")
	
	GUICtrlCreateLabel("Try to click on that specific GUI window", 40, 40, 300, 30)
	GUICtrlSetFont(-1, 12, 800)
	
	GUICtrlCreateLabel("Press ESC to exit", 10, 10)
	
	GUISetState()
	
	;A little(?) buggy when you mix different events :(
	
	_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "MousePrimaryDown_Event", "", "", $hGUI)
	;_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT, "MouseSecondaryUp_Event", "", "", $hGUI)
	
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $GUI_EVENT_PRIMARYDOWN
				MsgBox(0, "", "Should be shown ;)")
		EndSwitch
	WEnd
	
	_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT)
	;_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT)
EndFunc

Func _Example_Intro()
	;Disable Primary mouse button *down*, and call our function when mouse button *down* event is recieved
	_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "MousePrimaryDown_Event")
	Sleep(5000)
	_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT) ;Enable mouse button back.

	MsgBox(64, "Attention!", _
		"Now we disable Secondary mouse button up, and call our function when mouse button up event is recieved.", 5)

	;Disable Secondary mouse button *up*, and call our function when mouse button *up* event is recieved
	_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT, "MouseSecondaryUp_Event")
	Sleep(5000)
	_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT) ;Enable mouse button back.
EndFunc

Func MousePrimaryDown_Event()
	ConsoleWrite("Primary Mouse Down" & @LF)
EndFunc

Func MouseSecondaryUp_Event()
	ConsoleWrite("Secondar Mouse Up" & @LF)
EndFunc
