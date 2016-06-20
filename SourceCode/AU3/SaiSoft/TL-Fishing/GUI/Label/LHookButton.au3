;~ Bấm vào $LHookButton
Func LHookButtonClick()
	MsgBox(0,"72ls.NET","") 
EndFunc

;~ Check và UnCheck $LHookButton
Func LHookButtonCheck($check = 0)
	If $check == 1 Then
		LHookButtonSetState($GUI_CHECKED)
	Else
		LHookButtonSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LHookButton
Func LHookButtonGet()
	Return GUICtrlRead($LHookButton)
EndFunc
;~ Lấy giá trị từ $LHookButton
Func LHookButtonSet($NewValue = "")
	Local $Check = LHookButtonGet()
	If $Check <> $NewValue Then GUICtrlSetData($LHookButton,$NewValue)
EndFunc
;~ Gán ToolTip cho $LHookButton
Func LHookButtonSetTip($NewValue = "")
	Return GUICtrlSetTip($LHookButton, $NewValue)	
EndFunc	



;~ Lấy vị trí và kích thước của $LHookButton
Func LHookButtonGetPos()
	Return ControlGetPos($MainGUI, "", $LHookButton)
EndFunc
;~ Chỉnh vị trí của $LHookButton
Func LHookButtonSetPos($x = -1,$y = -1)
	Local $Size = LHookButtonGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LHookButton,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LHookButton
Func LHookButtonSetSize($Width = -1,$Height = -1)
	Local $Size = LHookButtonGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LHookButton,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LHookButton
Func LHookButtonGetState()
	Return GUICtrlGetState($LHookButton)
EndFunc
Func LHookButtonSetState($State = $GUI_SHOW)
	GUICtrlSetState($LHookButton,$State)
EndFunc


;~ Chỉnh màu chữ của $LHookButton
Func LHookButtonColor($Color = 0x000000)
	GUICtrlSetColor($LHookButton,$Color)
EndFunc
;~ Chỉnh màu nền của $LHookButton
Func LHookButtonBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LHookButton,$Color)
EndFunc