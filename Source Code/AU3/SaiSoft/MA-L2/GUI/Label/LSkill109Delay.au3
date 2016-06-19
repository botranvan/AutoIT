;~ Bấm vào $LSkill109Delay
Func LSkill109DelayClick()
	Local $Key = $Skill[109][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill109DelaySet($Key)
	$Skill[109][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill109Delay
Func LSkill109DelayGet()
	Return GUICtrlRead($LSkill109Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill109Delay
Func LSkill109DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill109Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill109DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill109Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill109Delay
Func LSkill109DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill109Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill109Delay
Func LSkill109DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill109DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill109Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill109Delay
Func LSkill109DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill109DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill109Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill109Delay
Func LSkill109DelayGetState()
	Return GUICtrlGetState($LSkill109Delay)
EndFunc
Func LSkill109DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill109Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill109Delay
Func LSkill109DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill109Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill109Delay
Func LSkill109DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill109Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================