;~ Chỉnh giá trị chuỗi của $IAddressSpan
Func IAddressSpanGet()
	Return GUICtrlRead($IAddressSpan)
EndFunc
;~ Lấy giá trị từ $IAddressSpan
Func IAddressSpanSet($NewValue = "",$run = 0)
	Local $Check = IAddressSpanGet()
	If $Check <> $NewValue Then GUICtrlSetData($IAddressSpan,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("IAddressSpanRun2Left",$run)
	Else
		AdlibUnRegister("IAddressSpanRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func IAddressSpanRun2Left()
	Local $data
	$data = IAddressSpanGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	IAddressSpanSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $IAddressSpan
Func IAddressSpanGetPos()
	Return ControlGetPos($MainGUI, "", $IAddressSpan)
EndFunc
;~ Chỉnh vị trí của $IAddressSpan
Func IAddressSpanSetPos($x = -1,$y = -1)
	Local $Size = IAddressSpanGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IAddressSpan,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IAddressSpan
Func IAddressSpanSetSize($Width = -1,$Height = -1)
	Local $Size = IAddressSpanGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IAddressSpan,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IAddressSpan
Func IAddressSpanGetState()
	Return GUICtrlGetState($IAddressSpan)
EndFunc
Func IAddressSpanSetState($State = $GUI_SHOW)
	GUICtrlSetState($IAddressSpan,$State)
EndFunc


;~ Chỉnh màu chữ của $IAddressSpan
Func IAddressSpanColor($Color = 0x000000)
	GUICtrlSetColor($IAddressSpan,$Color)
EndFunc
;~ Chỉnh màu nền của $IAddressSpan
Func IAddressSpanBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IAddressSpan,$Color)
EndFunc