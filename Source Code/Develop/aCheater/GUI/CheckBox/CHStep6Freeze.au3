;~ Bấm vào $CHStep6Freeze
GUICtrlSetOnEvent($CHStep6Freeze, "CHStep6FreezeClick")
Func CHStep6FreezeClick()
;~ 	$SpamCount = CHStep6FreezeIsCheck()
;~ 	MsgBox(0,'',$SpamCount)
EndFunc

CHStep6FreezeTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHStep6FreezeTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHStep6Freeze"

	$Text = FT($ControlID,CHStep6FreezeGet())

	CHStep6FreezeSet($Text)
EndFunc

;Lưu trạng thái của CHStep6Freeze xuống file
Func CHStep6FreezeCheckSave()
	IniWrite($DataFile,"Setting","CHStep6FreezeCheck",CHStep6FreezeGet(0))
EndFunc

;Nạp trạng thái của CHStep6Freeze từ file
;~ CHStep6FreezeCheckLoad()
Func CHStep6FreezeCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHStep6FreezeCheck",CHStep6FreezeGet(0))
	CHStep6FreezeCheck($Data)
EndFunc

;~ Check và UnCheck $CHStep6Freeze
Func CHStep6FreezeCheck($check = 0)
	If $check == 1 Then	CHStep6FreezeSetState($GUI_CHECKED)
	If $check == 4 Then	CHStep6FreezeSetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHStep6Freeze có đang check hay không
Func CHStep6FreezeIsCheck()
	Local $State = CHStep6FreezeGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHStep6FreezeSave()
	IniWrite($DataFile,"Setting","CHStep6Freeze",CHStep6FreezeGet())
EndFunc
;Nạp giá trị của label từ file
Func CHStep6FreezeLoad()
	Local $Data = IniRead($DataFile,"Setting","CHStep6Freeze",CHStep6FreezeGet())
	CHStep6FreezeSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHStep6Freeze
Func CHStep6FreezeGet($Advanced = 0)
	Return GUICtrlRead($CHStep6Freeze,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHStep6Freeze
Func CHStep6FreezeSet($NewValue = "")
	Local $Check = CHStep6FreezeGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHStep6Freeze,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHStep6Freeze
Func CHStep6FreezeGetPos()
	Return ControlGetPos($MainGUI, "", $CHStep6Freeze)
EndFunc
;~ Chỉnh vị trí của $CHStep6Freeze
Func CHStep6FreezeSetPos($x = -1,$y = -1)
	Local $Size = CHStep6FreezeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHStep6Freeze,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHStep6Freeze
Func CHStep6FreezeSetSize($Width = -1,$Height = -1)
	Local $Size = CHStep6FreezeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHStep6Freeze,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHStep6Freeze
Func CHStep6FreezeGetState()
	Return GUICtrlGetState($CHStep6Freeze)
EndFunc
Func CHStep6FreezeSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHStep6Freeze,$State)
EndFunc


;~ Chỉnh màu chữ của $CHStep6Freeze
Func CHStep6FreezeColor($Color = 0x000000)
	GUICtrlSetColor($CHStep6Freeze,$Color)
EndFunc
;~ Chỉnh màu nền của $CHStep6Freeze
Func CHStep6FreezeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHStep6Freeze,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHStep6FreezeFont($Size,$Weight)
	GUICtrlSetFont($CHStep6Freeze,$Size,$Weight)
EndFunc