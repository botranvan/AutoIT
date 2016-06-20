;~ Bấm vào $LDomainIP
GUICtrlSetOnEvent($LDomainIP, "LDomainIPClick")
Func LDomainIPClick()
;~	MsgBox(0,"72ls.NET","LDomainIPClick")
EndFunc

;~ LDomainIPTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LDomainIPTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LDomainIP"

 	$Text = FT($ControlID,LDomainIPGet())

	LDomainIPSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LDomainIPSave()
	IniWrite($DataFile,"Setting","LDomainIP",LDomainIPGet())
EndFunc

;Nạp giá trị của label từ file
Func LDomainIPLoad()
	Local $Data = IniRead($DataFile,"Setting","LDomainIP",LDomainIPGet())
	LDomainIPSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LDomainIP
Func LDomainIPGet()
	Return GUICtrlRead($LDomainIP)
EndFunc
;~ Lấy giá trị từ $LDomainIP
Func LDomainIPSet($NewValue = "")
	Local $Check = LDomainIPGet()
	If $Check <> $NewValue Then GUICtrlSetData($LDomainIP,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LDomainIP
Func LDomainIPGetPos()
	Return ControlGetPos($MainGUI, "", $LDomainIP)
EndFunc
;~ Chỉnh vị trí của $LDomainIP
Func LDomainIPSetPos($x = -1,$y = -1)
	Local $Size = LDomainIPGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LDomainIP,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LDomainIP
Func LDomainIPSetSize($Width = -1,$Height = -1)
	Local $Size = LDomainIPGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LDomainIP,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LDomainIP
Func LDomainIPGetState()
	Return GUICtrlGetState($LDomainIP)
EndFunc
Func LDomainIPSetState($State = $GUI_SHOW)
	GUICtrlSetState($LDomainIP,$State)
EndFunc


;~ Chỉnh màu chữ của $LDomainIP
Func LDomainIPColor($Color = 0x000000)
	GUICtrlSetColor($LDomainIP,$Color)
EndFunc
;~ Chỉnh màu nền của $LDomainIP
Func LDomainIPBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LDomainIP,$Color)
EndFunc