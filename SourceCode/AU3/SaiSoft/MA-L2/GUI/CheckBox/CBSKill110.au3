;~ Bấm vào $CBSKill110
Func CBSKill110Click()
	If CBSKill110Get() == 1 Then $Skill[110][0] = 1
	If CBSKill110Get() == 4 Then $Skill[110][0] = 0
	SkillSave(110)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill110
Func CBSKill110Get()
	Return GUICtrlRead($CBSKill110)
EndFunc
;~ Lấy giá trị từ $CBSKill110
Func CBSKill110Set($NewValue = "")
	Local $Check = CBSKill110Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill110,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill110
Func CBSKill110GetState()
	Return GUICtrlGetState($CBSKill110)
EndFunc
Func CBSKill110SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill110,$State)
EndFunc


;~ Check và UnCheck $CBSKill110
Func CBSKill110Check($check = 0)
	If $check == 1 Then
		CBSKill110SetState($GUI_CHECKED)
	Else
		CBSKill110SetState($GUI_UNCHECKED)
	EndIf
EndFunc