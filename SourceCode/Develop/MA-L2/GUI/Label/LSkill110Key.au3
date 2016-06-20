;~ Bấm vào $LSkill110Key
Func LSkill110KeyClick()
	Local $Key = LSkill110KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill110KeySet($Key)
	$Skill[110][1] = LSkill110KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill110Key
Func LSkill110KeyGet()
	Return GUICtrlRead($LSkill110Key)
EndFunc
;~ Lấy giá trị từ $LSkill110Key
Func LSkill110KeySet($NewValue = "")
	Local $Check = LSkill110KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill110Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill110Key
Func LSkill110KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill110Key)
EndFunc
;~ Chỉnh vị trí của $LSkill110Key
Func LSkill110KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill110KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill110Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill110Key
Func LSkill110KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill110KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill110Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill110Key
Func LSkill110KeyGetState()
	Return GUICtrlGetState($LSkill110Key)
EndFunc
Func LSkill110KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill110Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill110Key
Func LSkill110KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill110Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill110Key
Func LSkill110KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill110Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================