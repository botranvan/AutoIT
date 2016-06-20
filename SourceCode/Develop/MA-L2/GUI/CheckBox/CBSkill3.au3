;~ Bấm vào $CBSkill3
Func CBSkill3Click()
	If CBSkill3Get() == 1 Then $Skill[3][0] = 1
	If CBSkill3Get() == 4 Then $Skill[3][0] = 0	
	SkillSave(3)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSkill3
Func CBSkill3Get()
	Return GUICtrlRead($CBSkill3)
EndFunc
;~ Lấy giá trị từ $CBSkill3
Func CBSkill3Set($NewValue = "")
	Local $Check = CBSkill3Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill3,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill3
Func CBSkill3GetState()
	Return GUICtrlGetState($CBSkill3)
EndFunc
Func CBSkill3SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill3,$State)
EndFunc

;~ Check và UnCheck $CBSkill3
Func CBSkill3Check($check = 0)
	If $check == 1 Then
		CBSkill3SetState($GUI_CHECKED)
	Else
		CBSkill3SetState($GUI_UNCHECKED)
	EndIf
EndFunc