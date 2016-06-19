;~ Bấm vào $CBSKill104
Func CBSKill104Click()
	If CBSKill104Get() == 1 Then $Skill[104][0] = 1
	If CBSKill104Get() == 4 Then $Skill[104][0] = 0
	SkillSave(104)
EndFunc

;~ Chỉnh giá trị chuỗi của $CBSKill104
Func CBSKill104Get()
	Return GUICtrlRead($CBSKill104)
EndFunc
;~ Lấy giá trị từ $CBSKill104
Func CBSKill104Set($NewValue = "")
	Local $Check = CBSKill104Get()
	If $Check <> $NewValue Then GUICtrlSetData($CBSKill104,$NewValue)
EndFunc


;~ Chỉnh trạng thái $CBSKill104
Func CBSKill104GetState()
	Return GUICtrlGetState($CBSKill104)
EndFunc
Func CBSKill104SetState($State = $GUI_SHOW)
	GUICtrlSetState($CBSKill104,$State)
EndFunc


;~ Check và UnCheck $CBSKill104
Func CBSKill104Check($check = 0)
	If $check == 1 Then
		CBSKill104SetState($GUI_CHECKED)
	Else
		CBSKill104SetState($GUI_UNCHECKED)
	EndIf
EndFunc