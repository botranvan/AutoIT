; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

Local  $guiHandle = GUICreate("", 320, 320, 1030, 380, $WS_OVERLAPPEDWINDOW)
GUISetIcon("..\icons\ico500.ico", $guiHandle)
Local  $controlListview = GUICtrlCreateListView("   ID   |   Username 	|   Password 	|   Email   ", -1, -1, 320, 320)	; Creates a ListView control for the GUI

Local  $controlListViewItem1 = GUICtrlCreateListViewItem("1|dragon|123456|abc.xyz@yahoo.com", $controlListview)
Local $controlListViewItem2 = GUICtrlCreateListViewItem("2|sandy|thisispass", $controlListview)
Local $controlListViewItem3 = GUICtrlCreateListViewItem("3|ricky|password", $controlListview)

Local  $controlListViewItemInput = GUICtrlCreateListViewItem("null", $controlListview)

GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; to allow drag and dropping
GUISetState(@SW_SHOW)
GUICtrlSetData($controlListViewItem2, "|SanDy") ; Default insert data on col11
GUICtrlSetData($controlListViewItem3, "||PaSswOrD") ; If you want insert insert into any colum then use |
; GUICtrlDelete($controlListViewItem1) ; Delete a control ListView Item

GUISetState(@SW_SHOW, $guiHandle)
While True
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd