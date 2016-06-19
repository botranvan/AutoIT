;~ Bấm vào $BBetDown
Func BBetDownClick()
	If $Bet < 0 Then $Bet = 0
	If $Bet = 0 Then Return
	If $Spining Then Return
		
	$Credits+=$BetPerTime
	$Bet-=$BetPerTime
	LCreditsSet($Credits)
	LBetSet($Bet)	
EndFunc

;~ Check và UnCheck $BBetDown
Func BBetDownCheck($check = 0)
	If $check == 1 Then
		BBetDownSetState($GUI_CHECKED)
	Else
		BBetDownSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $BBetDown
Func BBetDownGet()
	Return GUICtrlRead($BBetDown)
EndFunc
;~ Lấy giá trị từ $BBetDown
Func BBetDownSet($NewValue = "",$run = 0)
	Local $Check = BBetDownGet()
	If $Check <> $NewValue Then GUICtrlSetData($BBetDown,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BBetDownRun2Left",$run)
	Else
		AdlibUnRegister("BBetDownRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BBetDownRun2Left()
	Local $data
	$data = BBetDownGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BBetDownSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BBetDown
Func BBetDownGetPos()
	Return ControlGetPos($MainGUI, "", $BBetDown)
EndFunc
;~ Chỉnh vị trí của $BBetDown
Func BBetDownSetPos($x = -1,$y = -1)
	Local $Size = BBetDownGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BBetDown,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BBetDown
Func BBetDownSetSize($Width = -1,$Height = -1)
	Local $Size = BBetDownGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BBetDown,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BBetDown
Func BBetDownGetState()
	Return GUICtrlGetState($BBetDown)
EndFunc
Func BBetDownSetState($State = $GUI_SHOW)
	GUICtrlSetState($BBetDown,$State)
EndFunc


;~ Chỉnh màu chữ của $BBetDown
Func BBetDownColor($Color = 0x000000)
	GUICtrlSetColor($BBetDown,$Color)
EndFunc
;~ Chỉnh màu nền của $BBetDown
Func BBetDownBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BBetDown,$Color)
EndFunc