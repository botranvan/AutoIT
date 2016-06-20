;~ Bấm vào $LSkill104Key
Func LSkill104KeyClick()
	Local $Key = LSkill104KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill104KeySet($Key)
	$Skill[104][1] = LSkill104KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill104Key
Func LSkill104KeyGet()
	Return GUICtrlRead($LSkill104Key)
EndFunc
;~ Lấy giá trị từ $LSkill104Key
Func LSkill104KeySet($NewValue = "")
	Local $Check = LSkill104KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill104Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill104Key
Func LSkill104KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill104Key)
EndFunc
;~ Chỉnh vị trí của $LSkill104Key
Func LSkill104KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill104KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill104Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill104Key
Func LSkill104KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill104KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill104Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill104Key
Func LSkill104KeyGetState()
	Return GUICtrlGetState($LSkill104Key)
EndFunc
Func LSkill104KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill104Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill104Key
Func LSkill104KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill104Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill104Key
Func LSkill104KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill104Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================