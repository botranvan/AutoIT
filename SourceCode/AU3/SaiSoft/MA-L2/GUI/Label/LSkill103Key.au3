;~ Bấm vào $LSkill103Key
Func LSkill103KeyClick()
	Local $Key = LSkill103KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill103KeySet($Key)
	$Skill[103][1] = LSkill103KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill103Key
Func LSkill103KeyGet()
	Return GUICtrlRead($LSkill103Key)
EndFunc
;~ Lấy giá trị từ $LSkill103Key
Func LSkill103KeySet($NewValue = "")
	Local $Check = LSkill103KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill103Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill103Key
Func LSkill103KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill103Key)
EndFunc
;~ Chỉnh vị trí của $LSkill103Key
Func LSkill103KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill103KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill103Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill103Key
Func LSkill103KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill103KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill103Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill103Key
Func LSkill103KeyGetState()
	Return GUICtrlGetState($LSkill103Key)
EndFunc
Func LSkill103KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill103Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill103Key
Func LSkill103KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill103Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill103Key
Func LSkill103KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill103Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================