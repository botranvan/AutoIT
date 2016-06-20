;~ Bấm vào $CBSkill5
Func CBSkill5Click()
	If CBSkill5Get() == 1 Then $Skill[5][0] = 1
	If CBSkill5Get() == 4 Then $Skill[5][0] = 0	
	SkillSave(5)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSkill5
Func CBSkill5Get()
	Return GUICtrlRead($CBSkill5)
EndFunc
;~ Lấy giá trị từ $CBSkill5
Func CBSkill5Set($NewValue = "")
	Local $Check = CBSkill5Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill5,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill5
Func CBSkill5GetState()
	Return GUICtrlGetState($CBSkill5)
EndFunc
Func CBSkill5SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill5,$State)
EndFunc

;~ Check và UnCheck $CBSkill5
Func CBSkill5Check($check = 0)
	If $check == 1 Then
		CBSkill5SetState($GUI_CHECKED)
	Else
		CBSkill5SetState($GUI_UNCHECKED)
	EndIf
EndFunc