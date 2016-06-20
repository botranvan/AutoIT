;~ Bấm vào $COFuncList
GUICtrlSetOnEvent($COFuncList, "COFuncListChange")
Func COFuncListChange()
;~ 	Local $Data = COFuncListGet()
;~ 	MsgBox(0,"72ls.NET","COFuncListChange: "&$Data)
EndFunc

;~ COFuncListTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func COFuncListTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "COFuncList"

	$Text = FT($ControlID,COFuncListGet())

	COFuncListSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func COFuncListSave()
	IniWrite($DataFile,"Setting","COFuncList",COFuncListGet())
EndFunc

;Nạp giá trị của label từ file
Func COFuncListLoad()
	Local $Data = IniRead($DataFile,"Setting","COFuncList",COFuncListGet())
	If $Data <> "" Then COFuncListSet($Data,$Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $COFuncList
Func COFuncListGet()
	Return GUICtrlRead($COFuncList)
EndFunc
;~ Lấy giá trị từ $COFuncList
Func COFuncListSet($NewValue = "",$Default = "")
	Local $Check = COFuncListGet()
	If $Check <> $NewValue Then GUICtrlSetData($COFuncList,$NewValue,$Default)
EndFunc


;~ Lấy vị trí và kích thước của $COFuncList
Func COFuncListGetPos()
	Return ControlGetPos($MainGUI, "", $COFuncList)
EndFunc
;~ Chỉnh vị trí của $COFuncList
Func COFuncListSetPos($x = -1,$y = -1)
	Local $Size = COFuncListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($COFuncList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $COFuncList
Func COFuncListSetSize($Width = -1,$Height = -1)
	Local $Size = COFuncListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($COFuncList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $COFuncList
Func COFuncListGetState()
	Return GUICtrlGetState($COFuncList)
EndFunc
Func COFuncListSetState($State = $GUI_SHOW)
	GUICtrlSetState($COFuncList,$State)
EndFunc


;~ Chỉnh màu chữ của $COFuncList
Func COFuncListColor($Color = 0x000000)
	GUICtrlSetColor($COFuncList,$Color)
EndFunc
;~ Chỉnh màu nền của $COFuncList
Func COFuncListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($COFuncList,$Color)
EndFunc