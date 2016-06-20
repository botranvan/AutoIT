;~ Bấm vào $BStart
GUICtrlSetOnEvent($BStart, "BStartClick")
Func BStartClick()
	$AutoRuning = Not $AutoRuning
	If $AutoRuning Then
		BStartSet('Stop')
	Else
		BStartSet('Start')
	EndIf

EndFunc


;~ BStartTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStartTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStart"

	$Text = FT($ControlID,BStartGet())

	BStartSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStartSave()
	IniWrite($DataFile,"Setting","BStart",BStartGet())
EndFunc

;Nạp giá trị của label từ file
Func BStartLoad()
	Local $Data = IniRead($DataFile,"Setting","BStart",BStartGet())
	BStartSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStart
Func BStartGet()
	Return GUICtrlRead($BStart)
EndFunc
;~ Lấy giá trị từ $BStart
Func BStartSet($NewValue = "")
	Local $Check = BStartGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStart,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStart
Func BStartGetPos()
	Return ControlGetPos($MainGUI, "", $BStart)
EndFunc
;~ Chỉnh vị trí của $BStart
Func BStartSetPos($x = -1,$y = -1)
	Local $Size = BStartGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStart,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStart
Func BStartSetSize($Width = -1,$Height = -1)
	Local $Size = BStartGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStart,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStart
Func BStartGetState()
	Return GUICtrlGetState($BStart)
EndFunc
Func BStartSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStart,$State)
EndFunc


;~ Chỉnh màu chữ của $BStart
Func BStartColor($Color = 0x000000)
	GUICtrlSetColor($BStart,$Color)
EndFunc
;~ Chỉnh màu nền của $BStart
Func BStartBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStart,$Color)
EndFunc