;~ Bấm vào $LSkill10Key
Func LSkill10KeyClick()
	Local $Key = LSkill10KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill10KeySet($Key)
	$Skill[10][1] = LSkill10KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill10Key
Func LSkill10KeyGet()
	Return GUICtrlRead($LSkill10Key)
EndFunc
;~ Lấy giá trị từ $LSkill10Key
Func LSkill10KeySet($NewValue = "")
	Local $Check = LSkill10KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill10Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill10Key
Func LSkill10KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill10Key)
EndFunc
;~ Chỉnh vị trí của $LSkill10Key
Func LSkill10KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill10KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill10Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill10Key
Func LSkill10KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill10KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill10Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill10Key
Func LSkill10KeyGetState()
	Return GUICtrlGetState($LSkill10Key)
EndFunc
Func LSkill10KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill10Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill10Key
Func LSkill10KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill10Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill10Key
Func LSkill10KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill10Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================