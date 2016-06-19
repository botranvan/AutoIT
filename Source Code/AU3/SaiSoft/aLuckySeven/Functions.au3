#include-once
#include "GUI\GUIFunctions.au3"


#cs >> Danh sách hàm ===============================================================================================


Func FAutoStart()			;~ Nạp các thông số của Auto khi khởi động
Func FAutoEnd()				;~ Kết thúc chương trình
Func FAutoCheckUpdate()		;~ Kiểm tra phiên bản mới của Auto
Func FSaveSetting()			;~ Lưu các thông số trên GUI
Func FSaveGUIPos()			;~ Lưu vị trí GUI
Func FLoadGUIPos()			;~ Nạp vị trí GUI
Func FToolTipDel()			;~ Xóa ToolTip
Func FPercent()				;~ Tính phần trăm giữa 2 số
Func FNumberCheckSum()		;~ Kiểm tra xem 2 số có gần bằng nhau hay không


#ce << Danh sách hàm ===============================================================================================

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FCreditsLoad()
	FLoadGUIPos()
	MainGUIFix()
	;~ AutoCheckUpdate()
EndFunc

;~ Kết thúc chương trình
Func FAutoEnd()
	FCreditsSave()		;Lưu khi thoát chương trình
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
		FToolTipDel()
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
	
;~ Kiểm tra xem 2 điểm có gần nhau hay kg
Func FIsNear($X1,$Y1,$X2,$Y2,$Area = 2)
   Local $IsNear = 0
   Local $Distance = FDistance($X1,$Y1,$X2,$Y2)
   If $Distance <= $Area Then $IsNear = 1
   Return $IsNear
EndFunc

;~ Tính khoãn cách 2 điểm
Func FDistance($X1,$Y1,$X2,$Y2)
   Local $Distance = -99
   Local $AC,$AB,$BC
   $AC = Abs($X1 - $X2)
   $BC = Abs($Y1 - $Y2)
   $AB = Sqrt($AC*$AC + $BC*$BC)
   $Distance = Round($AB)
   Return $Distance
EndFunc

;~ Tính toán xem 2 số có lệch nhau nhiều kg
Func FNumIsNear($a,$b,$near = 3)
	Local $n
	$n = Abs($a-$b)
	If $n > $near Then Return 0
	If $n <= $near Then Return 1
EndFunc	
	
;Xử lý việc quay số
Func FSpinProcess()
	Local $num,$min,$max	;Các biến Local nên viết thường để dễ phân biệt

	If Not $Spining Then Return
	
	$min = 1
	$max = 9
	
	$Lucky1 = Random($min,$max,1)	;1 có nghĩa chỉ lấy số nguyên
	LLucky1Set($Lucky1)
	
	$Lucky2 = Random($min,$max,1)	;1 có nghĩa chỉ lấy số nguyên
	LLucky2Set($Lucky2)
	
	$Lucky3 = Random($min,$max,1)	;1 có nghĩa chỉ lấy số nguyên
	LLucky3Set($Lucky3)
	

	;Kiểm tra ngưng quay
	$SpinTime-=1
	If $SpinTime < 0 Then
		$SpinTime = 99
		$Spining = 0

		FCalculateWin()
		
		$Bet = 0
		LBetSet($Bet)
		
		FCreditsSave()	;Lưu sau khi quay xong
		
		BSpinSetState($GUI_ENABLE)
	EndIf
	
	;Cập nhật lại lên GUI
	LWinSet($Win)
	
	;Quay chậm dần
	Sleep(Round(1000/$SpinTime))
EndFunc
	

;Xử lý trúng thưởng
Func FCalculateWin()
		
	;Có cược mới được giải an ủi
	If $Bet>0 Then
		;Có 1 số 7.. trúng giải an ủi :)
		If $Lucky1 == 7 Then $Win+=1
		If $Lucky2 == 7 Then $Win+=1
		If $Lucky3 == 7 Then $Win+=1
			
		;Có 2 số 7... an ủi tập 2
		If $Lucky1 == $Lucky2 And $Lucky1 = 7 Then $Win+=2
		If $Lucky2 == $Lucky3 And $Lucky2 = 7 Then $Win+=2
		If $Lucky1 == $Lucky3 And $Lucky1 = 7 Then $Win+=2
	EndIf
		
	;3 số trùng nhau
	If $Lucky1 == $Lucky2 And $Lucky2 == $Lucky3 Then $Win+=$Bet
		
	;Có 3 số 7.. thưởng lớn !!!!
	;Cái này có thể bao gồm cả mấy cái trên
	If $Lucky1 == $Lucky2 And $Lucky2 == $Lucky3 And $Lucky1 == 7 Then $Win+=$Bet*2
EndFunc

;Lưu credits
Func FCreditsSave()
	IniWrite ($DataFileName, "Game", "$Credits", $Credits )
	IniWrite ($DataFileName, "Game", "$Bet", $Bet )
	IniWrite ($DataFileName, "Game", "$Win", $Win )
EndFunc

;Nạp credits từ lần chơi trước
Func FCreditsLoad()
	$Credits = IniRead ($DataFileName, "Game", "$Credits", $Credits )
	$Bet = IniRead ($DataFileName, "Game", "$Bet", $Bet )
	$Win = IniRead ($DataFileName, "Game", "$Win", $Win )
EndFunc
	
Func FCheat()
	;Cheat :)
	If Not Random(0,3,1) Then
		$Lucky1 = 7
		$Lucky2 = 7
		$Lucky3 = 7
		LLucky1Set($Lucky1)
		LLucky2Set($Lucky2)
		LLucky3Set($Lucky3)
	EndIf	
EndFunc
	
	
	
	
	