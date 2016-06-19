;~ Bấm vào $LLucky2
Func LLucky2Click()
	
EndFunc

;~ Check và UnCheck $LLucky2
Func LLucky2Check($check = 0)
	If $check == 1 Then
		LLucky2SetState($GUI_CHECKED)
	Else
		LLucky2SetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LLucky2
Func LLucky2Get()
	Return GUICtrlRead($LLucky2)
EndFunc
;~ Lấy giá trị từ $LLucky2
Func LLucky2Set($NewValue = "",$run = 0)
	Local $Check = LLucky2Get()
	If $Check <> $NewValue Then GUICtrlSetData($LLucky2,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LLucky2Run2Left",$run)
	Else
		AdlibUnRegister("LLucky2Run2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LLucky2Run2Left()
	Local $data
	$data = LLucky2Get()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LLucky2Set($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LLucky2
Func LLucky2GetPos()
	Return ControlGetPos($MainGUI, "", $LLucky2)
EndFunc
;~ Chỉnh vị trí của $LLucky2
Func LLucky2SetPos($x = -1,$y = -1)
	Local $Size = LLucky2GetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LLucky2,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LLucky2
Func LLucky2SetSize($Width = -1,$Height = -1)
	Local $Size = LLucky2GetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LLucky2,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LLucky2
Func LLucky2GetState()
	Return GUICtrlGetState($LLucky2)
EndFunc
Func LLucky2SetState($State = $GUI_SHOW)
	GUICtrlSetState($LLucky2,$State)
EndFunc


;~ Chỉnh màu chữ của $LLucky2
Func LLucky2Color($Color = 0x000000)
	GUICtrlSetColor($LLucky2,$Color)
EndFunc
;~ Chỉnh màu nền của $LLucky2
Func LLucky2BackGround($Color = 0x000000)
	GUICtrlSetBkColor($LLucky2,$Color)
EndFunc