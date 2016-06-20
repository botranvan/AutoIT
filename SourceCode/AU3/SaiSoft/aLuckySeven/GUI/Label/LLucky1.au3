;~ Bấm vào $LLucky1
Func LLucky1Click()
	 
EndFunc

;~ Check và UnCheck $LLucky1
Func LLucky1Check($check = 0)
	If $check == 1 Then
		LLucky1SetState($GUI_CHECKED)
	Else
		LLucky1SetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LLucky1
Func LLucky1Get()
	Return GUICtrlRead($LLucky1)
EndFunc
;~ Lấy giá trị từ $LLucky1
Func LLucky1Set($NewValue = "",$run = 0)
	Local $Check = LLucky1Get()
	If $Check <> $NewValue Then GUICtrlSetData($LLucky1,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LLucky1Run2Left",$run)
	Else
		AdlibUnRegister("LLucky1Run2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LLucky1Run2Left()
	Local $data
	$data = LLucky1Get()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LLucky1Set($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LLucky1
Func LLucky1GetPos()
	Return ControlGetPos($MainGUI, "", $LLucky1)
EndFunc
;~ Chỉnh vị trí của $LLucky1
Func LLucky1SetPos($x = -1,$y = -1)
	Local $Size = LLucky1GetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LLucky1,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LLucky1
Func LLucky1SetSize($Width = -1,$Height = -1)
	Local $Size = LLucky1GetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LLucky1,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LLucky1
Func LLucky1GetState()
	Return GUICtrlGetState($LLucky1)
EndFunc
Func LLucky1SetState($State = $GUI_SHOW)
	GUICtrlSetState($LLucky1,$State)
EndFunc


;~ Chỉnh màu chữ của $LLucky1
Func LLucky1Color($Color = 0x000000)
	GUICtrlSetColor($LLucky1,$Color)
EndFunc
;~ Chỉnh màu nền của $LLucky1
Func LLucky1BackGround($Color = 0x000000)
	GUICtrlSetBkColor($LLucky1,$Color)
EndFunc