;~ Bấm vào $LCharPos
GUICtrlSetOnEvent($LCharPos, "LCharPosClick")
Func LCharPosClick()
;~	MsgBox(0,"72ls.NET","LCharPosClick")
EndFunc

;~ LCharPosTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LCharPosTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LCharPos"

 	$Text = FT($ControlID,LCharPosGet())

	LCharPosSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LCharPosSave()
	IniWrite($DataFile,"Setting","LCharPos",LCharPosGet())
EndFunc

;Nạp giá trị của label từ file
Func LCharPosLoad()
	Local $Data = IniRead($DataFile,"Setting","LCharPos",LCharPosGet())
	LCharPosSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LCharPos
Func LCharPosGet()
	Return GUICtrlRead($LCharPos)
EndFunc
;~ Lấy giá trị từ $LCharPos
Func LCharPosSet($NewValue = "")
	Local $Check = LCharPosGet()
	If $Check <> $NewValue Then GUICtrlSetData($LCharPos,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LCharPos
Func LCharPosGetPos()
	Return ControlGetPos($MainGUI, "", $LCharPos)
EndFunc
;~ Chỉnh vị trí của $LCharPos
Func LCharPosSetPos($x = -1,$y = -1)
	Local $Size = LCharPosGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LCharPos,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LCharPos
Func LCharPosSetSize($Width = -1,$Height = -1)
	Local $Size = LCharPosGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LCharPos,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LCharPos
Func LCharPosGetState()
	Return GUICtrlGetState($LCharPos)
EndFunc
Func LCharPosSetState($State = $GUI_SHOW)
	GUICtrlSetState($LCharPos,$State)
EndFunc


;~ Chỉnh màu chữ của $LCharPos
Func LCharPosColor($Color = 0x000000)
	GUICtrlSetColor($LCharPos,$Color)
EndFunc
;~ Chỉnh màu nền của $LCharPos
Func LCharPosBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LCharPos,$Color)
EndFunc