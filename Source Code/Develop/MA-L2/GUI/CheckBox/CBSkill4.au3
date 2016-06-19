;~ Bấm vào $CBSkill4
Func CBSkill4Click()
	If CBSkill4Get() == 1 Then $Skill[4][0] = 1
	If CBSkill4Get() == 4 Then $Skill[4][0] = 0	
	SkillSave(4)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSkill4
Func CBSkill4Get()
	Return GUICtrlRead($CBSkill4)
EndFunc
;~ Lấy giá trị từ $CBSkill4
Func CBSkill4Set($NewValue = "")
	Local $Check = CBSkill4Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill4,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill4
Func CBSkill4GetState()
	Return GUICtrlGetState($CBSkill4)
EndFunc
Func CBSkill4SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill4,$State)
EndFunc

;~ Check và UnCheck $CBSkill4
Func CBSkill4Check($check = 0)
	If $check == 1 Then
		CBSkill4SetState($GUI_CHECKED)
	Else
		CBSkill4SetState($GUI_UNCHECKED)
	EndIf
EndFunc