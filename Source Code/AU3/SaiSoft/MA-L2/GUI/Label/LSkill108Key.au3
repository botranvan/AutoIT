;~ Bấm vào $LSkill108Key
Func LSkill108KeyClick()
	Local $Key = LSkill108KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill108KeySet($Key)
	$Skill[108][1] = LSkill108KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill108Key
Func LSkill108KeyGet()
	Return GUICtrlRead($LSkill108Key)
EndFunc
;~ Lấy giá trị từ $LSkill108Key
Func LSkill108KeySet($NewValue = "")
	Local $Check = LSkill108KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill108Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill108Key
Func LSkill108KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill108Key)
EndFunc
;~ Chỉnh vị trí của $LSkill108Key
Func LSkill108KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill108KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill108Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill108Key
Func LSkill108KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill108KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill108Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill108Key
Func LSkill108KeyGetState()
	Return GUICtrlGetState($LSkill108Key)
EndFunc
Func LSkill108KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill108Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill108Key
Func LSkill108KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill108Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill108Key
Func LSkill108KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill108Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================