;~ Bấm vào $IStep7Address
GUICtrlSetOnEvent($IStep7Address, "IStep7AddressChange")
Func IStep7AddressChange()
;~	MsgBox(0,"72ls.NET","IStep7AddressChange")
	IStep7AddressSave()
EndFunc

;~ IStep7AddressTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep7AddressTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep7Address"

	$Text = FT($ControlID,IStep7AddressGet())

	IStep7AddressSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep7AddressTSave()
    FTWrite('IStep7Address',IStep7AddressGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep7AddressSave()
	IniWrite($DataFile,"Setting","IStep7Address",IStep7AddressGet())
EndFunc

;Nạp giá trị của label từ file
IStep7AddressLoad()
Func IStep7AddressLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep7Address",IStep7AddressGet())
	IStep7AddressSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep7Address
Func IStep7AddressGet()
	Return GUICtrlRead($IStep7Address)
EndFunc
;~ Lấy giá trị từ $IStep7Address
Func IStep7AddressSet($NewValue = "")
	Local $Check = IStep7AddressGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep7Address,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep7Address
Func IStep7AddressGetPos()
	Return ControlGetPos($MainGUI, "", $IStep7Address)
EndFunc
;~ Chỉnh vị trí của $IStep7Address
Func IStep7AddressSetPos($x = -1,$y = -1)
	Local $Size = IStep7AddressGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep7Address,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep7Address
Func IStep7AddressSetSize($Width = -1,$Height = -1)
	Local $Size = IStep7AddressGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep7Address,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep7Address
Func IStep7AddressGetState()
	Return GUICtrlGetState($IStep7Address)
EndFunc
Func IStep7AddressSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep7Address,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep7Address
Func IStep7AddressColor($Color = 0x000000)
	GUICtrlSetColor($IStep7Address,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep7Address
Func IStep7AddressBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep7Address,$Color)
EndFunc