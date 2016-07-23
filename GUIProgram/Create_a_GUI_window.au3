; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

Local  $guiHandle = GUICreate("Form", 320, 320, Default, Default, BitOR($WS_MINIMIZEBOX, $WS_SYSMENU)) ; Create a GUI window.
GUISetIcon("..\icons\ico500.ico", $guiHandle)	; Sets the icon used in a GUI window
GUICtrlCreateGroup("Informations", 5, 10, 310, Default, $WS_GROUP, $WS_EX_TRANSPARENT)	; Creates a Group control for the GUI
GUICtrlCreateLabel("Username: ", 10, 35, Default, Default, $SS_LEFT)	; Creates a static Label control for the GUI
GUICtrlCreateInput("",80, 30, 230, Default, $ES_CENTER, $WS_EX_CLIENTEDGE)	; Creates an Input control for the GUI
GUICtrlCreateLabel("Date of birth: ", 10, 70)
GUICtrlCreateDate("", 80, 65, 230, Default, $DTS_LONGDATEFORMAT)	; Creates a date control for the GUI
GUICtrlCreateLabel("Sex: ", 10, 100)
GUICtrlCreateRadio("Male", 80, 95)	; Creates a Radio button control for the GUI
GUICtrlCreateRadio("Female", 160, 95)
GUICtrlCreateLabel("Email: ", 10, 130)
GUICtrlCreateInput("", 80, 125, 230, Default,$ES_CENTER, $WS_EX_CLIENTEDGE)
GUICtrlCreateGroup("", -99, -99, 1, 1) ; Closed group



GUICtrlCreateCheckbox("Remember me.", 120, 200)		; Creates a Checkbox control for the GUI
GUICtrlCreateButton("Send", 60, 220, 80, 20, $WS_EX_OVERLAPPEDWINDOW)	; Creates a Button control for the GUI
Local $buttonDiscard = GUICtrlCreateButton("Discard", 180, 220, 80, 20, $WS_EX_OVERLAPPEDWINDOW)

GUISetState(@SW_SHOW, $guiHandle) ; Important to GUI is enable

While True
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $buttonDiscard
			GUIDelete($guiHandle) ; Deletes a control.
	EndSwitch
WEnd

GUIDelete($guiHandle)