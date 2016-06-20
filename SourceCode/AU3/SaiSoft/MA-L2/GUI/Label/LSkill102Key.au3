;~ Bấm vào $LSkill102Key
Func LSkill102KeyClick()
	Local $Key = LSkill102KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill102KeySet($Key)
	$Skill[102][1] = LSkill102KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill102Key
Func LSkill102KeyGet()
	Return GUICtrlRead($LSkill102Key)
EndFunc
;~ Lấy giá trị từ $LSkill102Key
Func LSkill102KeySet($NewValue = "")
	Local $Check = LSkill102KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill102Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill102Key
Func LSkill102KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill102Key)
EndFunc
;~ Chỉnh vị trí của $LSkill102Key
Func LSkill102KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill102KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill102Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill102Key
Func LSkill102KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill102KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill102Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill102Key
Func LSkill102KeyGetState()
	Return GUICtrlGetState($LSkill102Key)
EndFunc
Func LSkill102KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill102Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill102Key
Func LSkill102KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill102Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill102Key
Func LSkill102KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill102Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================