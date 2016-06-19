;~ Bấm vào $IStep1Address
GUICtrlSetOnEvent($IStep1Address, "IStep1AddressChange")
Func IStep1AddressChange()
;~	MsgBox(0,"72ls.NET","IStep1AddressChange")
	IStep1AddressSave()
EndFunc

;~ IStep1AddressTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep1AddressTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep1Address"

	$Text = FT($ControlID,IStep1AddressGet())

	IStep1AddressSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep1AddressTSave()
    FTWrite('IStep1Address',IStep1AddressGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep1AddressSave()
	IniWrite($DataFile,"Setting","IStep1Address",IStep1AddressGet())
EndFunc

;Nạp giá trị của label từ file
IStep1AddressLoad()
Func IStep1AddressLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep1Address",IStep1AddressGet())
	IStep1AddressSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep1Address
Func IStep1AddressGet()
	Return GUICtrlRead($IStep1Address)
EndFunc
;~ Lấy giá trị từ $IStep1Address
Func IStep1AddressSet($NewValue = "")
	Local $Check = IStep1AddressGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep1Address,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep1Address
Func IStep1AddressGetPos()
	Return ControlGetPos($MainGUI, "", $IStep1Address)
EndFunc
;~ Chỉnh vị trí của $IStep1Address
Func IStep1AddressSetPos($x = -1,$y = -1)
	Local $Size = IStep1AddressGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep1Address,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep1Address
Func IStep1AddressSetSize($Width = -1,$Height = -1)
	Local $Size = IStep1AddressGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep1Address,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep1Address
Func IStep1AddressGetState()
	Return GUICtrlGetState($IStep1Address)
EndFunc
Func IStep1AddressSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep1Address,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep1Address
Func IStep1AddressColor($Color = 0x000000)
	GUICtrlSetColor($IStep1Address,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep1Address
Func IStep1AddressBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep1Address,$Color)
EndFunc