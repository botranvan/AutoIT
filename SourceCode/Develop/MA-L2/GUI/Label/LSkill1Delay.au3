;~ Bấm vào $LSkill1Delay
Func LSkill1DelayClick()
	Local $Key = $Skill[1][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill1DelaySet($Key)
	$Skill[1][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill1Delay
Func LSkill1DelayGet()
	Return GUICtrlRead($LSkill1Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill1Delay
Func LSkill1DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill1Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill1DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill1Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill1Delay
Func LSkill1DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill1Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill1Delay
Func LSkill1DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill1DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill1Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill1Delay
Func LSkill1DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill1DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill1Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill1Delay
Func LSkill1DelayGetState()
	Return GUICtrlGetState($LSkill1Delay)
EndFunc
Func LSkill1DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill1Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill1Delay
Func LSkill1DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill1Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill1Delay
Func LSkill1DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill1Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================