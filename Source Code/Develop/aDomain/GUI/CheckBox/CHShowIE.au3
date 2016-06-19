;~ Bấm vào $CHShowIE
GUICtrlSetOnEvent($CHShowIE, "CHShowIEClick")
Func CHShowIEClick()
	$ShowIE = CHShowIEIsCheck()
EndFunc

;~ CHShowIETLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHShowIETLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHShowIE"

	$Text = FT($ControlID,CHShowIEGet())

	CHShowIESet($Text)
EndFunc

;Lưu trạng thái của CHShowIE xuống file
Func CHShowIECheckSave()
	IniWrite($DataFile,"Setting","CHShowIECheck",CHShowIEGet(0))
EndFunc

;Nạp trạng thái của CHShowIE từ file
;~ CHShowIECheckLoad()
Func CHShowIECheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHShowIECheck",CHShowIEGet(0))
	CHShowIECheck($Data)
EndFunc

;~ Check và UnCheck $CHShowIE
Func CHShowIECheck($check = 0)
	If $check == 1 Then	CHShowIESetState($GUI_CHECKED)
	If $check == 4 Then	CHShowIESetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHShowIE có đang check hay không
Func CHShowIEIsCheck()
	Local $State = CHShowIEGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHShowIESave()
	IniWrite($DataFile,"Setting","CHShowIE",CHShowIEGet())
EndFunc
;Nạp giá trị của label từ file
Func CHShowIELoad()
	Local $Data = IniRead($DataFile,"Setting","CHShowIE",CHShowIEGet())
	CHShowIESet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHShowIE
Func CHShowIEGet($Advanced = 0)
	Return GUICtrlRead($CHShowIE,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHShowIE
Func CHShowIESet($NewValue = "")
	Local $Check = CHShowIEGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHShowIE,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHShowIE
Func CHShowIEGetPos()
	Return ControlGetPos($MainGUI, "", $CHShowIE)
EndFunc
;~ Chỉnh vị trí của $CHShowIE
Func CHShowIESetPos($x = -1,$y = -1)
	Local $Size = CHShowIEGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHShowIE,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHShowIE
Func CHShowIESetSize($Width = -1,$Height = -1)
	Local $Size = CHShowIEGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHShowIE,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHShowIE
Func CHShowIEGetState()
	Return GUICtrlGetState($CHShowIE)
EndFunc
Func CHShowIESetState($State = $GUI_SHOW)
	GUICtrlSetState($CHShowIE,$State)
EndFunc


;~ Chỉnh màu chữ của $CHShowIE
Func CHShowIEColor($Color = 0x000000)
	GUICtrlSetColor($CHShowIE,$Color)
EndFunc
;~ Chỉnh màu nền của $CHShowIE
Func CHShowIEBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHShowIE,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHShowIEFont($Size,$Weight)
	GUICtrlSetFont($CHShowIE,$Size,$Weight)
EndFunc