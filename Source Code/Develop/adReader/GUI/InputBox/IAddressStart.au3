;~ Thực hiện khi giá trị của $IAddressStart thay đổi
Func IAddressStartChange()
	$AddressStart = IAddressStartGet()
	IniWrite($DataFileName,"GUI","$AddressStart",$AddressStart)
EndFunc

;~ Chỉnh giá trị chuỗi của $IAddressStart
Func IAddressStartGet()
	Return GUICtrlRead($IAddressStart)
EndFunc
;~ Lấy giá trị từ $IAddressStart
Func IAddressStartSet($NewValue = "",$run = 0)
	Local $Check = IAddressStartGet()
	If $Check <> $NewValue Then GUICtrlSetData($IAddressStart,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("IAddressStartRun2Left",$run)
	Else
		AdlibUnRegister("IAddressStartRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func IAddressStartRun2Left()
	Local $data
	$data = IAddressStartGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	IAddressStartSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $IAddressStart
Func IAddressStartGetPos()
	Return ControlGetPos($MainGUI, "", $IAddressStart)
EndFunc
;~ Chỉnh vị trí của $IAddressStart
Func IAddressStartSetPos($x = -1,$y = -1)
	Local $Size = IAddressStartGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IAddressStart,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IAddressStart
Func IAddressStartSetSize($Width = -1,$Height = -1)
	Local $Size = IAddressStartGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IAddressStart,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IAddressStart
Func IAddressStartGetState()
	Return GUICtrlGetState($IAddressStart)
EndFunc
Func IAddressStartSetState($State = $GUI_SHOW)
	GUICtrlSetState($IAddressStart,$State)
EndFunc


;~ Chỉnh màu chữ của $IAddressStart
Func IAddressStartColor($Color = 0x000000)
	GUICtrlSetColor($IAddressStart,$Color)
EndFunc
;~ Chỉnh màu nền của $IAddressStart
Func IAddressStartBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IAddressStart,$Color)
EndFunc