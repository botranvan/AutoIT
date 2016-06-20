;~ Bấm vào $LSkill105Key
Func LSkill105KeyClick()
	Local $Key = LSkill105KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill105KeySet($Key)
	$Skill[105][1] = LSkill105KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill105Key
Func LSkill105KeyGet()
	Return GUICtrlRead($LSkill105Key)
EndFunc
;~ Lấy giá trị từ $LSkill105Key
Func LSkill105KeySet($NewValue = "")
	Local $Check = LSkill105KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill105Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill105Key
Func LSkill105KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill105Key)
EndFunc
;~ Chỉnh vị trí của $LSkill105Key
Func LSkill105KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill105KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill105Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill105Key
Func LSkill105KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill105KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill105Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill105Key
Func LSkill105KeyGetState()
	Return GUICtrlGetState($LSkill105Key)
EndFunc
Func LSkill105KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill105Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill105Key
Func LSkill105KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill105Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill105Key
Func LSkill105KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill105Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================