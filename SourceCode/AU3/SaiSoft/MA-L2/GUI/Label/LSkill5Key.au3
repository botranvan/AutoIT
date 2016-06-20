;~ Bấm vào $LSkill5Key
Func LSkill5KeyClick()
	Local $Key = LSkill5KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill5KeySet($Key)
	$Skill[5][1] = LSkill5KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill5Key
Func LSkill5KeyGet()
	Return GUICtrlRead($LSkill5Key)
EndFunc
;~ Lấy giá trị từ $LSkill5Key
Func LSkill5KeySet($NewValue = "")
	Local $Check = LSkill5KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill5Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill5Key
Func LSkill5KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill5Key)
EndFunc
;~ Chỉnh vị trí của $LSkill5Key
Func LSkill5KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill5KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill5Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill5Key
Func LSkill5KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill5KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill5Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill5Key
Func LSkill5KeyGetState()
	Return GUICtrlGetState($LSkill5Key)
EndFunc
Func LSkill5KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill5Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill5Key
Func LSkill5KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill5Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill5Key
Func LSkill5KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill5Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================