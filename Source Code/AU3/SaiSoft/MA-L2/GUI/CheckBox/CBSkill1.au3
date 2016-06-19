;~ Bấm vào $CBSkill1
Func CBSkill1Click()
	If CBSkill1Get() == 1 Then $Skill[1][0] = 1
	If CBSkill1Get() == 4 Then $Skill[1][0] = 0
	SkillSave(1)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSkill1
Func CBSkill1Get()
	Return GUICtrlRead($CBSkill1)
EndFunc
;~ Lấy giá trị từ $CBSkill1
Func CBSkill1Set($NewValue = "")
	Local $Check = CBSkill1Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSkill1,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSkill1
Func CBSkill1GetState()
	Return GUICtrlGetState($CBSkill1)
EndFunc
Func CBSkill1SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSkill1,$State)
EndFunc


;~ Check và UnCheck $CBSkill1
Func CBSkill1Check($check = 0)
	If $check == 1 Then
		CBSkill1SetState($GUI_CHECKED)
	Else
		CBSkill1SetState($GUI_UNCHECKED)
	EndIf
EndFunc