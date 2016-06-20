;~ Bấm vào $LSkill107Delay
Func LSkill107DelayClick()
	Local $Key = $Skill[107][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill107DelaySet($Key)
	$Skill[107][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill107Delay
Func LSkill107DelayGet()
	Return GUICtrlRead($LSkill107Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill107Delay
Func LSkill107DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill107Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill107DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill107Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill107Delay
Func LSkill107DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill107Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill107Delay
Func LSkill107DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill107DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill107Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill107Delay
Func LSkill107DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill107DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill107Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill107Delay
Func LSkill107DelayGetState()
	Return GUICtrlGetState($LSkill107Delay)
EndFunc
Func LSkill107DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill107Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill107Delay
Func LSkill107DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill107Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill107Delay
Func LSkill107DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill107Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================