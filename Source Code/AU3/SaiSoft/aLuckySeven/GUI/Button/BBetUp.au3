;~ Bấm vào $BBetUp
Func BBetUpClick()
	If $Credits < $BetPerTime Then Return
	If $Spining Then Return
	$Credits-=$BetPerTime
	$Bet+=$BetPerTime
	LCreditsSet($Credits)
	LBetSet($Bet)
EndFunc

;~ Check và UnCheck $BBetUp
Func BBetUpCheck($check = 0)
	If $check == 1 Then
		BBetUpSetState($GUI_CHECKED)
	Else
		BBetUpSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $BBetUp
Func BBetUpGet()
	Return GUICtrlRead($BBetUp)
EndFunc
;~ Lấy giá trị từ $BBetUp
Func BBetUpSet($NewValue = "",$run = 0)
	Local $Check = BBetUpGet()
	If $Check <> $NewValue Then GUICtrlSetData($BBetUp,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BBetUpRun2Left",$run)
	Else
		AdlibUnRegister("BBetUpRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BBetUpRun2Left()
	Local $data
	$data = BBetUpGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BBetUpSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BBetUp
Func BBetUpGetPos()
	Return ControlGetPos($MainGUI, "", $BBetUp)
EndFunc
;~ Chỉnh vị trí của $BBetUp
Func BBetUpSetPos($x = -1,$y = -1)
	Local $Size = BBetUpGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BBetUp,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BBetUp
Func BBetUpSetSize($Width = -1,$Height = -1)
	Local $Size = BBetUpGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BBetUp,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BBetUp
Func BBetUpGetState()
	Return GUICtrlGetState($BBetUp)
EndFunc
Func BBetUpSetState($State = $GUI_SHOW)
	GUICtrlSetState($BBetUp,$State)
EndFunc


;~ Chỉnh màu chữ của $BBetUp
Func BBetUpColor($Color = 0x000000)
	GUICtrlSetColor($BBetUp,$Color)
EndFunc
;~ Chỉnh màu nền của $BBetUp
Func BBetUpBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BBetUp,$Color)
EndFunc