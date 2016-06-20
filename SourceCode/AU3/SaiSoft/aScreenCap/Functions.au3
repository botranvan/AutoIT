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
	FCapModLoad()
	FCapKeyLoad()
	FSaveInPathLoad()
	MainGUIFix()
	FCapKeySetFunc($CapKey)
	;~ AutoCheckUpdate()
	FShowADS()
EndFunc

;~ Hiện mẫu quản cáo
Func FShowADS()
	Local $NotShow = Random(0,3,1)
	If $NotShow Then Return
	LNoticeSet("Please wait... Ads loading",0)
	Sleep(1111)
	Local $IEOb = _IECreate($ADSLink,1,0,0)
	AdlibRegister("FOffADS",5000)
EndFunc

Func FOffADS()
	Local $Pos,$Message
	WinMove($ADSTitle,"",100,100,800,600)
	WinSetState($ADSTitle,"",@SW_SHOW)
	WinSetState($ADSTitle,"",@SW_RESTORE)
	$Pos = WinGetPos($ADSTitle,"")	
	LNoticeSet()
	If Not WinExists($ADSTitle) Then Return
		
	$Message = "Pls Click: SKIP AD"
	ToolTip($Message,$Pos[0]+$Pos[2]-50,$Pos[1]+120,"Click here",1,1)
	LNoticeSet("Waiting click")
	Sleep(7000)
	ToolTip("")
	LNoticeSet()
	AdlibUnRegister("FOffADS")
EndFunc

;~ Cài đặt phím nóng vào hàm chụp ảnh
Func FCapKeySetFunc($Key = "")
	If $Key == "" Then 
		HotKeySet("{"&$CapKey&"}")
	Else
		HotKeySet("{"&$Key&"}","FCapture")
	EndIf
EndFunc

;~ Chụp ảnh
Func FCapTure()
	If $CapMod == 1 Then FCapDesktop()
	If $CapMod == 2 Then FCapWindow()
EndFunc

;~ Chụp ảnh 1 cửa sổ
Func FCapWindow()
	Local $PicName,$Window
	$PicName = FPicNameGet()
	$Window = FWindowGet()
	If $Window Then
		_ScreenCapture_CaptureWnd($SaveInPath&"\"&$PicName,$Window,0,0,-1,-1,$CapCur)
		LNoticeSet("Window capture: "&$PicName,0)
	Else
		LNoticeSet("Can't find active window",0)
	EndIf

EndFunc

;~ Lấy window cần chụp
Func FWindowGet()
	Local $List
	$List = WinList()
	For $i = 1 To $List[0][0]
		If Not $List[$i][0] Then ContinueLoop
		If WinActive($List[$i][1]) Then Return $List[$i][1]
	Next
	Return 0	
EndFunc

;~ Chụp ảnh toàn màng hình
Func FCapDesktop()
	Local $PicName
	$PicName = FPicNameGet()
	_ScreenCapture_Capture($SaveInPath&"\"&$PicName,0,0,-1,-1,$CapCur)
	LNoticeSet("Desktop capture: "&$PicName,0)
EndFunc

;~ Lấy tên cho file ảnh
Func FPicNameGet()
	Local $Num,$Name,$Ext,$PicName
	$Num = 0
	$Name = "aPic"
	$Ext = ".jpg"
	
	Do
		$Num+=1
		$PicName = $Name&$Num&$Ext
	Until (Not FileExists($SaveInPath&"\"&$PicName))
	
	Return $PicName
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
	
;~ Lưu chế độ chụp
Func FCapModSave()
	IniWrite($DataFileName,"Setting","$CapMod",$CapMod)
EndFunc
;~ Nạp chế độ chụp
Func FCapModLoad()
	$CapMod = IniRead($DataFileName,"Setting","$CapMod",$CapMod)
EndFunc


;~ Lưu phím nóng chụp
Func FCapKeySave()
	IniWrite($DataFileName,"Setting","$CapKey",$CapKey)
EndFunc
;~ Nạp phím nóng chụp
Func FCapKeyLoad()
	$CapKey = IniRead($DataFileName,"Setting","$CapKey",$CapKey)
EndFunc

;~ Lưu đường dẫn lưu ảnh
Func FSaveInPathSave()
	IniWrite($DataFileName,"Setting","$SaveInPath",$SaveInPath)
EndFunc
;~ Nạp đường dẫn lưu ảnh
Func FSaveInPathLoad()
	$SaveInPath = IniRead($DataFileName,"Setting","$SaveInPath",$SaveInPath)
	If Not FileExists ($SaveInPath) Then $SaveInPath = @DesktopDir

EndFunc

	
	