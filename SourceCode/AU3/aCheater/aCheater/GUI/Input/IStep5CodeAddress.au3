;~ Bấm vào $IStep5CodeAddress
GUICtrlSetOnEvent($IStep5CodeAddress, "IStep5CodeAddressChange")
Func IStep5CodeAddressChange()
;~	MsgBox(0,"72ls.NET","IStep5CodeAddressChange")
	IStep5CodeAddressSave()
EndFunc

;~ IStep5CodeAddressTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep5CodeAddressTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep5CodeAddress"

	$Text = FT($ControlID,IStep5CodeAddressGet())

	IStep5CodeAddressSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep5CodeAddressTSave()
    FTWrite('IStep5CodeAddress',IStep5CodeAddressGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep5CodeAddressSave()
	IniWrite($DataFile,"Setting","IStep5CodeAddress",IStep5CodeAddressGet())
EndFunc

;Nạp giá trị của label từ file
IStep5CodeAddressLoad()
Func IStep5CodeAddressLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep5CodeAddress",IStep5CodeAddressGet())
	IStep5CodeAddressSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep5CodeAddress
Func IStep5CodeAddressGet()
	Return GUICtrlRead($IStep5CodeAddress)
EndFunc
;~ Lấy giá trị từ $IStep5CodeAddress
Func IStep5CodeAddressSet($NewValue = "")
	Local $Check = IStep5CodeAddressGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep5CodeAddress,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep5CodeAddress
Func IStep5CodeAddressGetPos()
	Return ControlGetPos($MainGUI, "", $IStep5CodeAddress)
EndFunc
;~ Chỉnh vị trí của $IStep5CodeAddress
Func IStep5CodeAddressSetPos($x = -1,$y = -1)
	Local $Size = IStep5CodeAddressGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep5CodeAddress,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep5CodeAddress
Func IStep5CodeAddressSetSize($Width = -1,$Height = -1)
	Local $Size = IStep5CodeAddressGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep5CodeAddress,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep5CodeAddress
Func IStep5CodeAddressGetState()
	Return GUICtrlGetState($IStep5CodeAddress)
EndFunc
Func IStep5CodeAddressSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep5CodeAddress,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep5CodeAddress
Func IStep5CodeAddressColor($Color = 0x000000)
	GUICtrlSetColor($IStep5CodeAddress,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep5CodeAddress
Func IStep5CodeAddressBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep5CodeAddress,$Color)
EndFunc