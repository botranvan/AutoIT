;~ Bấm vào $CHPinky
GUICtrlSetOnEvent($CHPinky, "CHPinkyClick")
Func CHPinkyClick()
;~ 	$SpamCount = CHPinkyIsCheck()
;~ 	MsgBox(0,'',$SpamCount)
EndFunc

;~ CHPinkyTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHPinkyTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHPinky"

	$Text = FT($ControlID,CHPinkyGet())

	CHPinkySet($Text)
EndFunc

;Lưu trạng thái của CHPinky xuống file
Func CHPinkyCheckSave()
	IniWrite($DataFile,"Setting","CHPinkyCheck",CHPinkyGet(0))
EndFunc

;Nạp trạng thái của CHPinky từ file
;~ CHPinkyCheckLoad()
Func CHPinkyCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHPinkyCheck",CHPinkyGet(0))
	CHPinkyCheck($Data)
EndFunc

;~ Check và UnCheck $CHPinky
Func CHPinkyCheck($check = 0)
	If $check == 1 Then	CHPinkySetState($GUI_CHECKED)
	If $check == 4 Then	CHPinkySetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHPinky có đang check hay không
Func CHPinkyIsCheck()
	Local $State = CHPinkyGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHPinkySave()
	IniWrite($DataFile,"Setting","CHPinky",CHPinkyGet())
EndFunc
;Nạp giá trị của label từ file
Func CHPinkyLoad()
	Local $Data = IniRead($DataFile,"Setting","CHPinky",CHPinkyGet())
	CHPinkySet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHPinky
Func CHPinkyGet($Advanced = 0)
	Return GUICtrlRead($CHPinky,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHPinky
Func CHPinkySet($NewValue = "")
	Local $Check = CHPinkyGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHPinky,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHPinky
Func CHPinkyGetPos()
	Return ControlGetPos($MainGUI, "", $CHPinky)
EndFunc
;~ Chỉnh vị trí của $CHPinky
Func CHPinkySetPos($x = -1,$y = -1)
	Local $Size = CHPinkyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHPinky,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHPinky
Func CHPinkySetSize($Width = -1,$Height = -1)
	Local $Size = CHPinkyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHPinky,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHPinky
Func CHPinkyGetState()
	Return GUICtrlGetState($CHPinky)
EndFunc
Func CHPinkySetState($State = $GUI_SHOW)
	GUICtrlSetState($CHPinky,$State)
EndFunc


;~ Chỉnh màu chữ của $CHPinky
Func CHPinkyColor($Color = 0x000000)
	GUICtrlSetColor($CHPinky,$Color)
EndFunc
;~ Chỉnh màu nền của $CHPinky
Func CHPinkyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHPinky,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHPinkyFont($Size,$Weight)
	GUICtrlSetFont($CHPinky,$Size,$Weight)
EndFunc