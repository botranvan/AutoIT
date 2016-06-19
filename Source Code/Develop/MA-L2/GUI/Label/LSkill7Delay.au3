;~ Bấm vào $LSkill7Delay
Func LSkill7DelayClick()
	Local $Key = $Skill[7][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill7DelaySet($Key)
	$Skill[7][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill7Delay
Func LSkill7DelayGet()
	Return GUICtrlRead($LSkill7Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill7Delay
Func LSkill7DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill7Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill7DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill7Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill7Delay
Func LSkill7DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill7Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill7Delay
Func LSkill7DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill7DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill7Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill7Delay
Func LSkill7DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill7DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill7Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill7Delay
Func LSkill7DelayGetState()
	Return GUICtrlGetState($LSkill7Delay)
EndFunc
Func LSkill7DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill7Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill7Delay
Func LSkill7DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill7Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill7Delay
Func LSkill7DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill7Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================