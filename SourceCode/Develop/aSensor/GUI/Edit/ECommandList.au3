;~ Bấm vào $ECommandList
GUICtrlSetOnEvent($ECommandList, "ECommandListChange")
Func ECommandListChange()
;~	MsgBox(0,"72ls.NET","ECommandListChange")
;~	ECommandListSave()
EndFunc

;~ ECommandListTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func ECommandListTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "ECommandList"

	$Text = FT($ControlID,ECommandListGet())

	ECommandListSet($Text)
EndFunc

;~ Cuộn chuột xuống hàng cuối
Func ECommandListScrollEnd()
	_GUICtrlEdit_LineScroll($ECommandList, 0, _GUICtrlEdit_GetLineCount($ECommandList))
EndFunc

;Lưu giá trị trong label xuống file
Func ECommandListSave()
	Local $Data = ECommandListGet()
	$Data = StringReplace($Data,@CRLF,"<br>")
	IniWrite($DataFile,"Setting","ECommandList",$Data)
EndFunc

;Nạp giá trị của label từ file
Func ECommandListLoad()
	Local $Data = IniRead($DataFile,"Setting","ECommandList",ECommandListGet())
	$Data = StringReplace($Data,"<br>",@CRLF)
	ECommandListSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $ECommandList
Func ECommandListGet()
	Return GUICtrlRead($ECommandList)
EndFunc
;~ Lấy giá trị từ $ECommandList
Func ECommandListSet($NewValue = "")
	Local $Check = ECommandListGet()
	If $Check <> $NewValue Then GUICtrlSetData($ECommandList,$NewValue)
EndFunc



;~ Lấy vị trí và kích thước của $ECommandList
Func ECommandListGetPos()
	Return ControlGetPos($MainGUI, "", $ECommandList)
EndFunc
;~ Chỉnh vị trí của $ECommandList
Func ECommandListSetPos($x = -1,$y = -1)
	Local $Size = ECommandListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($ECommandList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $ECommandList
Func ECommandListSetSize($Width = -1,$Height = -1)
	Local $Size = ECommandListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($ECommandList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $ECommandList
Func ECommandListGetState()
	Return GUICtrlGetState($ECommandList)
EndFunc
Func ECommandListSetState($State = $GUI_SHOW)
	GUICtrlSetState($ECommandList,$State)
EndFunc


;~ Chỉnh màu chữ của $ECommandList
Func ECommandListColor($Color = 0x000000)
	GUICtrlSetColor($ECommandList,$Color)
EndFunc
;~ Chỉnh màu nền của $ECommandList
Func ECommandListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($ECommandList,$Color)
EndFunc