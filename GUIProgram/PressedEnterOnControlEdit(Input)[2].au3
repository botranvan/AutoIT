; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

Local  $guiHandle = GUICreate("", 320, 320, 1030, 380, $WS_OVERLAPPEDWINDOW)
Local  $controlInput = GUICtrlCreateInput("", 5, 10, 310, 21*3, $ES_WANTRETURN + $ES_MULTILINE + $ES_AUTOVSCROLL + $WS_VSCROLL)

GUISetState(@SW_SHOW, $guiHandle)
While True
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd