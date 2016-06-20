;~ Bấm vào $CHCapCursor
Func CHCapCursorClick()
	If CHCapCursorGet() == 1 Then $CapCur = 1
	If CHCapCursorGet() == 4 Then $CapCur = 0
EndFunc

;~ Check và UnCheck $CHCapCursor
Func CHCapCursorCheck($check = 0)
	If $check == 1 Then
		CHCapCursorSetState($GUI_CHECKED)
	Else
		CHCapCursorSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $CHCapCursor
Func CHCapCursorGet()
	Return GUICtrlRead($CHCapCursor)
EndFunc
;~ Lấy giá trị từ $CHCapCursor
Func CHCapCursorSet($NewValue = "",$run = 150)
	Local $Check = CHCapCursorGet()
	If $Check <> $NewValue Then
		GUICtrlSetData($CHCapCursor,$NewValue)
	EndIf
	If $NewValue Then
		If $run > 0 Then AdlibRegister("CHCapCursorRun2Left",$run)
	Else
		AdlibUnRegister("CHCapCursorRun2Left")	
	EndIf
	
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func CHCapCursorRun2Left()
	Local $data
	$data = CHCapCursorGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	CHCapCursorSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $CHCapCursor
Func CHCapCursorGetPos()
	Return ControlGetPos($MainGUI, "", $CHCapCursor)
EndFunc
;~ Chỉnh vị trí của $CHCapCursor
Func CHCapCursorSetPos($x = -1,$y = -1)
	Local $Size = CHCapCursorGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHCapCursor,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHCapCursor
Func CHCapCursorSetSize($Width = -1,$Height = -1)
	Local $Size = CHCapCursorGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHCapCursor,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHCapCursor
Func CHCapCursorGetState()
	Return GUICtrlGetState($CHCapCursor)
EndFunc
Func CHCapCursorSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHCapCursor,$State)
EndFunc


;~ Chỉnh màu chữ của $CHCapCursor
Func CHCapCursorColor($Color = 0x000000)
	GUICtrlSetColor($CHCapCursor,$Color)
EndFunc
;~ Chỉnh màu nền của $CHCapCursor
Func CHCapCursorBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHCapCursor,$Color)
EndFunc