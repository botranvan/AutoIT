;~ Bấm vào $LBet
Func LBetClick()
	
EndFunc

;~ Check và UnCheck $LBet
Func LBetCheck($check = 0)
	If $check == 1 Then
		LBetSetState($GUI_CHECKED)
	Else
		LBetSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LBet
Func LBetGet()
	Return GUICtrlRead($LBet)
EndFunc
;~ Lấy giá trị từ $LBet
Func LBetSet($NewValue = "",$run = 0)
	Local $Check = LBetGet()
	If $Check <> $NewValue Then GUICtrlSetData($LBet,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LBetRun2Left",$run)
	Else
		AdlibUnRegister("LBetRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LBetRun2Left()
	Local $data
	$data = LBetGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LBetSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LBet
Func LBetGetPos()
	Return ControlGetPos($MainGUI, "", $LBet)
EndFunc
;~ Chỉnh vị trí của $LBet
Func LBetSetPos($x = -1,$y = -1)
	Local $Size = LBetGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LBet,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LBet
Func LBetSetSize($Width = -1,$Height = -1)
	Local $Size = LBetGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LBet,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LBet
Func LBetGetState()
	Return GUICtrlGetState($LBet)
EndFunc
Func LBetSetState($State = $GUI_SHOW)
	GUICtrlSetState($LBet,$State)
EndFunc


;~ Chỉnh màu chữ của $LBet
Func LBetColor($Color = 0x000000)
	GUICtrlSetColor($LBet,$Color)
EndFunc
;~ Chỉnh màu nền của $LBet
Func LBetBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LBet,$Color)
EndFunc