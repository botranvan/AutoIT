;~ Bấm vào $LMobHPCur
Func LMobHPCurClick()
	$AModHPCurIndex+=1
	If $AModHPCurIndex > UBound($AModHPCur)-1 Then $AModHPCurIndex = 0
	LNoticeSet("MonHP: "&$AModHPCurIndex)
EndFunc

;~ Chỉnh giá trị chuỗi của $LMobHPCur
Func LMobHPCurGet()
	Return GUICtrlRead($LMobHPCur)
EndFunc
;~ Lấy giá trị từ $LMobHPCur
Func LMobHPCurSet($NewValue = "")
	Local $Check = LMobHPCurGet()
	If $Check <> $NewValue Then GUICtrlSetData($LMobHPCur,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LMobHPCur
Func LMobHPCurGetPos()
	Return ControlGetPos($MainGUI, "", $LMobHPCur)
EndFunc
;~ Chỉnh vị trí của $LMobHPCur
Func LMobHPCurSetPos($x = -1,$y = -1)
	Local $Size = LMobHPCurGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LMobHPCur,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LMobHPCur
Func LMobHPCurSetSize($Width = -1,$Height = -1)
	Local $Size = LMobHPCurGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LMobHPCur,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LMobHPCur
Func LMobHPCurGetState()
	Return GUICtrlGetState($LMobHPCur)
EndFunc
Func LMobHPCurSetState($State = $GUI_SHOW)
	GUICtrlSetState($LMobHPCur,$State)
EndFunc


;~ Chỉnh màu chữ của $LMobHPCur
Func LMobHPCurColor($Color = 0x000000)
	GUICtrlSetColor($LMobHPCur,$Color)
EndFunc
;~ Chỉnh màu nền của $LMobHPCur
Func LMobHPCurBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LMobHPCur,$Color)
EndFunc
