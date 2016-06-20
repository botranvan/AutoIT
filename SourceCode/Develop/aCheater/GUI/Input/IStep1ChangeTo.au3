;~ Bấm vào $IStep1ChangeTo
GUICtrlSetOnEvent($IStep1ChangeTo, "IStep1ChangeToChange")
Func IStep1ChangeToChange()
;~	MsgBox(0,"72ls.NET","IStep1ChangeToChange")
	IStep1ChangeToSave()
EndFunc

;~ IStep1ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep1ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep1ChangeTo"

	$Text = FT($ControlID,IStep1ChangeToGet())

	IStep1ChangeToSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep1ChangeToTSave()
    FTWrite('IStep1ChangeTo',IStep1ChangeToGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep1ChangeToSave()
	IniWrite($DataFile,"Setting","IStep1ChangeTo",IStep1ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
IStep1ChangeToLoad()
Func IStep1ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep1ChangeTo",IStep1ChangeToGet())
	IStep1ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep1ChangeTo
Func IStep1ChangeToGet()
	Return GUICtrlRead($IStep1ChangeTo)
EndFunc
;~ Lấy giá trị từ $IStep1ChangeTo
Func IStep1ChangeToSet($NewValue = "")
	Local $Check = IStep1ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep1ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep1ChangeTo
Func IStep1ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $IStep1ChangeTo)
EndFunc
;~ Chỉnh vị trí của $IStep1ChangeTo
Func IStep1ChangeToSetPos($x = -1,$y = -1)
	Local $Size = IStep1ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep1ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep1ChangeTo
Func IStep1ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = IStep1ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep1ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep1ChangeTo
Func IStep1ChangeToGetState()
	Return GUICtrlGetState($IStep1ChangeTo)
EndFunc
Func IStep1ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep1ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep1ChangeTo
Func IStep1ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($IStep1ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep1ChangeTo
Func IStep1ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep1ChangeTo,$Color)
EndFunc