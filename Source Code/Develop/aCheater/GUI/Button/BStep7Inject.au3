;~ Bấm vào $BStep7Inject
GUICtrlSetOnEvent($BStep7Inject, "BStep7InjectClick")
Func BStep7InjectClick()
	FCTStep7Inject()
EndFunc


;~ BStep7InjectTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStep7InjectTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStep7Inject"

	$Text = FT($ControlID,BStep7InjectGet())

	BStep7InjectSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStep7InjectSave()
	IniWrite($DataFile,"Setting","BStep7Inject",BStep7InjectGet())
EndFunc

;Nạp giá trị của label từ file
Func BStep7InjectLoad()
	Local $Data = IniRead($DataFile,"Setting","BStep7Inject",BStep7InjectGet())
	BStep7InjectSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStep7Inject
Func BStep7InjectGet()
	Return GUICtrlRead($BStep7Inject)
EndFunc
;~ Lấy giá trị từ $BStep7Inject
Func BStep7InjectSet($NewValue = "")
	Local $Check = BStep7InjectGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStep7Inject,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStep7Inject
Func BStep7InjectGetPos()
	Return ControlGetPos($MainGUI, "", $BStep7Inject)
EndFunc
;~ Chỉnh vị trí của $BStep7Inject
Func BStep7InjectSetPos($x = -1,$y = -1)
	Local $Size = BStep7InjectGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStep7Inject,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStep7Inject
Func BStep7InjectSetSize($Width = -1,$Height = -1)
	Local $Size = BStep7InjectGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStep7Inject,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStep7Inject
Func BStep7InjectGetState()
	Return GUICtrlGetState($BStep7Inject)
EndFunc
Func BStep7InjectSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStep7Inject,$State)
EndFunc


;~ Chỉnh màu chữ của $BStep7Inject
Func BStep7InjectColor($Color = 0x000000)
	GUICtrlSetColor($BStep7Inject,$Color)
EndFunc
;~ Chỉnh màu nền của $BStep7Inject
Func BStep7InjectBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStep7Inject,$Color)
EndFunc