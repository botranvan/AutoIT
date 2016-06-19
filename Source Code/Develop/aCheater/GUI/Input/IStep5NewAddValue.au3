;~ Bấm vào $IStep5NewAddValue
GUICtrlSetOnEvent($IStep5NewAddValue, "IStep5NewAddValueChange")
Func IStep5NewAddValueChange()
;~	MsgBox(0,"72ls.NET","IStep5NewAddValueChange")
	IStep5NewAddValueSave()
EndFunc

;~ IStep5NewAddValueTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep5NewAddValueTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep5NewAddValue"

	$Text = FT($ControlID,IStep5NewAddValueGet())

	IStep5NewAddValueSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep5NewAddValueTSave()
    FTWrite('IStep5NewAddValue',IStep5NewAddValueGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep5NewAddValueSave()
	IniWrite($DataFile,"Setting","IStep5NewAddValue",IStep5NewAddValueGet())
EndFunc

;Nạp giá trị của label từ file
IStep5NewAddValueLoad()
Func IStep5NewAddValueLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep5NewAddValue",IStep5NewAddValueGet())
	IStep5NewAddValueSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep5NewAddValue
Func IStep5NewAddValueGet()
	Return GUICtrlRead($IStep5NewAddValue)
EndFunc
;~ Lấy giá trị từ $IStep5NewAddValue
Func IStep5NewAddValueSet($NewValue = "")
	Local $Check = IStep5NewAddValueGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep5NewAddValue,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep5NewAddValue
Func IStep5NewAddValueGetPos()
	Return ControlGetPos($MainGUI, "", $IStep5NewAddValue)
EndFunc
;~ Chỉnh vị trí của $IStep5NewAddValue
Func IStep5NewAddValueSetPos($x = -1,$y = -1)
	Local $Size = IStep5NewAddValueGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep5NewAddValue,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep5NewAddValue
Func IStep5NewAddValueSetSize($Width = -1,$Height = -1)
	Local $Size = IStep5NewAddValueGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep5NewAddValue,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep5NewAddValue
Func IStep5NewAddValueGetState()
	Return GUICtrlGetState($IStep5NewAddValue)
EndFunc
Func IStep5NewAddValueSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep5NewAddValue,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep5NewAddValue
Func IStep5NewAddValueColor($Color = 0x000000)
	GUICtrlSetColor($IStep5NewAddValue,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep5NewAddValue
Func IStep5NewAddValueBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep5NewAddValue,$Color)
EndFunc