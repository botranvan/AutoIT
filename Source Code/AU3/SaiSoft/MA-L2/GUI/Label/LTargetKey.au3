;~ Bấm vào $LTargetKey
Func LTargetKeyClick()
	Local $Key = LTargetKeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LTargetKeySet($Key)
	$TargetKey = LTargetKeyGet()
	GameTargetKeySave()
EndFunc

;~ Chỉnh giá trị chuỗi của $LTargetKey
Func LTargetKeyGet()
	Return GUICtrlRead($LTargetKey)
EndFunc
;~ Lấy giá trị từ $LTargetKey
Func LTargetKeySet($NewValue = "")
	Local $Check = LTargetKeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LTargetKey,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LTargetKey
Func LTargetKeyGetPos()
	Return ControlGetPos($MainGUI, "", $LTargetKey)
EndFunc
;~ Chỉnh vị trí của $LTargetKey
Func LTargetKeySetPos($x = -1,$y = -1)
	Local $Size = LTargetKeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LTargetKey,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LTargetKey
Func LTargetKeySetSize($Width = -1,$Height = -1)
	Local $Size = LTargetKeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LTargetKey,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LTargetKey
Func LTargetKeyGetState()
	Return GUICtrlGetState($LTargetKey)
EndFunc
Func LTargetKeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LTargetKey,$State)
EndFunc


;~ Chỉnh màu chữ của $LTargetKey
Func LTargetKeyColor($Color = 0x000000)
	GUICtrlSetColor($LTargetKey,$Color)
EndFunc
;~ Chỉnh màu nền của $LTargetKey
Func LTargetKeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LTargetKey,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================