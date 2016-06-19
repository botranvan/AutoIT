;~ Bấm vào $LSkill10Delay
Func LSkill10DelayClick()
	Local $Key = $Skill[10][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill10DelaySet($Key)
	$Skill[10][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill10Delay
Func LSkill10DelayGet()
	Return GUICtrlRead($LSkill10Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill10Delay
Func LSkill10DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill10Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill10DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill10Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill10Delay
Func LSkill10DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill10Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill10Delay
Func LSkill10DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill10DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill10Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill10Delay
Func LSkill10DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill10DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill10Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill10Delay
Func LSkill10DelayGetState()
	Return GUICtrlGetState($LSkill10Delay)
EndFunc
Func LSkill10DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill10Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill10Delay
Func LSkill10DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill10Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill10Delay
Func LSkill10DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill10Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================