;~ Bấm vào $CBSKill102
Func CBSKill102Click()
	If CBSKill102Get() == 1 Then $Skill[102][0] = 1
	If CBSKill102Get() == 4 Then $Skill[102][0] = 0
	SkillSave(102)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill102
Func CBSKill102Get()
	Return GUICtrlRead($CBSKill102)
EndFunc
;~ Lấy giá trị từ $CBSKill102
Func CBSKill102Set($NewValue = "")
	Local $Check = CBSKill102Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill102,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill102
Func CBSKill102GetState()
	Return GUICtrlGetState($CBSKill102)
EndFunc
Func CBSKill102SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill102,$State)
EndFunc


;~ Check và UnCheck $CBSKill102
Func CBSKill102Check($check = 0)
	If $check == 1 Then
		CBSKill102SetState($GUI_CHECKED)
	Else
		CBSKill102SetState($GUI_UNCHECKED)
	EndIf
EndFunc