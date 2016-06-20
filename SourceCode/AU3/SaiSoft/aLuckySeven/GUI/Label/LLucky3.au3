;~ Bấm vào $LLucky3
Func LLucky3Click()
	
EndFunc

;~ Check và UnCheck $LLucky3
Func LLucky3Check($check = 0)
	If $check == 1 Then
		LLucky3SetState($GUI_CHECKED)
	Else
		LLucky3SetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LLucky3
Func LLucky3Get()
	Return GUICtrlRead($LLucky3)
EndFunc
;~ Lấy giá trị từ $LLucky3
Func LLucky3Set($NewValue = "",$run = 0)
	Local $Check = LLucky3Get()
	If $Check <> $NewValue Then GUICtrlSetData($LLucky3,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LLucky3Run2Left",$run)
	Else
		AdlibUnRegister("LLucky3Run2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LLucky3Run2Left()
	Local $data
	$data = LLucky3Get()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LLucky3Set($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LLucky3
Func LLucky3GetPos()
	Return ControlGetPos($MainGUI, "", $LLucky3)
EndFunc
;~ Chỉnh vị trí của $LLucky3
Func LLucky3SetPos($x = -1,$y = -1)
	Local $Size = LLucky3GetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LLucky3,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LLucky3
Func LLucky3SetSize($Width = -1,$Height = -1)
	Local $Size = LLucky3GetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LLucky3,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LLucky3
Func LLucky3GetState()
	Return GUICtrlGetState($LLucky3)
EndFunc
Func LLucky3SetState($State = $GUI_SHOW)
	GUICtrlSetState($LLucky3,$State)
EndFunc


;~ Chỉnh màu chữ của $LLucky3
Func LLucky3Color($Color = 0x000000)
	GUICtrlSetColor($LLucky3,$Color)
EndFunc
;~ Chỉnh màu nền của $LLucky3
Func LLucky3BackGround($Color = 0x000000)
	GUICtrlSetBkColor($LLucky3,$Color)
EndFunc