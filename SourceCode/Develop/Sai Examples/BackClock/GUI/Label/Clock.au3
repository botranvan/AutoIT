#cs >> Danh sách hàm ===============================================================================================

Func ClockGet()					;~ Chỉnh giá trị chuỗi của $Clock
Func ClockSet()					;~ Lấy giá trị từ $Clock
Func ClockGetPos()				;~ Lấy vị trí và kích thước của $Clock
Func ClockSetPos()				;~ Chỉnh vị trí của $Clock
Func ClockSetSize()				;~ Chỉnh kích thước của $Clock
Func ClockGetState()
Func ClockSetState()				;~ Chỉnh trạng thái $Clock
Func ClockColor()					;~ Chỉnh màu chữ của $Clock
Func ClockBackGround()			;~ Chỉnh màu nền của $Clock

#ce << Danh sách hàm ===============================================================================================


;~ >> Thông báo ở cuối chương trình ============================================================================
;~ Chỉnh giá trị chuỗi của $Clock
Func ClockGet()
	Return GUICtrlRead($Clock)
EndFunc
;~ Lấy giá trị từ $Clock
Func ClockSet($NewValue = "")
	Local $Check = ClockGet()
	If $Check <> $NewValue Then GUICtrlSetData($Clock,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $Clock
Func ClockGetPos()
	Return ControlGetPos($MainGUI, "", $Clock)
EndFunc
;~ Chỉnh vị trí của $Clock
Func ClockSetPos($x = -1,$y = -1)
	Local $Size = ClockGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($Clock,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $Clock
Func ClockSetSize($Width = -1,$Height = -1)
	Local $Size = ClockGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($Clock,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $Clock
Func ClockGetState()
	Return GUICtrlGetState($Clock)
EndFunc
Func ClockSetState($State = $GUI_SHOW)
	GUICtrlSetState($Clock,$State)
EndFunc


;~ Chỉnh màu chữ của $Clock
Func ClockColor($Color = 0x000000)
	GUICtrlSetColor($Clock,$Color)
EndFunc
;~ Chỉnh màu nền của $Clock
Func ClockBackGround($Color = 0x000000)
	GUICtrlSetBkColor($Clock,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================