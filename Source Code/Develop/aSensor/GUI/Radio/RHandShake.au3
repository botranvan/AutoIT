;~ Bấm vào $RHandShake
GUICtrlSetOnEvent($RHandShake, "RHandShakeClick")
Func RHandShakeClick()
;~	msgbox(0,"hocautoit.com","RHandShakeClick")
;~	$RSample = "Sample1"
;~	FRSampleSave()
EndFunc

;~ RHandShakeTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func RHandShakeTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "RHandShake"

	$Text = FT($ControlID,RHandShakeGet())

	RHandShakeSet($Text)
EndFunc

;Lưu trạng thái của RHandShake xuống file
Func RHandShakeCheckSave()
	IniWrite($DataFile,"Setting","RHandShakeCheck",RHandShakeGet(0))
EndFunc

;Nạp trạng thái của RHandShake từ file
Func RHandShakeCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandShakeCheck",RHandShakeGet(0))
	RHandShakeCheck($Data)
EndFunc

;~ Check và UnCheck $RHandShake
Func RHandShakeCheck($check = 0)
	If $check == 1 Then	RHandShakeSetState($GUI_CHECKED)
	If $check == 4 Then	RHandShakeSetState($GUI_UNCHECKED)
EndFunc

;Lưu giá trị trong label xuống file
Func RHandShakeSave()
	IniWrite($DataFile,"Setting","RHandShake",RHandShakeGet())
EndFunc
;Nạp giá trị của label từ file
Func RHandShakeLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandShake",RHandShakeGet())
	RHandShakeSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $RHandShake
Func RHandShakeGet($Advanced = 1)
	Return GUICtrlRead($RHandShake,$Advanced)
EndFunc
;~ Lấy giá trị từ $RHandShake
Func RHandShakeSet($NewValue = "")
	Local $Check = RHandShakeGet()
	If $Check <> $NewValue Then GUICtrlSetData($RHandShake,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $RHandShake
Func RHandShakeGetPos()
	Return ControlGetPos($MainGUI, "", $RHandShake)
EndFunc
;~ Chỉnh vị trí của $RHandShake
Func RHandShakeSetPos($x = -1,$y = -1)
	Local $Size = RHandShakeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($RHandShake,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $RHandShake
Func RHandShakeSetSize($Width = -1,$Height = -1)
	Local $Size = RHandShakeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($RHandShake,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $RHandShake
Func RHandShakeGetState()
	Return GUICtrlGetState($RHandShake)
EndFunc
Func RHandShakeSetState($State = $GUI_SHOW)
	GUICtrlSetState($RHandShake,$State)
EndFunc


;~ Chỉnh màu chữ của $RHandShake
Func RHandShakeColor($Color = 0x000000)
	GUICtrlSetColor($RHandShake,$Color)
EndFunc
;~ Chỉnh màu nền của $RHandShake
Func RHandShakeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($RHandShake,$Color)
EndFunc

;~ Kiểm tra xem $RHandShake có đang check hay không
Func RHandShakeIsCheck()
	Local $State = RHandShakeGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc