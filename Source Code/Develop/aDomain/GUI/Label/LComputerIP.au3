;~ Bấm vào $LComputerIP
GUICtrlSetOnEvent($LComputerIP, "LComputerIPClick")
Func LComputerIPClick()
;~	MsgBox(0,"72ls.NET","LComputerIPClick")
EndFunc

;~ LComputerIPTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LComputerIPTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LComputerIP"

 	$Text = FT($ControlID,LComputerIPGet())

	LComputerIPSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LComputerIPSave()
	IniWrite($DataFile,"Setting","LComputerIP",LComputerIPGet())
EndFunc

;Nạp giá trị của label từ file
Func LComputerIPLoad()
	Local $Data = IniRead($DataFile,"Setting","LComputerIP",LComputerIPGet())
	LComputerIPSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LComputerIP
Func LComputerIPGet()
	Return GUICtrlRead($LComputerIP)
EndFunc
;~ Lấy giá trị từ $LComputerIP
Func LComputerIPSet($NewValue = "")
	Local $Check = LComputerIPGet()
	If $Check <> $NewValue Then GUICtrlSetData($LComputerIP,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LComputerIP
Func LComputerIPGetPos()
	Return ControlGetPos($MainGUI, "", $LComputerIP)
EndFunc
;~ Chỉnh vị trí của $LComputerIP
Func LComputerIPSetPos($x = -1,$y = -1)
	Local $Size = LComputerIPGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LComputerIP,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LComputerIP
Func LComputerIPSetSize($Width = -1,$Height = -1)
	Local $Size = LComputerIPGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LComputerIP,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LComputerIP
Func LComputerIPGetState()
	Return GUICtrlGetState($LComputerIP)
EndFunc
Func LComputerIPSetState($State = $GUI_SHOW)
	GUICtrlSetState($LComputerIP,$State)
EndFunc


;~ Chỉnh màu chữ của $LComputerIP
Func LComputerIPColor($Color = 0x000000)
	GUICtrlSetColor($LComputerIP,$Color)
EndFunc
;~ Chỉnh màu nền của $LComputerIP
Func LComputerIPBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LComputerIP,$Color)
EndFunc