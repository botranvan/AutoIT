;~ Bấm vào $CBSkill9
Func CBSkill9Click()
	If CBSkill9Get() == 1 Then $Skill[9][0] = 1
	If CBSkill9Get() == 4 Then $Skill[9][0] = 0	
	SkillSave(9)
EndFunc


;~ Chỉnh giá trị chuỗi của $CBSkill9
Func CBSkill9Get()
	Return GUICtrlRead($CBSkill9)
EndFunc
;~ Lấy giá trị từ $CBSkill9
Func CBSkill9Set($NewValue = "")
	Local $Check = CBSkill9Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill9,$NewValue)
EndFunc

;~ Chỉnh trạng thái $CBSkill9
Func CBSkill9GetState()
	Return GUICtrlGetState($CBSkill9)
EndFunc
Func CBSkill9SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill9,$State)
EndFunc

;~ Check và UnCheck $CBSkill9
Func CBSkill9Check($check = 0)
	If $check == 1 Then
		CBSkill9SetState($GUI_CHECKED)
	Else
		CBSkill9SetState($GUI_UNCHECKED)
	EndIf
EndFunc