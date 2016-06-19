;~ Bấm vào $RCapMod2
Func RCapMod2Click()
	$CapMod = 2
	FCapModSave()
EndFunc

;~ Check và UnCheck $RCapMod2
Func RCapMod2Check($check = 0)
	If $check == 1 Then
		RCapMod2SetState($GUI_CHECKED)
	Else
		RCapMod2SetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $RCapMod2
Func RCapMod2Get()
	Return GUICtrlRead($RCapMod2)
EndFunc
;~ Lấy giá trị từ $RCapMod2
Func RCapMod2Set($NewValue = "",$run = 150)
	Local $Check = RCapMod2Get()
	If $Check <> $NewValue Then GUICtrlSetData($RCapMod2,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("RCapMod2Run2Left",$run)
	Else
		AdlibUnRegister("RCapMod2Run2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func RCapMod2Run2Left()
	Local $data
	$data = RCapMod2Get()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	RCapMod2Set($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $RCapMod2
Func RCapMod2GetPos()
	Return ControlGetPos($MainGUI, "", $RCapMod2)
EndFunc
;~ Chỉnh vị trí của $RCapMod2
Func RCapMod2SetPos($x = -1,$y = -1)
	Local $Size = RCapMod2GetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($RCapMod2,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $RCapMod2
Func RCapMod2SetSize($Width = -1,$Height = -1)
	Local $Size = RCapMod2GetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($RCapMod2,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $RCapMod2
Func RCapMod2GetState()
	Return GUICtrlGetState($RCapMod2)
EndFunc
Func RCapMod2SetState($State = $GUI_SHOW)
	GUICtrlSetState($RCapMod2,$State)
EndFunc


;~ Chỉnh màu chữ của $RCapMod2
Func RCapMod2Color($Color = 0x000000)
	GUICtrlSetColor($RCapMod2,$Color)
EndFunc
;~ Chỉnh màu nền của $RCapMod2
Func RCapMod2BackGround($Color = 0x000000)
	GUICtrlSetBkColor($RCapMod2,$Color)
EndFunc