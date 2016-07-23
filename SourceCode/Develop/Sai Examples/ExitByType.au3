#include <GUIConstants.au3>

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 141, 73, 193, 115)
$Input1 = GUICtrlCreateInput("Input1", 8, 8, 121, 21)
$Label1 = GUICtrlCreateLabel("Nhap chu 'Exit' de thoat", 8, 40, 123, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
	If GUICtrlRead($Input1) = "Exit" Then Exit
WEnd
