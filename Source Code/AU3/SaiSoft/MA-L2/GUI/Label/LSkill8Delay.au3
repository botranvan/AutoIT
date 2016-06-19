;~ Bấm vào $LSkill8Delay
Func LSkill8DelayClick()
	Local $Key = $Skill[8][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill8DelaySet($Key)
	$Skill[8][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill8Delay
Func LSkill8DelayGet()
	Return GUICtrlRead($LSkill8Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill8Delay
Func LSkill8DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill8Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill8DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill8Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill8Delay
Func LSkill8DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill8Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill8Delay
Func LSkill8DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill8DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill8Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill8Delay
Func LSkill8DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill8DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill8Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill8Delay
Func LSkill8DelayGetState()
	Return GUICtrlGetState($LSkill8Delay)
EndFunc
Func LSkill8DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill8Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill8Delay
Func LSkill8DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill8Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill8Delay
Func LSkill8DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill8Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================