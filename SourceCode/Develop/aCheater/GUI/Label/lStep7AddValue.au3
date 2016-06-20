;~ Bấm vào $lStep7AddValue
GUICtrlSetOnEvent($lStep7AddValue, "lStep7AddValueClick")
Func lStep7AddValueClick()
	$Step7ValueIsHex = Not $Step7ValueIsHex
EndFunc

;~ lStep7AddValueTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func lStep7AddValueTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "lStep7AddValue"

 	$Text = FT($ControlID,lStep7AddValueGet())

	lStep7AddValueSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func lStep7AddValueSave()
	IniWrite($DataFile,"Setting","lStep7AddValue",lStep7AddValueGet())
EndFunc

;Nạp giá trị của label từ file
Func lStep7AddValueLoad()
	Local $Data = IniRead($DataFile,"Setting","lStep7AddValue",lStep7AddValueGet())
	lStep7AddValueSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $lStep7AddValue
Func lStep7AddValueGet()
	Return GUICtrlRead($lStep7AddValue)
EndFunc
;~ Lấy giá trị từ $lStep7AddValue
Func lStep7AddValueSet($NewValue = "")
	Local $Check = lStep7AddValueGet()
	If $Check <> $NewValue Then GUICtrlSetData($lStep7AddValue,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $lStep7AddValue
Func lStep7AddValueGetPos()
	Return ControlGetPos($MainGUI, "", $lStep7AddValue)
EndFunc
;~ Chỉnh vị trí của $lStep7AddValue
Func lStep7AddValueSetPos($x = -1,$y = -1)
	Local $Size = lStep7AddValueGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($lStep7AddValue,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $lStep7AddValue
Func lStep7AddValueSetSize($Width = -1,$Height = -1)
	Local $Size = lStep7AddValueGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($lStep7AddValue,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $lStep7AddValue
Func lStep7AddValueGetState()
	Return GUICtrlGetState($lStep7AddValue)
EndFunc
Func lStep7AddValueSetState($State = $GUI_SHOW)
	GUICtrlSetState($lStep7AddValue,$State)
EndFunc


;~ Chỉnh màu chữ của $lStep7AddValue
Func lStep7AddValueColor($Color = 0x000000)
	GUICtrlSetColor($lStep7AddValue,$Color)
EndFunc
;~ Chỉnh màu nền của $lStep7AddValue
Func lStep7AddValueBackGround($Color = 0x000000)
	GUICtrlSetBkColor($lStep7AddValue,$Color)
EndFunc