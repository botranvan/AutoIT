;~ Bấm vào $CBSKill105
Func CBSKill105Click()
	If CBSKill105Get() == 1 Then $Skill[105][0] = 1
	If CBSKill105Get() == 4 Then $Skill[105][0] = 0
	SkillSave(105)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill105
Func CBSKill105Get()
	Return GUICtrlRead($CBSKill105)
EndFunc
;~ Lấy giá trị từ $CBSKill105
Func CBSKill105Set($NewValue = "")
	Local $Check = CBSKill105Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill105,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill105
Func CBSKill105GetState()
	Return GUICtrlGetState($CBSKill105)
EndFunc
Func CBSKill105SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill105,$State)
EndFunc


;~ Check và UnCheck $CBSKill105
Func CBSKill105Check($check = 0)
	If $check == 1 Then
		CBSKill105SetState($GUI_CHECKED)
	Else
		CBSKill105SetState($GUI_UNCHECKED)
	EndIf
EndFunc