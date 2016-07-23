;~ Bấm vào $LPixel
Func LPixelClick()
	
EndFunc

;~ Check và UnCheck $LPixel
Func LPixelCheck($check = 0)
	If $check == 1 Then
		LPixelSetState($GUI_CHECKED)
	Else
		LPixelSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LPixel
Func LPixelGet()
	Return GUICtrlRead($LPixel)
EndFunc
;~ Lấy giá trị từ $LPixel
Func LPixelSet($NewValue = "",$run = 0)
	Local $Check = LPixelGet()
	If $Check <> $NewValue Then GUICtrlSetData($LPixel,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LPixelRun2Left",$run)
	Else
		AdlibUnRegister("LPixelRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LPixelRun2Left()
	Local $data
	$data = LPixelGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LPixelSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LPixel
Func LPixelGetPos()
	Return ControlGetPos($MainGUI, "", $LPixel)
EndFunc
;~ Chỉnh vị trí của $LPixel
Func LPixelSetPos($x = -1,$y = -1)
	Local $Size = LPixelGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LPixel,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LPixel
Func LPixelSetSize($Width = -1,$Height = -1)
	Local $Size = LPixelGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LPixel,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LPixel
Func LPixelGetState()
	Return GUICtrlGetState($LPixel)
EndFunc
Func LPixelSetState($State = $GUI_SHOW)
	GUICtrlSetState($LPixel,$State)
EndFunc


;~ Chỉnh màu chữ của $LPixel
Func LPixelColor($Color = 0x000000)
	GUICtrlSetColor($LPixel,$Color)
EndFunc
;~ Chỉnh màu nền của $LPixel
Func LPixelBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LPixel,$Color)
EndFunc