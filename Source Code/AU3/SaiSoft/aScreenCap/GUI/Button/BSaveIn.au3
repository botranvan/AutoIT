;~ Bấm vào $BSaveIn
Func BSaveInClick()
	Local $Mess = "Choose a folder to save your picture"
	$SaveInPath = FileSelectFolder($Mess, "",1+2,$SaveInPath)
	FSaveInPathSave()
	ISaveInSet($SaveInPath,0)
	GUICtrlSetTip($BSaveIn,$SaveInPath)
EndFunc

;~ Check và UnCheck $BSaveIn
Func BSaveInCheck($check = 0)
	If $check == 1 Then
		BSaveInSetState($GUI_CHECKED)
	Else
		BSaveInSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $BSaveIn
Func BSaveInGet()
	Return GUICtrlRead($BSaveIn)
EndFunc
;~ Lấy giá trị từ $BSaveIn
Func BSaveInSet($NewValue = "",$run = 150)
	Local $Check = BSaveInGet()
	If $Check <> $NewValue Then
		GUICtrlSetData($BSaveIn,$NewValue)
	EndIf
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BSaveInRun2Left",$run)
	Else
		AdlibUnRegister("BSaveInRun2Left")	
	EndIf
	
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BSaveInRun2Left()
	Local $data
	$data = BSaveInGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BSaveInSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BSaveIn
Func BSaveInGetPos()
	Return ControlGetPos($MainGUI, "", $BSaveIn)
EndFunc
;~ Chỉnh vị trí của $BSaveIn
Func BSaveInSetPos($x = -1,$y = -1)
	Local $Size = BSaveInGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BSaveIn,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BSaveIn
Func BSaveInSetSize($Width = -1,$Height = -1)
	Local $Size = BSaveInGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BSaveIn,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BSaveIn
Func BSaveInGetState()
	Return GUICtrlGetState($BSaveIn)
EndFunc
Func BSaveInSetState($State = $GUI_SHOW)
	GUICtrlSetState($BSaveIn,$State)
EndFunc


;~ Chỉnh màu chữ của $BSaveIn
Func BSaveInColor($Color = 0x000000)
	GUICtrlSetColor($BSaveIn,$Color)
EndFunc
;~ Chỉnh màu nền của $BSaveIn
Func BSaveInBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BSaveIn,$Color)
EndFunc