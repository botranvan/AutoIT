;~ Bấm vào $LSkill109Key
Func LSkill109KeyClick()
	Local $Key = LSkill109KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill109KeySet($Key)
	$Skill[109][1] = LSkill109KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill109Key
Func LSkill109KeyGet()
	Return GUICtrlRead($LSkill109Key)
EndFunc
;~ Lấy giá trị từ $LSkill109Key
Func LSkill109KeySet($NewValue = "")
	Local $Check = LSkill109KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill109Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill109Key
Func LSkill109KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill109Key)
EndFunc
;~ Chỉnh vị trí của $LSkill109Key
Func LSkill109KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill109KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill109Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill109Key
Func LSkill109KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill109KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill109Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill109Key
Func LSkill109KeyGetState()
	Return GUICtrlGetState($LSkill109Key)
EndFunc
Func LSkill109KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill109Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill109Key
Func LSkill109KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill109Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill109Key
Func LSkill109KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill109Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================