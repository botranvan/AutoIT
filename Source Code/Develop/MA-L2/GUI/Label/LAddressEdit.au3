;~ Bấm vào $LAddressEdit
Func LAddressEditClick()
	Run(@WindowsDir & "\Notepad.exe "&@ScriptDir&"\address.ini", "", @SW_MAXIMIZE)
EndFunc

;~ Chỉnh giá trị chuỗi của $LAddressEdit
Func LAddressEditGet()
	Return GUICtrlRead($LAddressEdit)
EndFunc
;~ Lấy giá trị từ $LAddressEdit
Func LAddressEditSet($NewValue = "")
	Local $Check = LAddressEditGet()
	If $Check <> $NewValue Then GUICtrlSetData($LAddressEdit,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LAddressEdit
Func LAddressEditGetPos()
	Return ControlGetPos($MainGUI, "", $LAddressEdit)
EndFunc
;~ Chỉnh vị trí của $LAddressEdit
Func LAddressEditSetPos($x = -1,$y = -1)
	Local $Size = LAddressEditGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LAddressEdit,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LAddressEdit
Func LAddressEditSetSize($Width = -1,$Height = -1)
	Local $Size = LAddressEditGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LAddressEdit,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LAddressEdit
Func LAddressEditGetState()
	Return GUICtrlGetState($LAddressEdit)
EndFunc
Func LAddressEditSetState($State = $GUI_SHOW)
	GUICtrlSetState($LAddressEdit,$State)
EndFunc


;~ Chỉnh màu chữ của $LAddressEdit
Func LAddressEditColor($Color = 0x000000)
	GUICtrlSetColor($LAddressEdit,$Color)
EndFunc
;~ Chỉnh màu nền của $LAddressEdit
Func LAddressEditBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LAddressEdit,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================