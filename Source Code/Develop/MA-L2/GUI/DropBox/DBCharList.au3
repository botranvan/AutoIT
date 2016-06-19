;~ Bấm vào $DBCharList
Func DBCharListChange()
	CharDefaultSave()
	SkillLoad()
	GameTargetKeyLoad()
	GameUseBuffLoad()
	LoadGUIPos()
	MainGUIFix()
EndFunc

;~ Chỉnh giá trị chuỗi của $DBCharList
Func DBCharListGet()
	Return GUICtrlRead($DBCharList)
EndFunc
;~ Lấy giá trị từ $DBCharList
Func DBCharListSet($NewValue = "")
	Local $Check = DBCharListGet()
	If $Check <> $NewValue Then GUICtrlSetData($DBCharList,$NewValue)
EndFunc

;~ Thêm giá trị vào $DBCharList
Func DBCharListAdd($NewValue = "",$duplicate = 0)
	If $NewValue == "" Then Return
		
	If Not $duplicate Then 
		If _GUICtrlComboBox_FindStringExact($DBCharList, $NewValue) >= 0 Then Return
	EndIf


	_GUICtrlComboBox_AddString($DBCharList, $NewValue)
EndFunc	

;~ Chọn giá trị mặc định cho $DBCharList
Func DBCharListDefault($NewValue = "")
	If $NewValue == "" Then Return
	_GUICtrlComboBox_SelectString($DBCharList, $NewValue)
EndFunc	


;~ Lấy vị trí và kích thước của $DBCharList
Func DBCharListGetPos()
	Return ControlGetPos($MainGUI, "", $DBCharList)
EndFunc
;~ Chỉnh vị trí của $DBCharList
Func DBCharListSetPos($x = -1,$y = -1)
	Local $Size = DBCharListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($DBCharList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $DBCharList
Func DBCharListSetSize($Width = -1,$Height = -1)
	Local $Size = DBCharListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($DBCharList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $DBCharList
Func DBCharListGetState()
	Return GUICtrlGetState($DBCharList)
EndFunc
Func DBCharListSetState($State = $GUI_SHOW)
	GUICtrlSetState($DBCharList,$State)
EndFunc


;~ Chỉnh màu chữ của $DBCharList
Func DBCharListColor($Color = 0x000000)
	GUICtrlSetColor($DBCharList,$Color)
EndFunc
;~ Chỉnh màu nền của $DBCharList
Func DBCharListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($DBCharList,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================