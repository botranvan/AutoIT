;~ Bấm vào $CBProcessList
Func CBProcessListChange()
	$ProcessName = CBProcessListGet()
	IniWrite($DataFileName,"GUI","$ProcessName",$ProcessName)
	msgbox(0,"72ls.net",$ProcessName)
EndFunc

;~ Thêm 1 string vào $CBProcessList
Func CBProcessListSelect($NewValue = "")
	Local $Check = CBProcessListGet()
	If $Check <> $NewValue Then GUICtrlSetData($CBProcessList,$NewValue)
	Return _GUICtrlComboBox_SelectString($CBProcessList,$NewValue)
EndFunc

;~ Thêm 1 string vào $CBProcessList
Func CBProcessListAdd($String)
	Return _GUICtrlComboBox_AddString($CBProcessList,$String)
EndFunc

;~ Thêm 1 string vào $CBProcessList
Func CBProcessListIndexGet()
	Return _GUICtrlComboBox_GetCurSel($CBProcessList)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBProcessList
Func CBProcessListGet()
	Return GUICtrlRead($CBProcessList)
EndFunc
;~ Lấy giá trị từ $CBProcessList
Func CBProcessListSet($NewValue = "",$run = 0)
	Local $Check = CBProcessListGet()
	If $Check <> $NewValue Then GUICtrlSetData($CBProcessList,$NewValue)
EndFunc
	
;~ Lấy vị trí và kích thước của $CBProcessList
Func CBProcessListGetPos()
	Return ControlGetPos($MainGUI, "", $CBProcessList)
EndFunc
;~ Chỉnh vị trí của $CBProcessList
Func CBProcessListSetPos($x = -1,$y = -1)
	Local $Size = CBProcessListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CBProcessList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CBProcessList
Func CBProcessListSetSize($Width = -1,$Height = -1)
	Local $Size = CBProcessListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CBProcessList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CBProcessList
Func CBProcessListGetState()
	Return GUICtrlGetState($CBProcessList)
EndFunc
Func CBProcessListSetState($State = $GUI_SHOW)
	GUICtrlSetState($CBProcessList,$State)
EndFunc


;~ Chỉnh màu chữ của $CBProcessList
Func CBProcessListColor($Color = 0x000000)
	GUICtrlSetColor($CBProcessList,$Color)
EndFunc
;~ Chỉnh màu nền của $CBProcessList
Func CBProcessListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CBProcessList,$Color)
EndFunc