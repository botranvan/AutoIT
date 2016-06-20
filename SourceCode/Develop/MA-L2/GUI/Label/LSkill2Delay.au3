;~ Bấm vào $LSkill2Delay
Func LSkill2DelayClick()
	Local $Key = $Skill[2][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill2DelaySet($Key)
	$Skill[2][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill2Delay
Func LSkill2DelayGet()
	Return GUICtrlRead($LSkill2Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill2Delay
Func LSkill2DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill2Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill2DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill2Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill2Delay
Func LSkill2DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill2Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill2Delay
Func LSkill2DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill2DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill2Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill2Delay
Func LSkill2DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill2DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill2Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill2Delay
Func LSkill2DelayGetState()
	Return GUICtrlGetState($LSkill2Delay)
EndFunc
Func LSkill2DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill2Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill2Delay
Func LSkill2DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill2Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill2Delay
Func LSkill2DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill2Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================