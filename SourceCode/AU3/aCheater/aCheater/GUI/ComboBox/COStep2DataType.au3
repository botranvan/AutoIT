;~ Bấm vào $COStep2DataType
GUICtrlSetOnEvent($COStep2DataType, "COStep2DataTypeChange")
Func COStep2DataTypeChange()
	Local $Data = COStep2DataTypeGet()
;~ 	MsgBox(0,"72ls.NET","COStep2DataTypeChange: "&$Data)
	COStep2DataTypeSave()
EndFunc

;~ COStep2DataTypeTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func COStep2DataTypeTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "COStep2DataType"

	$Text = FT($ControlID,COStep2DataTypeGet())

	COStep2DataTypeSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func COStep2DataTypeSave()
	IniWrite($DataFile,"Setting","COStep2DataType",COStep2DataTypeGet())
EndFunc

;Nạp giá trị của label từ file
COStep2DataTypeLoad()
Func COStep2DataTypeLoad()
	Local $Data = IniRead($DataFile,"Setting","COStep2DataType",COStep2DataTypeGet())
	If $Data <> "" Then COStep2DataTypeSet($Data,$Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $COStep2DataType
Func COStep2DataTypeGet()
	Return GUICtrlRead($COStep2DataType)
EndFunc
;~ Lấy giá trị từ $COStep2DataType
Func COStep2DataTypeSet($NewValue = "",$Default = "")
	Local $Check = COStep2DataTypeGet()
	If $Check <> $NewValue Then GUICtrlSetData($COStep2DataType,$NewValue,$Default)
EndFunc


;~ Lấy vị trí và kích thước của $COStep2DataType
Func COStep2DataTypeGetPos()
	Return ControlGetPos($MainGUI, "", $COStep2DataType)
EndFunc
;~ Chỉnh vị trí của $COStep2DataType
Func COStep2DataTypeSetPos($x = -1,$y = -1)
	Local $Size = COStep2DataTypeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($COStep2DataType,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $COStep2DataType
Func COStep2DataTypeSetSize($Width = -1,$Height = -1)
	Local $Size = COStep2DataTypeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($COStep2DataType,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $COStep2DataType
Func COStep2DataTypeGetState()
	Return GUICtrlGetState($COStep2DataType)
EndFunc
Func COStep2DataTypeSetState($State = $GUI_SHOW)
	GUICtrlSetState($COStep2DataType,$State)
EndFunc


;~ Chỉnh màu chữ của $COStep2DataType
Func COStep2DataTypeColor($Color = 0x000000)
	GUICtrlSetColor($COStep2DataType,$Color)
EndFunc
;~ Chỉnh màu nền của $COStep2DataType
Func COStep2DataTypeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($COStep2DataType,$Color)
EndFunc