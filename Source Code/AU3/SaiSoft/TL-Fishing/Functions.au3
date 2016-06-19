#include-once
#include "GUI\GUIFunctions.au3"
#include "GAME\Include.au3"


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
Func AutoStart()
	LoadGUIPos()
	MainGUIFix()
	;~ AutoCheckUpdate()
EndFunc

;~ Kết thúc chương trình
Func AutoEnd()
	MainGUIClose()
EndFunc


;~ Tạm dừng chương trình
Func AutoPause()
	$Pause = Not $Pause
	While $Pause
		LNoticeSet("Pause "&@SEC,0)
		Sleep(500)
	WEnd
	LNoticeSet()
EndFunc

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


;~ Nạp vị trí GUI
Func LoadGUIPos()
	$AutoPos[0] = IniRead($DataFileName,"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead($DataFileName,"AutoPos","y",$AutoPos[1])
EndFunc

;~ Xóa ToolTip
Func ToolTipDel()
	ToolTip("")
EndFunc

;~ Tính phần trăm giữa 2 số
Func Percent($a,$b)
	local $percent = (( $a / $b )*100)
	return $percent
EndFunc

;~ Kiểm tra xem 2 số có gần bằng nhau hay không
Func NumberCheckSum($a,$b,$Span=3)
	Local $Start = $Span*-1
	For $i = $Start To $Span
		If ($a == ($b+$i)) Then Return 1
	Next
	Return 0
EndFunc
	
;~ Thực hiện việc cậu cá
Func FFishingProcess()
	If Not $Fishing Then Return
	
	If Not $HookPos[0] Or Not $FishingHolePos[0] Then
		MsgBox(0,$AutoName,"Chưa lấy tọa độ nút [Fishing Hole] hoặc nút hình Móc Câu")
		$Fishing = 1
		BStartClick()
		Return
	EndIf
	
	If $IsFishing == 1 Then
		MouseMove($HookPos[0],$HookPos[1])
		If $IsCaught == 1 Then
			MouseClick("left",$HookPos[0],$HookPos[1])
			Sleep(4000)
			MouseClick("left",$HookPos[0],$HookPos[1]-20)
		EndIf
	Else
		MouseClick("left",$FishingHolePos[0],$FishingHolePos[1])
	EndIf
EndFunc