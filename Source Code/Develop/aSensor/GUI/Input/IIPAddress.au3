;~ Bấm vào $IIPAddress
GUICtrlSetOnEvent($IIPAddress, "IIPAddressChange")
Func IIPAddressChange()
;~	MsgBox(0,"72ls.NET","IIPAddressChange")
;~	IIPAddressSave()
EndFunc

;~ IIPAddressTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IIPAddressTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IIPAddress"

	$Text = FT($ControlID,IIPAddressGet())

	IIPAddressSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IIPAddressTSave()
    FTWrite('IIPAddress',IIPAddressGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IIPAddressSave()
	IniWrite($DataFile,"Setting","IIPAddress",IIPAddressGet())
EndFunc

;Nạp giá trị của label từ file
Func IIPAddressLoad()
	Local $Data = IniRead($DataFile,"Setting","IIPAddress",IIPAddressGet())
	IIPAddressSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IIPAddress
Func IIPAddressGet()
	Return GUICtrlRead($IIPAddress)
EndFunc
;~ Lấy giá trị từ $IIPAddress
Func IIPAddressSet($NewValue = "")
	Local $Check = IIPAddressGet()
	If $Check <> $NewValue Then GUICtrlSetData($IIPAddress,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IIPAddress
Func IIPAddressGetPos()
	Return ControlGetPos($MainGUI, "", $IIPAddress)
EndFunc
;~ Chỉnh vị trí của $IIPAddress
Func IIPAddressSetPos($x = -1,$y = -1)
	Local $Size = IIPAddressGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IIPAddress,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IIPAddress
Func IIPAddressSetSize($Width = -1,$Height = -1)
	Local $Size = IIPAddressGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IIPAddress,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IIPAddress
Func IIPAddressGetState()
	Return GUICtrlGetState($IIPAddress)
EndFunc
Func IIPAddressSetState($State = $GUI_SHOW)
	GUICtrlSetState($IIPAddress,$State)
EndFunc


;~ Chỉnh màu chữ của $IIPAddress
Func IIPAddressColor($Color = 0x000000)
	GUICtrlSetColor($IIPAddress,$Color)
EndFunc
;~ Chỉnh màu nền của $IIPAddress
Func IIPAddressBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IIPAddress,$Color)
EndFunc