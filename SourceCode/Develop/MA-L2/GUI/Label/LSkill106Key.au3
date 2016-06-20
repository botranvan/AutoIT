;~ Bấm vào $LSkill106Key
Func LSkill106KeyClick()
	Local $Key = LSkill106KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill106KeySet($Key)
	$Skill[106][1] = LSkill106KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill106Key
Func LSkill106KeyGet()
	Return GUICtrlRead($LSkill106Key)
EndFunc
;~ Lấy giá trị từ $LSkill106Key
Func LSkill106KeySet($NewValue = "")
	Local $Check = LSkill106KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill106Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill106Key
Func LSkill106KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill106Key)
EndFunc
;~ Chỉnh vị trí của $LSkill106Key
Func LSkill106KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill106KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill106Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill106Key
Func LSkill106KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill106KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill106Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill106Key
Func LSkill106KeyGetState()
	Return GUICtrlGetState($LSkill106Key)
EndFunc
Func LSkill106KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill106Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill106Key
Func LSkill106KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill106Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill106Key
Func LSkill106KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill106Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================