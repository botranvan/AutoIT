;~ Bấm vào $IUsername
GUICtrlSetOnEvent($IUsername, "IUsernameChange")
Func IUsernameChange()
;~	MsgBox(0,"72ls.NET","IUsernameChange")
	IUsernameSave()
EndFunc

IUsernameLoad()
;~ IUsernameTLoad()

;~ Nạp chuỗi ngôn ngữ của 1 control
Func IUsernameTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IUsername"

	$Text = FT($ControlID,IUsernameGet())

	IUsernameSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IUsernameTSave()
    FTWrite('IUsername',IUsernameGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IUsernameSave()
	IniWrite($DataFile,"Setting","IUsername",IUsernameGet())
EndFunc

;Nạp giá trị của label từ file
Func IUsernameLoad()
	Local $Data = IniRead($DataFile,"Setting","IUsername",IUsernameGet())
	IUsernameSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IUsername
Func IUsernameGet()
	Return GUICtrlRead($IUsername)
EndFunc
;~ Lấy giá trị từ $IUsername
Func IUsernameSet($NewValue = "")
	Local $Check = IUsernameGet()
	If $Check <> $NewValue Then GUICtrlSetData($IUsername,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IUsername
Func IUsernameGetPos()
	Return ControlGetPos($MainGUI, "", $IUsername)
EndFunc
;~ Chỉnh vị trí của $IUsername
Func IUsernameSetPos($x = -1,$y = -1)
	Local $Size = IUsernameGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IUsername,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IUsername
Func IUsernameSetSize($Width = -1,$Height = -1)
	Local $Size = IUsernameGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IUsername,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IUsername
Func IUsernameGetState()
	Return GUICtrlGetState($IUsername)
EndFunc
Func IUsernameSetState($State = $GUI_SHOW)
	GUICtrlSetState($IUsername,$State)
EndFunc


;~ Chỉnh màu chữ của $IUsername
Func IUsernameColor($Color = 0x000000)
	GUICtrlSetColor($IUsername,$Color)
EndFunc
;~ Chỉnh màu nền của $IUsername
Func IUsernameBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IUsername,$Color)
EndFunc