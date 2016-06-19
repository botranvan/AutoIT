;~ Bấm vào $LAddress
Func LAddressClick()
	$IsPointer = Not $IsPointer
	If $IsPointer Then
		LAddressSet("Pointer:")
		BBackSpanSetState($GUI_DISABLE)
		BNextSpanSetState($GUI_DISABLE)
	Else
		LAddressSet("Address:")
		BBackSpanSetState($GUI_ENABLE)
		BNextSpanSetState($GUI_ENABLE)
	EndIf
EndFunc


;~ Chỉnh giá trị chuỗi của $LAddress
Func LAddressGet()
	Return GUICtrlRead($LAddress)
EndFunc
;~ Lấy giá trị từ $LAddress
Func LAddressSet($NewValue = "",$run = 0)
	Local $Check = LAddressGet()
	If $Check <> $NewValue Then GUICtrlSetData($LAddress,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LAddressRun2Left",$run)
	Else
		AdlibUnRegister("LAddressRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LAddressRun2Left()
	Local $data
	$data = LAddressGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LAddressSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LAddress
Func LAddressGetPos()
	Return ControlGetPos($MainGUI, "", $LAddress)
EndFunc
;~ Chỉnh vị trí của $LAddress
Func LAddressSetPos($x = -1,$y = -1)
	Local $Size = LAddressGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LAddress,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LAddress
Func LAddressSetSize($Width = -1,$Height = -1)
	Local $Size = LAddressGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LAddress,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LAddress
Func LAddressGetState()
	Return GUICtrlGetState($LAddress)
EndFunc
Func LAddressSetState($State = $GUI_SHOW)
	GUICtrlSetState($LAddress,$State)
EndFunc


;~ Chỉnh màu chữ của $LAddress
Func LAddressColor($Color = 0x000000)
	GUICtrlSetColor($LAddress,$Color)
EndFunc
;~ Chỉnh màu nền của $LAddress
Func LAddressBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LAddress,$Color)
EndFunc