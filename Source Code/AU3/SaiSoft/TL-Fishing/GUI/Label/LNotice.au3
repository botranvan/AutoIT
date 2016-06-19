;~ Bấm vào $LNotice
Func LNoticeClick()
	MsgBox(0,"72ls.NET","") 
EndFunc

;~ Check và UnCheck $LNotice
Func LNoticeCheck($check = 0)
	If $check == 1 Then
		LNoticeSetState($GUI_CHECKED)
	Else
		LNoticeSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LNotice
Func LNoticeGet()
	Return GUICtrlRead($LNotice)
EndFunc
;~ Lấy giá trị từ $LNotice
Func LNoticeSet($NewValue = "",$run = 150)
	Local $Check = LNoticeGet()
	If $Check <> $NewValue Then GUICtrlSetData($LNotice,$NewValue)
	If $NewValue Then
		If $run > 0 Then 
			AdlibRegister("LNoticeRun2Left",$run)
		Else
			AdlibUnRegister("LNoticeRun2Left")	
		EndIf
	Else
		AdlibUnRegister("LNoticeRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LNoticeRun2Left()
	Local $data
	$data = LNoticeGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LNoticeSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LNotice
Func LNoticeGetPos()
	Return ControlGetPos($MainGUI, "", $LNotice)
EndFunc
;~ Chỉnh vị trí của $LNotice
Func LNoticeSetPos($x = -1,$y = -1)
	Local $Size = LNoticeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LNotice,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LNotice
Func LNoticeSetSize($Width = -1,$Height = -1)
	Local $Size = LNoticeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LNotice,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LNotice
Func LNoticeGetState()
	Return GUICtrlGetState($LNotice)
EndFunc
Func LNoticeSetState($State = $GUI_SHOW)
	GUICtrlSetState($LNotice,$State)
EndFunc


;~ Chỉnh màu chữ của $LNotice
Func LNoticeColor($Color = 0x000000)
	GUICtrlSetColor($LNotice,$Color)
EndFunc
;~ Chỉnh màu nền của $LNotice
Func LNoticeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LNotice,$Color)
EndFunc