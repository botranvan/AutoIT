;~ Bấm vào $BBackSpan
Func BBackSpanClick()
	$AddressStart = IAddressStartGet()
	$AddressStart = Hex(Dec($AddressStart) - IAddressSpanGet()*$SpanTime,8)
	IAddressStartSet($AddressStart)
	IAddressStartChange()
EndFunc


;~ Chỉnh giá trị chuỗi của $BBackSpan
Func BBackSpanGet()
	Return GUICtrlRead($BBackSpan)
EndFunc
;~ Lấy giá trị từ $BBackSpan
Func BBackSpanSet($NewValue = "",$run = 0)
	Local $Check = BBackSpanGet()
	If $Check <> $NewValue Then GUICtrlSetData($BBackSpan,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BBackSpanRun2Left",$run)
	Else
		AdlibUnRegister("BBackSpanRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BBackSpanRun2Left()
	Local $data
	$data = BBackSpanGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BBackSpanSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BBackSpan
Func BBackSpanGetPos()
	Return ControlGetPos($MainGUI, "", $BBackSpan)
EndFunc
;~ Chỉnh vị trí của $BBackSpan
Func BBackSpanSetPos($x = -1,$y = -1)
	Local $Size = BBackSpanGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BBackSpan,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BBackSpan
Func BBackSpanSetSize($Width = -1,$Height = -1)
	Local $Size = BBackSpanGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BBackSpan,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BBackSpan
Func BBackSpanGetState()
	Return GUICtrlGetState($BBackSpan)
EndFunc
Func BBackSpanSetState($State = $GUI_SHOW)
	GUICtrlSetState($BBackSpan,$State)
EndFunc


;~ Chỉnh màu chữ của $BBackSpan
Func BBackSpanColor($Color = 0x000000)
	GUICtrlSetColor($BBackSpan,$Color)
EndFunc
;~ Chỉnh màu nền của $BBackSpan
Func BBackSpanBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BBackSpan,$Color)
EndFunc