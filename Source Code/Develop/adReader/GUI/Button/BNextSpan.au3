;~ Bấm vào $BNextSpan
Func BNextSpanClick()
	$AddressStart = IAddressStartGet()
	$AddressStart = Hex(Dec($AddressStart) + IAddressSpanGet()*$SpanTime,8)
	IAddressStartSet($AddressStart)
	IAddressStartChange()
EndFunc


;~ Chỉnh giá trị chuỗi của $BNextSpan
Func BNextSpanGet()
	Return GUICtrlRead($BNextSpan)
EndFunc
;~ Lấy giá trị từ $BNextSpan
Func BNextSpanSet($NewValue = "",$run = 0)
	Local $Check = BNextSpanGet()
	If $Check <> $NewValue Then GUICtrlSetData($BNextSpan,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BNextSpanRun2Left",$run)
	Else
		AdlibUnRegister("BNextSpanRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BNextSpanRun2Left()
	Local $data
	$data = BNextSpanGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BNextSpanSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BNextSpan
Func BNextSpanGetPos()
	Return ControlGetPos($MainGUI, "", $BNextSpan)
EndFunc
;~ Chỉnh vị trí của $BNextSpan
Func BNextSpanSetPos($x = -1,$y = -1)
	Local $Size = BNextSpanGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BNextSpan,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BNextSpan
Func BNextSpanSetSize($Width = -1,$Height = -1)
	Local $Size = BNextSpanGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BNextSpan,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BNextSpan
Func BNextSpanGetState()
	Return GUICtrlGetState($BNextSpan)
EndFunc
Func BNextSpanSetState($State = $GUI_SHOW)
	GUICtrlSetState($BNextSpan,$State)
EndFunc


;~ Chỉnh màu chữ của $BNextSpan
Func BNextSpanColor($Color = 0x000000)
	GUICtrlSetColor($BNextSpan,$Color)
EndFunc
;~ Chỉnh màu nền của $BNextSpan
Func BNextSpanBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BNextSpan,$Color)
EndFunc