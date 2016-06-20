;~ Bấm vào $ELog
GUICtrlSetOnEvent($ELog, "ELogChange")
Func ELogChange()
	MsgBox(0,"72ls.NET","ELogChange") 
;~ 	ELogSave()
EndFunc

;~ Cuộn chuột xuống hàng cuối
Func ELogScrollEnd()
	_GUICtrlEdit_LineScroll($ELog, 0, _GUICtrlEdit_GetLineCount($ELog))
EndFunc

;Lưu giá trị trong label xuống file
Func ELogSave()
	Local $Data = ELogGet()
	$Data = StringReplace($Data,@CRLF,"<br>")
	IniWrite($DataFile,"Setting","ELog",$Data)
EndFunc

;Nạp giá trị của label từ file
Func ELogLoad()
	Local $Data = IniRead($DataFile,"Setting","ELog",ELogGet())
	$Data = StringReplace($Data,"<br>",@CRLF)
	ELogSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $ELog
Func ELogGet()
	Return GUICtrlRead($ELog)
EndFunc
;~ Lấy giá trị từ $ELog
Func ELogSet($NewValue = "")
	Local $Check = ELogGet()
	If $Check <> $NewValue Then GUICtrlSetData($ELog,$NewValue)
EndFunc
	

;~ Lấy vị trí và kích thước của $ELog
Func ELogGetPos()
	Return ControlGetPos($MainGUI, "", $ELog)
EndFunc
;~ Chỉnh vị trí của $ELog
Func ELogSetPos($x = -1,$y = -1)
	Local $Size = ELogGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($ELog,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $ELog
Func ELogSetSize($Width = -1,$Height = -1)
	Local $Size = ELogGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($ELog,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $ELog
Func ELogGetState()
	Return GUICtrlGetState($ELog)
EndFunc
Func ELogSetState($State = $GUI_SHOW)
	GUICtrlSetState($ELog,$State)
EndFunc


;~ Chỉnh màu chữ của $ELog
Func ELogColor($Color = 0x000000)
	GUICtrlSetColor($ELog,$Color)
EndFunc
;~ Chỉnh màu nền của $ELog
Func ELogBackGround($Color = 0x000000)
	GUICtrlSetBkColor($ELog,$Color)
EndFunc	