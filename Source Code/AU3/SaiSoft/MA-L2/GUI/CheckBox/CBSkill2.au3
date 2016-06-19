;~ Bấm vào $CBSkill2
Func CBSkill2Click()
	If CBSkill2Get() == 1 Then $Skill[2][0] = 1
	If CBSkill2Get() == 4 Then $Skill[2][0] = 0
	SkillSave(2)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSkill2
Func CBSkill2Get()
	Return GUICtrlRead($CBSkill2)
EndFunc
;~ Lấy giá trị từ $CBSkill2
Func CBSkill2Set($NewValue = "")
	Local $Check = CBSkill2Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill2,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill2
Func CBSkill2GetState()
	Return GUICtrlGetState($CBSkill2)
EndFunc
Func CBSkill2SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill2,$State)
EndFunc

;~ Check và UnCheck $CBSkill2
Func CBSkill2Check($check = 0)
	If $check == 1 Then
		CBSkill2SetState($GUI_CHECKED)
	Else
		CBSkill2SetState($GUI_UNCHECKED)
	EndIf
EndFunc