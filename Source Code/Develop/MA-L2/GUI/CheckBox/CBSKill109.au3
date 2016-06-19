;~ Bấm vào $CBSKill109
Func CBSKill109Click()
	If CBSKill109Get() == 1 Then $Skill[109][0] = 1
	If CBSKill109Get() == 4 Then $Skill[109][0] = 0
	SkillSave(109)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill109
Func CBSKill109Get()
	Return GUICtrlRead($CBSKill109)
EndFunc
;~ Lấy giá trị từ $CBSKill109
Func CBSKill109Set($NewValue = "")
	Local $Check = CBSKill109Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill109,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill109
Func CBSKill109GetState()
	Return GUICtrlGetState($CBSKill109)
EndFunc
Func CBSKill109SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill109,$State)
EndFunc


;~ Check và UnCheck $CBSKill109
Func CBSKill109Check($check = 0)
	If $check == 1 Then
		CBSKill109SetState($GUI_CHECKED)
	Else
		CBSKill109SetState($GUI_UNCHECKED)
	EndIf
EndFunc