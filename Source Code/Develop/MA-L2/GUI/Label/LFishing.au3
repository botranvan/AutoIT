;~ Bấm vào $LFishing
Func LFishingClick()
	$AIsFishingIndex+=1
	If $AIsFishingIndex > UBound($AIsFishing)-1 Then $AIsFishingIndex = 0
	LNoticeSet("IsFishing: "&$AIsFishingIndex)
EndFunc

;~ Chỉnh giá trị chuỗi của $LFishing
Func LFishingGet()
	Return GUICtrlRead($LFishing)
EndFunc
;~ Lấy giá trị từ $LFishing
Func LFishingSet($NewValue = "")
	Local $Check = LFishingGet()
	If $Check <> $NewValue Then GUICtrlSetData($LFishing,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LFishing
Func LFishingGetPos()
	Return ControlGetPos($MainGUI, "", $LFishing)
EndFunc
;~ Chỉnh vị trí của $LFishing
Func LFishingSetPos($x = -1,$y = -1)
	Local $Size = LFishingGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LFishing,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LFishing
Func LFishingSetSize($Width = -1,$Height = -1)
	Local $Size = LFishingGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LFishing,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LFishing
Func LFishingGetState()
	Return GUICtrlGetState($LFishing)
EndFunc
Func LFishingSetState($State = $GUI_SHOW)
	GUICtrlSetState($LFishing,$State)
EndFunc


;~ Chỉnh màu chữ của $LFishing
Func LFishingColor($Color = 0x000000)
	GUICtrlSetColor($LFishing,$Color)
EndFunc
;~ Chỉnh màu nền của $LFishing
Func LFishingBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LFishing,$Color)
EndFunc
