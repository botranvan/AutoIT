;~ Bấm vào $IRepeatTime
GUICtrlSetOnEvent($IRepeatTime, "IRepeatTimeChange")
Func IRepeatTimeChange()
;~ 	MsgBox(0,"72ls.NET","IRepeatTimeChange")
	IRepeatTimeSave()
EndFunc

;~ IRepeatTimeTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IRepeatTimeTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IRepeatTime"

	$Text = FT($ControlID,IRepeatTimeGet())

	IRepeatTimeSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IRepeatTimeTSave()
    FTWrite('IRepeatTime',IRepeatTimeGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IRepeatTimeSave()
	IniWrite($DataFile,"Setting","IRepeatTime",IRepeatTimeGet())
EndFunc

;Nạp giá trị của label từ file
IRepeatTimeLoad()
Func IRepeatTimeLoad()
	Local $Data = IniRead($DataFile,"Setting","IRepeatTime",IRepeatTimeGet())
	IRepeatTimeSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IRepeatTime
Func IRepeatTimeGet()
	Return GUICtrlRead($IRepeatTime)
EndFunc
;~ Lấy giá trị từ $IRepeatTime
Func IRepeatTimeSet($NewValue = "")
	Local $Check = IRepeatTimeGet()
	If $Check <> $NewValue Then GUICtrlSetData($IRepeatTime,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IRepeatTime
Func IRepeatTimeGetPos()
	Return ControlGetPos($MainGUI, "", $IRepeatTime)
EndFunc
;~ Chỉnh vị trí của $IRepeatTime
Func IRepeatTimeSetPos($x = -1,$y = -1)
	Local $Size = IRepeatTimeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IRepeatTime,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IRepeatTime
Func IRepeatTimeSetSize($Width = -1,$Height = -1)
	Local $Size = IRepeatTimeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IRepeatTime,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IRepeatTime
Func IRepeatTimeGetState()
	Return GUICtrlGetState($IRepeatTime)
EndFunc
Func IRepeatTimeSetState($State = $GUI_SHOW)
	GUICtrlSetState($IRepeatTime,$State)
EndFunc


;~ Chỉnh màu chữ của $IRepeatTime
Func IRepeatTimeColor($Color = 0x000000)
	GUICtrlSetColor($IRepeatTime,$Color)
EndFunc
;~ Chỉnh màu nền của $IRepeatTime
Func IRepeatTimeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IRepeatTime,$Color)
EndFunc