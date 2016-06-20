;~ Bấm vào $LSkill6Key
Func LSkill6KeyClick()
	Local $Key = LSkill6KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill6KeySet($Key)
	$Skill[6][1] = LSkill6KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill6Key
Func LSkill6KeyGet()
	Return GUICtrlRead($LSkill6Key)
EndFunc
;~ Lấy giá trị từ $LSkill6Key
Func LSkill6KeySet($NewValue = "")
	Local $Check = LSkill6KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill6Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill6Key
Func LSkill6KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill6Key)
EndFunc
;~ Chỉnh vị trí của $LSkill6Key
Func LSkill6KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill6KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill6Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill6Key
Func LSkill6KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill6KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill6Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill6Key
Func LSkill6KeyGetState()
	Return GUICtrlGetState($LSkill6Key)
EndFunc
Func LSkill6KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill6Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill6Key
Func LSkill6KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill6Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill6Key
Func LSkill6KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill6Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================