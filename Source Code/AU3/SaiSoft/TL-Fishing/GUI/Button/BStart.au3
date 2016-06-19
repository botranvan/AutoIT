;~ Bấm vào $BStart
Func BStartClick()
	$Fishing = Not $Fishing
	If $Fishing Then
		BStartSet("Ngưng câu")
	Else
		BStartSet("Bắt đầu")
	EndIf
	
EndFunc

;~ Check và UnCheck $BStart
Func BStartCheck($check = 0)
	If $check == 1 Then
		BStartSetState($GUI_CHECKED)
	Else
		BStartSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $BStart
Func BStartGet()
	Return GUICtrlRead($BStart)
EndFunc
;~ Lấy giá trị từ $BStart
Func BStartSet($NewValue = "")
	Local $Check = BStartGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStart,$NewValue)
EndFunc
;~ Gán ToolTip cho $BStart
Func BStartSetTip($NewValue = "")
	Return GUICtrlSetTip($BStart, $NewValue)	
EndFunc	



;~ Lấy vị trí và kích thước của $BStart
Func BStartGetPos()
	Return ControlGetPos($MainGUI, "", $BStart)
EndFunc
;~ Chỉnh vị trí của $BStart
Func BStartSetPos($x = -1,$y = -1)
	Local $Size = BStartGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStart,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStart
Func BStartSetSize($Width = -1,$Height = -1)
	Local $Size = BStartGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStart,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStart
Func BStartGetState()
	Return GUICtrlGetState($BStart)
EndFunc
Func BStartSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStart,$State)
EndFunc


;~ Chỉnh màu chữ của $BStart
Func BStartColor($Color = 0x000000)
	GUICtrlSetColor($BStart,$Color)
EndFunc
;~ Chỉnh màu nền của $BStart
Func BStartBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStart,$Color)
EndFunc