;~ Bấm vào $BStep5ChangeValue
GUICtrlSetOnEvent($BStep5ChangeValue, "BStep5ChangeValueClick")
Func BStep5ChangeValueClick()
	FCTStep5ChangeTo()
EndFunc


;~ BStep5ChangeValueTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStep5ChangeValueTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStep5ChangeValue"

	$Text = FT($ControlID,BStep5ChangeValueGet())

	BStep5ChangeValueSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStep5ChangeValueSave()
	IniWrite($DataFile,"Setting","BStep5ChangeValue",BStep5ChangeValueGet())
EndFunc

;Nạp giá trị của label từ file
Func BStep5ChangeValueLoad()
	Local $Data = IniRead($DataFile,"Setting","BStep5ChangeValue",BStep5ChangeValueGet())
	BStep5ChangeValueSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStep5ChangeValue
Func BStep5ChangeValueGet()
	Return GUICtrlRead($BStep5ChangeValue)
EndFunc
;~ Lấy giá trị từ $BStep5ChangeValue
Func BStep5ChangeValueSet($NewValue = "")
	Local $Check = BStep5ChangeValueGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStep5ChangeValue,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStep5ChangeValue
Func BStep5ChangeValueGetPos()
	Return ControlGetPos($MainGUI, "", $BStep5ChangeValue)
EndFunc
;~ Chỉnh vị trí của $BStep5ChangeValue
Func BStep5ChangeValueSetPos($x = -1,$y = -1)
	Local $Size = BStep5ChangeValueGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStep5ChangeValue,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStep5ChangeValue
Func BStep5ChangeValueSetSize($Width = -1,$Height = -1)
	Local $Size = BStep5ChangeValueGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStep5ChangeValue,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStep5ChangeValue
Func BStep5ChangeValueGetState()
	Return GUICtrlGetState($BStep5ChangeValue)
EndFunc
Func BStep5ChangeValueSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStep5ChangeValue,$State)
EndFunc


;~ Chỉnh màu chữ của $BStep5ChangeValue
Func BStep5ChangeValueColor($Color = 0x000000)
	GUICtrlSetColor($BStep5ChangeValue,$Color)
EndFunc
;~ Chỉnh màu nền của $BStep5ChangeValue
Func BStep5ChangeValueBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStep5ChangeValue,$Color)
EndFunc