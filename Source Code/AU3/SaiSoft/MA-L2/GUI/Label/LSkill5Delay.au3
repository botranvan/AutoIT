;~ Bấm vào $LSkill5Delay
Func LSkill5DelayClick()
	Local $Key = $Skill[5][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill5DelaySet($Key)
	$Skill[5][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill5Delay
Func LSkill5DelayGet()
	Return GUICtrlRead($LSkill5Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill5Delay
Func LSkill5DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill5Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill5DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill5Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill5Delay
Func LSkill5DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill5Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill5Delay
Func LSkill5DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill5DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill5Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill5Delay
Func LSkill5DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill5DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill5Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill5Delay
Func LSkill5DelayGetState()
	Return GUICtrlGetState($LSkill5Delay)
EndFunc
Func LSkill5DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill5Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill5Delay
Func LSkill5DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill5Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill5Delay
Func LSkill5DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill5Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================