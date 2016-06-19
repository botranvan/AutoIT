;~ Bấm vào $LWin
Func LWinClick()
	While ($Win>0)
		$Credits+=1
		$Win-=1
		LCreditsSet($Credits)
		LWinSet($Win)
		Sleep(27)
	WEnd
	FCreditsSave()	;Lưu sau khi nhận tiền thưởng
EndFunc

;~ Check và UnCheck $LWin
Func LWinCheck($check = 0)
	If $check == 1 Then
		LWinSetState($GUI_CHECKED)
	Else
		LWinSetState($GUI_UNCHECKED)
	EndIf
EndFunc

;~ Chỉnh giá trị chuỗi của $LWin
Func LWinGet()
	Return GUICtrlRead($LWin)
EndFunc
;~ Lấy giá trị từ $LWin
Func LWinSet($NewValue = "",$run = 0)
	Local $Check = LWinGet()
	If $Check <> $NewValue Then GUICtrlSetData($LWin,$NewValue)
	If $NewValue Then
		If $run > 0 Then AdlibRegister("LWinRun2Left",$run)
	Else
		AdlibUnRegister("LWinRun2Left")	
	EndIf
EndFunc

;~ Tạo chữ chạy trừ Trái sang Phải
Func LWinRun2Left()
	Local $data
	$data = LWinGet()
	$data = StringRight($data,StringLen($data)-1)&StringLeft($data,1)
	LWinSet($data,0)
EndFunc
	
;~ Lấy vị trí và kích thước của $LWin
Func LWinGetPos()
	Return ControlGetPos($MainGUI, "", $LWin)
EndFunc
;~ Chỉnh vị trí của $LWin
Func LWinSetPos($x = -1,$y = -1)
	Local $Size = LWinGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LWin,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LWin
Func LWinSetSize($Width = -1,$Height = -1)
	Local $Size = LWinGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LWin,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LWin
Func LWinGetState()
	Return GUICtrlGetState($LWin)
EndFunc
Func LWinSetState($State = $GUI_SHOW)
	GUICtrlSetState($LWin,$State)
EndFunc


;~ Chỉnh màu chữ của $LWin
Func LWinColor($Color = 0x000000)
	GUICtrlSetColor($LWin,$Color)
EndFunc
;~ Chỉnh màu nền của $LWin
Func LWinBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LWin,$Color)
EndFunc