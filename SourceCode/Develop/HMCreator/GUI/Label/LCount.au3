;~ Bấm vào $LCount
GUICtrlSetOnEvent($LCount, "LCountClick")
Func LCountClick()
;~	MsgBox(0,"72ls.NET","LCountClick")
EndFunc

;~ LCountTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LCountTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LCount"

 	$Text = FT($ControlID,LCountGet())

	LCountSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LCountSave()
	IniWrite($DataFile,"Setting","LCount",LCountGet())
EndFunc

;Nạp giá trị của label từ file
Func LCountLoad()
	Local $Data = IniRead($DataFile,"Setting","LCount",LCountGet())
	LCountSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LCount
Func LCountGet()
	Return GUICtrlRead($LCount)
EndFunc
;~ Lấy giá trị từ $LCount
Func LCountSet($NewValue = "")
	Local $Check = LCountGet()
	If $Check <> $NewValue Then GUICtrlSetData($LCount,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LCount
Func LCountGetPos()
	Return ControlGetPos($MainGUI, "", $LCount)
EndFunc
;~ Chỉnh vị trí của $LCount
Func LCountSetPos($x = -1,$y = -1)
	Local $Size = LCountGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LCount,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LCount
Func LCountSetSize($Width = -1,$Height = -1)
	Local $Size = LCountGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LCount,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LCount
Func LCountGetState()
	Return GUICtrlGetState($LCount)
EndFunc
Func LCountSetState($State = $GUI_SHOW)
	GUICtrlSetState($LCount,$State)
EndFunc


;~ Chỉnh màu chữ của $LCount
Func LCountColor($Color = 0x000000)
	GUICtrlSetColor($LCount,$Color)
EndFunc
;~ Chỉnh màu nền của $LCount
Func LCountBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LCount,$Color)
EndFunc