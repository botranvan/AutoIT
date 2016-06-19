;~ Bấm vào $CBSKill103
Func CBSKill103Click()
	If CBSKill103Get() == 1 Then $Skill[103][0] = 1
	If CBSKill103Get() == 4 Then $Skill[103][0] = 0
	SkillSave(103)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill103
Func CBSKill103Get()
	Return GUICtrlRead($CBSKill103)
EndFunc
;~ Lấy giá trị từ $CBSKill103
Func CBSKill103Set($NewValue = "")
	Local $Check = CBSKill103Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill103,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill103
Func CBSKill103GetState()
	Return GUICtrlGetState($CBSKill103)
EndFunc
Func CBSKill103SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill103,$State)
EndFunc


;~ Check và UnCheck $CBSKill103
Func CBSKill103Check($check = 0)
	If $check == 1 Then
		CBSKill103SetState($GUI_CHECKED)
	Else
		CBSKill103SetState($GUI_UNCHECKED)
	EndIf
EndFunc