;~ Bấm vào $LSkill8Key
Func LSkill8KeyClick()
	Local $Key = LSkill8KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill8KeySet($Key)
	$Skill[8][1] = LSkill8KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill8Key
Func LSkill8KeyGet()
	Return GUICtrlRead($LSkill8Key)
EndFunc
;~ Lấy giá trị từ $LSkill8Key
Func LSkill8KeySet($NewValue = "")
	Local $Check = LSkill8KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill8Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill8Key
Func LSkill8KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill8Key)
EndFunc
;~ Chỉnh vị trí của $LSkill8Key
Func LSkill8KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill8KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill8Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill8Key
Func LSkill8KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill8KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill8Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill8Key
Func LSkill8KeyGetState()
	Return GUICtrlGetState($LSkill8Key)
EndFunc
Func LSkill8KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill8Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill8Key
Func LSkill8KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill8Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill8Key
Func LSkill8KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill8Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================