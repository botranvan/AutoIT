;~ Bấm vào $RCapMod1
Func RCapMod1Click()
	$CapMod = 1
	FCapModSave()
EndFunc

;~ Check và UnCheck $RCapMod1
Func RCapMod1Check($check = 0)
	If $check == 1 Then
		RCapMod1SetState($GUI_CHECKED)
	Else
		RCapMod1SetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $RCapMod1
Func RCapMod1Get()
	Return GUICtrlRead($RCapMod1)
EndFunc
;~ Lấy giá trị từ $RCapMod1
Func RCapMod1Set($NewValue = "",$run = 150)
	Local $Check = RCapMod1Get()
	If $Check <> $NewValue Then GUICtrlSetData($RCapMod1,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("RCapMod1Run2Left",$run)
	Else
		AdlibUnRegister("RCapMod1Run2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func RCapMod1Run2Left()
	Local $data
	$data = RCapMod1Get()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	RCapMod1Set($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $RCapMod1
Func RCapMod1GetPos()
	Return ControlGetPos($MainGUI, "", $RCapMod1)
EndFunc
;~ Chỉnh vị trí của $RCapMod1
Func RCapMod1SetPos($x = -1,$y = -1)
	Local $Size = RCapMod1GetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($RCapMod1,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $RCapMod1
Func RCapMod1SetSize($Width = -1,$Height = -1)
	Local $Size = RCapMod1GetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($RCapMod1,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $RCapMod1
Func RCapMod1GetState()
	Return GUICtrlGetState($RCapMod1)
EndFunc
Func RCapMod1SetState($State = $GUI_SHOW)
	GUICtrlSetState($RCapMod1,$State)
EndFunc


;~ Chỉnh màu chữ của $RCapMod1
Func RCapMod1Color($Color = 0x000000)
	GUICtrlSetColor($RCapMod1,$Color)
EndFunc
;~ Chỉnh màu nền của $RCapMod1
Func RCapMod1BackGround($Color = 0x000000)
	GUICtrlSetBkColor($RCapMod1,$Color)
EndFunc