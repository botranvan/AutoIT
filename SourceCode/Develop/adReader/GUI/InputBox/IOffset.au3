;~ Chỉnh giá trị chuỗi của $IOffset
Func IOffsetGet()
	Return GUICtrlRead($IOffset)
EndFunc
;~ Lấy giá trị từ $IOffset
Func IOffsetSet($NewValue = "",$run = 0)
	Local $Check = IOffsetGet()
	If $Check <> $NewValue Then GUICtrlSetData($IOffset,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("IOffsetRun2Left",$run)
	Else
		AdlibUnRegister("IOffsetRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func IOffsetRun2Left()
	Local $data
	$data = IOffsetGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	IOffsetSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $IOffset
Func IOffsetGetPos()
	Return ControlGetPos($MainGUI, "", $IOffset)
EndFunc
;~ Chỉnh vị trí của $IOffset
Func IOffsetSetPos($x = -1,$y = -1)
	Local $Size = IOffsetGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IOffset,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IOffset
Func IOffsetSetSize($Width = -1,$Height = -1)
	Local $Size = IOffsetGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IOffset,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IOffset
Func IOffsetGetState()
	Return GUICtrlGetState($IOffset)
EndFunc
Func IOffsetSetState($State = $GUI_SHOW)
	GUICtrlSetState($IOffset,$State)
EndFunc


;~ Chỉnh màu chữ của $IOffset
Func IOffsetColor($Color = 0x000000)
	GUICtrlSetColor($IOffset,$Color)
EndFunc
;~ Chỉnh màu nền của $IOffset
Func IOffsetBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IOffset,$Color)
EndFunc