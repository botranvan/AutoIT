;~ Bấm vào $EResult
GUICtrlSetOnEvent($EResult, "EResultChange")
Func EResultChange()
;~	MsgBox(0,"72ls.NET","EResultChange")
;~	EResultSave()
EndFunc

;~ EResultTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func EResultTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "EResult"

	$Text = FT($ControlID,EResultGet())

	EResultSet($Text)
EndFunc

;~ Cuộn chuột xuống hàng cuối
Func EResultScrollEnd()
	_GUICtrlEdit_LineScroll($ELog, 0, _GUICtrlEdit_GetLineCount($ELog))
EndFunc

;Lưu giá trị trong label xuống file
Func EResultSave()
	Local $Data = EResultGet()
	$Data = StringReplace($Data,@CRLF,"<br>")
	IniWrite($DataFile,"Setting","EResult",$Data)
EndFunc

;Nạp giá trị của label từ file
Func EResultLoad()
	Local $Data = IniRead($DataFile,"Setting","EResult",EResultGet())
	$Data = StringReplace($Data,"<br>",@CRLF)
	EResultSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $EResult
Func EResultGet()
	Return GUICtrlRead($EResult)
EndFunc
;~ Lấy giá trị từ $EResult
Func EResultSet($NewValue = "")
	Local $Check = EResultGet()
	If $Check <> $NewValue Then GUICtrlSetData($EResult,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $EResult
Func EResultGetPos()
	Return ControlGetPos($MainGUI, "", $EResult)
EndFunc
;~ Chỉnh vị trí của $EResult
Func EResultSetPos($x = -1,$y = -1)
	Local $Size = EResultGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($EResult,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $EResult
Func EResultSetSize($Width = -1,$Height = -1)
	Local $Size = EResultGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($EResult,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $EResult
Func EResultGetState()
	Return GUICtrlGetState($EResult)
EndFunc
Func EResultSetState($State = $GUI_SHOW)
	GUICtrlSetState($EResult,$State)
EndFunc


;~ Chỉnh màu chữ của $EResult
Func EResultColor($Color = 0x000000)
	GUICtrlSetColor($EResult,$Color)
EndFunc
;~ Chỉnh màu nền của $EResult
Func EResultBackGround($Color = 0x000000)
	GUICtrlSetBkColor($EResult,$Color)
EndFunc

Func EResultAddLine($Line)
	_GUICtrlEdit_AppendText($EResult, @CRLF & $Line)
EndFunc

