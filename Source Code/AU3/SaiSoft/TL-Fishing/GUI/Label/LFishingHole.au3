;~ Bấm vào $LFishingHole
Func LFishingHoleClick()
	LFishingHoleSet("????:????")
	LNoticeSet("")
	Sleep(500)
	LNoticeSet("Đưa chuột lên nút [Fishing Hole] của game rồi bấm phím [Insert] | ")
	HotKeySet("{Insert}","GameFishingHoleGet")
EndFunc

;~ Check và UnCheck $LFishingHole
Func LFishingHoleCheck($check = 0)
	If $check == 1 Then
		LFishingHoleSetState($GUI_CHECKED)
	Else
		LFishingHoleSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LFishingHole
Func LFishingHoleGet()
	Return GUICtrlRead($LFishingHole)
EndFunc
;~ Lấy giá trị từ $LFishingHole
Func LFishingHoleSet($NewValue = "")
	Local $Check = LFishingHoleGet()
	If $Check <> $NewValue Then GUICtrlSetData($LFishingHole,$NewValue)
EndFunc
;~ Gán ToolTip cho $LFishingHole
Func LFishingHoleSetTip($NewValue = "")
	Return GUICtrlSetTip($LFishingHole, $NewValue)	
EndFunc	

;~ Lấy vị trí và kích thước của $LFishingHole
Func LFishingHoleGetPos()
	Return ControlGetPos($MainGUI, "", $LFishingHole)
EndFunc
;~ Chỉnh vị trí của $LFishingHole
Func LFishingHoleSetPos($x = -1,$y = -1)
	Local $Size = LFishingHoleGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LFishingHole,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LFishingHole
Func LFishingHoleSetSize($Width = -1,$Height = -1)
	Local $Size = LFishingHoleGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LFishingHole,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LFishingHole
Func LFishingHoleGetState()
	Return GUICtrlGetState($LFishingHole)
EndFunc
Func LFishingHoleSetState($State = $GUI_SHOW)
	GUICtrlSetState($LFishingHole,$State)
EndFunc


;~ Chỉnh màu chữ của $LFishingHole
Func LFishingHoleColor($Color = 0x000000)
	GUICtrlSetColor($LFishingHole,$Color)
EndFunc
;~ Chỉnh màu nền của $LFishingHole
Func LFishingHoleBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LFishingHole,$Color)
EndFunc