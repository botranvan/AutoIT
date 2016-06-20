;~ Bấm vào $LSkill1Key
Func LSkill1KeyClick()
	Local $Key = LSkill1KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill1KeySet($Key)
	$Skill[1][1] = LSkill1KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill1Key
Func LSkill1KeyGet()
	Return GUICtrlRead($LSkill1Key)
EndFunc
;~ Lấy giá trị từ $LSkill1Key
Func LSkill1KeySet($NewValue = "")
	Local $Check = LSkill1KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill1Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill1Key
Func LSkill1KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill1Key)
EndFunc
;~ Chỉnh vị trí của $LSkill1Key
Func LSkill1KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill1KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill1Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill1Key
Func LSkill1KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill1KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill1Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill1Key
Func LSkill1KeyGetState()
	Return GUICtrlGetState($LSkill1Key)
EndFunc
Func LSkill1KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill1Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill1Key
Func LSkill1KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill1Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill1Key
Func LSkill1KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill1Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================