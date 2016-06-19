#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

$ShowSetting = False ;Biến kiểm tra xem Setting có hiển thị kông

;~ Tạo giao diện chính
$GUI_main = GUICreate("Main", 316, 248, 6, 267)
GUISetBkColor(0xFFFFFF)
$Bt_start = GUICtrlCreateButton("Start", 17, 219, 75, 25)
$Bt_setting = GUICtrlCreateButton("Setting", 122, 219, 75, 25)
$Bt_exit = GUICtrlCreateButton("Exit", 224, 219, 75, 25)
GUISetState(@SW_SHOW)

;~ Tạo giao diện cho Setting
$GUI_setting = GUICreate("Setting", 315, 304, 329, 268, -1, $WS_EX_TOOLWINDOW)
GUISetBkColor(0xFFFBF0)
GUICtrlCreateGroup("", 8, 1, 297, 209)
$Bt_Save = GUICtrlCreateButton("Save Setting", 25, 219, 75, 25, 0)
$Bt_Back = GUICtrlCreateButton("Back", 218, 219, 75, 25, 0)

Func Setting()
	$ShowSetting = Not $ShowSetting
	If $ShowSetting Then 
		GUISetState(@SW_SHOW)
	Else
		GUISetState(@SW_HIDE)
	EndIf
EndFunc

While 1
$Msg = GUIGetMsg(1) ;Dùng chế độ nâng cao
Select
	Case $Msg[0] = $Bt_Setting
		Setting()
	Case $Msg[0] = $Bt_Back
		Setting()
	Case $Msg[0] = $GUI_EVENT_CLOSE And $Msg[1] = $GUI_setting ;Dùng Handle để nhận dạng Window
		Setting()
	Case $Msg[0] = $GUI_EVENT_CLOSE And $Msg[1] = $GUI_main
		Exit
EndSelect
WEnd