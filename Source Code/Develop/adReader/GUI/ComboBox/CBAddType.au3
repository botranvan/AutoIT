;~ Bấm vào $CBAddType
Func CBAddTypeChange()
	$DataType = CBAddTypeGet()
EndFunc

;~ Thêm 1 string vào $CBAddType
Func CBAddTypeAdd($String)
	Return _GUICtrlComboBox_AddString($CBAddType,$String)
EndFunc

;~ Thêm 1 string vào $CBAddType
Func CBAddTypeIndexGet()
	Return _GUICtrlComboBox_GetCurSel($CBAddType)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBAddType
Func CBAddTypeGet()
	Return GUICtrlRead($CBAddType)
EndFunc
;~ Lấy giá trị từ $CBAddType
Func CBAddTypeSet($NewValue = "",$run = 0)
	Local $Check = CBAddTypeGet()
	If $Check <> $NewValue Then GUICtrlSetData($CBAddType,$NewValue)
EndFunc
	
;~ Lấy vị trí và kích thước của $CBAddType
Func CBAddTypeGetPos()
	Return ControlGetPos($MainGUI, "", $CBAddType)
EndFunc
;~ Chỉnh vị trí của $CBAddType
Func CBAddTypeSetPos($x = -1,$y = -1)
	Local $Size = CBAddTypeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CBAddType,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CBAddType
Func CBAddTypeSetSize($Width = -1,$Height = -1)
	Local $Size = CBAddTypeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CBAddType,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CBAddType
Func CBAddTypeGetState()
	Return GUICtrlGetState($CBAddType)
EndFunc
Func CBAddTypeSetState($State = $GUI_SHOW)
	GUICtrlSetState($CBAddType,$State)
EndFunc


;~ Chỉnh màu chữ của $CBAddType
Func CBAddTypeColor($Color = 0x000000)
	GUICtrlSetColor($CBAddType,$Color)
EndFunc
;~ Chỉnh màu nền của $CBAddType
Func CBAddTypeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CBAddType,$Color)
EndFunc