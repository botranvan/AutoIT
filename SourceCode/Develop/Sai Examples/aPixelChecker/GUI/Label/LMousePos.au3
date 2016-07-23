;~ Bấm vào $LMousePos
Func LMousePosClick()
	
EndFunc

;~ Check và UnCheck $LMousePos
Func LMousePosCheck($check = 0)
	If $check == 1 Then
		LMousePosSetState($GUI_CHECKED)
	Else
		LMousePosSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LMousePos
Func LMousePosGet()
	Return GUICtrlRead($LMousePos)
EndFunc
;~ Lấy giá trị từ $LMousePos
Func LMousePosSet($NewValue = "",$run = 0)
	Local $Check = LMousePosGet()
	If $Check <> $NewValue Then GUICtrlSetData($LMousePos,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LMousePosRun2Left",$run)
	Else
		AdlibUnRegister("LMousePosRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LMousePosRun2Left()
	Local $data
	$data = LMousePosGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LMousePosSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LMousePos
Func LMousePosGetPos()
	Return ControlGetPos($MainGUI, "", $LMousePos)
EndFunc
;~ Chỉnh vị trí của $LMousePos
Func LMousePosSetPos($x = -1,$y = -1)
	Local $Size = LMousePosGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LMousePos,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LMousePos
Func LMousePosSetSize($Width = -1,$Height = -1)
	Local $Size = LMousePosGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LMousePos,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LMousePos
Func LMousePosGetState()
	Return GUICtrlGetState($LMousePos)
EndFunc
Func LMousePosSetState($State = $GUI_SHOW)
	GUICtrlSetState($LMousePos,$State)
EndFunc


;~ Chỉnh màu chữ của $LMousePos
Func LMousePosColor($Color = 0x000000)
	GUICtrlSetColor($LMousePos,$Color)
EndFunc
;~ Chỉnh màu nền của $LMousePos
Func LMousePosBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LMousePos,$Color)
EndFunc