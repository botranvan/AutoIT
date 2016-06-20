;~ Bấm vào $CHMiddle
GUICtrlSetOnEvent($CHMiddle, "CHMiddleClick")
Func CHMiddleClick()
;~ 	$SpamCount = CHMiddleIsCheck()
;~ 	MsgBox(0,'',$SpamCount)
EndFunc

;~ CHMiddleTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHMiddleTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHMiddle"

	$Text = FT($ControlID,CHMiddleGet())

	CHMiddleSet($Text)
EndFunc

;Lưu trạng thái của CHMiddle xuống file
Func CHMiddleCheckSave()
	IniWrite($DataFile,"Setting","CHMiddleCheck",CHMiddleGet(0))
EndFunc

;Nạp trạng thái của CHMiddle từ file
;~ CHMiddleCheckLoad()
Func CHMiddleCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHMiddleCheck",CHMiddleGet(0))
	CHMiddleCheck($Data)
EndFunc

;~ Check và UnCheck $CHMiddle
Func CHMiddleCheck($check = 0)
	If $check == 1 Then	CHMiddleSetState($GUI_CHECKED)
	If $check == 4 Then	CHMiddleSetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHMiddle có đang check hay không
Func CHMiddleIsCheck()
	Local $State = CHMiddleGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHMiddleSave()
	IniWrite($DataFile,"Setting","CHMiddle",CHMiddleGet())
EndFunc
;Nạp giá trị của label từ file
Func CHMiddleLoad()
	Local $Data = IniRead($DataFile,"Setting","CHMiddle",CHMiddleGet())
	CHMiddleSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHMiddle
Func CHMiddleGet($Advanced = 0)
	Return GUICtrlRead($CHMiddle,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHMiddle
Func CHMiddleSet($NewValue = "")
	Local $Check = CHMiddleGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHMiddle,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHMiddle
Func CHMiddleGetPos()
	Return ControlGetPos($MainGUI, "", $CHMiddle)
EndFunc
;~ Chỉnh vị trí của $CHMiddle
Func CHMiddleSetPos($x = -1,$y = -1)
	Local $Size = CHMiddleGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHMiddle,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHMiddle
Func CHMiddleSetSize($Width = -1,$Height = -1)
	Local $Size = CHMiddleGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHMiddle,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHMiddle
Func CHMiddleGetState()
	Return GUICtrlGetState($CHMiddle)
EndFunc
Func CHMiddleSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHMiddle,$State)
EndFunc


;~ Chỉnh màu chữ của $CHMiddle
Func CHMiddleColor($Color = 0x000000)
	GUICtrlSetColor($CHMiddle,$Color)
EndFunc
;~ Chỉnh màu nền của $CHMiddle
Func CHMiddleBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHMiddle,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHMiddleFont($Size,$Weight)
	GUICtrlSetFont($CHMiddle,$Size,$Weight)
EndFunc