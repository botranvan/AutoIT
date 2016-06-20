;~ Bấm vào $LFishingButton
Func LFishingButtonClick()
	MsgBox(0,"72ls.NET","") 
EndFunc

;~ Check và UnCheck $LFishingButton
Func LFishingButtonCheck($check = 0)
	If $check == 1 Then
		LFishingButtonSetState($GUI_CHECKED)
	Else
		LFishingButtonSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LFishingButton
Func LFishingButtonGet()
	Return GUICtrlRead($LFishingButton)
EndFunc
;~ Lấy giá trị từ $LFishingButton
Func LFishingButtonSet($NewValue = "")
	Local $Check = LFishingButtonGet()
	If $Check <> $NewValue Then GUICtrlSetData($LFishingButton,$NewValue)
EndFunc
;~ Gán ToolTip cho $LFishingButton
Func LFishingButtonSetTip($NewValue = "")
	Return GUICtrlSetTip($LFishingButton, $NewValue)	
EndFunc	

;~ Lấy vị trí và kích thước của $LFishingButton
Func LFishingButtonGetPos()
	Return ControlGetPos($MainGUI, "", $LFishingButton)
EndFunc
;~ Chỉnh vị trí của $LFishingButton
Func LFishingButtonSetPos($x = -1,$y = -1)
	Local $Size = LFishingButtonGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LFishingButton,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LFishingButton
Func LFishingButtonSetSize($Width = -1,$Height = -1)
	Local $Size = LFishingButtonGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LFishingButton,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LFishingButton
Func LFishingButtonGetState()
	Return GUICtrlGetState($LFishingButton)
EndFunc
Func LFishingButtonSetState($State = $GUI_SHOW)
	GUICtrlSetState($LFishingButton,$State)
EndFunc


;~ Chỉnh màu chữ của $LFishingButton
Func LFishingButtonColor($Color = 0x000000)
	GUICtrlSetColor($LFishingButton,$Color)
EndFunc
;~ Chỉnh màu nền của $LFishingButton
Func LFishingButtonBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LFishingButton,$Color)
EndFunc