;~ Bấm vào $IStep2Address
GUICtrlSetOnEvent($IStep2Address, "IStep2AddressChange")
Func IStep2AddressChange()
;~	MsgBox(0,"72ls.NET","IStep2AddressChange")
	IStep2AddressSave()
EndFunc

;~ IStep2AddressTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep2AddressTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep2Address"

	$Text = FT($ControlID,IStep2AddressGet())

	IStep2AddressSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep2AddressTSave()
    FTWrite('IStep2Address',IStep2AddressGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep2AddressSave()
	IniWrite($DataFile,"Setting","IStep2Address",IStep2AddressGet())
EndFunc

;Nạp giá trị của label từ file
IStep2AddressLoad()
Func IStep2AddressLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep2Address",IStep2AddressGet())
	IStep2AddressSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep2Address
Func IStep2AddressGet()
	Return GUICtrlRead($IStep2Address)
EndFunc
;~ Lấy giá trị từ $IStep2Address
Func IStep2AddressSet($NewValue = "")
	Local $Check = IStep2AddressGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep2Address,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep2Address
Func IStep2AddressGetPos()
	Return ControlGetPos($MainGUI, "", $IStep2Address)
EndFunc
;~ Chỉnh vị trí của $IStep2Address
Func IStep2AddressSetPos($x = -1,$y = -1)
	Local $Size = IStep2AddressGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep2Address,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep2Address
Func IStep2AddressSetSize($Width = -1,$Height = -1)
	Local $Size = IStep2AddressGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep2Address,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep2Address
Func IStep2AddressGetState()
	Return GUICtrlGetState($IStep2Address)
EndFunc
Func IStep2AddressSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep2Address,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep2Address
Func IStep2AddressColor($Color = 0x000000)
	GUICtrlSetColor($IStep2Address,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep2Address
Func IStep2AddressBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep2Address,$Color)
EndFunc