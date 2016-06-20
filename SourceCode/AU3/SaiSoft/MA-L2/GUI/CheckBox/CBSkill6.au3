;~ Bấm vào $CBSkill6
Func CBSkill6Click()
	If CBSkill6Get() == 1 Then $Skill[6][0] = 1
	If CBSkill6Get() == 4 Then $Skill[6][0] = 0	
	SkillSave(6)
EndFunc


;~ Chỉnh giá trị chuỗi của $CBSkill6
Func CBSkill6Get()
	Return GUICtrlRead($CBSkill6)
EndFunc
;~ Lấy giá trị từ $CBSkill6
Func CBSkill6Set($NewValue = "")
	Local $Check = CBSkill6Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill6,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill6
Func CBSkill6GetState()
	Return GUICtrlGetState($CBSkill6)
EndFunc
Func CBSkill6SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill6,$State)
EndFunc

;~ Check và UnCheck $CBSkill6
Func CBSkill6Check($check = 0)
	If $check == 1 Then
		CBSkill6SetState($GUI_CHECKED)
	Else
		CBSkill6SetState($GUI_UNCHECKED)
	EndIf
EndFunc