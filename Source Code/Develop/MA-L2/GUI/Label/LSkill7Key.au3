;~ Bấm vào $LSkill7Key
Func LSkill7KeyClick()
	Local $Key = LSkill7KeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LSkill7KeySet($Key)
	$Skill[7][1] = LSkill7KeyGet()
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill7Key
Func LSkill7KeyGet()
	Return GUICtrlRead($LSkill7Key)
EndFunc
;~ Lấy giá trị từ $LSkill7Key
Func LSkill7KeySet($NewValue = "")
	Local $Check = LSkill7KeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LSkill7Key,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LSkill7Key
Func LSkill7KeyGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill7Key)
EndFunc
;~ Chỉnh vị trí của $LSkill7Key
Func LSkill7KeySetPos($x = -1,$y = -1)
	Local $Size = LSkill7KeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill7Key,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill7Key
Func LSkill7KeySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill7KeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill7Key,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill7Key
Func LSkill7KeyGetState()
	Return GUICtrlGetState($LSkill7Key)
EndFunc
Func LSkill7KeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill7Key,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill7Key
Func LSkill7KeyColor($Color = 0x000000)
	GUICtrlSetColor($LSkill7Key,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill7Key
Func LSkill7KeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill7Key,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================