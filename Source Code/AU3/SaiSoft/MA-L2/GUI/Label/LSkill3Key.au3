;~ Bấm vào $LSkill3Key
Func LSkill3KeyClick()
	Local $Key = LSkill3KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill3KeySet($Key)
	$Skill[3][1] = LSkill3KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill3Key
Func LSkill3KeyGet()
	Return GUICtrlRead($LSkill3Key)
EndFunc
;~ Lấy giá trị từ $LSkill3Key
Func LSkill3KeySet($NewValue = "")
	Local $Check = LSkill3KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill3Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill3Key
Func LSkill3KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill3Key)
EndFunc
;~ Chỉnh vị trí của $LSkill3Key
Func LSkill3KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill3KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill3Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill3Key
Func LSkill3KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill3KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill3Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill3Key
Func LSkill3KeyGetState()
	Return GUICtrlGetState($LSkill3Key)
EndFunc
Func LSkill3KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill3Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill3Key
Func LSkill3KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill3Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill3Key
Func LSkill3KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill3Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================