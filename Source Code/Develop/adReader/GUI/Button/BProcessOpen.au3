;~ Bấm vào $BProcessOpen
Func BProcessOpenClick()
	Local $Index = CBProcessListIndexGet()
	If $Index == -1 Then Return
	$Index+=1

	$IsOpen = Not $IsOpen
	If $IsOpen Then
		BProcessOpenSet("Close")
		$ProcessMem = _MemoryOpen($ProcessList[$Index][1])
		CBProcessListSetState($GUI_DISABLE)
	Else
		BProcessOpenSet("Open")
		_MemoryClose($ProcessMem)
		CBProcessListSetState($GUI_ENABLE)
		$ProcessMem = 0
	EndIf
EndFunc


;~ Chỉnh giá trị chuỗi của $BProcessOpen
Func BProcessOpenGet()
	Return GUICtrlRead($BProcessOpen)
EndFunc
;~ Lấy giá trị từ $BProcessOpen
Func BProcessOpenSet($NewValue = "",$run = 0)
	Local $Check = BProcessOpenGet()
	If $Check <> $NewValue Then GUICtrlSetData($BProcessOpen,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("BProcessOpenRun2Left",$run)
	Else
		AdlibUnRegister("BProcessOpenRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func BProcessOpenRun2Left()
	Local $data
	$data = BProcessOpenGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	BProcessOpenSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $BProcessOpen
Func BProcessOpenGetPos()
	Return ControlGetPos($MainGUI, "", $BProcessOpen)
EndFunc
;~ Chỉnh vị trí của $BProcessOpen
Func BProcessOpenSetPos($x = -1,$y = -1)
	Local $Size = BProcessOpenGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BProcessOpen,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BProcessOpen
Func BProcessOpenSetSize($Width = -1,$Height = -1)
	Local $Size = BProcessOpenGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BProcessOpen,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BProcessOpen
Func BProcessOpenGetState()
	Return GUICtrlGetState($BProcessOpen)
EndFunc
Func BProcessOpenSetState($State = $GUI_SHOW)
	GUICtrlSetState($BProcessOpen,$State)
EndFunc


;~ Chỉnh màu chữ của $BProcessOpen
Func BProcessOpenColor($Color = 0x000000)
	GUICtrlSetColor($BProcessOpen,$Color)
EndFunc
;~ Chỉnh màu nền của $BProcessOpen
Func BProcessOpenBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BProcessOpen,$Color)
EndFunc