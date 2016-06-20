;~ Bấm vào $BSensorDel
GUICtrlSetOnEvent($BSensorDel, "BSensorDelClick")
Func BSensorDelClick()
	SensorDel()
EndFunc


;~ BSensorDelTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BSensorDelTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BSensorDel"

	$Text = FT($ControlID,BSensorDelGet())

	BSensorDelSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BSensorDelSave()
	IniWrite($DataFile,"Setting","BSensorDel",BSensorDelGet())
EndFunc

;Nạp giá trị của label từ file
Func BSensorDelLoad()
	Local $Data = IniRead($DataFile,"Setting","BSensorDel",BSensorDelGet())
	BSensorDelSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BSensorDel
Func BSensorDelGet()
	Return GUICtrlRead($BSensorDel)
EndFunc
;~ Lấy giá trị từ $BSensorDel
Func BSensorDelSet($NewValue = "")
	Local $Check = BSensorDelGet()
	If $Check <> $NewValue Then GUICtrlSetData($BSensorDel,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BSensorDel
Func BSensorDelGetPos()
	Return ControlGetPos($MainGUI, "", $BSensorDel)
EndFunc
;~ Chỉnh vị trí của $BSensorDel
Func BSensorDelSetPos($x = -1,$y = -1)
	Local $Size = BSensorDelGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BSensorDel,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BSensorDel
Func BSensorDelSetSize($Width = -1,$Height = -1)
	Local $Size = BSensorDelGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BSensorDel,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BSensorDel
Func BSensorDelGetState()
	Return GUICtrlGetState($BSensorDel)
EndFunc
Func BSensorDelSetState($State = $GUI_SHOW)
	GUICtrlSetState($BSensorDel,$State)
EndFunc


;~ Chỉnh màu chữ của $BSensorDel
Func BSensorDelColor($Color = 0x000000)
	GUICtrlSetColor($BSensorDel,$Color)
EndFunc
;~ Chỉnh màu nền của $BSensorDel
Func BSensorDelBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BSensorDel,$Color)
EndFunc