;~ Bấm vào $LStep2Heath
GUICtrlSetOnEvent($LStep2Heath, "LStep2HeathClick")
Func LStep2HeathClick()
;~	MsgBox(0,"72ls.NET","LStep2HeathClick")
EndFunc

;~ LStep2HeathTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LStep2HeathTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LStep2Heath"

 	$Text = FT($ControlID,LStep2HeathGet())

	LStep2HeathSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LStep2HeathSave()
	IniWrite($DataFile,"Setting","LStep2Heath",LStep2HeathGet())
EndFunc

;Nạp giá trị của label từ file
Func LStep2HeathLoad()
	Local $Data = IniRead($DataFile,"Setting","LStep2Heath",LStep2HeathGet())
	LStep2HeathSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LStep2Heath
Func LStep2HeathGet()
	Return GUICtrlRead($LStep2Heath)
EndFunc
;~ Lấy giá trị từ $LStep2Heath
Func LStep2HeathSet($NewValue = "")
	Local $Check = LStep2HeathGet()
	If $Check <> $NewValue Then GUICtrlSetData($LStep2Heath,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LStep2Heath
Func LStep2HeathGetPos()
	Return ControlGetPos($MainGUI, "", $LStep2Heath)
EndFunc
;~ Chỉnh vị trí của $LStep2Heath
Func LStep2HeathSetPos($x = -1,$y = -1)
	Local $Size = LStep2HeathGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LStep2Heath,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LStep2Heath
Func LStep2HeathSetSize($Width = -1,$Height = -1)
	Local $Size = LStep2HeathGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LStep2Heath,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LStep2Heath
Func LStep2HeathGetState()
	Return GUICtrlGetState($LStep2Heath)
EndFunc
Func LStep2HeathSetState($State = $GUI_SHOW)
	GUICtrlSetState($LStep2Heath,$State)
EndFunc


;~ Chỉnh màu chữ của $LStep2Heath
Func LStep2HeathColor($Color = 0x000000)
	GUICtrlSetColor($LStep2Heath,$Color)
EndFunc
;~ Chỉnh màu nền của $LStep2Heath
Func LStep2HeathBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LStep2Heath,$Color)
EndFunc