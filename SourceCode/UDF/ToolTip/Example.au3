#include <GuiConstantsEx.au3>
#include <StaticConstants.au3>
#include "ToolTip_UDF.au3"

$hGUI = GUICreate("Custom ToolTip Demo", 300, 260)

$ListView = GUICtrlCreateListView("Items|SubItems", 10, 10, 280, 100)
_ToolTip_SetText($ListView, "Choose item", "ListView", 1)
_ToolTip_SetTextColor($ListView, 0xFF0000)
_ToolTip_SetBkColor($ListView, 0x0000FF)
_ToolTip_SetFont($ListView, 14, 400, 2, "Arial")

$Input = GUICtrlCreateInput("", 10, 130, 150, 20)
_ToolTip_SetText($Input, "Type text here", "Input", 2)
_ToolTip_SetTextColor($Input, 0x0000FF)
_ToolTip_SetBkColor($Input, 0xFF0000)
_ToolTip_SetFont($Input, 12, 400, 6, "MS Sans Serif")

$label = GUICtrlCreateLabel("Label control", 170, 130, 120, 20, $SS_CENTER)
GUICtrlSetBkColor(-1, 0xDDDDDD)
_ToolTip_SetText($label, "Read text here", "Label", 3)
_ToolTip_SetTextColor($label, 0x00FF00)
_ToolTip_SetBkColor($label, 0x808040)

$Ok_Button = GUICtrlCreateButton("Ok", 10, 170, 75, 23)
_ToolTip_SetText($Ok_Button, "Click to start", "OK Button", 7)
_ToolTip_SetTextColor($Ok_Button, 0xFFFF00)
_ToolTip_SetBkColor($Ok_Button, 0x408080)
_ToolTip_SetFont($Ok_Button, 14, 800, 4, "MS Sans Serif")

$About_Button = GUICtrlCreateButton("About", 115, 170, 75, 23)
_ToolTip_SetText($About_Button, "About program", "About", 1)
_ToolTip_SetTextColor($About_Button, 0xFF80C0)
_ToolTip_SetFont($About_Button, 16, 700, 8, "Comic Sans MS")

$Close_Button = GUICtrlCreateButton("Close", 217, 170, 75, 23)
_ToolTip_SetText($Close_Button, "Click to exit")
_ToolTip_SetTextColor($Close_Button, 0x808080)
_ToolTip_SetBkColor($Close_Button, 0xFFFFFF)

_ToolTip_SetShowTime(10000)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE, $Close_Button
			ExitLoop
	EndSwitch
WEnd