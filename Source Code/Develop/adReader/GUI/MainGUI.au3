#cs >> Danh sách hàm ===============================================================================================


Func MainGUIFix()		;~ Hiệu chỉnh lại GUI
Func MainGUIClose()		;~ Đóng chương trình
Func MainGUIGet()		;~ Chỉnh giá trị chuỗi của $MainGUI
Func MainGUISet()		;~ Lấy giá trị từ $MainGUI
Func MainGUIGetPos()	;~ Lấy vị trí và kích thước của $MainGUI
Func MainGUISetPos()	;~ Chỉnh vị trí của $MainGUI
Func MainGUISetSize()	;~ Chỉnh kích thước của $MainGUI
Func MainGUIGetState()	;~ Lấy thái Window
Func MainGUISetState()	;~ Chỉnh trạng thái Window
Func MainGUIBackGround()	;~ Chỉnh màu nền của $MainGUI


#ce << Danh sách hàm ===============================================================================================


;~ >> Tương tác với Window =====================================================================================
;~ Hiệu chỉnh lại GUI
Func MainGUIFix()
	MainGUISetPos($AutoPos[0],$AutoPos[1])
	MainGUISet($AutoName&" v"&$AutoVersion)
	IAddressReviewSet($AddressReview)
	IAddressStartSet($AddressStart)
	CBProcessListSelect($ProcessName)
	LNoticeSetSize(50)

	MainGUISetState()
EndFunc

;~ Đóng chương trình
Func MainGUIClose()
	FSaveSetting()
	Exit
EndFunc


;~ Chỉnh giá trị chuỗi của $MainGUI
Func MainGUIGet()
	Return WinGetTitle($MainGUI)
EndFunc
;~ Lấy giá trị từ $MainGUI
Func MainGUISet($NewValue = "")
	Local $Check = MainGUIGet()
	If $Check <> $NewValue Then WinSetTitle($MainGUI,"",$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $MainGUI
Func MainGUIGetPos()
	Return WinGetPos($MainGUI)
EndFunc
;~ Chỉnh vị trí của $MainGUI
Func MainGUISetPos($x = -1,$y = -1,$Speed=1)
	Local $Size = MainGUIGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	WinMove( $MainGUI, "", $Size[0],$Size[1],$Size[2],$Size[3],$Speed)
EndFunc
;~ Chỉnh kích thước của $MainGUI
Func MainGUISetSize($Width = -1,$Height = -1)
	Local $Size = MainGUIGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	WinMove($MainGUI,"",$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Lấy thái Window
Func MainGUIGetState()
	Return WinGetState($MainGUI)
EndFunc
Func MainGUISetState($State = @SW_SHOW)
	GUISetState($State,$MainGUI)
EndFunc


;~ Chỉnh màu nền của $MainGUI
Func MainGUIBackGround($Color = 0x000000)
	GUISetBkColor($Color,$MainGUI)
EndFunc
;~ << Tương tác với Window =====================================================================================




