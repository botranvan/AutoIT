#include <GUIConstants.au3>

#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Sai\Desktop\Form1.kxf
$Form1 = GUICreate("Form1", 264, 101, 193, 115)
$Tab1 = GUICtrlCreateTab(8, 8, 241, 81)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$TabSheet1 = GUICtrlCreateTabItem("Cong")
$Input1 = GUICtrlCreateInput("Input1", 24, 48, 49, 21)
$Input2 = GUICtrlCreateInput("Input1", 102, 48, 49, 21)
$Input3 = GUICtrlCreateInput("Input1", 179, 48, 49, 21)
$Label1 = GUICtrlCreateLabel("+", 80, 44, 16, 28)
GUICtrlSetFont(-1, 14, 800, 0, "MS Sans Serif")
$Label2 = GUICtrlCreateLabel("=", 159, 44, 16, 28)
GUICtrlSetFont(-1, 14, 800, 0, "MS Sans Serif")

$TabSheet2 = GUICtrlCreateTabItem("Tru")
$Input4 = GUICtrlCreateInput("Input1", 29, 43, 49, 21)
$Label3 = GUICtrlCreateLabel("-", 85, 39, 11, 28)
GUICtrlSetFont(-1, 14, 800, 0, "MS Sans Serif")
$Input5 = GUICtrlCreateInput("Input1", 107, 43, 49, 21)
$Label4 = GUICtrlCreateLabel("=", 164, 39, 16, 28)
GUICtrlSetFont(-1, 14, 800, 0, "MS Sans Serif")
$Input6 = GUICtrlCreateInput("Input1", 184, 43, 49, 21)
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
	KQCongSet(GUICtrlRead($Input1) + GUICtrlRead($Input2))
	KQTruSet(GUICtrlRead($Input4) - GUICtrlRead($Input5))
WEnd

Func KQCongSet($Data)
	Local $old = GUICtrlRead($Input3)
	If $Data <> $old Then GUICtrlSetData($Input3,$Data)
EndFunc
	
Func KQTruSet($Data)
	Local $old = GUICtrlRead($Input6)
	If $Data <> $old Then GUICtrlSetData($Input6,$Data)
EndFunc