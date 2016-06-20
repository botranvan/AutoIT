;~ Bấm vào $IProcessName
GUICtrlSetOnEvent($IProcessName, "IProcessNameChange")
Func IProcessNameChange()
;~	MsgBox(0,"72ls.NET","IProcessNameChange")
	IProcessNameSave()
EndFunc

;~ IProcessNameTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IProcessNameTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IProcessName"

	$Text = FT($ControlID,IProcessNameGet())

	IProcessNameSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IProcessNameTSave()
    FTWrite('IProcessName',IProcessNameGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IProcessNameSave()
	IniWrite($DataFile,"Setting","IProcessName",IProcessNameGet())
EndFunc

;Nạp giá trị của label từ file
IProcessNameLoad()
Func IProcessNameLoad()
	Local $Data = IniRead($DataFile,"Setting","IProcessName",IProcessNameGet())
	IProcessNameSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IProcessName
Func IProcessNameGet()
	Return GUICtrlRead($IProcessName)
EndFunc
;~ Lấy giá trị từ $IProcessName
Func IProcessNameSet($NewValue = "")
	Local $Check = IProcessNameGet()
	If $Check <> $NewValue Then GUICtrlSetData($IProcessName,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IProcessName
Func IProcessNameGetPos()
	Return ControlGetPos($MainGUI, "", $IProcessName)
EndFunc
;~ Chỉnh vị trí của $IProcessName
Func IProcessNameSetPos($x = -1,$y = -1)
	Local $Size = IProcessNameGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IProcessName,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IProcessName
Func IProcessNameSetSize($Width = -1,$Height = -1)
	Local $Size = IProcessNameGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IProcessName,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IProcessName
Func IProcessNameGetState()
	Return GUICtrlGetState($IProcessName)
EndFunc
Func IProcessNameSetState($State = $GUI_SHOW)
	GUICtrlSetState($IProcessName,$State)
EndFunc


;~ Chỉnh màu chữ của $IProcessName
Func IProcessNameColor($Color = 0x000000)
	GUICtrlSetColor($IProcessName,$Color)
EndFunc
;~ Chỉnh màu nền của $IProcessName
Func IProcessNameBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IProcessName,$Color)
EndFunc