;~ Bấm vào $IPassword
GUICtrlSetOnEvent($IPassword, "IPasswordChange")
Func IPasswordChange()
;~	MsgBox(0,"72ls.NET","IPasswordChange")
;~	IPasswordSave()
EndFunc

;~ IPasswordTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IPasswordTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IPassword"

	$Text = FT($ControlID,IPasswordGet())

	IPasswordSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IPasswordTSave()
    FTWrite('IPassword',IPasswordGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IPasswordSave()
	IniWrite($DataFile,"Setting","IPassword",IPasswordGet())
EndFunc

;Nạp giá trị của label từ file
Func IPasswordLoad()
	Local $Data = IniRead($DataFile,"Setting","IPassword",IPasswordGet())
	IPasswordSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IPassword
Func IPasswordGet()
	Return GUICtrlRead($IPassword)
EndFunc
;~ Lấy giá trị từ $IPassword
Func IPasswordSet($NewValue = "")
	Local $Check = IPasswordGet()
	If $Check <> $NewValue Then GUICtrlSetData($IPassword,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IPassword
Func IPasswordGetPos()
	Return ControlGetPos($MainGUI, "", $IPassword)
EndFunc
;~ Chỉnh vị trí của $IPassword
Func IPasswordSetPos($x = -1,$y = -1)
	Local $Size = IPasswordGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IPassword,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IPassword
Func IPasswordSetSize($Width = -1,$Height = -1)
	Local $Size = IPasswordGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IPassword,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IPassword
Func IPasswordGetState()
	Return GUICtrlGetState($IPassword)
EndFunc
Func IPasswordSetState($State = $GUI_SHOW)
	GUICtrlSetState($IPassword,$State)
EndFunc


;~ Chỉnh màu chữ của $IPassword
Func IPasswordColor($Color = 0x000000)
	GUICtrlSetColor($IPassword,$Color)
EndFunc
;~ Chỉnh màu nền của $IPassword
Func IPasswordBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IPassword,$Color)
EndFunc