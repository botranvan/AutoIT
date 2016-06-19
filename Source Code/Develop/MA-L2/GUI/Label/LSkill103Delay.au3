;~ Bấm vào $LSkill103Delay
Func LSkill103DelayClick()
	Local $Key = $Skill[103][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill103DelaySet($Key)
	$Skill[103][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill103Delay
Func LSkill103DelayGet()
	Return GUICtrlRead($LSkill103Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill103Delay
Func LSkill103DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill103Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill103DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill103Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill103Delay
Func LSkill103DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill103Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill103Delay
Func LSkill103DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill103DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill103Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill103Delay
Func LSkill103DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill103DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill103Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill103Delay
Func LSkill103DelayGetState()
	Return GUICtrlGetState($LSkill103Delay)
EndFunc
Func LSkill103DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill103Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill103Delay
Func LSkill103DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill103Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill103Delay
Func LSkill103DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill103Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================