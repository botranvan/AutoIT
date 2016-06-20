;~ Bấm vào $LReelKey
Func LReelKeyClick()
	Local $Key = LReelKeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LReelKeySet($Key)
	$ReelKey = LReelKeyGet()
	GameReelingKeySave()
EndFunc

;~ Chỉnh giá trị chuỗi của $LReelKey
Func LReelKeyGet()
	Return GUICtrlRead($LReelKey)
EndFunc
;~ Lấy giá trị từ $LReelKey
Func LReelKeySet($NewValue = "")
	Local $Check = LReelKeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LReelKey,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LReelKey
Func LReelKeyGetPos()
	Return ControlGetPos($MainGUI, "", $LReelKey)
EndFunc
;~ Chỉnh vị trí của $LReelKey
Func LReelKeySetPos($x = -1,$y = -1)
	Local $Size = LReelKeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LReelKey,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LReelKey
Func LReelKeySetSize($Width = -1,$Height = -1)
	Local $Size = LReelKeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LReelKey,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LReelKey
Func LReelKeyGetState()
	Return GUICtrlGetState($LReelKey)
EndFunc
Func LReelKeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LReelKey,$State)
EndFunc


;~ Chỉnh màu chữ của $LReelKey
Func LReelKeyColor($Color = 0x000000)
	GUICtrlSetColor($LReelKey,$Color)
EndFunc
;~ Chỉnh màu nền của $LReelKey
Func LReelKeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LReelKey,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================