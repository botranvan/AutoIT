;~ Bấm vào $LIsFishing
Func LIsFishingClick()
	MsgBox(0,"72ls.NET","") 
EndFunc

;~ Check và UnCheck $LIsFishing
Func LIsFishingCheck($check = 0)
	If $check == 1 Then
		LIsFishingSetState($GUI_CHECKED)
	Else
		LIsFishingSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LIsFishing
Func LIsFishingGet()
	Return GUICtrlRead($LIsFishing)
EndFunc
;~ Lấy giá trị từ $LIsFishing
Func LIsFishingSet($NewValue = "")
	Local $Check = LIsFishingGet()
	If $Check <> $NewValue Then GUICtrlSetData($LIsFishing,$NewValue)
EndFunc
;~ Gán ToolTip cho $LIsFishing
Func LIsFishingSetTip($NewValue = "")
	Return GUICtrlSetTip($LIsFishing, $NewValue)	
EndFunc	



;~ Lấy vị trí và kích thước của $LIsFishing
Func LIsFishingGetPos()
	Return ControlGetPos($MainGUI, "", $LIsFishing)
EndFunc
;~ Chỉnh vị trí của $LIsFishing
Func LIsFishingSetPos($x = -1,$y = -1)
	Local $Size = LIsFishingGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LIsFishing,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LIsFishing
Func LIsFishingSetSize($Width = -1,$Height = -1)
	Local $Size = LIsFishingGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LIsFishing,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LIsFishing
Func LIsFishingGetState()
	Return GUICtrlGetState($LIsFishing)
EndFunc
Func LIsFishingSetState($State = $GUI_SHOW)
	GUICtrlSetState($LIsFishing,$State)
EndFunc


;~ Chỉnh màu chữ của $LIsFishing
Func LIsFishingColor($Color = 0x000000)
	GUICtrlSetColor($LIsFishing,$Color)
EndFunc
;~ Chỉnh màu nền của $LIsFishing
Func LIsFishingBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LIsFishing,$Color)
EndFunc