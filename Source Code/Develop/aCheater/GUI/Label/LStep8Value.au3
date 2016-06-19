;~ Bấm vào $LStep8Value
GUICtrlSetOnEvent($LStep8Value, "LStep8ValueClick")
Func LStep8ValueClick()
	$Step8ValueIsHex = Not $Step8ValueIsHex
EndFunc

;~ LStep8ValueTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LStep8ValueTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LStep8Value"

 	$Text = FT($ControlID,LStep8ValueGet())

	LStep8ValueSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LStep8ValueSave()
	IniWrite($DataFile,"Setting","LStep8Value",LStep8ValueGet())
EndFunc

;Nạp giá trị của label từ file
Func LStep8ValueLoad()
	Local $Data = IniRead($DataFile,"Setting","LStep8Value",LStep8ValueGet())
	LStep8ValueSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LStep8Value
Func LStep8ValueGet()
	Return GUICtrlRead($LStep8Value)
EndFunc
;~ Lấy giá trị từ $LStep8Value
Func LStep8ValueSet($NewValue = "")
	Local $Check = LStep8ValueGet()
	If $Check <> $NewValue Then GUICtrlSetData($LStep8Value,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LStep8Value
Func LStep8ValueGetPos()
	Return ControlGetPos($MainGUI, "", $LStep8Value)
EndFunc
;~ Chỉnh vị trí của $LStep8Value
Func LStep8ValueSetPos($x = -1,$y = -1)
	Local $Size = LStep8ValueGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LStep8Value,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LStep8Value
Func LStep8ValueSetSize($Width = -1,$Height = -1)
	Local $Size = LStep8ValueGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LStep8Value,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LStep8Value
Func LStep8ValueGetState()
	Return GUICtrlGetState($LStep8Value)
EndFunc
Func LStep8ValueSetState($State = $GUI_SHOW)
	GUICtrlSetState($LStep8Value,$State)
EndFunc


;~ Chỉnh màu chữ của $LStep8Value
Func LStep8ValueColor($Color = 0x000000)
	GUICtrlSetColor($LStep8Value,$Color)
EndFunc
;~ Chỉnh màu nền của $LStep8Value
Func LStep8ValueBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LStep8Value,$Color)
EndFunc