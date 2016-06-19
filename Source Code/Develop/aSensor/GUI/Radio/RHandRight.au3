;~ Bấm vào $RHandRight
GUICtrlSetOnEvent($RHandRight, "RHandRightClick")
Func RHandRightClick()
;~	msgbox(0,"hocautoit.com","RHandRightClick")
;~	$RSample = "Sample1"
;~	FRSampleSave()
EndFunc

;~ RHandRightTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func RHandRightTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "RHandRight"

	$Text = FT($ControlID,RHandRightGet())

	RHandRightSet($Text)
EndFunc

;Lưu trạng thái của RHandRight xuống file
Func RHandRightCheckSave()
	IniWrite($DataFile,"Setting","RHandRightCheck",RHandRightGet(0))
EndFunc

;Nạp trạng thái của RHandRight từ file
Func RHandRightCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandRightCheck",RHandRightGet(0))
	RHandRightCheck($Data)
EndFunc

;~ Check và UnCheck $RHandRight
Func RHandRightCheck($check = 0)
	If $check == 1 Then	RHandRightSetState($GUI_CHECKED)
	If $check == 4 Then	RHandRightSetState($GUI_UNCHECKED)
EndFunc

;Lưu giá trị trong label xuống file
Func RHandRightSave()
	IniWrite($DataFile,"Setting","RHandRight",RHandRightGet())
EndFunc
;Nạp giá trị của label từ file
Func RHandRightLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandRight",RHandRightGet())
	RHandRightSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $RHandRight
Func RHandRightGet($Advanced = 1)
	Return GUICtrlRead($RHandRight,$Advanced)
EndFunc
;~ Lấy giá trị từ $RHandRight
Func RHandRightSet($NewValue = "")
	Local $Check = RHandRightGet()
	If $Check <> $NewValue Then GUICtrlSetData($RHandRight,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $RHandRight
Func RHandRightGetPos()
	Return ControlGetPos($MainGUI, "", $RHandRight)
EndFunc
;~ Chỉnh vị trí của $RHandRight
Func RHandRightSetPos($x = -1,$y = -1)
	Local $Size = RHandRightGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($RHandRight,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $RHandRight
Func RHandRightSetSize($Width = -1,$Height = -1)
	Local $Size = RHandRightGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($RHandRight,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $RHandRight
Func RHandRightGetState()
	Return GUICtrlGetState($RHandRight)
EndFunc
Func RHandRightSetState($State = $GUI_SHOW)
	GUICtrlSetState($RHandRight,$State)
EndFunc


;~ Chỉnh màu chữ của $RHandRight
Func RHandRightColor($Color = 0x000000)
	GUICtrlSetColor($RHandRight,$Color)
EndFunc
;~ Chỉnh màu nền của $RHandRight
Func RHandRightBackGround($Color = 0x000000)
	GUICtrlSetBkColor($RHandRight,$Color)
EndFunc


;~ Kiểm tra xem $RHandRight có đang check hay không
Func RHandRightIsCheck()
	Local $State = RHandRightGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc