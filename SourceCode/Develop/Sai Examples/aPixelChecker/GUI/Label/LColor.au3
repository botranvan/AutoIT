;~ Bấm vào $LColor
Func LColorClick()
	
EndFunc

;~ Check và UnCheck $LColor
Func LColorCheck($check = 0)
	If $check == 1 Then
		LColorSetState($GUI_CHECKED)
	Else
		LColorSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LColor
Func LColorGet()
	Return GUICtrlRead($LColor)
EndFunc
;~ Lấy giá trị từ $LColor
Func LColorSet($NewValue = "",$run = 0)
	Local $Check = LColorGet()
	If $Check <> $NewValue Then GUICtrlSetData($LColor,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LColorRun2Left",$run)
	Else
		AdlibUnRegister("LColorRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LColorRun2Left()
	Local $data
	$data = LColorGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LColorSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LColor
Func LColorGetPos()
	Return ControlGetPos($MainGUI, "", $LColor)
EndFunc
;~ Chỉnh vị trí của $LColor
Func LColorSetPos($x = -1,$y = -1)
	Local $Size = LColorGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LColor,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LColor
Func LColorSetSize($Width = -1,$Height = -1)
	Local $Size = LColorGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LColor,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LColor
Func LColorGetState()
	Return GUICtrlGetState($LColor)
EndFunc
Func LColorSetState($State = $GUI_SHOW)
	GUICtrlSetState($LColor,$State)
EndFunc


;~ Chỉnh màu chữ của $LColor
Func LColorColor($Color = 0x000000)
	GUICtrlSetColor($LColor,$Color)
EndFunc
;~ Chỉnh màu nền của $LColor
Func LColorBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LColor,$Color)
EndFunc












