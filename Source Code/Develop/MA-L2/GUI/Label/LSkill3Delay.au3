;~ Bấm vào $LSkill3Delay
Func LSkill3DelayClick()
	Local $Key = $Skill[3][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill3DelaySet($Key)
	$Skill[3][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill3Delay
Func LSkill3DelayGet()
	Return GUICtrlRead($LSkill3Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill3Delay
Func LSkill3DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill3Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill3DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill3Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill3Delay
Func LSkill3DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill3Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill3Delay
Func LSkill3DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill3DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill3Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill3Delay
Func LSkill3DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill3DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill3Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill3Delay
Func LSkill3DelayGetState()
	Return GUICtrlGetState($LSkill3Delay)
EndFunc
Func LSkill3DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill3Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill3Delay
Func LSkill3DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill3Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill3Delay
Func LSkill3DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill3Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================