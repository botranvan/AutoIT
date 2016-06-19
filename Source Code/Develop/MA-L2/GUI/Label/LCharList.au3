;~ Bấm vào $LCharList
Func LCharListClick()
	Local $Data,$File
	$Data = DBCharListGet()
	If Not $Data Then Return
	$File = "Setting/"&$Data&".ini"
	If FileExists($File) Then Return
	LNoticeSet("")
	$File = FileOpen($File,1+8)
	Sleep(500)
	FileClose($File)
	LNoticeSet("Save done")
	Sleep(500)
EndFunc

;~ Chỉnh giá trị chuỗi của $LCharList
Func LCharListGet()
	Return GUICtrlRead($LCharList)
EndFunc
;~ Lấy giá trị từ $LCharList
Func LCharListSet($NewValue = "")
	Local $Check = LCharListGet()
	If $Check <> $NewValue Then GUICtrlSetData($LCharList,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LCharList
Func LCharListGetPos()
	Return ControlGetPos($MainGUI, "", $LCharList)
EndFunc
;~ Chỉnh vị trí của $LCharList
Func LCharListSetPos($x = -1,$y = -1)
	Local $Size = LCharListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LCharList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LCharList
Func LCharListSetSize($Width = -1,$Height = -1)
	Local $Size = LCharListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LCharList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LCharList
Func LCharListGetState()
	Return GUICtrlGetState($LCharList)
EndFunc
Func LCharListSetState($State = $GUI_SHOW)
	GUICtrlSetState($LCharList,$State)
EndFunc


;~ Chỉnh màu chữ của $LCharList
Func LCharListColor($Color = 0x000000)
	GUICtrlSetColor($LCharList,$Color)
EndFunc
;~ Chỉnh màu nền của $LCharList
Func LCharListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LCharList,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================