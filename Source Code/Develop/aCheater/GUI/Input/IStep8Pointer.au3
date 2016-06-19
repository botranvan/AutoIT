;~ Bấm vào $IStep8Pointer
GUICtrlSetOnEvent($IStep8Pointer, "IStep8PointerChange")
Func IStep8PointerChange()
;~	MsgBox(0,"72ls.NET","IStep8PointerChange")
	IStep8PointerSave()
EndFunc

;~ IStep8PointerTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep8PointerTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep8Pointer"

	$Text = FT($ControlID,IStep8PointerGet())

	IStep8PointerSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep8PointerTSave()
    FTWrite('IStep8Pointer',IStep8PointerGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep8PointerSave()
	IniWrite($DataFile,"Setting","IStep8Pointer",IStep8PointerGet())
EndFunc

;Nạp giá trị của label từ file
IStep8PointerLoad()
Func IStep8PointerLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep8Pointer",IStep8PointerGet())
	IStep8PointerSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep8Pointer
Func IStep8PointerGet()
	Return GUICtrlRead($IStep8Pointer)
EndFunc
;~ Lấy giá trị từ $IStep8Pointer
Func IStep8PointerSet($NewValue = "")
	Local $Check = IStep8PointerGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep8Pointer,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep8Pointer
Func IStep8PointerGetPos()
	Return ControlGetPos($MainGUI, "", $IStep8Pointer)
EndFunc
;~ Chỉnh vị trí của $IStep8Pointer
Func IStep8PointerSetPos($x = -1,$y = -1)
	Local $Size = IStep8PointerGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep8Pointer,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep8Pointer
Func IStep8PointerSetSize($Width = -1,$Height = -1)
	Local $Size = IStep8PointerGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep8Pointer,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep8Pointer
Func IStep8PointerGetState()
	Return GUICtrlGetState($IStep8Pointer)
EndFunc
Func IStep8PointerSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep8Pointer,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep8Pointer
Func IStep8PointerColor($Color = 0x000000)
	GUICtrlSetColor($IStep8Pointer,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep8Pointer
Func IStep8PointerBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep8Pointer,$Color)
EndFunc