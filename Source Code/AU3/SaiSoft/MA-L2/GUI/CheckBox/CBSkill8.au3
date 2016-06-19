;~ Bấm vào $CBSkill8
Func CBSkill8Click()
	If CBSkill8Get() == 1 Then $Skill[8][0] = 1
	If CBSkill8Get() == 4 Then $Skill[8][0] = 0	
	SkillSave(8)
EndFunc


;~ Chỉnh giá trị chuỗi của $CBSkill8
Func CBSkill8Get()
	Return GUICtrlRead($CBSkill8)
EndFunc
;~ Lấy giá trị từ $CBSkill8
Func CBSkill8Set($NewValue = "")
	Local $Check = CBSkill8Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill8,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill8
Func CBSkill8GetState()
	Return GUICtrlGetState($CBSkill8)
EndFunc
Func CBSkill8SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill8,$State)
EndFunc

;~ Check và UnCheck $CBSkill8
Func CBSkill8Check($check = 0)
	If $check == 1 Then
		CBSkill8SetState($GUI_CHECKED)
	Else
		CBSkill8SetState($GUI_UNCHECKED)
	EndIf
EndFunc