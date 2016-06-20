;~ >> Nút thu gọn chương trình =================================================================================
;~ Ẩn chương trình
Func BHiddenClick()
	$AutoHide = Not $AutoHide
	Local $Span = 35
	If $AutoHide Then
		$AutoPos = MainGUIGetPos()
		BHiddenSet("\/")
		MainGUISetPos($AutoPos[0],0-$AutoPos[3]+$Span,2)
	Else
		BHiddenSet("/\")
		MainGUISetPos($AutoPos[0],$AutoPos[1])
	EndIf
EndFunc


;~ Chỉnh giá trị chuỗi của $BHidden
Func BHiddenGet()
	Return GUICtrlRead($BHidden)
EndFunc
;~ Lấy giá trị từ $BHidden
Func BHiddenSet($NewValue = "")
	Local $Check = BHiddenGet()
	If $Check <> $NewValue Then GUICtrlSetData($BHidden,$NewValue)
EndFunc
;~ << Nút thu gọn chương trình =================================================================================