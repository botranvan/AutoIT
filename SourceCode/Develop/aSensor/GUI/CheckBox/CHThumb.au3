;~ Bấm vào $CHThumb
GUICtrlSetOnEvent($CHThumb, "CHThumbClick")
Func CHThumbClick()
;~ 	$SpamCount = CHThumbIsCheck()
;~ 	MsgBox(0,'',$SpamCount)
EndFunc

;~ CHThumbTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHThumbTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHThumb"

	$Text = FT($ControlID,CHThumbGet())

	CHThumbSet($Text)
EndFunc

;Lưu trạng thái của CHThumb xuống file
Func CHThumbCheckSave()
	IniWrite($DataFile,"Setting","CHThumbCheck",CHThumbGet(0))
EndFunc

;Nạp trạng thái của CHThumb từ file
;~ CHThumbCheckLoad()
Func CHThumbCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHThumbCheck",CHThumbGet(0))
	CHThumbCheck($Data)
EndFunc

;~ Check và UnCheck $CHThumb
Func CHThumbCheck($check = 0)
	If $check == 1 Then	CHThumbSetState($GUI_CHECKED)
	If $check == 4 Then	CHThumbSetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHThumb có đang check hay không
Func CHThumbIsCheck()
	Local $State = CHThumbGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHThumbSave()
	IniWrite($DataFile,"Setting","CHThumb",CHThumbGet())
EndFunc
;Nạp giá trị của label từ file
Func CHThumbLoad()
	Local $Data = IniRead($DataFile,"Setting","CHThumb",CHThumbGet())
	CHThumbSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHThumb
Func CHThumbGet($Advanced = 0)
	Return GUICtrlRead($CHThumb,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHThumb
Func CHThumbSet($NewValue = "")
	Local $Check = CHThumbGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHThumb,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHThumb
Func CHThumbGetPos()
	Return ControlGetPos($MainGUI, "", $CHThumb)
EndFunc
;~ Chỉnh vị trí của $CHThumb
Func CHThumbSetPos($x = -1,$y = -1)
	Local $Size = CHThumbGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHThumb,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHThumb
Func CHThumbSetSize($Width = -1,$Height = -1)
	Local $Size = CHThumbGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHThumb,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHThumb
Func CHThumbGetState()
	Return GUICtrlGetState($CHThumb)
EndFunc
Func CHThumbSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHThumb,$State)
EndFunc


;~ Chỉnh màu chữ của $CHThumb
Func CHThumbColor($Color = 0x000000)
	GUICtrlSetColor($CHThumb,$Color)
EndFunc
;~ Chỉnh màu nền của $CHThumb
Func CHThumbBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHThumb,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHThumbFont($Size,$Weight)
	GUICtrlSetFont($CHThumb,$Size,$Weight)
EndFunc