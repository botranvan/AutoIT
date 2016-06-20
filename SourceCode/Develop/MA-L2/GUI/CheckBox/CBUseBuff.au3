;~ Bấm vào $CBUseBuff
Func CBUseBuffClick()
	If CBUseBuffGet() == 1 Then $UsingBuff = 1
	If CBUseBuffGet() == 4 Then $UsingBuff = 0
	GameUseBuffSave()
EndFunc

;~ Chỉnh giá trị chuỗi của $CBUseBuff
Func CBUseBuffGet()
	Return GUICtrlRead($CBUseBuff)
EndFunc
;~ Lấy giá trị từ $CBUseBuff
Func CBUseBuffSet($NewValue = "")
	Local $Check = CBUseBuffGet()
	If $Check <> $NewValue Then GUICtrlSetData($CBUseBuff,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBUseBuff
Func CBUseBuffGetState()
	Return GUICtrlGetState($CBUseBuff)
EndFunc
Func CBUseBuffSetState($State = $GUI_SHOW)
	GUICtrlSetState($CBUseBuff,$State)
EndFunc


;~ Check và UnCheck $CBUseBuff
Func CBUseBuffCheck($check = 0)
	If $check == 1 Then
		CBUseBuffSetState($GUI_CHECKED)
	Else
		CBUseBuffSetState($GUI_UNCHECKED)
	EndIf
EndFunc