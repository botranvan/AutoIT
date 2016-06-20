;~ Bấm vào $LSkill9Key
Func LSkill9KeyClick()
	Local $Key = LSkill9KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill9KeySet($Key)
	$Skill[9][1] = LSkill9KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill9Key
Func LSkill9KeyGet()
	Return GUICtrlRead($LSkill9Key)
EndFunc
;~ Lấy giá trị từ $LSkill9Key
Func LSkill9KeySet($NewValue = "")
	Local $Check = LSkill9KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill9Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill9Key
Func LSkill9KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill9Key)
EndFunc
;~ Chỉnh vị trí của $LSkill9Key
Func LSkill9KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill9KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill9Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill9Key
Func LSkill9KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill9KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill9Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill9Key
Func LSkill9KeyGetState()
	Return GUICtrlGetState($LSkill9Key)
EndFunc
Func LSkill9KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill9Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill9Key
Func LSkill9KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill9Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill9Key
Func LSkill9KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill9Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================