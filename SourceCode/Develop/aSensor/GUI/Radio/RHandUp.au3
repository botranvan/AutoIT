;~ Bấm vào $RHandUp
GUICtrlSetOnEvent($RHandUp, "RHandUpClick")
Func RHandUpClick()
;~	msgbox(0,"hocautoit.com","RHandUpClick")
;~	$RSample = "Sample1"
;~	FRSampleSave()
EndFunc

;~ RHandUpTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func RHandUpTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "RHandUp"

	$Text = FT($ControlID,RHandUpGet())

	RHandUpSet($Text)
EndFunc

;Lưu trạng thái của RHandUp xuống file
Func RHandUpCheckSave()
	IniWrite($DataFile,"Setting","RHandUpCheck",RHandUpGet(0))
EndFunc

;Nạp trạng thái của RHandUp từ file
Func RHandUpCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandUpCheck",RHandUpGet(0))
	RHandUpCheck($Data)
EndFunc

;~ Check và UnCheck $RHandUp
Func RHandUpCheck($check = 0)
	If $check == 1 Then	RHandUpSetState($GUI_CHECKED)
	If $check == 4 Then	RHandUpSetState($GUI_UNCHECKED)
EndFunc

;Lưu giá trị trong label xuống file
Func RHandUpSave()
	IniWrite($DataFile,"Setting","RHandUp",RHandUpGet())
EndFunc
;Nạp giá trị của label từ file
Func RHandUpLoad()
	Local $Data = IniRead($DataFile,"Setting","RHandUp",RHandUpGet())
	RHandUpSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $RHandUp
Func RHandUpGet($Advanced = 1)
	Return GUICtrlRead($RHandUp,$Advanced)
EndFunc
;~ Lấy giá trị từ $RHandUp
Func RHandUpSet($NewValue = "")
	Local $Check = RHandUpGet()
	If $Check <> $NewValue Then GUICtrlSetData($RHandUp,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $RHandUp
Func RHandUpGetPos()
	Return ControlGetPos($MainGUI, "", $RHandUp)
EndFunc
;~ Chỉnh vị trí của $RHandUp
Func RHandUpSetPos($x = -1,$y = -1)
	Local $Size = RHandUpGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($RHandUp,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $RHandUp
Func RHandUpSetSize($Width = -1,$Height = -1)
	Local $Size = RHandUpGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($RHandUp,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $RHandUp
Func RHandUpGetState()
	Return GUICtrlGetState($RHandUp)
EndFunc
Func RHandUpSetState($State = $GUI_SHOW)
	GUICtrlSetState($RHandUp,$State)
EndFunc


;~ Chỉnh màu chữ của $RHandUp
Func RHandUpColor($Color = 0x000000)
	GUICtrlSetColor($RHandUp,$Color)
EndFunc
;~ Chỉnh màu nền của $RHandUp
Func RHandUpBackGround($Color = 0x000000)
	GUICtrlSetBkColor($RHandUp,$Color)
EndFunc


;~ Kiểm tra xem $RHandUp có đang check hay không
Func RHandUpIsCheck()
	Local $State = RHandUpGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc