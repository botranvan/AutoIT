;~ Bấm vào $LSkill110Delay
Func LSkill110DelayClick()
	Local $Key = $Skill[110][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill110DelaySet($Key)
	$Skill[110][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill110Delay
Func LSkill110DelayGet()
	Return GUICtrlRead($LSkill110Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill110Delay
Func LSkill110DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill110Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill110DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill110Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill110Delay
Func LSkill110DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill110Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill110Delay
Func LSkill110DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill110DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill110Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill110Delay
Func LSkill110DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill110DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill110Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill110Delay
Func LSkill110DelayGetState()
	Return GUICtrlGetState($LSkill110Delay)
EndFunc
Func LSkill110DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill110Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill110Delay
Func LSkill110DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill110Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill110Delay
Func LSkill110DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill110Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================