;~ Bấm vào $LSkill4Key
Func LSkill4KeyClick()
	Local $Key = LSkill4KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill4KeySet($Key)
	$Skill[4][1] = LSkill4KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill4Key
Func LSkill4KeyGet()
	Return GUICtrlRead($LSkill4Key)
EndFunc
;~ Lấy giá trị từ $LSkill4Key
Func LSkill4KeySet($NewValue = "")
	Local $Check = LSkill4KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill4Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill4Key
Func LSkill4KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill4Key)
EndFunc
;~ Chỉnh vị trí của $LSkill4Key
Func LSkill4KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill4KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill4Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill4Key
Func LSkill4KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill4KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill4Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill4Key
Func LSkill4KeyGetState()
	Return GUICtrlGetState($LSkill4Key)
EndFunc
Func LSkill4KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill4Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill4Key
Func LSkill4KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill4Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill4Key
Func LSkill4KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill4Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================