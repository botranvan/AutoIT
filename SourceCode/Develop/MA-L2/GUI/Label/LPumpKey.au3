;~ Bấm vào $LPumpKey
Func LPumpKeyClick()
	Local $Key = LPumpKeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LPumpKeySet($Key)
	$PumpKey = LPumpKeyGet()
	GamePumpingKeySave()
EndFunc

;~ Chỉnh giá trị chuỗi của $LPumpKey
Func LPumpKeyGet()
	Return GUICtrlRead($LPumpKey)
EndFunc
;~ Lấy giá trị từ $LPumpKey
Func LPumpKeySet($NewValue = "")
	Local $Check = LPumpKeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LPumpKey,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LPumpKey
Func LPumpKeyGetPos()
	Return ControlGetPos($MainGUI, "", $LPumpKey)
EndFunc
;~ Chỉnh vị trí của $LPumpKey
Func LPumpKeySetPos($x = -1,$y = -1)
	Local $Size = LPumpKeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LPumpKey,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LPumpKey
Func LPumpKeySetSize($Width = -1,$Height = -1)
	Local $Size = LPumpKeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LPumpKey,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LPumpKey
Func LPumpKeyGetState()
	Return GUICtrlGetState($LPumpKey)
EndFunc
Func LPumpKeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LPumpKey,$State)
EndFunc


;~ Chỉnh màu chữ của $LPumpKey
Func LPumpKeyColor($Color = 0x000000)
	GUICtrlSetColor($LPumpKey,$Color)
EndFunc
;~ Chỉnh màu nền của $LPumpKey
Func LPumpKeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LPumpKey,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================