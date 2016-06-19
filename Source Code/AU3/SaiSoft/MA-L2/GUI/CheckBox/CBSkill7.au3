;~ Bấm vào $CBSkill7
Func CBSkill7Click()
	If CBSkill7Get() == 1 Then $Skill[7][0] = 1
	If CBSkill7Get() == 4 Then $Skill[7][0] = 0	
	SkillSave(7)
EndFunc


;~ Chỉnh giá trị chuỗi của $CBSkill7
Func CBSkill7Get()
	Return GUICtrlRead($CBSkill7)
EndFunc
;~ Lấy giá trị từ $CBSkill7
Func CBSkill7Set($NewValue = "")
	Local $Check = CBSkill7Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill7,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill7
Func CBSkill7GetState()
	Return GUICtrlGetState($CBSkill7)
EndFunc
Func CBSkill7SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill7,$State)
EndFunc

;~ Check và UnCheck $CBSkill7
Func CBSkill7Check($check = 0)
	If $check == 1 Then
		CBSkill7SetState($GUI_CHECKED)
	Else
		CBSkill7SetState($GUI_UNCHECKED)
	EndIf
EndFunc