; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

    Opt("GUIOnEventMode", 1)

Global  $guiHandle = GUICreate("", 320, 320, Default, Default, $WS_OVERLAPPEDWINDOW)
Global  $buttonClickMe = GUICtrlCreateButton("Click Me!", 110, 135, 100, 50)
#comments-start
	OnEvent functions are only called when the option GUIOnEventMode is set to 1
	When in this mode GUIGetMsg() is NOT used at all.
	You can not call a function using parameters. In here, that is _ClickMe() Function
#comments-end
GUICtrlSetOnEvent($buttonClickMe, "_ClickMe")
GUISetState(@SW_SHOW, $guiHandle)
While True
	Sleep(10)
WEnd
Func _ClickMe()
	;code
	MsgBox($MB_APPLMODAL, "", "Clicked!")
EndFunc