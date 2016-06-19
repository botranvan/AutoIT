;~ Bấm vào $LGroundPos
GUICtrlSetOnEvent($LGroundPos, "LGroundPosClick")
Func LGroundPosClick()
;~	MsgBox(0,"72ls.NET","LGroundPosClick")
EndFunc

;~ LGroundPosTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LGroundPosTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LGroundPos"

 	$Text = FT($ControlID,LGroundPosGet())

	LGroundPosSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LGroundPosSave()
	IniWrite($DataFile,"Setting","LGroundPos",LGroundPosGet())
EndFunc

;Nạp giá trị của label từ file
Func LGroundPosLoad()
	Local $Data = IniRead($DataFile,"Setting","LGroundPos",LGroundPosGet())
	LGroundPosSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LGroundPos
Func LGroundPosGet()
	Return GUICtrlRead($LGroundPos)
EndFunc
;~ Lấy giá trị từ $LGroundPos
Func LGroundPosSet($NewValue = "")
	Local $Check = LGroundPosGet()
	If $Check <> $NewValue Then GUICtrlSetData($LGroundPos,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LGroundPos
Func LGroundPosGetPos()
	Return ControlGetPos($MainGUI, "", $LGroundPos)
EndFunc
;~ Chỉnh vị trí của $LGroundPos
Func LGroundPosSetPos($x = -1,$y = -1)
	Local $Size = LGroundPosGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LGroundPos,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LGroundPos
Func LGroundPosSetSize($Width = -1,$Height = -1)
	Local $Size = LGroundPosGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LGroundPos,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LGroundPos
Func LGroundPosGetState()
	Return GUICtrlGetState($LGroundPos)
EndFunc
Func LGroundPosSetState($State = $GUI_SHOW)
	GUICtrlSetState($LGroundPos,$State)
EndFunc


;~ Chỉnh màu chữ của $LGroundPos
Func LGroundPosColor($Color = 0x000000)
	GUICtrlSetColor($LGroundPos,$Color)
EndFunc
;~ Chỉnh màu nền của $LGroundPos
Func LGroundPosBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LGroundPos,$Color)
EndFunc