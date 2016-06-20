;~ Ẩn chương trình
Func BStartAutoClick()
	$Training = Not $Training
	If $Training Then
		$AutoPos = MainGUIGetPos()
		BStartAutoSet("Stop Train")
		_ResumeGIFAnimation($hGIFThread)
	Else
		BStartAutoSet("Start Train")
		_StopGIFAnimation($hGIFThread)
	EndIf
EndFunc


;~ Chỉnh giá trị chuỗi của $BStartAuto
Func BStartAutoGet()
	Return GUICtrlRead($BStartAuto)
EndFunc
;~ Lấy giá trị từ $BStartAuto
Func BStartAutoSet($NewValue = "")
	Local $Check = BStartAutoGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStartAuto,$NewValue)
EndFunc
