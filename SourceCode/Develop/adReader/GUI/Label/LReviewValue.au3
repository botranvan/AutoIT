;~ Bấm vào $LReviewValue
Func LReviewValueClick()
	
EndFunc


;~ Chỉnh giá trị chuỗi của $LReviewValue
Func LReviewValueGet()
	Return GUICtrlRead($LReviewValue)
EndFunc
;~ Lấy giá trị từ $LReviewValue
Func LReviewValueSet($NewValue = "",$run = 0)
	Local $Check = LReviewValueGet()
	If $Check <> $NewValue Then GUICtrlSetData($LReviewValue,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LReviewValueRun2Left",$run)
	Else
		AdlibUnRegister("LReviewValueRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LReviewValueRun2Left()
	Local $data
	$data = LReviewValueGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LReviewValueSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LReviewValue
Func LReviewValueGetPos()
	Return ControlGetPos($MainGUI, "", $LReviewValue)
EndFunc
;~ Chỉnh vị trí của $LReviewValue
Func LReviewValueSetPos($x = -1,$y = -1)
	Local $Size = LReviewValueGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LReviewValue,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LReviewValue
Func LReviewValueSetSize($Width = -1,$Height = -1)
	Local $Size = LReviewValueGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LReviewValue,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LReviewValue
Func LReviewValueGetState()
	Return GUICtrlGetState($LReviewValue)
EndFunc
Func LReviewValueSetState($State = $GUI_SHOW)
	GUICtrlSetState($LReviewValue,$State)
EndFunc


;~ Chỉnh màu chữ của $LReviewValue
Func LReviewValueColor($Color = 0x000000)
	GUICtrlSetColor($LReviewValue,$Color)
EndFunc
;~ Chỉnh màu nền của $LReviewValue
Func LReviewValueBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LReviewValue,$Color)
EndFunc