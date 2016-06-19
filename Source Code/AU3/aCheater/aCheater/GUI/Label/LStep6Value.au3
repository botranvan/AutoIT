;~ Bấm vào $LStep6Value
GUICtrlSetOnEvent($LStep6Value, "LStep6ValueClick")
Func LStep6ValueClick()
	$Step6ValueIsHex = Not $Step6ValueIsHex
EndFunc

;~ LStep6ValueTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LStep6ValueTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LStep6Value"

 	$Text = FT($ControlID,LStep6ValueGet())

	LStep6ValueSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LStep6ValueSave()
	IniWrite($DataFile,"Setting","LStep6Value",LStep6ValueGet())
EndFunc

;Nạp giá trị của label từ file
Func LStep6ValueLoad()
	Local $Data = IniRead($DataFile,"Setting","LStep6Value",LStep6ValueGet())
	LStep6ValueSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LStep6Value
Func LStep6ValueGet()
	Return GUICtrlRead($LStep6Value)
EndFunc
;~ Lấy giá trị từ $LStep6Value
Func LStep6ValueSet($NewValue = "")
	Local $Check = LStep6ValueGet()
	If $Check <> $NewValue Then GUICtrlSetData($LStep6Value,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LStep6Value
Func LStep6ValueGetPos()
	Return ControlGetPos($MainGUI, "", $LStep6Value)
EndFunc
;~ Chỉnh vị trí của $LStep6Value
Func LStep6ValueSetPos($x = -1,$y = -1)
	Local $Size = LStep6ValueGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LStep6Value,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LStep6Value
Func LStep6ValueSetSize($Width = -1,$Height = -1)
	Local $Size = LStep6ValueGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LStep6Value,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LStep6Value
Func LStep6ValueGetState()
	Return GUICtrlGetState($LStep6Value)
EndFunc
Func LStep6ValueSetState($State = $GUI_SHOW)
	GUICtrlSetState($LStep6Value,$State)
EndFunc


;~ Chỉnh màu chữ của $LStep6Value
Func LStep6ValueColor($Color = 0x000000)
	GUICtrlSetColor($LStep6Value,$Color)
EndFunc
;~ Chỉnh màu nền của $LStep6Value
Func LStep6ValueBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LStep6Value,$Color)
EndFunc