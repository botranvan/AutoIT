;~ Bấm vào $LFishingKey
Func LFishingKeyClick()
	Local $Key = LFishingKeyGet()
	$Key = InputBox($AutoName,"Please enter a hot key",$Key)
	If Not $Key Then Return
	LFishingKeySet($Key)
	$FishingKey = LFishingKeyGet()
	GameFishingKeySave()
EndFunc

;~ Chỉnh giá trị chuỗi của $LFishingKey
Func LFishingKeyGet()
	Return GUICtrlRead($LFishingKey)
EndFunc
;~ Lấy giá trị từ $LFishingKey
Func LFishingKeySet($NewValue = "")
	Local $Check = LFishingKeyGet()
	If $Check <> $NewValue Then GUICtrlSetData($LFishingKey,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LFishingKey
Func LFishingKeyGetPos()
	Return ControlGetPos($MainGUI, "", $LFishingKey)
EndFunc
;~ Chỉnh vị trí của $LFishingKey
Func LFishingKeySetPos($x = -1,$y = -1)
	Local $Size = LFishingKeyGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LFishingKey,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LFishingKey
Func LFishingKeySetSize($Width = -1,$Height = -1)
	Local $Size = LFishingKeyGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LFishingKey,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LFishingKey
Func LFishingKeyGetState()
	Return GUICtrlGetState($LFishingKey)
EndFunc
Func LFishingKeySetState($State = $GUI_SHOW)
	GUICtrlSetState($LFishingKey,$State)
EndFunc


;~ Chỉnh màu chữ của $LFishingKey
Func LFishingKeyColor($Color = 0x000000)
	GUICtrlSetColor($LFishingKey,$Color)
EndFunc
;~ Chỉnh màu nền của $LFishingKey
Func LFishingKeyBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LFishingKey,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================