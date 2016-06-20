;~ Bấm vào $IKeyword
GUICtrlSetOnEvent($IKeyword, "IKeywordChange")
Func IKeywordChange()
;~ 	MsgBox(0,"72ls.NET","IKeywordChange")
	IKeywordTSave()
EndFunc

IKeywordTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IKeywordTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IKeyword"

	$Text = FT($ControlID,IKeywordGet())

	IKeywordSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IKeywordTSave()
    FTWrite('IKeyword',IKeywordGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IKeywordSave()
	IniWrite($DataFile,"Setting","IKeyword",IKeywordGet())
EndFunc

;Nạp giá trị của label từ file
Func IKeywordLoad()
	Local $Data = IniRead($DataFile,"Setting","IKeyword",IKeywordGet())
	IKeywordSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IKeyword
Func IKeywordGet()
	Return GUICtrlRead($IKeyword)
EndFunc
;~ Lấy giá trị từ $IKeyword
Func IKeywordSet($NewValue = "")
	Local $Check = IKeywordGet()
	If $Check <> $NewValue Then GUICtrlSetData($IKeyword,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IKeyword
Func IKeywordGetPos()
	Return ControlGetPos($MainGUI, "", $IKeyword)
EndFunc
;~ Chỉnh vị trí của $IKeyword
Func IKeywordSetPos($x = -1,$y = -1)
	Local $Size = IKeywordGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IKeyword,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IKeyword
Func IKeywordSetSize($Width = -1,$Height = -1)
	Local $Size = IKeywordGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IKeyword,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IKeyword
Func IKeywordGetState()
	Return GUICtrlGetState($IKeyword)
EndFunc
Func IKeywordSetState($State = $GUI_SHOW)
	GUICtrlSetState($IKeyword,$State)
EndFunc


;~ Chỉnh màu chữ của $IKeyword
Func IKeywordColor($Color = 0x000000)
	GUICtrlSetColor($IKeyword,$Color)
EndFunc
;~ Chỉnh màu nền của $IKeyword
Func IKeywordBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IKeyword,$Color)
EndFunc