;~ Bấm vào $LHook
Func LHookClick()
	LHookSet("????:????")
	LNoticeSet("")
	Sleep(500)
	LNoticeSet("Đưa chuột lên nút hình Móc Câu của game rồi bấm phím [Insert] | ")
	HotKeySet("{Insert}","GameHookGet")
EndFunc

;~ Check và UnCheck $LHook
Func LHookCheck($check = 0)
	If $check == 1 Then
		LHookSetState($GUI_CHECKED)
	Else
		LHookSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LHook
Func LHookGet()
	Return GUICtrlRead($LHook)
EndFunc
;~ Lấy giá trị từ $LHook
Func LHookSet($NewValue = "")
	Local $Check = LHookGet()
	If $Check <> $NewValue Then GUICtrlSetData($LHook,$NewValue)
EndFunc
;~ Gán ToolTip cho $LHook
Func LHookSetTip($NewValue = "")
	Return GUICtrlSetTip($LHook, $NewValue)	
EndFunc	

;~ Lấy vị trí và kích thước của $LHook
Func LHookGetPos()
	Return ControlGetPos($MainGUI, "", $LHook)
EndFunc
;~ Chỉnh vị trí của $LHook
Func LHookSetPos($x = -1,$y = -1)
	Local $Size = LHookGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LHook,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LHook
Func LHookSetSize($Width = -1,$Height = -1)
	Local $Size = LHookGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LHook,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LHook
Func LHookGetState()
	Return GUICtrlGetState($LHook)
EndFunc
Func LHookSetState($State = $GUI_SHOW)
	GUICtrlSetState($LHook,$State)
EndFunc


;~ Chỉnh màu chữ của $LHook
Func LHookColor($Color = 0x000000)
	GUICtrlSetColor($LHook,$Color)
EndFunc
;~ Chỉnh màu nền của $LHook
Func LHookBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LHook,$Color)
EndFunc