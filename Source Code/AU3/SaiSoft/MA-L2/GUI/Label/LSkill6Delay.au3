;~ Bấm vào $LSkill6Delay
Func LSkill6DelayClick()
	Local $Key = $Skill[6][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill6DelaySet($Key)
	$Skill[6][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill6Delay
Func LSkill6DelayGet()
	Return GUICtrlRead($LSkill6Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill6Delay
Func LSkill6DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill6Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill6DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill6Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill6Delay
Func LSkill6DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill6Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill6Delay
Func LSkill6DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill6DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill6Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill6Delay
Func LSkill6DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill6DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill6Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill6Delay
Func LSkill6DelayGetState()
	Return GUICtrlGetState($LSkill6Delay)
EndFunc
Func LSkill6DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill6Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill6Delay
Func LSkill6DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill6Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill6Delay
Func LSkill6DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill6Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================