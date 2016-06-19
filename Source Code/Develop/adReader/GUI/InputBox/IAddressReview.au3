;~ Thực hiện khi giá trị của $IAddressReview thay đổi
Func IAddressReviewChange()
	$AddressReview = IAddressReviewGet()
	IniWrite($DataFileName,"GUI","$AddressReview",$AddressReview)
EndFunc

;~ Chỉnh giá trị chuỗi của $IAddressReview
Func IAddressReviewGet()
	Return GUICtrlRead($IAddressReview)
EndFunc
;~ Lấy giá trị từ $IAddressReview
Func IAddressReviewSet($NewValue = "",$run = 0)
	Local $Check = IAddressReviewGet()
	If $Check <> $NewValue Then GUICtrlSetData($IAddressReview,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("IAddressReviewRun2Left",$run)
	Else
		AdlibUnRegister("IAddressReviewRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func IAddressReviewRun2Left()
	Local $data
	$data = IAddressReviewGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	IAddressReviewSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $IAddressReview
Func IAddressReviewGetPos()
	Return ControlGetPos($MainGUI, "", $IAddressReview)
EndFunc
;~ Chỉnh vị trí của $IAddressReview
Func IAddressReviewSetPos($x = -1,$y = -1)
	Local $Size = IAddressReviewGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IAddressReview,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IAddressReview
Func IAddressReviewSetSize($Width = -1,$Height = -1)
	Local $Size = IAddressReviewGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IAddressReview,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IAddressReview
Func IAddressReviewGetState()
	Return GUICtrlGetState($IAddressReview)
EndFunc
Func IAddressReviewSetState($State = $GUI_SHOW)
	GUICtrlSetState($IAddressReview,$State)
EndFunc


;~ Chỉnh màu chữ của $IAddressReview
Func IAddressReviewColor($Color = 0x000000)
	GUICtrlSetColor($IAddressReview,$Color)
EndFunc
;~ Chỉnh màu nền của $IAddressReview
Func IAddressReviewBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IAddressReview,$Color)
EndFunc