#cs >> Danh sách hàm ===============================================================================================

Func LNoticeGet()					;~ Chỉnh giá trị chuỗi của $LNotice
Func LNoticeSet()					;~ Lấy giá trị từ $LNotice
Func LNoticeGetPos()				;~ Lấy vị trí và kích thước của $LNotice
Func LNoticeSetPos()				;~ Chỉnh vị trí của $LNotice
Func LNoticeSetSize()				;~ Chỉnh kích thước của $LNotice
Func LNoticeGetState()
Func LNoticeSetState()				;~ Chỉnh trạng thái $LNotice
Func LNoticeColor()					;~ Chỉnh màu chữ của $LNotice
Func LNoticeBackGround()			;~ Chỉnh màu nền của $LNotice

#ce << Danh sách hàm ===============================================================================================


;~ >> Thông báo ở cuối chương trình ============================================================================
;~ Chỉnh giá trị chuỗi của $LNotice
Func LNoticeGet()
	Return GUICtrlRead($LNotice)
EndFunc
;~ Lấy giá trị từ $LNotice
Func LNoticeSet($NewValue = "")
	Local $Check = LNoticeGet()
	If $Check <> $NewValue Then GUICtrlSetData($LNotice,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LNotice
Func LNoticeGetPos()
	Return ControlGetPos($MainGUI, "", $LNotice)
EndFunc
;~ Chỉnh vị trí của $LNotice
Func LNoticeSetPos($x = -1,$y = -1)
	Local $Size = LNoticeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LNotice,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LNotice
Func LNoticeSetSize($Width = -1,$Height = -1)
	Local $Size = LNoticeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LNotice,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LNotice
Func LNoticeGetState()
	Return GUICtrlGetState($LNotice)
EndFunc
Func LNoticeSetState($State = $GUI_SHOW)
	GUICtrlSetState($LNotice,$State)
EndFunc


;~ Chỉnh màu chữ của $LNotice
Func LNoticeColor($Color = 0x000000)
	GUICtrlSetColor($LNotice,$Color)
EndFunc
;~ Chỉnh màu nền của $LNotice
Func LNoticeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LNotice,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================