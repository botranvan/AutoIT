;~ Bấm vào $LSkill101Delay
Func LSkill101DelayClick()
	Local $Key = $Skill[101][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill101DelaySet($Key)
	$Skill[101][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill101Delay
Func LSkill101DelayGet()
	Return GUICtrlRead($LSkill101Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill101Delay
Func LSkill101DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill101Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill101DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill101Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill101Delay
Func LSkill101DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill101Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill101Delay
Func LSkill101DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill101DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill101Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill101Delay
Func LSkill101DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill101DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill101Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill101Delay
Func LSkill101DelayGetState()
	Return GUICtrlGetState($LSkill101Delay)
EndFunc
Func LSkill101DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill101Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill101Delay
Func LSkill101DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill101Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill101Delay
Func LSkill101DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill101Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================