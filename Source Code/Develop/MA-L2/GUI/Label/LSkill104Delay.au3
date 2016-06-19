;~ Bấm vào $LSkill104Delay
Func LSkill104DelayClick()
	Local $Key = $Skill[104][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill104DelaySet($Key)
	$Skill[104][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill104Delay
Func LSkill104DelayGet()
	Return GUICtrlRead($LSkill104Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill104Delay
Func LSkill104DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill104Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill104DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill104Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill104Delay
Func LSkill104DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill104Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill104Delay
Func LSkill104DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill104DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill104Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill104Delay
Func LSkill104DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill104DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill104Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill104Delay
Func LSkill104DelayGetState()
	Return GUICtrlGetState($LSkill104Delay)
EndFunc
Func LSkill104DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill104Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill104Delay
Func LSkill104DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill104Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill104Delay
Func LSkill104DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill104Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================