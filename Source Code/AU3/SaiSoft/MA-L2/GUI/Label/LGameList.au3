;~ Bấm vào $LGameList
Func LGameListClick()
	GameActivate()
EndFunc

;~ Chỉnh giá trị chuỗi của $LGameList
Func LGameListGet()
	Return GUICtrlRead($LGameList)
EndFunc
;~ Lấy giá trị từ $LGameList
Func LGameListSet($NewValue = "")
	Local $Check = LGameListGet()
	If $Check <> $NewValue Then GUICtrlSetData($LGameList,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LGameList
Func LGameListGetPos()
	Return ControlGetPos($MainGUI, "", $LGameList)
EndFunc
;~ Chỉnh vị trí của $LGameList
Func LGameListSetPos($x = -1,$y = -1)
	Local $Size = LGameListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LGameList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LGameList
Func LGameListSetSize($Width = -1,$Height = -1)
	Local $Size = LGameListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LGameList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LGameList
Func LGameListGetState()
	Return GUICtrlGetState($LGameList)
EndFunc
Func LGameListSetState($State = $GUI_SHOW)
	GUICtrlSetState($LGameList,$State)
EndFunc


;~ Chỉnh màu chữ của $LGameList
Func LGameListColor($Color = 0x000000)
	GUICtrlSetColor($LGameList,$Color)
EndFunc
;~ Chỉnh màu nền của $LGameList
Func LGameListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LGameList,$Color)
EndFunc
