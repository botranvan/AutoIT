;~ Bấm vào $IStep6Pointer
GUICtrlSetOnEvent($IStep6Pointer, "IStep6PointerChange")
Func IStep6PointerChange()
;~	MsgBox(0,"72ls.NET","IStep6PointerChange")
	IStep6PointerSave()
EndFunc

;~ IStep6PointerTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep6PointerTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep6Pointer"

	$Text = FT($ControlID,IStep6PointerGet())

	IStep6PointerSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep6PointerTSave()
    FTWrite('IStep6Pointer',IStep6PointerGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep6PointerSave()
	IniWrite($DataFile,"Setting","IStep6Pointer",IStep6PointerGet())
EndFunc

;Nạp giá trị của label từ file
IStep6PointerLoad()
Func IStep6PointerLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep6Pointer",IStep6PointerGet())
	IStep6PointerSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep6Pointer
Func IStep6PointerGet()
	Return GUICtrlRead($IStep6Pointer)
EndFunc
;~ Lấy giá trị từ $IStep6Pointer
Func IStep6PointerSet($NewValue = "")
	Local $Check = IStep6PointerGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep6Pointer,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep6Pointer
Func IStep6PointerGetPos()
	Return ControlGetPos($MainGUI, "", $IStep6Pointer)
EndFunc
;~ Chỉnh vị trí của $IStep6Pointer
Func IStep6PointerSetPos($x = -1,$y = -1)
	Local $Size = IStep6PointerGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep6Pointer,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep6Pointer
Func IStep6PointerSetSize($Width = -1,$Height = -1)
	Local $Size = IStep6PointerGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep6Pointer,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep6Pointer
Func IStep6PointerGetState()
	Return GUICtrlGetState($IStep6Pointer)
EndFunc
Func IStep6PointerSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep6Pointer,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep6Pointer
Func IStep6PointerColor($Color = 0x000000)
	GUICtrlSetColor($IStep6Pointer,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep6Pointer
Func IStep6PointerBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep6Pointer,$Color)
EndFunc