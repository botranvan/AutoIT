;~ Bấm vào $LCredits
Func LCreditsClick()
	
EndFunc

;~ Check và UnCheck $LCredits
Func LCreditsCheck($check = 0)
	If $check == 1 Then
		LCreditsSetState($GUI_CHECKED)
	Else
		LCreditsSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LCredits
Func LCreditsGet()
	Return GUICtrlRead($LCredits)
EndFunc
;~ Lấy giá trị từ $LCredits
Func LCreditsSet($NewValue = "",$run = 0)
	Local $Check = LCreditsGet()
	If $Check <> $NewValue Then GUICtrlSetData($LCredits,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LCreditsRun2Left",$run)
	Else
		AdlibUnRegister("LCreditsRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LCreditsRun2Left()
	Local $data
	$data = LCreditsGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LCreditsSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LCredits
Func LCreditsGetPos()
	Return ControlGetPos($MainGUI, "", $LCredits)
EndFunc
;~ Chỉnh vị trí của $LCredits
Func LCreditsSetPos($x = -1,$y = -1)
	Local $Size = LCreditsGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LCredits,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LCredits
Func LCreditsSetSize($Width = -1,$Height = -1)
	Local $Size = LCreditsGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LCredits,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LCredits
Func LCreditsGetState()
	Return GUICtrlGetState($LCredits)
EndFunc
Func LCreditsSetState($State = $GUI_SHOW)
	GUICtrlSetState($LCredits,$State)
EndFunc


;~ Chỉnh màu chữ của $LCredits
Func LCreditsColor($Color = 0x000000)
	GUICtrlSetColor($LCredits,$Color)
EndFunc
;~ Chỉnh màu nền của $LCredits
Func LCreditsBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LCredits,$Color)
EndFunc