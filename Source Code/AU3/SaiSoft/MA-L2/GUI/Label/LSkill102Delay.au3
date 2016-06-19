;~ Bấm vào $LSkill102Delay
Func LSkill102DelayClick()
	Local $Key = $Skill[102][2]
	$Key = InputBox($AutoName,"Please enter a time delay",$Key)
	$Key*=1
	If $Key < 200 Then $Key = 200
		
	LSkill102DelaySet($Key)
	$Skill[102][2] = $Key
EndFunc

;~ Chỉnh giá trị chuỗi của $LSkill102Delay
Func LSkill102DelayGet()
	Return GUICtrlRead($LSkill102Delay)
EndFunc
;;~ Lấy giá trị từ $LSkill102Delay
Func LSkill102DelaySet($Data = "")
	Local $After = "s"
	Local $Title = "Time"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" minute"	
	GUICtrlSetTip($LSkill102Delay,$Data&" milliseconds",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = "m"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	$Data = $Data&$After
	Local $Check = LSkill102DelayGet()
	If $Check <> $Data Then GUICtrlSetData($LSkill102Delay,$Data)
EndFunc	


;~ Lấy vị trí và kích thước của $LSkill102Delay
Func LSkill102DelayGetPos()
	Return ControlGetPos($MainGUI, "", $LSkill102Delay)
EndFunc
;~ Chỉnh vị trí của $LSkill102Delay
Func LSkill102DelaySetPos($x = -1,$y = -1)
	Local $Size = LSkill102DelayGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LSkill102Delay,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LSkill102Delay
Func LSkill102DelaySetSize($Width = -1,$Height = -1)
	Local $Size = LSkill102DelayGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LSkill102Delay,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LSkill102Delay
Func LSkill102DelayGetState()
	Return GUICtrlGetState($LSkill102Delay)
EndFunc
Func LSkill102DelaySetState($State = $GUI_SHOW)
	GUICtrlSetState($LSkill102Delay,$State)
EndFunc


;~ Chỉnh màu chữ của $LSkill102Delay
Func LSkill102DelayColor($Color = 0x000000)
	GUICtrlSetColor($LSkill102Delay,$Color)
EndFunc
;~ Chỉnh màu nền của $LSkill102Delay
Func LSkill102DelayBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LSkill102Delay,$Color)
EndFunc
;~ << Thông báo ở cuối chương trình ============================================================================