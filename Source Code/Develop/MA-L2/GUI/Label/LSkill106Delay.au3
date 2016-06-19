;~ Bấm vào $LSkill106Delay
Func LSkill106DelayClick()
	Local $Key = $Skill[106][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill106DelaySet($Key)
	$Skill[106][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill106Delay
Func LSkill106DelayGet()
	Return GUICtrlRead($LSkill106Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill106Delay
Func LSkill106DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill106Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill106DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill106Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill106Delay
Func LSkill106DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill106Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill106Delay
Func LSkill106DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill106DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill106Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill106Delay
Func LSkill106DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill106DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill106Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill106Delay
Func LSkill106DelayGetState()
	Return GUICtrlGetState($LSkill106Delay)
EndFunc
Func LSkill106DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill106Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill106Delay
Func LSkill106DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill106Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill106Delay
Func LSkill106DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill106Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================