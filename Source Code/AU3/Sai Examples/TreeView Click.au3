#include <GUIConstantsEx.au3>
GUICreate("", 200, 100)
GUISetBkColor(0xFFFFF)
Global $h2, $h1
;Tree gốc
$Tree = GUICtrlCreateTreeView(0, 0, 100, 100)
$1 = GUICtrlCreateTreeViewItem("1", $Tree)
$11 = GUICtrlCreateTreeViewItem("1.1", $1)
$12 = GUICtrlCreateTreeViewItem("1.2", $1)
GUISetState()


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $11
			Fun1()
		Case $12
			Fun2()

	EndSwitch
WEnd

Func Fun1()
	GUICtrlDelete($h2)
	$h1 = GUICtrlCreateButton("1111",101,10)
EndFunc

Func Fun2()
	GUICtrlDelete($h1)
	$h2 = GUICtrlCreateButton("2222",101,10)
EndFunc