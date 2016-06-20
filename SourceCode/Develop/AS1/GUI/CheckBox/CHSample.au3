;~ Bấm vào $CHSample
GUICtrlSetOnEvent($CHSample, "CHSampleClick")
Func CHSampleClick()
;~	CHSampleSave()
;~	CHSampleCheckSave()
EndFunc

;Lưu trạng thái của CHSample xuống file
Func CHSampleCheckSave()
	IniWrite($DataFile,"Setting","CHSampleCheck",CHSampleGet(0))
EndFunc

;Nạp trạng thái của CHSample từ file
Func CHSampleCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHSampleCheck",CHSampleGet(0))
	CHSampleCheck($Data)
EndFunc

;~ Check và UnCheck $CHSample
Func CHSampleCheck($check = 0)
	If $check == 1 Then	CHSampleSetState($GUI_CHECKED)
	If $check == 4 Then	CHSampleSetState($GUI_UNCHECKED)
EndFunc
	
;~ Kiểm tra xem $CHSample có đang check hay không
Func CHSampleIsCheck()
	Local $State = CHSampleGetState()
	If $State == 1 Then	Return 1
	If $State == 4 Then	Return 0
EndFunc

;Lưu giá trị trong label xuống file
Func CHSampleSave()
	IniWrite($DataFile,"Setting","CHSample",CHSampleGet())
EndFunc
;Nạp giá trị của label từ file
Func CHSampleLoad()
	Local $Data = IniRead($DataFile,"Setting","CHSample",CHSampleGet())
	CHSampleSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHSample
Func CHSampleGet($Advanced = 1)
	Return GUICtrlRead($CHSample,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHSample
Func CHSampleSet($NewValue = "")
	Local $Check = CHSampleGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHSample,$NewValue)
EndFunc
	

;~ Lấy vị trí và kích thước của $CHSample
Func CHSampleGetPos()
	Return ControlGetPos($MainGUI, "", $CHSample)
EndFunc
;~ Chỉnh vị trí của $CHSample
Func CHSampleSetPos($x = -1,$y = -1)
	Local $Size = CHSampleGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHSample,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHSample
Func CHSampleSetSize($Width = -1,$Height = -1)
	Local $Size = CHSampleGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHSample,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHSample
Func CHSampleGetState()
	Return GUICtrlGetState($CHSample)
EndFunc
Func CHSampleSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHSample,$State)
EndFunc


;~ Chỉnh màu chữ của $CHSample
Func CHSampleColor($Color = 0x000000)
	GUICtrlSetColor($CHSample,$Color)
EndFunc
;~ Chỉnh màu nền của $CHSample
Func CHSampleBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHSample,$Color)
EndFunc	