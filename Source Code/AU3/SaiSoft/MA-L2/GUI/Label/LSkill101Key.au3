;~ Bấm vào $LSkill101Key
Func LSkill101KeyClick()
	Local $Key = LSkill101KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill101KeySet($Key)
	$Skill[101][1] = LSkill101KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill101Key
Func LSkill101KeyGet()
	Return GUICtrlRead($LSkill101Key)
EndFunc
;~ Lấy giá trị từ $LSkill101Key
Func LSkill101KeySet($NewValue = "")
	Local $Check = LSkill101KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill101Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill101Key
Func LSkill101KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill101Key)
EndFunc
;~ Chỉnh vị trí của $LSkill101Key
Func LSkill101KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill101KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill101Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill101Key
Func LSkill101KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill101KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill101Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill101Key
Func LSkill101KeyGetState()
	Return GUICtrlGetState($LSkill101Key)
EndFunc
Func LSkill101KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill101Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill101Key
Func LSkill101KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill101Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill101Key
Func LSkill101KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill101Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================