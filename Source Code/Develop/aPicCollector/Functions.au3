#include-once
#include "GUI\GUIFunctions.au3"


#cs >> Danh sách hàm ===============================================================================================


Func AutoStart()			;~ Nạp các thông số của Auto khi khởi động
Func AutoEnd()				;~ Kết thúc chương trình
Func AutoCheckUpdate()		;~ Kiểm tra phiên bản mới của Auto
Func SaveSetting()			;~ Lưu các thông số trên GUI
Func SaveGUIPos()			;~ Lưu vị trí GUI
Func LoadGUIPos()			;~ Nạp vị trí GUI
Func ToolTipDel()			;~ Xóa ToolTip
Func Percent()				;~ Tính phần trăm giữa 2 số
Func NumberCheckSum()		;~ Kiểm tra xem 2 số có gần bằng nhau hay không


#ce << Danh sách hàm ===============================================================================================

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FLoadGUIPos()
	MainGUIFix()
	;~ AutoCheckUpdate()
EndFunc

;~ Kết thúc chương trình
Func AutoEnd()
	MainGUIClose()
EndFunc

;~ Tạm dừng chương trình
Func FAutoPause()
	$Pause = Not $Pause
	While $Pause
		LNoticeSet("Pause "&@SEC,0)
		Sleep(500)
	WEnd
	LNoticeSet()
EndFunc

;~ Kiểm tra phiên bản mới của Auto
Func FAutoCheckUpdate()
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
Func FSaveSetting()
	FSaveGUIPos()
EndFunc

;~ Lưu vị trí GUI
Func FSaveGUIPos()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[0] < 0 Or $Pos[1] < 0 Then Return
	IniWrite($DataFileName,"AutoPos","x",$Pos[0])
	IniWrite($DataFileName,"AutoPos","y",$Pos[1])
	Return $Pos
EndFunc


;~ Nạp vị trí GUI
Func FLoadGUIPos()
	$AutoPos[0] = IniRead($DataFileName,"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead($DataFileName,"AutoPos","y",$AutoPos[1])
EndFunc

;~ Xóa ToolTip
Func FToolTipDel()
	ToolTip("")
EndFunc

;~ Tính phần trăm giữa 2 số
Func FPercent($a,$b)
	local $percent = (( $a / $b )*100)
	return $percent
EndFunc

;~ Kiểm tra xem 2 số có gần bằng nhau hay không
Func FNumberCheckSum($a,$b,$Span=3)
	Local $Start = $Span*-1
	For $i = $Start To $Span
		If ($a == ($b+$i)) Then Return 1
	Next
	Return 0
EndFunc
	
;~ Tìm ảnh	
Func FSearchPic()
	Switch $SearchMode
		Case 1
		Case 2
		Case 3
			FSearchAnySize()
	EndSwitch
EndFunc
	
;~ Tìm với kích thước bất kỳ
Func FSearchAnySize()
	Local $URL,$HTML
	$URL = "http://www.google.com.vn/search?q=3D+Girl&tbm=isch"
#cs
http://www.google.com.vn/search?
q=3D+Girl
&um=1
&ie=UTF-8
&hl=vi
&tbm=isch
&source=og
&sa=N
&tab=wi
&biw=1280
&bih=657
&sei=1BfOTs3bHKmriAfsz-HcDg	

http://www.google.com.vn/search?q=3d+girl&um=1&hl=vi&client=firefox-a&sa=N&rls=org.mozilla:en-US:official&biw=1280&bih=693&tbm=isch&ijn=sbg&ei=rRzOTqG8JeSXiQengtnVDg&sprg=14&page=15&start=230&tch=1&ech=1&psi=rRzOTqG8JeSXiQengtnVDg.1322130627736.1
http://www.google.com.vn/search?q=3d+girl&um=1&hl=vi&client=firefox-a&rls=org.mozilla:en-US:official&biw=986&bih=617&tbm=isch&ijn=sbg&ei=MR3OTpbZD6GWiQeu9tnUDg&sprg=16&page=17&start=242&tch=1&ech=2&psi=rRzOTqG8JeSXiQengtnVDg.1322130627736.5

#ce

	$HTML = FHTMLGet($URL)
	msgbox(0,"72ls.net",$HTML)
EndFunc

Func FHTMLGet($URL)
	Local $HTML,$obj
	
	$obj = _IEcreate($URL)
	$HTML = _IEBodyReadHTML($obj)
	Return $HTML
EndFunc