;~ Bấm vào $CBSKill107
Func CBSKill107Click()
	If CBSKill107Get() == 1 Then $Skill[107][0] = 1
	If CBSKill107Get() == 4 Then $Skill[107][0] = 0
	SkillSave(107)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill107
Func CBSKill107Get()
	Return GUICtrlRead($CBSKill107)
EndFunc
;~ Lấy giá trị từ $CBSKill107
Func CBSKill107Set($NewValue = "")
	Local $Check = CBSKill107Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill107,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill107
Func CBSKill107GetState()
	Return GUICtrlGetState($CBSKill107)
EndFunc
Func CBSKill107SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill107,$State)
EndFunc


;~ Check và UnCheck $CBSKill107
Func CBSKill107Check($check = 0)
	If $check == 1 Then
		CBSKill107SetState($GUI_CHECKED)
	Else
		CBSKill107SetState($GUI_UNCHECKED)
	EndIf
EndFunc