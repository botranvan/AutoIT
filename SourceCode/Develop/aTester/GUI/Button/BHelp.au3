;~ Bấm vào $BHelp
GUICtrlSetOnEvent($BHelp, "BHelpClick")
Func BHelpClick()
	MsgBox(0,$AutoName,"nothing yet")
EndFunc


;~ BHelpTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BHelpTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BHelp"

	$Text = FT($ControlID,BHelpGet())

	BHelpSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BHelpSave()
	IniWrite($DataFile,"Setting","BHelp",BHelpGet())
EndFunc

;Nạp giá trị của label từ file
Func BHelpLoad()
	Local $Data = IniRead($DataFile,"Setting","BHelp",BHelpGet())
	BHelpSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BHelp
Func BHelpGet()
	Return GUICtrlRead($BHelp)
EndFunc
;~ Lấy giá trị từ $BHelp
Func BHelpSet($NewValue = "")
	Local $Check = BHelpGet()
	If $Check <> $NewValue Then GUICtrlSetData($BHelp,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BHelp
Func BHelpGetPos()
	Return ControlGetPos($MainGUI, "", $BHelp)
EndFunc
;~ Chỉnh vị trí của $BHelp
Func BHelpSetPos($x = -1,$y = -1)
	Local $Size = BHelpGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BHelp,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BHelp
Func BHelpSetSize($Width = -1,$Height = -1)
	Local $Size = BHelpGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BHelp,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BHelp
Func BHelpGetState()
	Return GUICtrlGetState($BHelp)
EndFunc
Func BHelpSetState($State = $GUI_SHOW)
	GUICtrlSetState($BHelp,$State)
EndFunc


;~ Chỉnh màu chữ của $BHelp
Func BHelpColor($Color = 0x000000)
	GUICtrlSetColor($BHelp,$Color)
EndFunc
;~ Chỉnh màu nền của $BHelp
Func BHelpBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BHelp,$Color)
EndFunc