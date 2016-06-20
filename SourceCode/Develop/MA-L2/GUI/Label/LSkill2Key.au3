;~ Bấm vào $LSkill2Key
Func LSkill2KeyClick()
	Local $Key = LSkill2KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill2KeySet($Key)
	$Skill[2][1] = LSkill2KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill2Key
Func LSkill2KeyGet()
	Return GUICtrlRead($LSkill2Key)
EndFunc
;~ Lấy giá trị từ $LSkill2Key
Func LSkill2KeySet($NewValue = "")
	Local $Check = LSkill2KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill2Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill2Key
Func LSkill2KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill2Key)
EndFunc
;~ Chỉnh vị trí của $LSkill2Key
Func LSkill2KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill2KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill2Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill2Key
Func LSkill2KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill2KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill2Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill2Key
Func LSkill2KeyGetState()
	Return GUICtrlGetState($LSkill2Key)
EndFunc
Func LSkill2KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill2Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill2Key
Func LSkill2KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill2Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill2Key
Func LSkill2KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill2Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================