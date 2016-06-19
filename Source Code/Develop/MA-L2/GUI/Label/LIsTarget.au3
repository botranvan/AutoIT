;~ Bấm vào $LIsTarget
Func LIsTargetClick()
	$AIsTargetIndex+=1
	If $AIsTargetIndex > UBound($AIsTarget)-1 Then $AIsTargetIndex = 0
	LNoticeSet("Target: "&$AIsTargetIndex)
EndFunc

;~ Chỉnh giá trị chuỗi của $LIsTarget
Func LIsTargetGet()
	Return GUICtrlRead($LIsTarget)
EndFunc
;~ Lấy giá trị từ $LIsTarget
Func LIsTargetSet($NewValue = "")
	Local $Check = LIsTargetGet()
	If $Check <> $NewValue Then GUICtrlSetData($LIsTarget,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LIsTarget
Func LIsTargetGetPos()
	Return ControlGetPos($MainGUI, "", $LIsTarget)
EndFunc
;~ Chỉnh vị trí của $LIsTarget
Func LIsTargetSetPos($x = -1,$y = -1)
	Local $Size = LIsTargetGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LIsTarget,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LIsTarget
Func LIsTargetSetSize($Width = -1,$Height = -1)
	Local $Size = LIsTargetGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LIsTarget,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LIsTarget
Func LIsTargetGetState()
	Return GUICtrlGetState($LIsTarget)
EndFunc
Func LIsTargetSetState($State = $GUI_SHOW)
	GUICtrlSetState($LIsTarget,$State)
EndFunc


;~ Chỉnh màu chữ của $LIsTarget
Func LIsTargetColor($Color = 0x000000)
	GUICtrlSetColor($LIsTarget,$Color)
EndFunc
;~ Chỉnh màu nền của $LIsTarget
Func LIsTargetBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LIsTarget,$Color)
EndFunc
