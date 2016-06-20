;~ Bấm vào $ISaveIn
Func ISaveInClick()
	MsgBox(0,"72ls.NET","") 
EndFunc

;~ Check và UnCheck $ISaveIn
Func ISaveInCheck($check = 0)
	If $check == 1 Then
		ISaveInSetState($GUI_CHECKED)
	Else
		ISaveInSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $ISaveIn
Func ISaveInGet()
	Return GUICtrlRead($ISaveIn)
EndFunc
;~ Lấy giá trị từ $ISaveIn
Func ISaveInSet($NewValue = "",$run = 150)
	Local $Check = ISaveInGet()
	If $Check <> $NewValue Then
		GUICtrlSetData($ISaveIn,$NewValue)
		GUICtrlSetTip($ISaveIn,$NewValue)
	EndIf
	If $NewValue Then
		If $run > 0 Then AdlibRegister("ISaveInRun2Left",$run)
	Else
		AdlibUnRegister("ISaveInRun2Left")	
	EndIf
	
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func ISaveInRun2Left()
	Local $data
	$data = ISaveInGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	ISaveInSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $ISaveIn
Func ISaveInGetPos()
	Return ControlGetPos($MainGUI, "", $ISaveIn)
EndFunc
;~ Chỉnh vị trí của $ISaveIn
Func ISaveInSetPos($x = -1,$y = -1)
	Local $Size = ISaveInGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($ISaveIn,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $ISaveIn
Func ISaveInSetSize($Width = -1,$Height = -1)
	Local $Size = ISaveInGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($ISaveIn,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $ISaveIn
Func ISaveInGetState()
	Return GUICtrlGetState($ISaveIn)
EndFunc
Func ISaveInSetState($State = $GUI_SHOW)
	GUICtrlSetState($ISaveIn,$State)
EndFunc


;~ Chỉnh màu chữ của $ISaveIn
Func ISaveInColor($Color = 0x000000)
	GUICtrlSetColor($ISaveIn,$Color)
EndFunc
;~ Chỉnh màu nền của $ISaveIn
Func ISaveInBackGround($Color = 0x000000)
	GUICtrlSetBkColor($ISaveIn,$Color)
EndFunc