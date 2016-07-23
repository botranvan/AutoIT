;~ Bấm vào $IFolder
GUICtrlSetOnEvent($IFolder, "IFolderChange")
Func IFolderChange()
;~	MsgBox(0,"72ls.NET","IFolderChange")
	IFolderSave()
EndFunc

IFolderLoad()
;~ IFolderTLoad()

;~ Nạp chuỗi ngôn ngữ của 1 control
Func IFolderTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IFolder"

	$Text = FT($ControlID,IFolderGet())

	IFolderSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IFolderTSave()
    FTWrite('IFolder',IFolderGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IFolderSave()
	IniWrite($DataFile,"Setting","IFolder",IFolderGet())
EndFunc

;Nạp giá trị của label từ file
Func IFolderLoad()
	Local $Data = IniRead($DataFile,"Setting","IFolder",IFolderGet())
	IFolderSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IFolder
Func IFolderGet()
	Return GUICtrlRead($IFolder)
EndFunc
;~ Lấy giá trị từ $IFolder
Func IFolderSet($NewValue = "")
	Local $Check = IFolderGet()
	If $Check <> $NewValue Then GUICtrlSetData($IFolder,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IFolder
Func IFolderGetPos()
	Return ControlGetPos($MainGUI, "", $IFolder)
EndFunc
;~ Chỉnh vị trí của $IFolder
Func IFolderSetPos($x = -1,$y = -1)
	Local $Size = IFolderGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IFolder,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IFolder
Func IFolderSetSize($Width = -1,$Height = -1)
	Local $Size = IFolderGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IFolder,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IFolder
Func IFolderGetState()
	Return GUICtrlGetState($IFolder)
EndFunc
Func IFolderSetState($State = $GUI_SHOW)
	GUICtrlSetState($IFolder,$State)
EndFunc


;~ Chỉnh màu chữ của $IFolder
Func IFolderColor($Color = 0x000000)
	GUICtrlSetColor($IFolder,$Color)
EndFunc
;~ Chỉnh màu nền của $IFolder
Func IFolderBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IFolder,$Color)
EndFunc