;~ Bấm vào $LSkill9Delay
Func LSkill9DelayClick()
	Local $Key = $Skill[9][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill9DelaySet($Key)
	$Skill[9][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill9Delay
Func LSkill9DelayGet()
	Return GUICtrlRead($LSkill9Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill9Delay
Func LSkill9DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill9Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill9DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill9Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill9Delay
Func LSkill9DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill9Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill9Delay
Func LSkill9DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill9DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill9Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill9Delay
Func LSkill9DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill9DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill9Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill9Delay
Func LSkill9DelayGetState()
	Return GUICtrlGetState($LSkill9Delay)
EndFunc
Func LSkill9DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill9Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill9Delay
Func LSkill9DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill9Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill9Delay
Func LSkill9DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill9Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================