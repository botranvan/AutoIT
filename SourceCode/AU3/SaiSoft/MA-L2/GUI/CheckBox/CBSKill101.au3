;~ Bấm vào $CBSKill101
Func CBSKill101Click()
	If CBSKill101Get() == 1 Then $Skill[101][0] = 1
	If CBSKill101Get() == 4 Then $Skill[101][0] = 0
	SkillSave(101)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill101
Func CBSKill101Get()
	Return GUICtrlRead($CBSKill101)
EndFunc
;~ Lấy giá trị từ $CBSKill101
Func CBSKill101Set($NewValue = "")
	Local $Check = CBSKill101Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill101,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill101
Func CBSKill101GetState()
	Return GUICtrlGetState($CBSKill101)
EndFunc
Func CBSKill101SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill101,$State)
EndFunc


;~ Check và UnCheck $CBSKill101
Func CBSKill101Check($check = 0)
	If $check == 1 Then
		CBSKill101SetState($GUI_CHECKED)
	Else
		CBSKill101SetState($GUI_UNCHECKED)
	EndIf
EndFunc