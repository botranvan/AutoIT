;~ Bấm vào $CBSKill108
Func CBSKill108Click()
	If CBSKill108Get() == 1 Then $Skill[108][0] = 1
	If CBSKill108Get() == 4 Then $Skill[108][0] = 0
	SkillSave(108)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill108
Func CBSKill108Get()
	Return GUICtrlRead($CBSKill108)
EndFunc
;~ Lấy giá trị từ $CBSKill108
Func CBSKill108Set($NewValue = "")
	Local $Check = CBSKill108Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill108,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill108
Func CBSKill108GetState()
	Return GUICtrlGetState($CBSKill108)
EndFunc
Func CBSKill108SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill108,$State)
EndFunc


;~ Check và UnCheck $CBSKill108
Func CBSKill108Check($check = 0)
	If $check == 1 Then
		CBSKill108SetState($GUI_CHECKED)
	Else
		CBSKill108SetState($GUI_UNCHECKED)
	EndIf
EndFunc