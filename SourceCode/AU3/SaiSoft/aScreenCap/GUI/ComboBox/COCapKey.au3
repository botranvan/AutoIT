;~ Bấm vào $COCapKey
Func COCapKeyChange()
	FCapKeySetFunc()
	$CapKey = COCapKeyGet()
	FCapKeySave()
	FCapKeySetFunc($CapKey)
EndFunc

;~ Chỉnh giá trị chuỗi của $COCapKey
Func COCapKeyGet()
	Return GUICtrlRead($COCapKey)
EndFunc
;~ Lấy giá trị từ $COCapKey
Func COCapKeySet($NewValue = "",$run = 150)
	Local $Check = COCapKeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($COCapKey,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("COCapKeyRun2Left",$run)
	Else
		AdlibUnRegister("COCapKeyRun2Left")	
	EndIf
EndFunc

;~ Chọn chuỗi cho $COCapKey
Func COCapKeySelect($NewValue = "")
	_GUICtrlComboBox_SelectString($COCapKey, $NewValue)
EndFunc

;~ Lấy vị trí và kích thước của $COCapKey
Func COCapKeyGetPos()
	Return ControlGetPos($MainGUI, "", $COCapKey)
EndFunc
;~ Chỉnh vị trí của $COCapKey
Func COCapKeySetPos($x = -1,$y = -1)
	Local $Size = COCapKeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($COCapKey,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $COCapKey
Func COCapKeySetSize($Width = -1,$Height = -1)
	Local $Size = COCapKeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($COCapKey,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $COCapKey
Func COCapKeyGetState()
	Return GUICtrlGetState($COCapKey)
EndFunc
Func COCapKeySetState($State = $GUI_SHOW)
	GUICtrlSetState($COCapKey,$State)
EndFunc


;~ Chỉnh màu chữ của $COCapKey
Func COCapKeyColor($Color = 0x000000)
	GUICtrlSetColor($COCapKey,$Color)
EndFunc
;~ Chỉnh màu nền của $COCapKey
Func COCapKeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($COCapKey,$Color)
EndFunc