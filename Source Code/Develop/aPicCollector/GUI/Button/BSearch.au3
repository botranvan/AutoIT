;~ Bấm vào $BSearch
Func BSearchClick()
	FSearchPic()
EndFunc

;~ Check và UnCheck $BSearch
Func BSearchCheck($check = 0)
	If $check == 1 Then
		BSearchSetState($GUI_CHECKED)
	Else
		BSearchSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $BSearch
Func BSearchGet()
	Return GUICtrlRead($BSearch)
EndFunc
;~ Lấy giá trị từ $BSearch
Func BSearchSet($NewValue = "",$run = 0)
	Local $Check = BSearchGet()
	If $Check <> $NewValue Then GUICtrlSetData($BSearch,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BSearchRun2Left",$run)
	Else
		AdlibUnRegister("BSearchRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BSearchRun2Left()
	Local $data
	$data = BSearchGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BSearchSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BSearch
Func BSearchGetPos()
	Return ControlGetPos($MainGUI, "", $BSearch)
EndFunc
;~ Chỉnh vị trí của $BSearch
Func BSearchSetPos($x = -1,$y = -1)
	Local $Size = BSearchGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BSearch,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BSearch
Func BSearchSetSize($Width = -1,$Height = -1)
	Local $Size = BSearchGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BSearch,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BSearch
Func BSearchGetState()
	Return GUICtrlGetState($BSearch)
EndFunc
Func BSearchSetState($State = $GUI_SHOW)
	GUICtrlSetState($BSearch,$State)
EndFunc


;~ Chỉnh màu chữ của $BSearch
Func BSearchColor($Color = 0x000000)
	GUICtrlSetColor($BSearch,$Color)
EndFunc
;~ Chỉnh màu nền của $BSearch
Func BSearchBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BSearch,$Color)
EndFunc