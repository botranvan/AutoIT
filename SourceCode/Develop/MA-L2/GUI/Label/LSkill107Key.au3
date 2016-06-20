;~ Bấm vào $LSkill107Key
Func LSkill107KeyClick()
	Local $Key = LSkill107KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill107KeySet($Key)
	$Skill[107][1] = LSkill107KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill107Key
Func LSkill107KeyGet()
	Return GUICtrlRead($LSkill107Key)
EndFunc
;~ Lấy giá trị từ $LSkill107Key
Func LSkill107KeySet($NewValue = "")
	Local $Check = LSkill107KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill107Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill107Key
Func LSkill107KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill107Key)
EndFunc
;~ Chỉnh vị trí của $LSkill107Key
Func LSkill107KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill107KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill107Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill107Key
Func LSkill107KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill107KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill107Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill107Key
Func LSkill107KeyGetState()
	Return GUICtrlGetState($LSkill107Key)
EndFunc
Func LSkill107KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill107Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill107Key
Func LSkill107KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill107Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill107Key
Func LSkill107KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill107Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================