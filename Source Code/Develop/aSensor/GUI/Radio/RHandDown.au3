;~ Bấm vào $RHandDown
GUICtrlSetOnEvent($RHandDown, "RHandDownClick")
Func RHandDownClick()
;~	msgbox(0,"hocautoit.com","RHandDownClick")
;~	$RSample = "Sample1"
;~	FRSampleSave()
EndFunc

;~ RHandDownTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func RHandDownTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "RHandDown"

	$Text = FT($ControlID,RHandDownGet())

	RHandDownSet($Text)
EndFunc

;Lưu trạng thái của RHandDown xuống file
Func RHandDownCheckSave()
	IniWrite($DataFile,"Setting","RHandDownCheck",RHandDownGet(0))
EndFunc

;Nạp trạng thái của RHandDown từ file
Func RHandDownCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandDownCheck",RHandDownGet(0))
	RHandDownCheck($Data)
EndFunc

;~ Check và UnCheck $RHandDown
Func RHandDownCheck($check = 0)
	If $check == 1 Then	RHandDownSetState($GUI_CHECKED)
	If $check == 4 Then	RHandDownSetState($GUI_UNCHECKED)
EndFunc

;Lưu giá trị trong label xuống file
Func RHandDownSave()
	IniWrite($DataFile,"Setting","RHandDown",RHandDownGet())
EndFunc
;Nạp giá trị của label từ file
Func RHandDownLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandDown",RHandDownGet())
	RHandDownSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $RHandDown
Func RHandDownGet($Advanced = 1)
	Return GUICtrlRead($RHandDown,$Advanced)
EndFunc
;~ Lấy giá trị từ $RHandDown
Func RHandDownSet($NewValue = "")
	Local $Check = RHandDownGet()
	If $Check <> $NewValue Then GUICtrlSetData($RHandDown,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $RHandDown
Func RHandDownGetPos()
	Return ControlGetPos($MainGUI, "", $RHandDown)
EndFunc
;~ Chỉnh vị trí của $RHandDown
Func RHandDownSetPos($x = -1,$y = -1)
	Local $Size = RHandDownGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($RHandDown,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $RHandDown
Func RHandDownSetSize($Width = -1,$Height = -1)
	Local $Size = RHandDownGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($RHandDown,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $RHandDown
Func RHandDownGetState()
	Return GUICtrlGetState($RHandDown)
EndFunc
Func RHandDownSetState($State = $GUI_SHOW)
	GUICtrlSetState($RHandDown,$State)
EndFunc


;~ Chỉnh màu chữ của $RHandDown
Func RHandDownColor($Color = 0x000000)
	GUICtrlSetColor($RHandDown,$Color)
EndFunc
;~ Chỉnh màu nền của $RHandDown
Func RHandDownBackGround($Color = 0x000000)
	GUICtrlSetBkColor($RHandDown,$Color)
EndFunc


;~ Kiểm tra xem $RHandDown có đang check hay không
Func RHandDownIsCheck()
	Local $State = RHandDownGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc