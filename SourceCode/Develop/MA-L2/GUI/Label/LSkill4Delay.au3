;~ Bấm vào $LSkill4Delay
Func LSkill4DelayClick()
	Local $Key = $Skill[4][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill4DelaySet($Key)
	$Skill[4][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill4Delay
Func LSkill4DelayGet()
	Return GUICtrlRead($LSkill4Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill4Delay
Func LSkill4DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill4Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill4DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill4Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill4Delay
Func LSkill4DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill4Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill4Delay
Func LSkill4DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill4DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill4Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill4Delay
Func LSkill4DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill4DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill4Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill4Delay
Func LSkill4DelayGetState()
	Return GUICtrlGetState($LSkill4Delay)
EndFunc
Func LSkill4DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill4Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill4Delay
Func LSkill4DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill4Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill4Delay
Func LSkill4DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill4Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================