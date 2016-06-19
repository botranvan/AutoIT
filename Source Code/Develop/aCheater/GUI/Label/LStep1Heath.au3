;~ Bấm vào $LStep1Heath
GUICtrlSetOnEvent($LStep1Heath, "LStep1HeathClick")
Func LStep1HeathClick()
;~	MsgBox(0,"72ls.NET","LStep1HeathClick")
EndFunc

;~ LStep1HeathTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LStep1HeathTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LStep1Heath"

 	$Text = FT($ControlID,LStep1HeathGet())

	LStep1HeathSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LStep1HeathSave()
	IniWrite($DataFile,"Setting","LStep1Heath",LStep1HeathGet())
EndFunc

;Nạp giá trị của label từ file
Func LStep1HeathLoad()
	Local $Data = IniRead($DataFile,"Setting","LStep1Heath",LStep1HeathGet())
	LStep1HeathSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LStep1Heath
Func LStep1HeathGet()
	Return GUICtrlRead($LStep1Heath)
EndFunc
;~ Lấy giá trị từ $LStep1Heath
Func LStep1HeathSet($NewValue = "")
	Local $Check = LStep1HeathGet()
	If $Check <> $NewValue Then GUICtrlSetData($LStep1Heath,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LStep1Heath
Func LStep1HeathGetPos()
	Return ControlGetPos($MainGUI, "", $LStep1Heath)
EndFunc
;~ Chỉnh vị trí của $LStep1Heath
Func LStep1HeathSetPos($x = -1,$y = -1)
	Local $Size = LStep1HeathGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LStep1Heath,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LStep1Heath
Func LStep1HeathSetSize($Width = -1,$Height = -1)
	Local $Size = LStep1HeathGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LStep1Heath,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LStep1Heath
Func LStep1HeathGetState()
	Return GUICtrlGetState($LStep1Heath)
EndFunc
Func LStep1HeathSetState($State = $GUI_SHOW)
	GUICtrlSetState($LStep1Heath,$State)
EndFunc


;~ Chỉnh màu chữ của $LStep1Heath
Func LStep1HeathColor($Color = 0x000000)
	GUICtrlSetColor($LStep1Heath,$Color)
EndFunc
;~ Chỉnh màu nền của $LStep1Heath
Func LStep1HeathBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LStep1Heath,$Color)
EndFunc