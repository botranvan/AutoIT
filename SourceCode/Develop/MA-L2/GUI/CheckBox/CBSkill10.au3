;~ Bấm vào $CBSkill10
Func CBSkill10Click()
	If CBSkill10Get() == 1 Then $Skill[10][0] = 1
	If CBSkill10Get() == 4 Then $Skill[10][0] = 0	
	SkillSave(10)
EndFunc


;~ Chỉnh giá trị chuỗi của $CBSkill10
Func CBSkill10Get()
	Return GUICtrlRead($CBSkill10)
EndFunc
;~ Lấy giá trị từ $CBSkill10
Func CBSkill10Set($NewValue = "")
	Local $Check = CBSkill10Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill10,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill10
Func CBSkill10GetState()
	Return GUICtrlGetState($CBSkill10)
EndFunc
Func CBSkill10SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill10,$State)
EndFunc

;~ Check và UnCheck $CBSkill10
Func CBSkill10Check($check = 0)
	If $check == 1 Then
		CBSkill10SetState($GUI_CHECKED)
	Else
		CBSkill10SetState($GUI_UNCHECKED)
	EndIf
EndFunc