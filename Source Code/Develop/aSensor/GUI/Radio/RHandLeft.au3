;~ Bấm vào $RHandLeft
GUICtrlSetOnEvent($RHandLeft, "RHandLeftClick")
Func RHandLeftClick()
;~	msgbox(0,"hocautoit.com","RHandLeftClick")
;~	$RSample = "Sample1"
;~	FRSampleSave()
EndFunc

;~ RHandLeftTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func RHandLeftTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "RHandLeft"

	$Text = FT($ControlID,RHandLeftGet())

	RHandLeftSet($Text)
EndFunc

;Lưu trạng thái của RHandLeft xuống file
Func RHandLeftCheckSave()
	IniWrite($DataFile,"Setting","RHandLeftCheck",RHandLeftGet(0))
EndFunc

;Nạp trạng thái của RHandLeft từ file
Func RHandLeftCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandLeftCheck",RHandLeftGet(0))
	RHandLeftCheck($Data)
EndFunc

;~ Check và UnCheck $RHandLeft
Func RHandLeftCheck($check = 0)
	If $check == 1 Then	RHandLeftSetState($GUI_CHECKED)
	If $check == 4 Then	RHandLeftSetState($GUI_UNCHECKED)
EndFunc

;Lưu giá trị trong label xuống file
Func RHandLeftSave()
	IniWrite($DataFile,"Setting","RHandLeft",RHandLeftGet())
EndFunc
;Nạp giá trị của label từ file
Func RHandLeftLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandLeft",RHandLeftGet())
	RHandLeftSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $RHandLeft
Func RHandLeftGet($Advanced = 1)
	Return GUICtrlRead($RHandLeft,$Advanced)
EndFunc
;~ Lấy giá trị từ $RHandLeft
Func RHandLeftSet($NewValue = "")
	Local $Check = RHandLeftGet()
	If $Check <> $NewValue Then GUICtrlSetData($RHandLeft,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $RHandLeft
Func RHandLeftGetPos()
	Return ControlGetPos($MainGUI, "", $RHandLeft)
EndFunc
;~ Chỉnh vị trí của $RHandLeft
Func RHandLeftSetPos($x = -1,$y = -1)
	Local $Size = RHandLeftGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($RHandLeft,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $RHandLeft
Func RHandLeftSetSize($Width = -1,$Height = -1)
	Local $Size = RHandLeftGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($RHandLeft,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $RHandLeft
Func RHandLeftGetState()
	Return GUICtrlGetState($RHandLeft)
EndFunc
Func RHandLeftSetState($State = $GUI_SHOW)
	GUICtrlSetState($RHandLeft,$State)
EndFunc


;~ Chỉnh màu chữ của $RHandLeft
Func RHandLeftColor($Color = 0x000000)
	GUICtrlSetColor($RHandLeft,$Color)
EndFunc
;~ Chỉnh màu nền của $RHandLeft
Func RHandLeftBackGround($Color = 0x000000)
	GUICtrlSetBkColor($RHandLeft,$Color)
EndFunc


;~ Kiểm tra xem $RHandLeft có đang check hay không
Func RHandLeftIsCheck()
	Local $State = RHandLeftGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc