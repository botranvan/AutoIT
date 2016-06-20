;~ Bấm vào $DBGameList
Func DBGameListChange()
	$Training = 1
	BStartAutoClick()
	$GameHandle = DBGameListGet()
	GameOpenMemory($GameHandle)
	GameActivate()
EndFunc

;~ Chỉnh giá trị chuỗi của $DBGameList
Func DBGameListGet()
	Return GUICtrlRead($DBGameList)
EndFunc
;~ Lấy giá trị từ $DBGameList
Func DBGameListSet($NewValue = "",$Default = "")
	Local $Check = DBGameListGet()
	If $Check <> $NewValue Then GUICtrlSetData($DBGameList,$NewValue,$Default)
EndFunc


;~ Lấy vị trí và kích thước của $DBGameList
Func DBGameListGetPos()
	Return ControlGetPos($MainGUI, "", $DBGameList)
EndFunc
;~ Chỉnh vị trí của $DBGameList
Func DBGameListSetPos($x = -1,$y = -1)
	Local $Size = DBGameListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($DBGameList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $DBGameList
Func DBGameListSetSize($Width = -1,$Height = -1)
	Local $Size = DBGameListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($DBGameList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $DBGameList
Func DBGameListGetState()
	Return GUICtrlGetState($DBGameList)
EndFunc
Func DBGameListSetState($State = $GUI_SHOW)
	GUICtrlSetState($DBGameList,$State)
EndFunc


;~ Chỉnh màu chữ của $DBGameList
Func DBGameListColor($Color = 0x000000)
	GUICtrlSetColor($DBGameList,$Color)
EndFunc
;~ Chỉnh màu nền của $DBGameList
Func DBGameListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($DBGameList,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================