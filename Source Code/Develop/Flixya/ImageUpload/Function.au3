
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


;~ Bắt đầu chọn ảnh để tải
Func StartUpload()
	Local $Wait = 200
	Local $Pos = MouseGetPos()
	Local $Count = 30
	
	For $i = 1 To $Count
		If $CurImage > $ImageList[0] Then Return
		$CurImage +=1
		ImageUpLSet("Uploaded "&$CurImage&" / "&$ImageList[0]&" Images")
		MouseClick("left",$Pos[0],$Pos[1])
		Sleep($Wait)
		ClipPut($ImageList[$CurImage])
		Send("^v")
;~ 		Send($ImageList[$CurImage])
		Sleep($Wait)
		Send("{Enter}")
		Sleep($Wait*2)
		
	Next
EndFunc




