;~ Bấm vào $BSpin
Func BSpinClick()
	$Spining = 1
	If $Spining Then	;Đang quay
		BSpinSetState($GUI_DISABLE)
	EndIf
EndFunc

;~ Check và UnCheck $BSpin
Func BSpinCheck($check = 0)
	If $check == 1 Then
		BSpinSetState($GUI_CHECKED)
	Else
		BSpinSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $BSpin
Func BSpinGet()
	Return GUICtrlRead($BSpin)
EndFunc
;~ Lấy giá trị từ $BSpin
Func BSpinSet($NewValue = "",$run = 0)
	Local $Check = BSpinGet()
	If $Check <> $NewValue Then GUICtrlSetData($BSpin,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BSpinRun2Left",$run)
	Else
		AdlibUnRegister("BSpinRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BSpinRun2Left()
	Local $data
	$data = BSpinGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BSpinSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BSpin
Func BSpinGetPos()
	Return ControlGetPos($MainGUI, "", $BSpin)
EndFunc
;~ Chỉnh vị trí của $BSpin
Func BSpinSetPos($x = -1,$y = -1)
	Local $Size = BSpinGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BSpin,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BSpin
Func BSpinSetSize($Width = -1,$Height = -1)
	Local $Size = BSpinGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BSpin,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BSpin
Func BSpinGetState()
	Return GUICtrlGetState($BSpin)
EndFunc
Func BSpinSetState($State = $GUI_SHOW)
	GUICtrlSetState($BSpin,$State)
EndFunc


;~ Chỉnh màu chữ của $BSpin
Func BSpinColor($Color = 0x000000)
	GUICtrlSetColor($BSpin,$Color)
EndFunc
;~ Chỉnh màu nền của $BSpin
Func BSpinBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BSpin,$Color)
EndFunc