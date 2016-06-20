;~ Bấm vào $BCheck
GUICtrlSetOnEvent($BCheck, "BCheckClick")
Func BCheckClick()
;~ 	$AutoShow = Not $AutoShow
;~ 	FAutoShow($AutoShow)
	FKeywordCheck()
EndFunc


;~ BCheckTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BCheckTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BCheck"

	$Text = FT($ControlID,BCheckGet())

	BCheckSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BCheckSave()
	IniWrite($DataFile,"Setting","BCheck",BCheckGet())
EndFunc

;Nạp giá trị của label từ file
Func BCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","BCheck",BCheckGet())
	BCheckSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BCheck
Func BCheckGet()
	Return GUICtrlRead($BCheck)
EndFunc
;~ Lấy giá trị từ $BCheck
Func BCheckSet($NewValue = "")
	Local $Check = BCheckGet()
	If $Check <> $NewValue Then GUICtrlSetData($BCheck,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BCheck
Func BCheckGetPos()
	Return ControlGetPos($MainGUI, "", $BCheck)
EndFunc
;~ Chỉnh vị trí của $BCheck
Func BCheckSetPos($x = -1,$y = -1)
	Local $Size = BCheckGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BCheck,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BCheck
Func BCheckSetSize($Width = -1,$Height = -1)
	Local $Size = BCheckGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BCheck,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BCheck
Func BCheckGetState()
	Return GUICtrlGetState($BCheck)
EndFunc
Func BCheckSetState($State = $GUI_SHOW)
	GUICtrlSetState($BCheck,$State)
EndFunc


;~ Chỉnh màu chữ của $BCheck
Func BCheckColor($Color = 0x000000)
	GUICtrlSetColor($BCheck,$Color)
EndFunc
;~ Chỉnh màu nền của $BCheck
Func BCheckBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BCheck,$Color)
EndFunc