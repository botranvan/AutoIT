
;~ Chỉnh giá trị chuỗi của $TMain
Func TMainGet()
	Return GUICtrlRead($TMain)
EndFunc
;~ Lấy giá trị từ $TMain
Func TMainSet($NewValue = "")
	Local $Check = TMainGet()
	If $Check <> $NewValue Then GUICtrlSetData($TMain,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $TMain
Func TMainGetPos()
	Return ControlGetPos($MainGUI, "", $TMain)
EndFunc
;~ Chỉnh vị trí của $TMain
Func TMainSetPos($x = -1,$y = -1)
	Local $Size = TMainGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($TMain,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $TMain
Func TMainSetSize($Width = -1,$Height = -1)
	Local $Size = TMainGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($TMain,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $TMain
Func TMainGetState()
	Return GUICtrlGetState($TMain)
EndFunc
Func TMainSetState($State = $GUI_SHOW)
	GUICtrlSetState($TMain,$State)
EndFunc


;~ Chỉnh màu chữ của $TMain
Func TMainColor($Color = 0x000000)
	GUICtrlSetColor($TMain,$Color)
EndFunc
;~ Chỉnh màu nền của $TMain
Func TMainBackGround($Color = 0x000000)
	GUICtrlSetBkColor($TMain,$Color)
EndFunc