;~ Bấm vào $BSensorAdd
GUICtrlSetOnEvent($BSensorAdd, "BSensorAddClick")
Func BSensorAddClick()
	SensorAdd()
EndFunc


;~ BSensorAddTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BSensorAddTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BSensorAdd"

	$Text = FT($ControlID,BSensorAddGet())

	BSensorAddSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BSensorAddSave()
	IniWrite($DataFile,"Setting","BSensorAdd",BSensorAddGet())
EndFunc

;Nạp giá trị của label từ file
Func BSensorAddLoad()
	Local $Data = IniRead($DataFile,"Setting","BSensorAdd",BSensorAddGet())
	BSensorAddSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BSensorAdd
Func BSensorAddGet()
	Return GUICtrlRead($BSensorAdd)
EndFunc
;~ Lấy giá trị từ $BSensorAdd
Func BSensorAddSet($NewValue = "")
	Local $Check = BSensorAddGet()
	If $Check <> $NewValue Then GUICtrlSetData($BSensorAdd,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BSensorAdd
Func BSensorAddGetPos()
	Return ControlGetPos($MainGUI, "", $BSensorAdd)
EndFunc
;~ Chỉnh vị trí của $BSensorAdd
Func BSensorAddSetPos($x = -1,$y = -1)
	Local $Size = BSensorAddGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BSensorAdd,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BSensorAdd
Func BSensorAddSetSize($Width = -1,$Height = -1)
	Local $Size = BSensorAddGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BSensorAdd,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BSensorAdd
Func BSensorAddGetState()
	Return GUICtrlGetState($BSensorAdd)
EndFunc
Func BSensorAddSetState($State = $GUI_SHOW)
	GUICtrlSetState($BSensorAdd,$State)
EndFunc


;~ Chỉnh màu chữ của $BSensorAdd
Func BSensorAddColor($Color = 0x000000)
	GUICtrlSetColor($BSensorAdd,$Color)
EndFunc
;~ Chỉnh màu nền của $BSensorAdd
Func BSensorAddBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BSensorAdd,$Color)
EndFunc