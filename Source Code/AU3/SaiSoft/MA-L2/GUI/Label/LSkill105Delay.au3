;~ Bấm vào $LSkill105Delay
Func LSkill105DelayClick()
	Local $Key = $Skill[105][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill105DelaySet($Key)
	$Skill[105][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill105Delay
Func LSkill105DelayGet()
	Return GUICtrlRead($LSkill105Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill105Delay
Func LSkill105DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill105Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill105DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill105Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill105Delay
Func LSkill105DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill105Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill105Delay
Func LSkill105DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill105DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill105Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill105Delay
Func LSkill105DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill105DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill105Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill105Delay
Func LSkill105DelayGetState()
	Return GUICtrlGetState($LSkill105Delay)
EndFunc
Func LSkill105DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill105Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill105Delay
Func LSkill105DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill105Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill105Delay
Func LSkill105DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill105Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================