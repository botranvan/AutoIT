;~ Bấm vào $BStartFishing
Func BStartFishingClick()
	$Fishing = Not $Fishing
	If $Fishing Then
		BStartFishingSet("Stop Fishing")
	Else
		BStartFishingSet("Start Fishing")
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $BStartFishing
Func BStartFishingGet()
	Return GUICtrlRead($BStartFishing)
EndFunc
;~ Lấy giá trị từ $BStartFishing
Func BStartFishingSet($NewValue = "")
	Local $Check = BStartFishingGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStartFishing,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStartFishing
Func BStartFishingGetPos()
	Return ControlGetPos($MainGUI, "", $BStartFishing)
EndFunc
;~ Chỉnh vị trí của $BStartFishing
Func BStartFishingSetPos($x = -1,$y = -1)
	Local $Size = BStartFishingGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStartFishing,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStartFishing
Func BStartFishingSetSize($Width = -1,$Height = -1)
	Local $Size = BStartFishingGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStartFishing,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStartFishing
Func BStartFishingGetState()
	Return GUICtrlGetState($BStartFishing)
EndFunc
Func BStartFishingSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStartFishing,$State)
EndFunc


;~ Chỉnh màu chữ của $BStartFishing
Func BStartFishingColor($Color = 0x000000)
	GUICtrlSetColor($BStartFishing,$Color)
EndFunc
;~ Chỉnh màu nền của $BStartFishing
Func BStartFishingBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStartFishing,$Color)
EndFunc
