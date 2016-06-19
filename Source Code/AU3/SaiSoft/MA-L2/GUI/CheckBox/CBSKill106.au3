;~ Bấm vào $CBSKill106
Func CBSKill106Click()
	If CBSKill106Get() == 1 Then $Skill[106][0] = 1
	If CBSKill106Get() == 4 Then $Skill[106][0] = 0
	SkillSave(106)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill106
Func CBSKill106Get()
	Return GUICtrlRead($CBSKill106)
EndFunc
;~ Lấy giá trị từ $CBSKill106
Func CBSKill106Set($NewValue = "")
	Local $Check = CBSKill106Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill106,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill106
Func CBSKill106GetState()
	Return GUICtrlGetState($CBSKill106)
EndFunc
Func CBSKill106SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill106,$State)
EndFunc


;~ Check và UnCheck $CBSKill106
Func CBSKill106Check($check = 0)
	If $check == 1 Then
		CBSKill106SetState($GUI_CHECKED)
	Else
		CBSKill106SetState($GUI_UNCHECKED)
	EndIf
EndFunc