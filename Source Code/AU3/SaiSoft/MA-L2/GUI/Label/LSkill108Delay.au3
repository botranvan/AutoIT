;~ Bấm vào $LSkill108Delay
Func LSkill108DelayClick()
	Local $Key = $Skill[108][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill108DelaySet($Key)
	$Skill[108][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill108Delay
Func LSkill108DelayGet()
	Return GUICtrlRead($LSkill108Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill108Delay
Func LSkill108DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill108Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill108DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill108Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill108Delay
Func LSkill108DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill108Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill108Delay
Func LSkill108DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill108DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill108Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill108Delay
Func LSkill108DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill108DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill108Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill108Delay
Func LSkill108DelayGetState()
	Return GUICtrlGetState($LSkill108Delay)
EndFunc
Func LSkill108DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill108Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill108Delay
Func LSkill108DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill108Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill108Delay
Func LSkill108DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill108Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================