;~ Bấm vào $IWebsite
GUICtrlSetOnEvent($IWebsite, "IWebsiteChange")
Func IWebsiteChange()
;~ 	MsgBox(0,"72ls.NET","IWebsiteChange")
	IWebsiteTSave()
EndFunc

IWebsiteTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IWebsiteTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IWebsite"

	$Text = FT($ControlID,IWebsiteGet())

	IWebsiteSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IWebsiteTSave()
    FTWrite('IWebsite',IWebsiteGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IWebsiteSave()
	IniWrite($DataFile,"Setting","IWebsite",IWebsiteGet())
EndFunc

;Nạp giá trị của label từ file
Func IWebsiteLoad()
	Local $Data = IniRead($DataFile,"Setting","IWebsite",IWebsiteGet())
	IWebsiteSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IWebsite
Func IWebsiteGet()
	Return GUICtrlRead($IWebsite)
EndFunc
;~ Lấy giá trị từ $IWebsite
Func IWebsiteSet($NewValue = "")
	Local $Check = IWebsiteGet()
	If $Check <> $NewValue Then GUICtrlSetData($IWebsite,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IWebsite
Func IWebsiteGetPos()
	Return ControlGetPos($MainGUI, "", $IWebsite)
EndFunc
;~ Chỉnh vị trí của $IWebsite
Func IWebsiteSetPos($x = -1,$y = -1)
	Local $Size = IWebsiteGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IWebsite,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IWebsite
Func IWebsiteSetSize($Width = -1,$Height = -1)
	Local $Size = IWebsiteGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IWebsite,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IWebsite
Func IWebsiteGetState()
	Return GUICtrlGetState($IWebsite)
EndFunc
Func IWebsiteSetState($State = $GUI_SHOW)
	GUICtrlSetState($IWebsite,$State)
EndFunc


;~ Chỉnh màu chữ của $IWebsite
Func IWebsiteColor($Color = 0x000000)
	GUICtrlSetColor($IWebsite,$Color)
EndFunc
;~ Chỉnh màu nền của $IWebsite
Func IWebsiteBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IWebsite,$Color)
EndFunc