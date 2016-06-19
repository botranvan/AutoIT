
;~ Kiểm tra phiên bản mới của Auto
Func AutoCheckUpdate()
	ToolTip("Checking for updates...",0,0)
	
	Local $HTML = _INetGetSource($HomePage)
	Local $start = StringInStr($HTML,"[Auto] Lineage 2 - Scan Monsters") + 53
	Local $len = StringInStr($HTML," |") - $start
	$HTML = StringMid($HTML,$start,$len)


	If $AutoVersion == $HTML Then 
		ToolTipDel()
	Else
		ToolTip("A newer version is available: v"&$HTML&" "&@LF&"Click [ Option ] => [ HomePage ] to download",0,0)
		AdlibRegister("DelTooltip",9000)
	EndIf
	
EndFunc

;~ Lưu các thông số trên GUI
Func SaveSetting()
	SaveGUIPos()
EndFunc

;~ Lưu vị trí GUI
Func SaveGUIPos()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[0] < 0 Or $Pos[1] < 0 Then Return
	IniWrite($DataFileName,"AutoPos","x",$Pos[0])
	IniWrite($DataFileName,"AutoPos","y",$Pos[1])
	Return $Pos
EndFunc

;~ Nạp các thông số của Auto lưu ở file
Func LoadSetting()
	LoadGUIPos()
EndFunc

;~ Nạp vị trí GUI
Func LoadGUIPos()
	$AutoPos[0] = IniRead($DataFileName,"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead($DataFileName,"AutoPos","y",$AutoPos[1])
EndFunc

;~ Xóa ToolTip
Func ToolTipDel()
	ToolTip("")
EndFunc

;~ Chèn file vào chương trình
Func FlashFileInstall()
	FileInstall('game.swf','game.swf')
EndFunc


;~ Tạo Control Flash Game
Func FlashCreateCtrl()
	Local $Path = @ScriptDir&"/game.swf"
	Local $ClassName = "ShockwaveFlash.ShockwaveFlash"
	Local $T = ObjGet($Path,$ClassName)
;~ 	msgbox(0,"72ls.net",$T.height)
	
	Global $FlashObj = ObjCreate($ClassName)
	Global $FlashCtrl = GUICtrlCreateObj($FlashObj, 0, 0, $AutoSize[0],$AutoSize[1]-50)
	With $FlashObj
			.ScaleMode = 0
			.Loop = True
			.Movie = "file:///"&$Path
		.ScaleMode = 0
	EndWith
EndFunc

;~ Hiểu chỉnh lại kích của của Flash Control theo kích thước GUI
Func FlashControlSetSize($Width,$Height)
	GUICtrlSetPos( $FlashCtrl, 0, 0, $Width,$Height-27)
EndFunc