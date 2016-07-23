;~ Bấm vào $IHostAddress
GUICtrlSetOnEvent($IHostAddress, "IHostAddressChange")
Func IHostAddressChange()
;~	MsgBox(0,"72ls.NET","IHostAddressChange")
	IHostAddressSave()
EndFunc

IHostAddressLoad()
;~ IHostAddressTLoad()

;~ Nạp chuỗi ngôn ngữ của 1 control
Func IHostAddressTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IHostAddress"

	$Text = FT($ControlID,IHostAddressGet())

	IHostAddressSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IHostAddressTSave()
    FTWrite('IHostAddress',IHostAddressGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IHostAddressSave()
	IniWrite($DataFile,"Setting","IHostAddress",IHostAddressGet())
EndFunc

;Nạp giá trị của label từ file
Func IHostAddressLoad()
	Local $Data = IniRead($DataFile,"Setting","IHostAddress",IHostAddressGet())
	IHostAddressSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IHostAddress
Func IHostAddressGet()
	Return GUICtrlRead($IHostAddress)
EndFunc
;~ Lấy giá trị từ $IHostAddress
Func IHostAddressSet($NewValue = "")
	Local $Check = IHostAddressGet()
	If $Check <> $NewValue Then GUICtrlSetData($IHostAddress,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IHostAddress
Func IHostAddressGetPos()
	Return ControlGetPos($MainGUI, "", $IHostAddress)
EndFunc
;~ Chỉnh vị trí của $IHostAddress
Func IHostAddressSetPos($x = -1,$y = -1)
	Local $Size = IHostAddressGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IHostAddress,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IHostAddress
Func IHostAddressSetSize($Width = -1,$Height = -1)
	Local $Size = IHostAddressGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IHostAddress,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IHostAddress
Func IHostAddressGetState()
	Return GUICtrlGetState($IHostAddress)
EndFunc
Func IHostAddressSetState($State = $GUI_SHOW)
	GUICtrlSetState($IHostAddress,$State)
EndFunc


;~ Chỉnh màu chữ của $IHostAddress
Func IHostAddressColor($Color = 0x000000)
	GUICtrlSetColor($IHostAddress,$Color)
EndFunc
;~ Chỉnh màu nền của $IHostAddress
Func IHostAddressBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IHostAddress,$Color)
EndFunc