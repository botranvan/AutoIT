;~ Bấm vào $LIsCaught
Func LIsCaughtClick()
	MsgBox(0,"72ls.NET","") 
EndFunc

;~ Check và UnCheck $LIsCaught
Func LIsCaughtCheck($check = 0)
	If $check == 1 Then
		LIsCaughtSetState($GUI_CHECKED)
	Else
		LIsCaughtSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LIsCaught
Func LIsCaughtGet()
	Return GUICtrlRead($LIsCaught)
EndFunc
;~ Lấy giá trị từ $LIsCaught
Func LIsCaughtSet($NewValue = "")
	Local $Check = LIsCaughtGet()
	If $Check <> $NewValue Then GUICtrlSetData($LIsCaught,$NewValue)
EndFunc
;~ Gán ToolTip cho $LIsCaught
Func LIsCaughtSetTip($NewValue = "")
	Return GUICtrlSetTip($LIsCaught, $NewValue)	
EndFunc	



;~ Lấy vị trí và kích thước của $LIsCaught
Func LIsCaughtGetPos()
	Return ControlGetPos($MainGUI, "", $LIsCaught)
EndFunc
;~ Chỉnh vị trí của $LIsCaught
Func LIsCaughtSetPos($x = -1,$y = -1)
	Local $Size = LIsCaughtGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LIsCaught,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LIsCaught
Func LIsCaughtSetSize($Width = -1,$Height = -1)
	Local $Size = LIsCaughtGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LIsCaught,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LIsCaught
Func LIsCaughtGetState()
	Return GUICtrlGetState($LIsCaught)
EndFunc
Func LIsCaughtSetState($State = $GUI_SHOW)
	GUICtrlSetState($LIsCaught,$State)
EndFunc


;~ Chỉnh màu chữ của $LIsCaught
Func LIsCaughtColor($Color = 0x000000)
	GUICtrlSetColor($LIsCaught,$Color)
EndFunc
;~ Chỉnh màu nền của $LIsCaught
Func LIsCaughtBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LIsCaught,$Color)
EndFunc