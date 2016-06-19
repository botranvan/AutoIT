;~ Bấm vào $LDone
GUICtrlSetOnEvent($LDone, "LDoneClick")
Func LDoneClick()
;~	MsgBox(0,"72ls.NET","LDoneClick")
EndFunc

LDoneTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LDoneTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LDone"

 	$Text = FT($ControlID,LDoneGet())

	LDoneSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LDoneSave()
	IniWrite($DataFile,"Setting","LDone",LDoneGet())
EndFunc

;Nạp giá trị của label từ file
Func LDoneLoad()
	Local $Data = IniRead($DataFile,"Setting","LDone",LDoneGet())
	LDoneSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LDone
Func LDoneGet()
	Return GUICtrlRead($LDone)
EndFunc
;~ Lấy giá trị từ $LDone
Func LDoneSet($NewValue = "")
	Local $Check = LDoneGet()
	If $Check <> $NewValue Then GUICtrlSetData($LDone,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LDone
Func LDoneGetPos()
	Return ControlGetPos($MainGUI, "", $LDone)
EndFunc
;~ Chỉnh vị trí của $LDone
Func LDoneSetPos($x = -1,$y = -1)
	Local $Size = LDoneGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LDone,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LDone
Func LDoneSetSize($Width = -1,$Height = -1)
	Local $Size = LDoneGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LDone,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LDone
Func LDoneGetState()
	Return GUICtrlGetState($LDone)
EndFunc
Func LDoneSetState($State = $GUI_SHOW)
	GUICtrlSetState($LDone,$State)
EndFunc


;~ Chỉnh màu chữ của $LDone
Func LDoneColor($Color = 0x000000)
	GUICtrlSetColor($LDone,$Color)
EndFunc
;~ Chỉnh màu nền của $LDone
Func LDoneBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LDone,$Color)
EndFunc